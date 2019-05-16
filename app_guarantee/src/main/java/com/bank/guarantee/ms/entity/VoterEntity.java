package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 投票人列表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@TableName("voter")
public class VoterEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 投票人名称
	 */
	private String username;
	/**
	 * 投票人手机号
	 */
	private String mobile;
	/**
	 * 创建时间
	 */
	private Date createTime;

	/**
	 * 设置：
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 获取：
	 */
	public String getId() {
		return id;
	}
	/**
	 * 设置：投票人名称
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * 获取：投票人名称
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * 设置：投票人手机号
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * 获取：投票人手机号
	 */
	public String getMobile() {
		return mobile;
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
}
