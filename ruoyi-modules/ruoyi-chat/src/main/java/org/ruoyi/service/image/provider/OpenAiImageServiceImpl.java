package org.ruoyi.service.image.provider;

import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.enums.ImageModeType;
import org.ruoyi.service.image.AbstractImageGenerationService;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class OpenAiImageServiceImpl extends AbstractImageGenerationService {

    private final RestClient restClient = RestClient.create();

    private static final int POLL_INTERVAL_MS = 3000;
    private static final int POLL_MAX_ATTEMPTS = 100; // 最多等 5 分钟

    @Override
    protected String doGenerateImage(ChatModelVo chatModelVo, String prompt, String size, Integer seed) {
        var body = new java.util.LinkedHashMap<String, Object>();
        body.put("model", chatModelVo.getModelName());
        body.put("prompt", prompt);
        body.put("n", 1);
        if (size != null) body.put("size", size);

        try {
            log.info("调用 OpenAI 兼容文生图接口: {}", chatModelVo.getApiHost());
            var response = restClient.post()
                .uri(chatModelVo.getApiHost() + "/v1/images/generations")
                .header("Authorization", "Bearer " + chatModelVo.getApiKey())
                .contentType(MediaType.APPLICATION_JSON)
                .body(body)
                .retrieve()
                .body(Map.class);

            if (response == null) return "";

            // 同步响应：直接包含 data 列表
            if (response.get("data") instanceof List<?> dataList && !dataList.isEmpty()) {
                return extractUrl((Map<String, Object>) dataList.get(0));
            }

            // 异步响应：返回 task_id，需要轮询
            String taskId = (String) response.get("task_id");
            if (taskId != null) {
                return pollTask(chatModelVo, taskId);
            }

            return "";
        } catch (RuntimeException e) {
            log.error("OpenAI 兼容文生图接口调用失败", e);
            throw e;
        } catch (Exception e) {
            log.error("OpenAI 兼容文生图接口调用失败", e);
            throw new RuntimeException(e);
        }
    }

    private String pollTask(ChatModelVo chatModelVo, String taskId) throws InterruptedException {
        String taskUrl = chatModelVo.getApiHost() + "/v1/images/tasks/" + taskId;
        for (int i = 0; i < POLL_MAX_ATTEMPTS; i++) {
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
                log.error("文生图任务失败: {}", result);
                String errorMsg = result.get("error") != null ? result.get("error").toString() : "图片生成失败";
                throw new RuntimeException(errorMsg);
            }
        }
        log.error("文生图任务超时: {}", taskId);
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
    protected Object buildImageModel(ChatModelVo chatModelVo) {
        return null;
    }

    @Override
    public String getProviderName() {
        return ImageModeType.OPENAI.getCode();
    }
}
