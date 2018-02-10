package com.itender.ms.domain;

import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 用户基本信息
 *
 * @author 邓洁芃
 * @create 2018-02-10 下午4:26
 **/
@Component
public class BasicUserInfo {
    private String username;
    private String nickname;
    private String ip;
    private Date operateDate;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getOperateDate() {
        return operateDate;
    }

    public void setOperateDate(Date operateDate) {
        this.operateDate = operateDate;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
