package com.itender.ms.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


@Component
@ConfigurationProperties(prefix = "httpRequest")
public class HttpConfig {

    private String domain;

    private String socket;

    public void setSocket(String socket) {
        this.socket = socket;
    }

    public String getSocket() {
        return socket;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getDomain() {
        return domain;
    }


}
