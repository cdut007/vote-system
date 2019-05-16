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
 * @date 2019-05-16 13:29:05
 */
@TableName("itender_company")
public class ItenderCompanyEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 法人
	 */
	private String corporation;
	/**
	 * 
	 */
	private String company;
	/**
	 * 
	 */
	private String socialNo;
	/**
	 * 
	 */
	private String address;
	/**
	 * 
	 */
	private String phone;
	/**
	 * 
	 */
	private String mail;
	/**
	 * 
	 */
	private String contactName;
	/**
	 * 
	 */
	private String status;
	/**
	 * 
	 */
	private String caJsonInfo;
	/**
	 * 
	 */
	private Date updateTime;
	/**
	 * 
	 */
	private Date createTime;
	/**
	 * 
	 */
	private String attachId;

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
	 * 设置：法人
	 */
	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}
	/**
	 * 获取：法人
	 */
	public String getCorporation() {
		return corporation;
	}
	/**
	 * 设置：
	 */
	public void setCompany(String company) {
		this.company = company;
	}
	/**
	 * 获取：
	 */
	public String getCompany() {
		return company;
	}
	/**
	 * 设置：
	 */
	public void setSocialNo(String socialNo) {
		this.socialNo = socialNo;
	}
	/**
	 * 获取：
	 */
	public String getSocialNo() {
		return socialNo;
	}
	/**
	 * 设置：
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * 获取：
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * 设置：
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * 获取：
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * 设置：
	 */
	public void setMail(String mail) {
		this.mail = mail;
	}
	/**
	 * 获取：
	 */
	public String getMail() {
		return mail;
	}
	/**
	 * 设置：
	 */
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	/**
	 * 获取：
	 */
	public String getContactName() {
		return contactName;
	}
	/**
	 * 设置：
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * 获取：
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * 设置：
	 */
	public void setCaJsonInfo(String caJsonInfo) {
		this.caJsonInfo = caJsonInfo;
	}
	/**
	 * 获取：
	 */
	public String getCaJsonInfo() {
		return caJsonInfo;
	}
	/**
	 * 设置：
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * 获取：
	 */
	public Date getUpdateTime() {
		return updateTime;
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
	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}
	/**
	 * 获取：
	 */
	public String getAttachId() {
		return attachId;
	}
}
