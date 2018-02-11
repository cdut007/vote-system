package com.itender.ms.domain;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 设备
 * @Author jameschen
 * @Date 2018/2/10 15:20
 */
@Table(name = "itender_log")
public class ItenderLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="start_time")
    private Date startTime;//开始访问时间





    @Column(name="end_time")

    private String endTime;//结束访问时间


    //设备地址信息
    @Column(name="user")
    private String user;//当前用户
    //设备地址信息
    @Column(name="ip")
    private String ip;//访问ip

    //访问内容
    @Column(name="content")
    private String content;//访问内容
    //浏览器类型
    @Column(name="browser_type")
    private String browserType;//浏览器类型


    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @Transient
    private String recordDate;



    //日志级别
    @Column(name="level")
    private String level;//日志级别


    public String getRecordDate() {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        recordDate = formatter.format(startTime);
        return recordDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getStartTime() {

        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getBrowserType() {
        return browserType;
    }

    public void setBrowserType(String browserType) {
        this.browserType = browserType;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ItenderLog that = (ItenderLog) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(startTime, that.startTime) &&
                Objects.equals(endTime, that.endTime) &&
                Objects.equals(user, that.user) &&
                Objects.equals(ip, that.ip) &&
                Objects.equals(content, that.content) &&
                Objects.equals(browserType, that.browserType);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, startTime, endTime, user, ip, content, browserType);
    }

    @Override
    public String toString() {
        return "ItenderLog{" +
                "id='" + id + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", user='" + user + '\'' +
                ", ip='" + ip + '\'' +
                ", content='" + content + '\'' +
                ", browserType='" + browserType + '\'' +
                '}';
    }
}
