package org.ruoyi.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.util.Date;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.constant.SystemConstants;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.tenant.helper.TenantHelper;
import org.ruoyi.domain.vo.DashboardStatisticsVo;
import org.ruoyi.mapper.chat.ChatModelMapper;
import org.ruoyi.system.domain.SysOperLog;
import org.ruoyi.system.mapper.SysOperLogMapper;
import org.ruoyi.system.mapper.SysUserMapper;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 首页统计
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/dashboard")
public class DashboardController {

    private final ChatModelMapper chatModelMapper;
    private final SysUserMapper sysUserMapper;
    private final SysOperLogMapper sysOperLogMapper;

    @GetMapping("/statistics")
    public R<DashboardStatisticsVo> statistics(@RequestParam(required = false) String tenantId) {
        // 超管且未指定租户 → 查看全部
        // 超管且指定租户 → 只看该租户
        // 普通用户 → 自动过滤自己所在租户
        Supplier<R<DashboardStatisticsVo>> query = () -> {
            DashboardStatisticsVo vo = new DashboardStatisticsVo();

            vo.setUserCount(sysUserMapper.selectCount(new LambdaQueryWrapper<>()));
            vo.setModelCount(chatModelMapper.selectCount(new LambdaQueryWrapper<>()));

            Date now = new Date();
            vo.setTodayCallCount(countByDateRange(
                DateUtil.beginOfDay(now), DateUtil.endOfDay(now)));
            vo.setWeekCallCount(countByDateRange(
                DateUtil.offsetDay(now, -7), now));
            vo.setMonthCallCount(countByDateRange(
                DateUtil.beginOfMonth(now), now));

            return R.ok(vo);
        };

        if (LoginHelper.isSuperAdmin()) {
            if (StringUtils.isNotBlank(tenantId)) {
                return TenantHelper.dynamic(tenantId, query);
            }
            return TenantHelper.ignore(query);
        }
        return query.get();
    }

    private Long countByDateRange(Date begin, Date end) {
        return sysOperLogMapper.selectCount(new LambdaQueryWrapper<SysOperLog>()
            .between(SysOperLog::getOperTime, begin, end));
    }
}
