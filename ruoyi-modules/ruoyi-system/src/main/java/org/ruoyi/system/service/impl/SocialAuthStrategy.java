package org.ruoyi.system.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.stp.parameter.SaLoginParameter;
import cn.hutool.core.codec.Base64;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.lock.annotation.Lock4j;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthUser;
import org.ruoyi.common.core.constant.SystemConstants;
import org.ruoyi.common.core.domain.model.LoginUser;
import org.ruoyi.common.core.domain.model.SocialLoginBody;
import org.ruoyi.common.core.exception.ServiceException;
import org.ruoyi.common.core.exception.user.UserException;
import org.ruoyi.common.core.utils.StreamUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.core.utils.ValidatorUtils;
import org.ruoyi.common.json.utils.JsonUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.social.config.properties.SocialProperties;
import org.ruoyi.common.social.utils.SocialUtils;
import org.ruoyi.common.tenant.helper.TenantHelper;
import org.ruoyi.system.domain.SysUser;
import org.ruoyi.system.domain.bo.SysSocialBo;
import org.ruoyi.system.domain.bo.SysUserBo;
import org.ruoyi.system.domain.vo.LoginVo;
import org.ruoyi.system.domain.vo.SysClientVo;
import org.ruoyi.system.domain.vo.SysSocialVo;
import org.ruoyi.system.domain.vo.SysUserVo;
import org.ruoyi.system.mapper.SysUserMapper;
import org.ruoyi.system.service.IAuthStrategy;
import org.ruoyi.system.service.ISysConfigService;
import org.ruoyi.system.service.ISysSocialService;
import org.ruoyi.system.service.ISysUserService;
import org.ruoyi.system.service.SysLoginService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * 第三方授权策略
 *
 * @author thiszhc is 三三
 */
@Slf4j
@Service("social" + IAuthStrategy.BASE_NAME)
@RequiredArgsConstructor
public class SocialAuthStrategy implements IAuthStrategy {

    private final SocialProperties socialProperties;
    private final ISysSocialService sysSocialService;
    private final SysUserMapper userMapper;
    private final ISysUserService userService;
    private final ISysConfigService configService;
    private final SysLoginService loginService;

    /**
     * 登录-第三方授权登录
     *
     * @param body     登录信息
     * @param client   客户端信息
     */
    @Override
    public LoginVo login(String body, SysClientVo client) {
        SocialLoginBody loginBody = JsonUtils.parseObject(body, SocialLoginBody.class);
        ValidatorUtils.validate(loginBody);
        AuthResponse<AuthUser> response = SocialUtils.loginAuth(
                loginBody.getSource(), loginBody.getSocialCode(),
                loginBody.getSocialState(), socialProperties);
        if (!response.ok()) {
            throw new ServiceException(response.getMsg());
        }
        AuthUser authUserData = response.getData();

        // 校验 state 中的 tenantId 与请求体中的 tenantId 一致，防止跨租户攻击
        String stateValue = SocialUtils.getStateValue(loginBody.getSocialState());
        if (StringUtils.isNotEmpty(stateValue)) {
            String stateJson = Base64.decodeStr(stateValue);
            if (JSONUtil.isTypeJSON(stateJson)) {
                String stateTenantId = JSONUtil.parseObj(stateJson).getStr("tenantId");
                if (StringUtils.isNotEmpty(stateTenantId) && !stateTenantId.equals(loginBody.getTenantId())) {
                    throw new ServiceException("租户ID与授权状态不匹配");
                }
            }
        }

        List<SysSocialVo> list = sysSocialService.selectByAuthId(authUserData.getSource() + authUserData.getUuid());
        if (CollUtil.isEmpty(list)) {
            // 检查当前租户是否开启自助注册功能
            if (!configService.selectRegisterEnabled(loginBody.getTenantId())) {
                throw new ServiceException("当前系统没有开启注册功能，请联系管理员先创建账号后绑定");
            }
            autoRegisterAndBind(authUserData, loginBody.getTenantId(), client);
            list = sysSocialService.selectByAuthId(authUserData.getSource() + authUserData.getUuid());
        }
        SysSocialVo social;
        if (TenantHelper.isEnable()) {
            Optional<SysSocialVo> opt = StreamUtils.findAny(list, x -> x.getTenantId().equals(loginBody.getTenantId()));
            if (opt.isEmpty()) {
                throw new ServiceException("对不起，你没有权限登录当前租户！");
            }
            social = opt.get();
        } else {
            social = list.get(0);
        }
        LoginUser loginUser = TenantHelper.dynamic(social.getTenantId(), () -> {
            SysUserVo user = loadUser(social.getUserId());
            // 此处可根据登录用户的数据不同 自行创建 loginUser 属性不够用继承扩展就行了
            return loginService.buildLoginUser(user);
        });
        loginUser.setClientKey(client.getClientKey());
        loginUser.setDeviceType(client.getDeviceType());
        SaLoginParameter model = new SaLoginParameter();
        model.setDeviceType(client.getDeviceType());
        // 自定义分配 不同用户体系 不同 token 授权时间 不设置默认走全局 yml 配置
        // 例如: 后台用户30分钟过期 app用户1天过期
        model.setTimeout(client.getTimeout());
        model.setActiveTimeout(client.getActiveTimeout());
        model.setExtra(LoginHelper.CLIENT_KEY, client.getClientId());
        // 生成token
        LoginHelper.login(loginUser, model);

        LoginVo loginVo = new LoginVo();
        loginVo.setAccessToken(StpUtil.getTokenValue());
        loginVo.setExpireIn(StpUtil.getTokenTimeout());
        loginVo.setClientId(client.getClientId());
        return loginVo;
    }

    private SysUserVo loadUser(Long userId) {
        SysUserVo user = userMapper.selectVoById(userId);
        if (ObjectUtil.isNull(user)) {
            log.info("登录用户：{} 不存在.", "");
            throw new UserException("user.not.exists", "");
        } else if (SystemConstants.DISABLE.equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", "");
            throw new UserException("user.blocked", "");
        }
        return user;
    }

    @Lock4j(keys = {"#tenantId", "#authUserData.source", "#authUserData.uuid"})
    private void autoRegisterAndBind(AuthUser authUserData, String tenantId, SysClientVo client) {
        String nickname = authUserData.getNickname();
        String baseUsername = nickname != null ? nickname : authUserData.getUsername();
        final String finalUsername = resolveUniqueUsername(baseUsername, tenantId);
        SysUserBo newUser = new SysUserBo();
        newUser.setUserName(finalUsername);
        newUser.setNickName(nickname != null ? nickname : finalUsername);
        // 第三方登录无密码，设置随机密码
        newUser.setPassword(cn.hutool.crypto.digest.BCrypt.hashpw(RandomUtil.randomString(16)));
        userService.registerUser(newUser, tenantId);

        SysUserVo savedUser = TenantHelper.dynamic(tenantId, () ->
            userMapper.selectVoOne(new LambdaQueryWrapper<SysUser>()
                .eq(SysUser::getUserName, finalUsername)));

        SysSocialBo bo = new SysSocialBo();
        bo.setUserId(savedUser.getUserId());
        bo.setAuthId(authUserData.getSource() + authUserData.getUuid());
        bo.setSource(authUserData.getSource());
        bo.setOpenId(authUserData.getUuid());
        bo.setUserName(authUserData.getUsername());
        bo.setNickName(authUserData.getNickname());
        bo.setEmail(authUserData.getEmail());
        bo.setAvatar(authUserData.getAvatar());
        if (authUserData.getToken() != null) {
            bo.setAccessToken(authUserData.getToken().getAccessToken());
            bo.setRefreshToken(authUserData.getToken().getRefreshToken());
            bo.setExpireIn(authUserData.getToken().getExpireIn());
        }
        sysSocialService.insertByBo(bo);
    }

    private String resolveUniqueUsername(String base, String tenantId) {
        String[] candidate = {base};
        while (Boolean.TRUE.equals(TenantHelper.dynamic(tenantId, () ->
            userMapper.exists(new LambdaQueryWrapper<SysUser>()
                .eq(SysUser::getUserName, candidate[0]))))) {
            candidate[0] = base + RandomUtil.randomNumbers(4);
        }
        return candidate[0];
    }

}
