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
    private Long modelId;
    private String sessionId;
    private String prompt;
    private String size;
    private Integer duration;
    private Integer seed;
    private String videoUrl;
    private Integer status;
    private LocalDateTime createTime;
}
