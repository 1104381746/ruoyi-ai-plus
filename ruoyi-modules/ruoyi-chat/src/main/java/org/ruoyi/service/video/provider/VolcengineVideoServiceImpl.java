package org.ruoyi.service.video.provider;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.volcengine.service.visual.IVisualService;
import com.volcengine.service.visual.impl.VisualServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.service.GenerationCancelManager;
import org.ruoyi.service.GenerationCancelledException;
import org.ruoyi.service.video.AbstractVideoGenerationService;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class VolcengineVideoServiceImpl extends AbstractVideoGenerationService {

    private final GenerationCancelManager cancelManager;

    private static final int POLL_INTERVAL_MS = 5000;
    private static final int POLL_MAX_ATTEMPTS = 120;

    @Override
    protected String doGenerateVideo(ChatModelVo modelVo, String prompt, String size, Integer duration, Integer seed, String referenceImageUrl, String sessionId) {
        IVisualService visualService = VisualServiceImpl.getInstance();
        visualService.setAccessKey(modelVo.getApiKey().split("\\.")[0]);
        visualService.setSecretKey(modelVo.getApiKey().split("\\.")[1]);

        JSONObject req = new JSONObject();
        req.put("req_key", modelVo.getModelName());
        if (referenceImageUrl != null) {
            try {
                String base64 = downloadAndEncodeBase64(referenceImageUrl);
                req.put("binary_data_base64", new String[]{base64});
            } catch (Exception e) {
                log.error("下载参考图失败: {}", referenceImageUrl, e);
                throw new RuntimeException("参考图下载失败");
            }
        }
        req.put("prompt", prompt);
        if (seed != null) req.put("seed", seed);
        if (duration != null) req.put("frames", duration * 24 + 1);

        try {
            log.info("提交即梦视频任务: req_key={}, prompt={}, referenceImageUrl={}", req.getString("req_key"), prompt, referenceImageUrl);
            Object response = visualService.cvSync2AsyncSubmitTask(req);
            JSONObject result = JSON.parseObject(JSON.toJSONString(response));

            if (result.getInteger("code") != 10000) {
                throw new RuntimeException("任务提交失败: " + result.getString("message"));
            }

            String taskId = result.getJSONObject("data").getString("task_id");
            return pollTask(visualService, taskId, req.getString("req_key"), sessionId);
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            log.error("视频生成失败", e);
            throw new RuntimeException("视频生成失败: " + e.getMessage());
        }
    }

    private String pollTask(IVisualService visualService, String taskId, String reqKey, String sessionId) {
        JSONObject req = new JSONObject();
        req.put("req_key", reqKey);
        req.put("task_id", taskId);

        for (int i = 0; i < POLL_MAX_ATTEMPTS; i++) {
            if (cancelManager.isCancelled(sessionId)) {
                log.info("即梦视频任务 {} 被用户取消", taskId);
                throw new GenerationCancelledException();
            }
            try {
                Thread.sleep(POLL_INTERVAL_MS);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new RuntimeException("轮询被中断", e);
            }

            try {
                Object response = visualService.cvSync2AsyncGetResult(req);
                JSONObject result = JSON.parseObject(JSON.toJSONString(response));

                if (result.getInteger("code") != 10000) {
                    throw new RuntimeException("查询失败: " + result.getString("message"));
                }

                JSONObject data = result.getJSONObject("data");
                String status = data.getString("status");
                log.info("轮询视频任务 {} 状态: {}", taskId, status);

                if ("done".equals(status)) {
                    return data.getString("video_url");
                }
                if ("expired".equals(status) || "not_found".equals(status)) {
                    throw new RuntimeException("任务" + status);
                }
            } catch (Exception e) {
                log.error("轮询任务异常", e);
                throw new RuntimeException("轮询失败", e);
            }
        }
        throw new RuntimeException("视频生成超时");
    }

    private String downloadAndEncodeBase64(String url) throws Exception {
        java.net.URL imageUrl = new java.net.URL(url);
        java.net.URLConnection conn = imageUrl.openConnection();
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(30000);
        try (java.io.InputStream in = conn.getInputStream();
             java.io.ByteArrayOutputStream out = new java.io.ByteArrayOutputStream()) {
            byte[] buffer = new byte[8192];
            int len;
            while ((len = in.read(buffer)) != -1) {
                out.write(buffer, 0, len);
            }
            return java.util.Base64.getEncoder().encodeToString(out.toByteArray());
        }
    }

    @Override
    public String getProviderName() {
        return "volcengine";
    }
}
