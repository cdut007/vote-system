package com.itender.ms.domain;

import java.util.Date;

/**
 * Itender基础属性类
 *
 * @author 邓洁芃
 * @create 2017-12-26 下午3:12
 **/
public class ItenderAttrBase {
    private Date createTime;

    private Date updateTime;

    private String operator;

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
