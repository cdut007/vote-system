package com.itender.ms.domain;

import com.itender.ms.domain.ItenderAttrBase;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 用户类
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:10
 */
/**
 * @author Administrator
 *
 */
@Table(name = "ITENDER_USER")
public class ItenderUser extends ItenderAttrBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="user_name")
    private String userName;

    @Column(name="pass_word")
    private String password;

    @Column(name="email")
    private String email;

    @Column(name="register_time")
    private Date registerTime;

    @Column(name="register_ip")
    private String registerIp;

    @Column(name="last_login_time")
    private Date lastLoginTime;

    @Column(name="last_login_ip")
    private String lastLoginIp;

    @Column(name="is_default_admin")
    private boolean isDefaultAdmin;

    @Transient
    private List<ItenderRole> roles;
    
    @Transient
    private List<ItenderPrivilege> privileges;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public String getRegisterIp() {
        return registerIp;
    }

    public void setRegisterIp(String registerIp) {
        this.registerIp = registerIp;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    public boolean isDefaultAdmin() {
        return isDefaultAdmin;
    }

    public void setDefaultAdmin(boolean defaultAdmin) {
        isDefaultAdmin = defaultAdmin;
    }

	public List<ItenderRole> getRoles() {
		return roles;
	}

	public void setRoles(List<ItenderRole> roles) {
		this.roles = roles;
	}

	public List<ItenderPrivilege> getPrivileges() {
		return privileges;
	}

	public void setPrivileges(List<ItenderPrivilege> privileges) {
		this.privileges = privileges;
	}


    @Override
    public String toString() {
        return "ItenderUser{" +
                "id='" + id + '\'' +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", registerTime=" + registerTime +
                ", registerIp='" + registerIp + '\'' +
                ", lastLoginTime=" + lastLoginTime +
                ", lastLoginIp='" + lastLoginIp + '\'' +
                ", isDefaultAdmin=" + isDefaultAdmin +
                ", roles=" + roles +
                ", privileges=" + privileges +
                '}';
    }
}
