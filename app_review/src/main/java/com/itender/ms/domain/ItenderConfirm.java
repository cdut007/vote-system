package com.itender.ms.domain;

import io.swagger.annotations.ApiModelProperty;

import javax.persistence.*;
import java.util.Date;

/**
 * 审批
 * @Author jameschen
 * @Date 2018/2/08 15:20
 */
@Table(name = "itender_confirm")
public class ItenderConfirm {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(value="id",hidden=true)
    private String id;

    @Column(name="type")
    private String type;



    @Column(name="status")
    private String status;//签章状态


    @Column(name="name")
    private String name;//文档标题


    @Column(name="review_id")
    private String reviewId;//

    @Column(name="create_time")
    private Date createTime;//审批任务创建时间

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getReviewId() {
        return reviewId;
    }

    public void setReviewId(String reviewId) {
        this.reviewId = reviewId;
    }
}
