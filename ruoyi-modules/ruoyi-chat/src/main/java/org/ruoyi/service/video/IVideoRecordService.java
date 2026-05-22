package org.ruoyi.service.video;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.ruoyi.domain.bo.VideoRecordBo;
import org.ruoyi.domain.vo.VideoRecordVo;

public interface IVideoRecordService {
    VideoRecordVo generate(VideoRecordBo bo);
    Page<VideoRecordVo> listByUser(int pageNum, int pageSize, String keyword);
    void deleteById(Long id);
}
