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
@ConfigurationProperties(prefix = "dir")
public class DirConfig {

    private String uploadDir;

    private String pdfDir;

    public String getUploadDir() {
        return uploadDir;
    }

    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    public String getPdfDir() {
        return pdfDir;
    }

    public void setPdfDir(String pdfDir) {
        this.pdfDir = pdfDir;
    }
}
