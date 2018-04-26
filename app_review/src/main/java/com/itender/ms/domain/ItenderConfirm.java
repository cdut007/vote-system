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

    @Column(name="count")
    private String count;


    @ApiModelProperty(value="id",hidden=true)
    @Transient
    private String status;//签章状态


    @Column(name="name")
    private String name;//文档标题


    @Column(name="review_id")
    private String reviewId;//

    @Column(name="attach_id")
    private String attachId;//

    @Column(name="create_time")
    private Date createTime;//审批任务创建时间

    @Column(name="reference_id")
    private String referenceId;//关联id




    public String getAttachId() {
        return attachId;
    }

    public void setAttachId(String attachId) {
        this.attachId = attachId;
    }

    public void setReferenceId(String referenceId) {
        this.referenceId = referenceId;
    }

    public String getReferenceId() {
        return referenceId;
    }

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

    public void setCount(String count) {
        this.count = count;
    }

    public String getCount() {
        return count;
    }
}
