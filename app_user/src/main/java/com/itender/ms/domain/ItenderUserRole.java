package com.itender.ms.domain;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "ITENDER_USER_ROLE")
public class ItenderUserRole {

    @Column(name="user_id")
    private String userId;

    @Column(name="role_id")
    private String roleId;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "ItenderUserRole{" +
                "userId='" + userId + '\'' +
                ", roleId='" + roleId + '\'' +
                '}';
    }
}
