package org.ruoyi.service;

public class GenerationCancelledException extends RuntimeException {
    public GenerationCancelledException() {
        super("生成已取消");
    }
}
