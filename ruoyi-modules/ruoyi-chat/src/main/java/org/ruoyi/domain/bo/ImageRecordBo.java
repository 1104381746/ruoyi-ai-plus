package org.ruoyi.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.ruoyi.domain.entity.ImageRecord;

@Data
@AutoMapper(target = ImageRecord.class)
public class ImageRecordBo {
    @NotBlank
    private String modelName;
    private String sessionId;
    @NotBlank
    private String content;
    private String size;
    private Integer seed;
    private String referenceImageUrl;
}
