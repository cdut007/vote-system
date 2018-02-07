package com.itender.ms.domain;

import javax.persistence.*;
import java.util.List;

/**
 * 用户角色
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:10
 */
@Table(name = "ITENDER_ROLE")
public class ItenderRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="role_name")
    private String roleName;

//    private List<ItenderUser> users;

    @Transient
    private List<ItenderPrivilege> privileges;

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

//    public List<ItenderUser> getUsers() {
//        return users;
//    }
//
//    public void setUsers(List<ItenderUser> users) {
//        this.users = users;
//    }

    public List<ItenderPrivilege> getPrivileges() {
        return privileges;
    }

    public void setPrivileges(List<ItenderPrivilege> privileges) {
        this.privileges = privileges;
    }

	@Override
	public String toString() {
		return "ItenderRole [id=" + id + ", roleName=" + roleName + ", privileges=" + privileges + "]";
	}

}
