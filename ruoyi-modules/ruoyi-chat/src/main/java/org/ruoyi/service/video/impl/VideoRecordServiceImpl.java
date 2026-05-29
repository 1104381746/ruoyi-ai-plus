package org.ruoyi.service.video.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.github.linpeilie.Converter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.common.chat.entity.video.VideoContext;
import org.ruoyi.common.chat.service.chat.IChatModelService;
import org.ruoyi.common.oss.factory.OssFactory;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.domain.bo.VideoRecordBo;
import org.ruoyi.domain.bo.chat.ChatSessionBo;
import org.ruoyi.domain.entity.VideoRecord;
import org.ruoyi.domain.vo.VideoRecordVo;
import org.ruoyi.mapper.video.VideoRecordMapper;
import org.ruoyi.service.GenerationCancelManager;
import org.ruoyi.service.GenerationCancelledException;
import org.ruoyi.service.chat.IChatSessionService;
import org.ruoyi.service.video.AbstractVideoGenerationService;
import org.ruoyi.service.video.IVideoRecordService;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.stream.Collectors;

@Slf4j

@Service
@RequiredArgsConstructor
public class VideoRecordServiceImpl implements IVideoRecordService {

    private final VideoRecordMapper videoRecordMapper;
    private final IChatModelService chatModelService;
    private final IChatSessionService chatSessionService;
    private final ApplicationContext applicationContext;
    private final Converter converter;
    private final GenerationCancelManager cancelManager;

    @Override
    public VideoRecordVo generate(VideoRecordBo bo) {
        ChatModelVo modelVo = chatModelService.selectModelByName(bo.getModelName());
        if (modelVo == null) throw new RuntimeException("模型不存在: " + bo.getModelName());

        // 新会话：创建 chat_session 记录
        if (bo.getSessionId() == null || bo.getSessionId().isBlank()) {
            ChatSessionBo sessionBo = new ChatSessionBo();
            sessionBo.setUserId(LoginHelper.getUserId());
            sessionBo.setSessionTitle(bo.getContent().length() > 50 ? bo.getContent().substring(0, 50) : bo.getContent());
            sessionBo.setSessionContent(bo.getContent());
            sessionBo.setType("video");
            chatSessionService.insertByBo(sessionBo);
            bo.setSessionId(String.valueOf(sessionBo.getId()));
        }

        var context = VideoContext.builder()
                .chatModelVo(modelVo)
                .prompt(bo.getContent())
                .size(bo.getSize())
                .duration(bo.getDuration())
                .seed(bo.getSeed())
                .referenceImageUrl(bo.getReferenceImageUrl())
                .sessionId(bo.getSessionId())
                .build();

        var providers = applicationContext.getBeansOfType(AbstractVideoGenerationService.class).values();
        AbstractVideoGenerationService provider = providers.stream()
                .filter(p -> p.getProviderName().equalsIgnoreCase(modelVo.getProviderCode()))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("No video provider for: " + modelVo.getProviderCode()));

        var record = new VideoRecord();
        record.setUserId(LoginHelper.getUserId());
        record.setModelName(modelVo.getModelName());
        record.setSessionId(bo.getSessionId());
        record.setContent(bo.getContent());
        record.setRole("user");
        record.setTotalTokens(0);
        record.setSize(bo.getSize());
        record.setDuration(bo.getDuration());
        record.setSeed(bo.getSeed());
        record.setReferenceImageUrl(bo.getReferenceImageUrl());

        String videoUrl = null;
        try {
            videoUrl = provider.generateVideo(context);
            if (cancelManager.isCancelled(bo.getSessionId())) {
                record.setStatus(3);
                videoRecordMapper.insert(record);
                return converter.convert(record, VideoRecordVo.class);
            }
            videoUrl = uploadToOss(videoUrl);
            record.setVideoUrl(videoUrl);
            record.setStatus(1);
        } catch (GenerationCancelledException e) {
            record.setStatus(3);
            videoRecordMapper.insert(record);
            return converter.convert(record, VideoRecordVo.class);
        } catch (Exception e) {
            record.setStatus(2);
            videoRecordMapper.insert(record);
            throw e instanceof RuntimeException re ? re : new RuntimeException(e);
        } finally {
            cancelManager.clear(bo.getSessionId());
        }
        videoRecordMapper.insert(record);

        return converter.convert(record, VideoRecordVo.class);
    }

    @Override
    public void cancel(String sessionId) {
        cancelManager.cancel(sessionId);
    }

    private String uploadToOss(String url) {
        try {
            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(java.time.Duration.ofSeconds(10))
                    .build();
            HttpResponse<InputStream> resp = client.send(
                    HttpRequest.newBuilder(URI.create(url))
                            .timeout(java.time.Duration.ofMinutes(5))
                            .build(),
                    HttpResponse.BodyHandlers.ofInputStream());
            long contentLength = resp.headers().firstValueAsLong("content-length").orElse(-1L);
            try (InputStream is = resp.body()) {
                return OssFactory.instance().uploadSuffix(is, ".mp4", contentLength, "video/mp4").getUrl();
            }
        } catch (Exception e) {
            log.warn("视频上传OSS失败，使用原始URL: {}", e.getMessage());
            return url;
        }
    }

    @Override
    public Page<VideoRecordVo> listByUser(int pageNum, int pageSize, String keyword, String sessionId) {
        long userId = LoginHelper.getUserId();
        Page<VideoRecord> page = videoRecordMapper.selectPage(
                new Page<>(pageNum, pageSize),
                new LambdaQueryWrapper<VideoRecord>()
                        .eq(VideoRecord::getUserId, userId)
                        .like(keyword != null && !keyword.isBlank(), VideoRecord::getContent, keyword)
                        .eq(sessionId != null && !sessionId.isBlank(), VideoRecord::getSessionId, sessionId)
                        .orderByDesc(VideoRecord::getCreateTime));
        Page<VideoRecordVo> voPage = new Page<>(page.getCurrent(), page.getSize(), page.getTotal());
        voPage.setRecords(page.getRecords().stream()
                .map(r -> converter.convert(r, VideoRecordVo.class))
                .collect(Collectors.toList()));
        return voPage;
    }

    @Override
    public void deleteById(Long id) {
        long userId = LoginHelper.getUserId();
        videoRecordMapper.delete(new LambdaQueryWrapper<VideoRecord>()
                .eq(VideoRecord::getId, id)
                .eq(VideoRecord::getUserId, userId));
    }
}
