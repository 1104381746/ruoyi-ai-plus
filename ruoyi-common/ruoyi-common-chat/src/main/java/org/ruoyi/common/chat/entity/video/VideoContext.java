package org.ruoyi.common.chat.entity.video;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Data;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;

@Data
@Builder
public class VideoContext {
    @NotNull(message = "模型不能为空")
    private ChatModelVo chatModelVo;
    @NotNull(message = "提示词不能为空")
    private String prompt;
    private String size;
    private Integer duration;
    private Integer seed;
    /** 参考图URL（图生视频时使用，可选） */
    private String referenceImageUrl;
    /** 会话ID（用于取消任务） */
    private String sessionId;
}
