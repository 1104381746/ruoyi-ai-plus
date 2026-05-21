package org.ruoyi.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.ruoyi.domain.entity.ImageRecord;

@Data
@AutoMapper(target = ImageRecord.class)
public class ImageRecordBo {
    @NotNull
    private Long modelId;
    private String sessionId;
    @NotBlank
    private String prompt;
    private String size;
    private Integer seed;
}
