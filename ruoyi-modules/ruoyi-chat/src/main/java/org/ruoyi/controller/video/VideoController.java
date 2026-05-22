package org.ruoyi.controller.video;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.domain.bo.VideoRecordBo;
import org.ruoyi.domain.vo.VideoRecordVo;
import org.ruoyi.service.video.IVideoRecordService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/video")
@RequiredArgsConstructor
public class VideoController {

    private final IVideoRecordService videoRecordService;

    @PostMapping("/generate")
    public R<VideoRecordVo> generate(@Valid @RequestBody VideoRecordBo bo) {
        return R.ok(videoRecordService.generate(bo));
    }

    @GetMapping("/list")
    public R<Page<VideoRecordVo>> list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize,
            @RequestParam(required = false) String keyword) {
        return R.ok(videoRecordService.listByUser(pageNum, pageSize, keyword));
    }

    @DeleteMapping("/{id}")
    public R<Void> delete(@PathVariable Long id) {
        videoRecordService.deleteById(id);
        return R.ok();
    }
}
