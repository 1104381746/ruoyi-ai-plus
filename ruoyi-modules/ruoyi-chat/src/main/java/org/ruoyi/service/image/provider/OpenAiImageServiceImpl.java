package org.ruoyi.service.image.provider;

import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.enums.ImageModeType;
import org.ruoyi.service.GenerationCancelManager;
import org.ruoyi.service.GenerationCancelledException;
import org.ruoyi.service.image.AbstractImageGenerationService;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestClient;

import java.time.Duration;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class OpenAiImageServiceImpl extends AbstractImageGenerationService {

    private final GenerationCancelManager cancelManager;
    private final RestClient restClient = RestClient.builder()
        .defaultStatusHandler(status -> status.is4xxClientError() || status.is5xxServerError(), (request, response) -> {
            throw new RuntimeException("HTTP " + response.getStatusCode() + ": " + new String(response.getBody().readAllBytes()));
        })
        .build();

    private static final Duration REQUEST_TIMEOUT = Duration.ofMinutes(2);
    private static final int POLL_INTERVAL_MS = 3000;
    private static final int POLL_MAX_ATTEMPTS = 100;

    @Override
    protected String doGenerateImage(ChatModelVo chatModelVo, String prompt, String size, Integer seed, String referenceImageUrl, String sessionId) {
        try {
            if (StrUtil.isNotBlank(referenceImageUrl)) {
                return doImageEdit(chatModelVo, prompt, size, seed, referenceImageUrl, sessionId);
            }
            return doTextToImage(chatModelVo, prompt, size, seed, sessionId);
        } catch (RuntimeException e) {
            log.error("OpenAI 兼容图片接口调用失败", e);
            throw e;
        } catch (Exception e) {
            log.error("OpenAI 兼容图片接口调用失败", e);
            throw new RuntimeException(e);
        }
    }

    private String doTextToImage(ChatModelVo chatModelVo, String prompt, String size, Integer seed, String sessionId) throws InterruptedException {
        var body = new java.util.LinkedHashMap<String, Object>();
        body.put("model", chatModelVo.getModelName());
        body.put("prompt", prompt);
        body.put("n", 1);
        if (size != null) body.put("size", size);

        log.info("调用 OpenAI 兼容文生图接口: {}", chatModelVo.getApiHost());
        var response = restClient.post()
            .uri(chatModelVo.getApiHost() + "/images/generations")
            .header("Authorization", "Bearer " + chatModelVo.getApiKey())
            .contentType(MediaType.APPLICATION_JSON)
            .body(body)
            .retrieve()
            .body(Map.class);

        return handleResponse(chatModelVo, response, sessionId);
    }

    private String doImageEdit(ChatModelVo chatModelVo, String prompt, String size, Integer seed, String referenceImageUrl, String sessionId) throws InterruptedException {
        byte[] imageBytes = downloadImage(referenceImageUrl);

        var body = new LinkedMultiValueMap<String, Object>();
        body.add("model", chatModelVo.getModelName());
        body.add("prompt", prompt);
        body.add("image", new ByteArrayResource(imageBytes) {
            @Override
            public String getFilename() {
                return "image.png";
            }
        });
        if (size != null) body.add("size", size);

        log.info("调用 OpenAI 兼容图生图接口(编辑): {}", chatModelVo.getApiHost());
        var response = restClient.post()
            .uri(chatModelVo.getApiHost() + "/images/edits")
            .header("Authorization", "Bearer " + chatModelVo.getApiKey())
            .contentType(MediaType.MULTIPART_FORM_DATA)
            .body(body)
            .retrieve()
            .body(Map.class);

        return handleResponse(chatModelVo, response, sessionId);
    }

    private String handleResponse(ChatModelVo chatModelVo, Map<?, ?> response, String sessionId) throws InterruptedException {
        if (response == null) return "";

        if (response.get("data") instanceof List<?> dataList && !dataList.isEmpty()) {
            return extractUrl((Map<String, Object>) dataList.get(0));
        }

        String taskId = (String) response.get("task_id");
        if (taskId != null) {
            return pollTask(chatModelVo, taskId, sessionId);
        }

        return "";
    }

    private byte[] downloadImage(String imageUrl) {
        return restClient.get()
            .uri(imageUrl)
            .retrieve()
            .body(byte[].class);
    }

    private String pollTask(ChatModelVo chatModelVo, String taskId, String sessionId) throws InterruptedException {
        String taskUrl = chatModelVo.getApiHost() + "/images/tasks/" + taskId;

        for (int i = 0; i < POLL_MAX_ATTEMPTS; i++) {
            if (cancelManager.isCancelled(sessionId)) {
                log.info("图片任务 {} 被用户取消", taskId);
                throw new GenerationCancelledException();
            }
            Thread.sleep(POLL_INTERVAL_MS);
            var result = restClient.get()
                .uri(taskUrl)
                .header("Authorization", "Bearer " + chatModelVo.getApiKey())
                .retrieve()
                .body(Map.class);
            if (result == null) continue;
            String status = (String) result.get("status");
            log.info("轮询任务 {} 状态: {}", taskId, status);
            if ("success".equals(status) || "complete".equals(status)) {
                if (result.get("data") instanceof List<?> dataList && !dataList.isEmpty()) {
                    return extractUrl((Map<String, Object>) dataList.get(0));
                }
            }
            if ("failed".equals(status) || "error".equals(status)) {
                log.error("图片任务失败: {}", result);
                String errorMsg = result.get("error") != null ? result.get("error").toString() : "图片生成失败";
                throw new RuntimeException(errorMsg);
            }
        }
        log.error("图片任务超时: {}", taskId);
        throw new RuntimeException("图片生成超时，请稍后重试");
    }

    private String extractUrl(Map<String, Object> item) {
        String url = (String) item.get("url");
        if (url != null && !url.isEmpty()) return url;
        String b64 = (String) item.get("b64_json");
        if (b64 != null && !b64.isEmpty()) return "data:image/png;base64," + b64;
        return "";
    }

    @Override
    public String getProviderName() {
        return ImageModeType.OPENAI.getCode();
    }
}
