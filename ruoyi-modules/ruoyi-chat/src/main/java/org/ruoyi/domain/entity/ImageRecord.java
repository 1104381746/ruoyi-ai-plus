package org.ruoyi.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.common.tenant.core.TenantEntity;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("image_record")
public class ImageRecord extends TenantEntity {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Long modelId;
    private String sessionId;
    private String prompt;
    private String size;
    private Integer seed;
    private String imageUrl;
}
