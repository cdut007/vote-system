package com.itender.ms.domain;

import io.swagger.annotations.ApiModelProperty;

import javax.persistence.*;

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

    @Column(name="path")
    private String path;



    //审批地址信息
    @Column(name="type")
    private String type;//审批类型


    @Column(name="name")
    private String name;//审批名称


    @Column(name="review_id")
    private String reviewId;//审批描述

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
