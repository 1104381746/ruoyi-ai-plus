package org.ruoyi.common.chat.service.video;

import org.ruoyi.common.chat.entity.video.VideoContext;

public interface IVideoGenerationService {
    String generateVideo(VideoContext context);
    String getProviderName();
}
