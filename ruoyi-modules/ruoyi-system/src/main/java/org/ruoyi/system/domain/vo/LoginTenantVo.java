package org.ruoyi.system.domain.vo;

import lombok.Data;

import java.util.List;

/**
 * 登录租户对象
 *
 * @author Michelle.Chung
 */
@Data
public class LoginTenantVo {

    /**
     * 租户开关（兼容旧字段）
     */
    private Boolean tenantEnabled;

    /**
     * 是否开启多租户（业务层）
     */
    private Boolean multiTenancy;

    /**
     * 默认租户ID（多租户关闭时使用）
     */
    private String defaultTenantId;

    /**
     * 租户对象列表
     */
    private List<TenantListVo> voList;

}
