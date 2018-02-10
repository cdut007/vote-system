package com.itender.ms.domain;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "itender_role_type")
public class ItenderRoleType {

    @Column(name = "role_id")
    private String roleId;

    @Column(name = "industry_id")
    private String industryId;

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId;
    }

    @Override
    public String toString() {
        return "ItenderRoleType{" +
                "roleId='" + roleId + '\'' +
                ", industryId='" + industryId + '\'' +
                '}';
    }
}
