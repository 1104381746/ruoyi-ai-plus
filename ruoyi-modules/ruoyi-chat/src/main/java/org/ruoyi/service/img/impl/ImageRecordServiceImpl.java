package org.ruoyi.service.img.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.github.linpeilie.Converter;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.chat.domain.vo.chat.ChatModelVo;
import org.ruoyi.common.chat.entity.image.ImageContext;
import org.ruoyi.common.chat.service.chat.IChatModelService;
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

import java.util.stream.Collectors;

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
        String imageUrl = provider.generateImage(context);

        var record = new ImageRecord();
        record.setUserId(LoginHelper.getUserId());
        record.setModelId(bo.getModelId());
        record.setSessionId(bo.getSessionId());
        record.setPrompt(bo.getPrompt());
        record.setSize(bo.getSize());
        record.setSeed(bo.getSeed());
        record.setImageUrl(imageUrl);
        imageRecordMapper.insert(record);

        return converter.convert(record, ImageRecordVo.class);
    }

    @Override
    public Page<ImageRecordVo> listByUser(int pageNum, int pageSize) {
        long userId = LoginHelper.getUserId();
        Page<ImageRecord> page = imageRecordMapper.selectPage(
                new Page<>(pageNum, pageSize),
                new LambdaQueryWrapper<ImageRecord>()
                        .eq(ImageRecord::getUserId, userId)
                        .orderByDesc(ImageRecord::getCreateTime));
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
