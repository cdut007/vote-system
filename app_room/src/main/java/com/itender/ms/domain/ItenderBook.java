package com.itender.ms.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 设备
 * @Author jameschen
 * @Date 2018/2/11 10:20
 */
@Table(name = "itender_book")
public class ItenderBook {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="content")
    private String content;//预定事项

    @Column(name="book_organization")
    private String bookOrganization;//预订单位


    @Column(name="industry")
    private String industry;//预订类型

    @Column(name="room")
    private String room;//预订房间


    @Column(name="room_id")
    private String roomId;//预订房间id

    @Column(name="begin_time")
    private Date beginTime;//预订开始时间


    @Column(name="end_time")
    private Date endTime;//预订结束时间



    @Column(name="book_user")
    private String bookUser;//预订人



    @Column(name="book_user_mobile")
    private String bookUserMobile;//预订人联系方式


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name="status")
    private String status;//订单状态


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getBookOrganization() {
        return bookOrganization;
    }

    public void setBookOrganization(String bookOrganization) {
        this.bookOrganization = bookOrganization;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getBookUser() {
        return bookUser;
    }

    public void setBookUser(String bookUser) {
        this.bookUser = bookUser;
    }

    public String getBookUserMobile() {
        return bookUserMobile;
    }

    public void setBookUserMobile(String bookUserMobile) {
        this.bookUserMobile = bookUserMobile;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    @Override
    public String toString() {
        return "ItenderBook{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", bookOrganization='" + bookOrganization + '\'' +
                ", industry='" + industry + '\'' +
                ", room='" + room + '\'' +
                ", beginTime=" + beginTime +
                ", endTime=" + endTime +
                ", bookUser='" + bookUser + '\'' +
                ", bookUserMobile='" + bookUserMobile + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
