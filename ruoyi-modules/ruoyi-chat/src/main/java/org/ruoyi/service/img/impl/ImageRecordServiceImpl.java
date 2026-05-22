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
import org.ruoyi.domain.entity.ImageRecord;
import org.ruoyi.domain.vo.ImageRecordVo;
import org.ruoyi.mapper.img.ImageRecordMapper;
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
    private final ApplicationContext applicationContext;
    private final Converter converter;

    @Override
    public ImageRecordVo generate(ImageRecordBo bo) {
        ChatModelVo modelVo = chatModelService.queryById(bo.getModelId());
        var context = ImageContext.builder()
                .chatModelVo(modelVo)
                .prompt(bo.getPrompt())
                .size(bo.getSize())
                .seed(bo.getSeed())
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
        record.setModelId(bo.getModelId());
        record.setSessionId(bo.getSessionId());
        record.setPrompt(bo.getPrompt());
        record.setSize(bo.getSize());
        record.setSeed(bo.getSeed());

        String imageUrl;
        try {
            imageUrl = provider.generateImage(context);
            imageUrl = uploadToOss(imageUrl);
            record.setImageUrl(imageUrl);
            record.setStatus(1);
        } catch (Exception e) {
            record.setStatus(2);
            imageRecordMapper.insert(record);
            throw e instanceof RuntimeException re ? re : new RuntimeException(e);
        }
        imageRecordMapper.insert(record);

        return converter.convert(record, ImageRecordVo.class);
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
            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<InputStream> resp = client.send(
                    HttpRequest.newBuilder(URI.create(url)).build(),
                    HttpResponse.BodyHandlers.ofInputStream());
            long contentLength = resp.headers().firstValueAsLong("content-length").orElse(-1L);
            String suffix = url.contains(".png") ? ".png" : ".jpg";
            String contentType = url.contains(".png") ? "image/png" : "image/jpeg";
            try (InputStream is = resp.body()) {
                return OssFactory.instance().uploadSuffix(is, suffix, contentLength, contentType).getUrl();
            }
        } catch (Exception e) {
            log.warn("图片上传OSS失败，使用原始URL: {}", e.getMessage());
            return url;
        }
    }


    @Override
    public Page<ImageRecordVo> listByUser(int pageNum, int pageSize, String keyword) {
        long userId = LoginHelper.getUserId();
        Page<ImageRecord> page = imageRecordMapper.selectPage(
                new Page<>(pageNum, pageSize),
                new LambdaQueryWrapper<ImageRecord>()
                        .eq(ImageRecord::getUserId, userId)
                        .like(keyword != null && !keyword.isBlank(), ImageRecord::getPrompt, keyword)
                        .orderByAsc(ImageRecord::getCreateTime));
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
