package com.vote.ms.form;

/**
 * 登录表单
 */
public class LoginForm {
    private String mobile;
    private String username;
    private String password;
    private String captcha;
    private String uuid;
    private String smsCode;

    public void setSmsCode(String smsCode) {
        this.smsCode = smsCode;
    }

    public String getSmsCode() {
        return smsCode;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
}
