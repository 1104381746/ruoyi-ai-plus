package org.ruoyi.service.video.provider;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.volcengine.service.visual.IVisualService;
import com.volcengine.service.visual.impl.VisualServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.service.video.AbstractVideoGenerationService;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class VolcengineVideoServiceImpl extends AbstractVideoGenerationService {

    private static final int POLL_INTERVAL_MS = 5000;
    private static final int POLL_MAX_ATTEMPTS = 120;

    @Override
    protected String doGenerateVideo(ChatModelVo modelVo, String prompt, String size, Integer duration, Integer seed) {
        IVisualService visualService = VisualServiceImpl.getInstance();
        visualService.setAccessKey(modelVo.getApiKey().split("\\.")[0]);
        visualService.setSecretKey(modelVo.getApiKey().split("\\.")[1]);

        JSONObject req = new JSONObject();
        req.put("req_key", "jimeng_t2v_v30");
        req.put("prompt", prompt);
        if (seed != null) req.put("seed", seed);
        if (duration != null) req.put("frames", duration * 24 + 1);
        if (size != null) req.put("aspect_ratio", convertSize(size));

        try {
            log.info("提交即梦视频任务: prompt={}", prompt);
            Object response = visualService.cvSync2AsyncSubmitTask(req);
            JSONObject result = JSON.parseObject(JSON.toJSONString(response));

            if (result.getInteger("code") != 10000) {
                throw new RuntimeException("任务提交失败: " + result.getString("message"));
            }

            String taskId = result.getJSONObject("data").getString("task_id");
            return pollTask(visualService, taskId);
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            log.error("视频生成失败", e);
            throw new RuntimeException("视频生成失败: " + e.getMessage());
        }
    }

    private String pollTask(IVisualService visualService, String taskId) {
        JSONObject req = new JSONObject();
        req.put("req_key", "jimeng_t2v_v30");
        req.put("task_id", taskId);

        for (int i = 0; i < POLL_MAX_ATTEMPTS; i++) {
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

    private String convertSize(String size) {
        return switch (size) {
            case "720x480" -> "3:2";
            case "1280x720" -> "16:9";
            case "1920x1080" -> "16:9";
            case "3840x2160" -> "16:9";
            default -> "16:9";
        };
    }

    @Override
    public String getProviderName() {
        return "volcengine";
    }
}
