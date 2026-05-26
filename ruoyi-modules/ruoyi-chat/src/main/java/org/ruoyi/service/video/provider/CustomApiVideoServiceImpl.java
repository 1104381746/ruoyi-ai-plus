package org.ruoyi.service.video.provider;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.service.GenerationCancelManager;
import org.ruoyi.service.GenerationCancelledException;
import org.ruoyi.service.video.AbstractVideoGenerationService;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class CustomApiVideoServiceImpl extends AbstractVideoGenerationService {

    private final RestClient restClient = RestClient.create();
    private final GenerationCancelManager cancelManager;
    private static final int POLL_INTERVAL_MS = 5000;
    private static final int POLL_MAX_ATTEMPTS = 120;

    @Override
    protected String doGenerateVideo(ChatModelVo modelVo, String prompt, String size, Integer duration, Integer seed, String referenceImageUrl) {
        var body = new LinkedHashMap<String, Object>();
        body.put("model", modelVo.getModelName());
        body.put("prompt", prompt);
        if (size != null) body.put("size", size);
        if (duration != null) body.put("duration", duration);
        if (seed != null) body.put("seed", seed);
        if (referenceImageUrl != null) body.put("image_url", referenceImageUrl);

        try {
            log.info("调用文生视频接口: {}, model: {}", modelVo.getApiHost(), modelVo.getModelName());
            var response = restClient.post()
                .uri(modelVo.getApiHost() + "/v1/videos")
                .header("Authorization", "Bearer " + modelVo.getApiKey())
                .contentType(MediaType.APPLICATION_JSON)
                .body(body)
                .retrieve()
                .body(Map.class);

            if (response == null) return "";

            if (response.get("data") instanceof List<?> dataList && !dataList.isEmpty()) {
                return extractUrl((Map<String, Object>) dataList.get(0));
            }

            String taskId = (String) response.get("task_id");
            if (taskId == null) taskId = (String) response.get("id");
            if (taskId != null) {
                return pollTask(modelVo, taskId);
            }

            log.error("文生视频接口返回异常: {}", response);
            return "";
        } catch (Exception e) {
            log.error("文生视频接口调用失败", e);
            throw new RuntimeException("视频生成失败: " + e.getMessage());
        }
    }

    private String pollTask(ChatModelVo modelVo, String taskId) throws InterruptedException {
        String taskUrl = modelVo.getApiHost() + "/v1/videos/" + taskId;
        for (int i = 0; i < POLL_MAX_ATTEMPTS; i++) {
            if (cancelManager.isCancelled()) {
                log.info("视频任务 {} 被用户取消", taskId);
                throw new GenerationCancelledException();
            }
            Thread.sleep(POLL_INTERVAL_MS);
            var result = restClient.get()
                .uri(taskUrl)
                .header("Authorization", "Bearer " + modelVo.getApiKey())
                .retrieve()
                .body(Map.class);
            if (result == null) continue;
            String status = (String) result.get("status");
            log.info("轮询视频任务 {} 状态: {}", taskId, status);
            if ("success".equals(status) || "completed".equals(status) || "complete".equals(status) || "succeeded".equals(status)) {
                if (result.get("data") instanceof List<?> dataList && !dataList.isEmpty()) {
                    return extractUrl((Map<String, Object>) dataList.get(0));
                }
                String url = (String) result.get("video_url");
                if (url != null) return url;
            }
            if ("failed".equals(status) || "error".equals(status)) {
                String msg = result.get("error") != null ? result.get("error").toString() : "视频生成失败";
                throw new RuntimeException(msg);
            }
        }
        throw new RuntimeException("视频生成超时，请稍后重试");
    }

    private String extractUrl(Map<String, Object> item) {
        String url = (String) item.get("url");
        if (url != null && !url.isEmpty()) return url;
        url = (String) item.get("video_url");
        if (url != null && !url.isEmpty()) return url;
        return "";
    }

    @Override
    public String getProviderName() {
        return "custom_api";
    }
}
