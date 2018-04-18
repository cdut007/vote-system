package com.itender.ms.domain;

import io.swagger.annotations.ApiModelProperty;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 审批
 * @Author jameschen
 * @Date 2018/2/08 15:20
 */
@Table(name = "itender_task")
public class ItenderTask {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(value="id",hidden=true)
    private String id;


    @Column(name="user_id")

    private String userId;//审批id


    @Column(name="role")

    private String role;


    @Column(name="status")

    private String status;



    @Column(name="review_id")

    private String reviewId;//审批id


    @Column(name="is_current_task")
    private Boolean isCurrentTask;


    @Column(name="create_time")
    private Date createTime;//审批任务创建时间


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReviewId() {
        return reviewId;
    }

    public void setReviewId(String reviewId) {
        this.reviewId = reviewId;
    }

    public Boolean getCurrentTask() {
        return isCurrentTask;
    }

    public void setCurrentTask(Boolean currentTask) {
        isCurrentTask = currentTask;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
