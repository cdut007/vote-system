package com.itender.ms.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


@Component
@ConfigurationProperties(prefix = "httpRequest")
public class HttpConfig {

    private String domain;

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getDomain() {
        return domain;
    }
}
