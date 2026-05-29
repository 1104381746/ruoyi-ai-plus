package org.ruoyi.common.core.domain.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import java.io.Serial;
import java.io.Serializable;

/**
 * 用户注册对象
 *
 * @author Lion Li
 */
@Data
public class RegisterBody implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 租户ID
     */
    @NotBlank(message = "{tenant.not.blank}")
    private String tenantId;

    /**
     * 用户名（用户名密码注册时必填）
     */
    @Length(min = 2, max = 30, message = "{user.username.length.valid}")
    private String username;

    /**
     * 用户密码
     */
    @Length(min = 5, max = 30, message = "{user.password.length.valid}")
    private String password;

    /**
     * 用户类型
     */
    private String userType;

    /**
     * 邮箱（邮件注册时使用）
     */
    @Email(message = "邮箱格式不正确")
    private String email;

    /**
     * 邮箱验证码（邮件注册时使用）
     */
    private String emailCode;

    /**
     * 图形验证码（用户名密码注册时使用）
     */
    private String code;

    /**
     * 图形验证码唯一标识
     */
    private String uuid;

}
