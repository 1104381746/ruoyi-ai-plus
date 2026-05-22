package org.ruoyi.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.ruoyi.domain.entity.VideoRecord;

@Data
@AutoMapper(target = VideoRecord.class)
public class VideoRecordBo {
    @NotNull
    private Long modelId;
    private String sessionId;
    @NotBlank
    private String prompt;
    private String size;
    private Integer duration;
    private Integer seed;
}
