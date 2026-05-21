package org.ruoyi.domain.vo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.domain.entity.ImageRecord;
import java.time.LocalDateTime;

@Data
@AutoMapper(target = ImageRecord.class)
public class ImageRecordVo {
    private Long id;
    private Long userId;
    private Long modelId;
    private String sessionId;
    private String prompt;
    private String size;
    private Integer seed;
    private String imageUrl;
    private LocalDateTime createTime;
}
