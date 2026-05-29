package org.ruoyi.system.service;

import cn.hutool.crypto.digest.BCrypt;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.constant.Constants;
import org.ruoyi.common.core.constant.GlobalConstants;
import org.ruoyi.common.core.domain.model.RegisterBody;
import org.ruoyi.common.core.enums.UserType;
import org.ruoyi.common.core.exception.ServiceException;
import org.ruoyi.common.core.exception.user.CaptchaException;
import org.ruoyi.common.core.exception.user.CaptchaExpireException;
import org.ruoyi.common.core.exception.user.UserException;
import org.ruoyi.common.core.utils.MessageUtils;
import org.ruoyi.common.core.utils.ServletUtils;
import org.ruoyi.common.core.utils.SpringUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.log.event.LogininforEvent;
import org.ruoyi.common.redis.utils.RedisUtils;
import org.ruoyi.common.tenant.helper.TenantHelper;
import org.ruoyi.common.web.config.properties.CaptchaProperties;
import org.ruoyi.system.domain.SysUser;
import org.ruoyi.system.domain.bo.SysUserBo;
import org.ruoyi.system.mapper.SysUserMapper;
import org.springframework.stereotype.Service;

/**
 * 注册校验方法
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Service
public class SysRegisterService {

    private final ISysUserService userService;
    private final SysUserMapper userMapper;
    private final CaptchaProperties captchaProperties;

    /**
     * 注册
     */
    public void register(RegisterBody registerBody) {
        String tenantId = registerBody.getTenantId();

        // 邮件注册
        if (StringUtils.isNotBlank(registerBody.getEmail())) {
            registerByEmail(registerBody, tenantId);
            return;
        }

        // // 用户名密码注册（暂不支持）
        // String username = registerBody.getUsername();
        // String password = registerBody.getPassword();
        // if (StringUtils.isBlank(username)) {
        //     throw new ServiceException("用户名不能为空");
        // }
        // if (StringUtils.isBlank(password)) {
        //     throw new ServiceException("密码不能为空");
        // }
        // // 校验用户类型是否存在，默认 sys_user
        // String userType = UserType.getUserType(
        //     StringUtils.isBlank(registerBody.getUserType()) ? UserType.SYS_USER.getUserType() : registerBody.getUserType()
        // ).getUserType();
        //
        // boolean captchaEnabled = captchaProperties.getEnable();
        // if (captchaEnabled) {
        //     validateCaptcha(tenantId, username, registerBody.getCode(), registerBody.getUuid());
        // }
        // SysUserBo sysUser = new SysUserBo();
        // sysUser.setUserName(username);
        // sysUser.setNickName(username);
        // sysUser.setPassword(BCrypt.hashpw(password));
        // sysUser.setUserType(userType);
        //
        // boolean exist = TenantHelper.dynamic(tenantId, () ->
        //     userMapper.exists(new LambdaQueryWrapper<SysUser>()
        //         .eq(SysUser::getUserName, sysUser.getUserName())));
        // if (exist) {
        //     throw new UserException("user.register.save.error", username);
        // }
        // boolean regFlag = userService.registerUser(sysUser, tenantId);
        // if (!regFlag) {
        //     throw new UserException("user.register.error");
        // }
        // recordLogininfor(tenantId, username, Constants.REGISTER, MessageUtils.message("user.register.success"));
    }

    private void registerByEmail(RegisterBody registerBody, String tenantId) {
        String username = registerBody.getUsername();
        String email = registerBody.getEmail();
        String emailCode = registerBody.getEmailCode();
        String password = registerBody.getPassword();
        if (StringUtils.isBlank(username)) {
            throw new ServiceException("用户名不能为空");
        }
        if (StringUtils.isBlank(emailCode)) {
            throw new ServiceException("邮箱验证码不能为空");
        }
        if (StringUtils.isBlank(password)) {
            throw new ServiceException("密码不能为空");
        }
        // 校验邮箱验证码
        String verifyKey = GlobalConstants.CAPTCHA_CODE_KEY + email;
        String captcha = RedisUtils.getCacheObject(verifyKey);
        RedisUtils.deleteObject(verifyKey);
        if (captcha == null) {
            throw new CaptchaExpireException();
        }
        if (!StringUtils.equalsIgnoreCase(emailCode, captcha)) {
            throw new CaptchaException();
        }
        // 检查邮箱是否已注册
        boolean exist = TenantHelper.dynamic(tenantId, () ->
            userMapper.exists(new LambdaQueryWrapper<SysUser>()
                .eq(SysUser::getEmail, email)));
        if (exist) {
            throw new ServiceException("该邮箱已被注册");
        }
        // 检查用户名是否已存在
        boolean userNameExist = TenantHelper.dynamic(tenantId, () ->
            userMapper.exists(new LambdaQueryWrapper<SysUser>()
                .eq(SysUser::getUserName, username)));
        if (userNameExist) {
            throw new UserException("user.register.save.error", username);
        }
        String userType = UserType.getUserType(
            StringUtils.isBlank(registerBody.getUserType()) ? UserType.SYS_USER.getUserType() : registerBody.getUserType()
        ).getUserType();
        SysUserBo sysUser = new SysUserBo();
        sysUser.setUserName(username);
        sysUser.setNickName(username);
        sysUser.setEmail(email);
        sysUser.setPassword(BCrypt.hashpw(password));
        sysUser.setUserType(userType);
        boolean regFlag = userService.registerUser(sysUser, tenantId);
        if (!regFlag) {
            throw new UserException("user.register.error");
        }
        recordLogininfor(tenantId, email, Constants.REGISTER, MessageUtils.message("user.register.success"));
    }


    /**
     * 校验验证码
     *
     * @param username 用户名
     * @param code     验证码
     * @param uuid     唯一标识
     */
    public void validateCaptcha(String tenantId, String username, String code, String uuid) {
        String verifyKey = GlobalConstants.CAPTCHA_CODE_KEY + StringUtils.blankToDefault(uuid, "");
        String captcha = RedisUtils.getCacheObject(verifyKey);
        RedisUtils.deleteObject(verifyKey);
        if (captcha == null) {
            recordLogininfor(tenantId, username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire"));
            throw new CaptchaExpireException();
        }
        if (!StringUtils.equalsIgnoreCase(code, captcha)) {
            recordLogininfor(tenantId, username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error"));
            throw new CaptchaException();
        }
    }

    /**
     * 记录登录信息
     *
     * @param tenantId 租户ID
     * @param username 用户名
     * @param status   状态
     * @param message  消息内容
     * @return
     */
    private void recordLogininfor(String tenantId, String username, String status, String message) {
        LogininforEvent logininforEvent = new LogininforEvent();
        logininforEvent.setTenantId(tenantId);
        logininforEvent.setUsername(username);
        logininforEvent.setStatus(status);
        logininforEvent.setMessage(message);
        logininforEvent.setRequest(ServletUtils.getRequest());
        SpringUtils.context().publishEvent(logininforEvent);
    }

}
