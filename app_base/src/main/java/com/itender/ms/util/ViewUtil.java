package com.itender.ms.util;

import org.springframework.util.StringUtils;

/**
 * 视图工具类
 *
 * @author 邓洁芃
 * @create 2017-12-26 下午5:11
 **/
public class ViewUtil {

    /**
     * 内部跳转页面
     * @param viewpage
     * @return
     */
    public static final String forward(String viewpage) {
        return StringUtils.isEmpty(viewpage)?"404":viewpage;
    }

    /**
     * 重定向到地址
     * @param path
     * @return
     */
    public static final String redirect(String path){
        return StringUtils.isEmpty(path)?"404":"redirect:" + path;
    }
}
