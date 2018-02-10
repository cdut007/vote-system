package com.itender.ms.domain;

import javax.persistence.*;
import java.util.List;

/**
 * 用户角色
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:10
 */
@Table(name = "itender_role")
public class ItenderRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="role_name")
    private String roleName;

    @Transient
    private List<ItenderPrivilege> privileges;

    @Transient
    private List<ItenderIndustry> roleType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<ItenderPrivilege> getPrivileges() {
        return privileges;
    }

    public void setPrivileges(List<ItenderPrivilege> privileges) {
        this.privileges = privileges;
    }

    public List<ItenderIndustry> getRoleType() {
        return roleType;
    }

    public void setRoleType(List<ItenderIndustry> roleType) {
        this.roleType = roleType;
    }

    @Override
    public String toString() {
        return "ItenderRole{" +
                "id='" + id + '\'' +
                ", roleName='" + roleName + '\'' +
                ", privileges=" + privileges +
                ", roleType=" + roleType +
                '}';
    }
}
