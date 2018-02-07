package com.itender.ms.directive;

import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Map;

/**
 * 处理单个事件的标签
 * @param <T>
 */
public abstract class SingleDirective<T> extends HandleDirective {
    /**
     * Logger for this class
     */
    private static final Logger logger = LoggerFactory.getLogger(SingleDirective.class);

    @Override
    protected Object handle(Map params, Map<String, Object> envParams) throws TemplateException, IOException {
        return field(params, envParams);
    }

    /**
     * 查找列表
     *
     * @param params    参数MAP
     * @param envParams 环境变量
     * @return
     */
    @SuppressWarnings("rawtypes")
    protected abstract T field(Map params, Map<String, Object> envParams);
}
