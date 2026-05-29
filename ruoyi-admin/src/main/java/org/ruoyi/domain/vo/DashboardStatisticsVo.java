package org.ruoyi.domain.vo;

import lombok.Data;

/**
 * 首页统计
 */
@Data
public class DashboardStatisticsVo {
    /** 用户总数 */
    private Long userCount;
    /** AI模型总数 */
    private Long modelCount;
    /** 今日API调用量 */
    private Long todayCallCount;
    /** 七日内API调用量 */
    private Long weekCallCount;
    /** 当月API调用量 */
    private Long monthCallCount;
}
