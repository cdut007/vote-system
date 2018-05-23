package com.itender.config;

import freemarker.template.Configuration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Freemarker配置类
 *
 * @author 邓洁芃
 * @create 2018-02-02 上午11:49
 **/
@Component
public class FreeMarkerConfig {
    @Autowired
    private Configuration freemarkerConfiguration;


}
