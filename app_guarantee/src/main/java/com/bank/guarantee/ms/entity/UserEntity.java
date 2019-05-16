package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户表
 * 
 * @author 陈泳君
 * @email 316458704@qq.com
 * @date 2018-10-15 10:06:52
 */
@TableName("user")
public class UserEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 用户主键
	 */
	@TableId
	private String id;
	/**
	 * 
	 */
	private String name;
	/**
	 * 手机号
	 */
	private String mobile;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 上次登录ip
	 */
	private String lastLoginIp;
	/**
	 * 上次登录时间
	 */
	private String lastLoginTime;
	/**
	 * 用户类型，admin,normal
	 */
	private String type;
	/**
	 * 
	 */
	private String updateTime;
	/**
	 * 
	 */
	private String email;

	/**
	 * 设置：用户主键
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 获取：用户主键
	 */
	public String getId() {
		return id;
	}
	/**
	 * 设置：
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：手机号
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * 获取：手机号
	 */
	public String getMobile() {
		return mobile;
	}
	/**
	 * 设置：密码
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * 获取：密码
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * 设置：创建时间
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取：创建时间
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * 设置：上次登录ip
	 */
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	/**
	 * 获取：上次登录ip
	 */
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	/**
	 * 设置：上次登录时间
	 */
	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	/**
	 * 获取：上次登录时间
	 */
	public String getLastLoginTime() {
		return lastLoginTime;
	}
	/**
	 * 设置：用户类型，admin,normal
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * 获取：用户类型，admin,normal
	 */
	public String getType() {
		return type;
	}
	/**
	 * 设置：
	 */
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * 获取：
	 */
	public String getUpdateTime() {
		return updateTime;
	}
	/**
	 * 设置：
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * 获取：
	 */
	public String getEmail() {
		return email;
	}
}
