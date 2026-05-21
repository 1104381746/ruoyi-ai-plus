package org.ruoyi.service.img;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.ruoyi.domain.bo.ImageRecordBo;
import org.ruoyi.domain.vo.ImageRecordVo;

public interface IImageRecordService {
    ImageRecordVo generate(ImageRecordBo bo);
    Page<ImageRecordVo> listByUser(int pageNum, int pageSize);
    void deleteById(Long id);
}
