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
import org.ruoyi.domain.entity.VideoRecord;
import org.ruoyi.domain.vo.VideoRecordVo;
import org.ruoyi.mapper.video.VideoRecordMapper;
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
    private final ApplicationContext applicationContext;
    private final Converter converter;

    @Override
    public VideoRecordVo generate(VideoRecordBo bo) {
        ChatModelVo modelVo = chatModelService.queryById(bo.getModelId());
        var context = VideoContext.builder()
                .chatModelVo(modelVo)
                .prompt(bo.getPrompt())
                .size(bo.getSize())
                .duration(bo.getDuration())
                .seed(bo.getSeed())
                .build();

        var providers = applicationContext.getBeansOfType(AbstractVideoGenerationService.class).values();
        AbstractVideoGenerationService provider = providers.stream()
                .filter(p -> p.getProviderName().equalsIgnoreCase(modelVo.getProviderCode()))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("No video provider for: " + modelVo.getProviderCode()));

        var record = new VideoRecord();
        record.setUserId(LoginHelper.getUserId());
        record.setModelId(bo.getModelId());
        record.setSessionId(bo.getSessionId());
        record.setPrompt(bo.getPrompt());
        record.setSize(bo.getSize());
        record.setDuration(bo.getDuration());
        record.setSeed(bo.getSeed());

        String videoUrl = null;
        try {
            videoUrl = provider.generateVideo(context);
            videoUrl = uploadToOss(videoUrl);
            record.setVideoUrl(videoUrl);
            record.setStatus(1);
        } catch (Exception e) {
            record.setStatus(2);
            videoRecordMapper.insert(record);
            throw e instanceof RuntimeException re ? re : new RuntimeException(e);
        }
        videoRecordMapper.insert(record);

        return converter.convert(record, VideoRecordVo.class);
    }

    private String uploadToOss(String url) {
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<InputStream> resp = client.send(
                    HttpRequest.newBuilder(URI.create(url)).build(),
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
    public Page<VideoRecordVo> listByUser(int pageNum, int pageSize) {
        long userId = LoginHelper.getUserId();
        Page<VideoRecord> page = videoRecordMapper.selectPage(
                new Page<>(pageNum, pageSize),
                new LambdaQueryWrapper<VideoRecord>()
                        .eq(VideoRecord::getUserId, userId)
                        .orderByAsc(VideoRecord::getCreateTime));
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
