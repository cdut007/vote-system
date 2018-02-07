package com.itender.ms.directive;

import freemarker.core.Environment;
import freemarker.template.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 标签处理器
 * Created by djiep on 2016/4/28.
 */
public abstract class HandleDirective implements TemplateDirectiveModel {
    private static final ObjectWrapper DEFAULT_WRAPER = WrappingTemplateModel
            .getDefaultObjectWrapper();

    @Override
    public void execute(Environment environment, Map params, TemplateModel[] loopVars, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException {
        Map<String, Object> envParams = new HashMap<String, Object>();
        Object obj = this.handle(params, envParams);
        if (obj != null) {
            if (loopVars.length > 0) {
                loopVars[0] = DEFAULT_WRAPER.wrap(obj);
            }

            envVariable(environment, DEFAULT_WRAPER, envParams);
            if (templateDirectiveBody != null) {
                templateDirectiveBody.render(environment.getOut());
            }
        }

    }

    private static void envVariable(Environment env, ObjectWrapper DEFAULT_WRAPER, Map<String, Object> envParams)
            throws TemplateModelException {
        if (envParams != null && envParams.size() > 0) {
            Iterator<Map.Entry<String, Object>> iterator = envParams.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, Object> entry = iterator.next();
                env.setVariable(entry.getKey(), DEFAULT_WRAPER.wrap(entry.getValue()));
            }
        }
    }

    private static void validLoopVars(TemplateModel[] loopVars) {
        if (loopVars.length < 1) {
            throw new RuntimeException("Loop variable is required.");
        }
    }

    protected abstract Object handle(Map params, Map<String, Object> envParams) throws TemplateException, IOException;
}
