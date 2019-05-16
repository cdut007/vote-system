package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:04
 */
@TableName("itender_message")
public class ItenderMessageEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 
	 */
	private String content;
	/**
	 * 
	 */
	private String type;
	/**
	 * 
	 */
	private String isDel;
	/**
	 * 
	 */
	private Date createTime;
	/**
	 * 
	 */
	private String assginUserId;
	/**
	 * 
	 */
	private String name;
	/**
	 * 
	 */
	private String referenceId;

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
	 * 设置：
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 获取：
	 */
	public String getContent() {
		return content;
	}
	/**
	 * 设置：
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * 获取：
	 */
	public String getType() {
		return type;
	}
	/**
	 * 设置：
	 */
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	/**
	 * 获取：
	 */
	public String getIsDel() {
		return isDel;
	}
	/**
	 * 设置：
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取：
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * 设置：
	 */
	public void setAssginUserId(String assginUserId) {
		this.assginUserId = assginUserId;
	}
	/**
	 * 获取：
	 */
	public String getAssginUserId() {
		return assginUserId;
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
	 * 设置：
	 */
	public void setReferenceId(String referenceId) {
		this.referenceId = referenceId;
	}
	/**
	 * 获取：
	 */
	public String getReferenceId() {
		return referenceId;
	}
}
