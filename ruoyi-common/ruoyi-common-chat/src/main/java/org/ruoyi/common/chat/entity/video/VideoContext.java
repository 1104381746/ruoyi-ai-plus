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
}
