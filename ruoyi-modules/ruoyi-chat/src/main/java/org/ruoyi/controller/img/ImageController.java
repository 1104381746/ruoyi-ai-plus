package org.ruoyi.controller.img;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.domain.bo.ImageRecordBo;
import org.ruoyi.domain.vo.ImageRecordVo;
import org.ruoyi.service.img.IImageRecordService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/img")
@RequiredArgsConstructor
public class ImageController {

    private final IImageRecordService imageRecordService;

    @PostMapping("/generate")
    public R<ImageRecordVo> generate(@Valid @RequestBody ImageRecordBo bo) {
        return R.ok(imageRecordService.generate(bo));
    }

    @GetMapping("/list")
    public R<Page<ImageRecordVo>> list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String sessionId) {
        return R.ok(imageRecordService.listByUser(pageNum, pageSize, keyword, sessionId));
    }

    @PostMapping("/cancel/{sessionId}")
    public R<Void> cancel(@PathVariable String sessionId) {
        imageRecordService.cancel(sessionId);
        return R.ok();
    }

    @DeleteMapping("/{id}")
    public R<Void> delete(@PathVariable Long id) {
        imageRecordService.deleteById(id);
        return R.ok();
    }
}
