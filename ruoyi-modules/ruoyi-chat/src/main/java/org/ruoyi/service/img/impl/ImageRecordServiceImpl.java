package org.ruoyi.service.img.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.github.linpeilie.Converter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.common.chat.entity.image.ImageContext;
import org.ruoyi.common.chat.service.chat.IChatModelService;
import org.ruoyi.common.oss.factory.OssFactory;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.domain.bo.ImageRecordBo;
import org.ruoyi.domain.bo.chat.ChatSessionBo;
import org.ruoyi.domain.entity.ImageRecord;
import org.ruoyi.domain.vo.ImageRecordVo;
import org.ruoyi.mapper.img.ImageRecordMapper;
import org.ruoyi.service.GenerationCancelManager;
import org.ruoyi.service.GenerationCancelledException;
import org.ruoyi.service.chat.IChatSessionService;
import org.ruoyi.service.img.IImageRecordService;
import org.ruoyi.enums.ImageModeType;
import org.ruoyi.service.image.AbstractImageGenerationService;
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
public class ImageRecordServiceImpl implements IImageRecordService {

    private final ImageRecordMapper imageRecordMapper;
    private final IChatModelService chatModelService;
    private final IChatSessionService chatSessionService;
    private final ApplicationContext applicationContext;
    private final Converter converter;
    private final GenerationCancelManager cancelManager;

    @Override
    public ImageRecordVo generate(ImageRecordBo bo) {
        ChatModelVo modelVo = chatModelService.selectModelByName(bo.getModelName());
        if (modelVo == null) throw new RuntimeException("模型不存在: " + bo.getModelName());

        // 新会话：创建 chat_session 记录
        if (bo.getSessionId() == null || bo.getSessionId().isBlank()) {
            ChatSessionBo sessionBo = new ChatSessionBo();
            sessionBo.setUserId(LoginHelper.getUserId());
            sessionBo.setSessionTitle(bo.getContent().length() > 50 ? bo.getContent().substring(0, 50) : bo.getContent());
            sessionBo.setSessionContent(bo.getContent());
            sessionBo.setType("image");
            chatSessionService.insertByBo(sessionBo);
            bo.setSessionId(String.valueOf(sessionBo.getId()));
        }

        var context = ImageContext.builder()
                .chatModelVo(modelVo)
                .prompt(bo.getContent())
                .size(bo.getSize())
                .seed(bo.getSeed())
                .referenceImageUrl(bo.getReferenceImageUrl())
                .sessionId(bo.getSessionId())
                .build();

        var providers = applicationContext.getBeansOfType(AbstractImageGenerationService.class).values();
        AbstractImageGenerationService provider = providers.stream()
                .filter(p -> p.getProviderName().equalsIgnoreCase(modelVo.getProviderCode()))
                .findFirst()
                .orElseGet(() -> providers.stream()
                        .filter(p -> p.getProviderName().equals(ImageModeType.OPENAI.getCode()))
                        .findFirst()
                        .orElseThrow(() -> new RuntimeException("No image provider for: " + modelVo.getProviderCode())));
        var record = new ImageRecord();
        record.setUserId(LoginHelper.getUserId());
        record.setModelName(modelVo.getModelName());
        record.setSessionId(bo.getSessionId());
        record.setContent(bo.getContent());
        record.setRole("user");
        record.setTotalTokens(0);
        record.setSize(bo.getSize());
        record.setSeed(bo.getSeed());
        record.setReferenceImageUrl(bo.getReferenceImageUrl());

        String imageUrl;
        try {
            imageUrl = provider.generateImage(context);
            if (cancelManager.isCancelled(bo.getSessionId())) {
                record.setStatus(3);
                imageRecordMapper.insert(record);
                return converter.convert(record, ImageRecordVo.class);
            }
            imageUrl = uploadToOss(imageUrl);
            record.setImageUrl(imageUrl);
            record.setStatus(1);
        } catch (GenerationCancelledException e) {
            record.setStatus(3);
            imageRecordMapper.insert(record);
            return converter.convert(record, ImageRecordVo.class);
        } catch (Exception e) {
            record.setStatus(2);
            imageRecordMapper.insert(record);
            throw e instanceof RuntimeException re ? re : new RuntimeException(e);
        } finally {
            cancelManager.clear(bo.getSessionId());
        }
        imageRecordMapper.insert(record);

        return converter.convert(record, ImageRecordVo.class);
    }

    @Override
    public void cancel(String sessionId) {
        cancelManager.cancel(sessionId);
    }

    private String uploadToOss(String url) {
        if (url == null || url.isEmpty()) return url;
        try {
            if (url.startsWith("data:image/")) {
                // base64 data URI: data:image/png;base64,<data>
                int comma = url.indexOf(',');
                String meta = url.substring(5, comma); // image/png;base64
                String ext = meta.split(";")[0].split("/")[1]; // png
                byte[] bytes = java.util.Base64.getDecoder().decode(url.substring(comma + 1));
                try (InputStream is = new java.io.ByteArrayInputStream(bytes)) {
                    return OssFactory.instance().uploadSuffix(is, "." + ext, (long) bytes.length, "image/" + ext).getUrl();
                }
            }
            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(java.time.Duration.ofSeconds(10))
                    .build();
            HttpResponse<InputStream> resp = client.send(
                    HttpRequest.newBuilder(URI.create(url))
                            .timeout(java.time.Duration.ofSeconds(30))
                            .build(),
                    HttpResponse.BodyHandlers.ofInputStream());
            long contentLength = resp.headers().firstValueAsLong("content-length").orElse(-1L);
            String ct = resp.headers().firstValue("content-type").orElse("image/jpeg");
            String ext = ct.contains("png") ? ".png" : ct.contains("webp") ? ".webp" : ct.contains("gif") ? ".gif" : ".jpg";
            String mimeType = ct.contains(";") ? ct.substring(0, ct.indexOf(';')).trim() : ct;
            try (InputStream is = resp.body()) {
                return OssFactory.instance().uploadSuffix(is, ext, contentLength, mimeType).getUrl();
            }
        } catch (Exception e) {
            log.warn("图片上传OSS失败，使用原始URL: {}", e.getMessage());
            return url;
        }
    }


    @Override
    public Page<ImageRecordVo> listByUser(int pageNum, int pageSize, String keyword, String sessionId) {
        long userId = LoginHelper.getUserId();
        Page<ImageRecord> page = imageRecordMapper.selectPage(
                new Page<>(pageNum, pageSize),
                new LambdaQueryWrapper<ImageRecord>()
                        .eq(ImageRecord::getUserId, userId)
                        .like(keyword != null && !keyword.isBlank(), ImageRecord::getContent, keyword)
                        .eq(sessionId != null && !sessionId.isBlank(), ImageRecord::getSessionId, sessionId)
                        .orderByDesc(ImageRecord::getCreateTime));
        Page<ImageRecordVo> voPage = new Page<>(page.getCurrent(), page.getSize(), page.getTotal());
        voPage.setRecords(page.getRecords().stream()
                .map(r -> converter.convert(r, ImageRecordVo.class))
                .collect(Collectors.toList()));
        return voPage;
    }

    @Override
    public void deleteById(Long id) {
        long userId = LoginHelper.getUserId();
        imageRecordMapper.delete(new LambdaQueryWrapper<ImageRecord>()
                .eq(ImageRecord::getId, id)
                .eq(ImageRecord::getUserId, userId));
    }
}
