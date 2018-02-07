package com.itender.ms.domain;

import javax.persistence.*;

@Table(name = "ITENDER_ROLE_PRIVILEGE")
public class ItenderRolePrivilege {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="role_id")
    private String roleId;

    @Column(name="privilege_id")
    private String privilegeId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getPrivilegeId() {
        return privilegeId;
    }

    public void setPrivilegeId(String privilegeId) {
        this.privilegeId = privilegeId;
    }

    @Override
    public String toString() {
        return "ItenderRolePrivilege{" +
                "id='" + id + '\'' +
                ", roleId='" + roleId + '\'' +
                ", privilegeId='" + privilegeId + '\'' +
                '}';
    }
}
