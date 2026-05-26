package org.ruoyi.service.video;

import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.common.chat.entity.video.VideoContext;
import org.ruoyi.common.chat.service.video.IVideoGenerationService;

public abstract class AbstractVideoGenerationService implements IVideoGenerationService {

    @Override
    public String generateVideo(VideoContext context) {
        return doGenerateVideo(
            context.getChatModelVo(),
            context.getPrompt(),
            context.getSize(),
            context.getDuration(),
            context.getSeed(),
            context.getReferenceImageUrl()
        );
    }

    protected abstract String doGenerateVideo(ChatModelVo modelVo, String prompt, String size, Integer duration, Integer seed, String referenceImageUrl);
}
