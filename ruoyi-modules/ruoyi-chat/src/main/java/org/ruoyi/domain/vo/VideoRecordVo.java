package org.ruoyi.domain.vo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.domain.entity.VideoRecord;
import java.time.LocalDateTime;

@Data
@AutoMapper(target = VideoRecord.class)
public class VideoRecordVo {
    private Long id;
    private Long userId;
    private String modelName;
    private String sessionId;
    private String content;
    private String role;
    private Integer totalTokens;
    private String size;
    private Integer duration;
    private Integer seed;
    private String videoUrl;
    private String referenceImageUrl;
    private Integer status;
    private LocalDateTime createTime;
}
