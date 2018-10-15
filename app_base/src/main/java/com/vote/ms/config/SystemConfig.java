package com.vote.ms.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 目录配置
 *
 * @author 陈泳君
 * @create 2018-03-06 上午10:48
 **/
@Component
@ConfigurationProperties(prefix = "sys")
public class SystemConfig {

    private String version;

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }
}
