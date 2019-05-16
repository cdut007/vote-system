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
@TableName("itender_apply")
public class ItenderApplyEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 
	 */
	private String userId;
	/**
	 * 
	 */
	private String platformId;
	/**
	 * 
	 */
	private String platformName;
	/**
	 * 
	 */
	private String status;
	/**
	 * 
	 */
	private Date createTime;
	/**
	 * 
	 */
	private String projectCode;
	/**
	 * 
	 */
	private String projectName;
	/**
	 * 
	 */
	private String projectMoney;
	/**
	 * 
	 */
	private String guaranteeType;
	/**
	 * 
	 */
	private String forbiddenReason;
	/**
	 * 阶段
	 */
	private String stage;
	/**
	 * 
	 */
	private String applyAttachGroupId;
	/**
	 * 
	 */
	private String guaranteeAttachId;
	/**
	 * 
	 */
	private String orderId;
	/**
	 * 
	 */
	private String companyInfoId;
	/**
	 * 
	 */
	private String description;
	/**
	 * 
	 */
	private String guaranteeMoney;
	/**
	 * 
	 */
	private String guaranteeServiceMoney;
	/**
	 * 
	 */
	private String attachSign;
	/**
	 * 
	 */
	private Date updateTime;

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
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * 获取：
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * 设置：
	 */
	public void setPlatformId(String platformId) {
		this.platformId = platformId;
	}
	/**
	 * 获取：
	 */
	public String getPlatformId() {
		return platformId;
	}
	/**
	 * 设置：
	 */
	public void setPlatformName(String platformName) {
		this.platformName = platformName;
	}
	/**
	 * 获取：
	 */
	public String getPlatformName() {
		return platformName;
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
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	/**
	 * 获取：
	 */
	public String getProjectCode() {
		return projectCode;
	}
	/**
	 * 设置：
	 */
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	/**
	 * 获取：
	 */
	public String getProjectName() {
		return projectName;
	}
	/**
	 * 设置：
	 */
	public void setProjectMoney(String projectMoney) {
		this.projectMoney = projectMoney;
	}
	/**
	 * 获取：
	 */
	public String getProjectMoney() {
		return projectMoney;
	}
	/**
	 * 设置：
	 */
	public void setGuaranteeType(String guaranteeType) {
		this.guaranteeType = guaranteeType;
	}
	/**
	 * 获取：
	 */
	public String getGuaranteeType() {
		return guaranteeType;
	}
	/**
	 * 设置：
	 */
	public void setForbiddenReason(String forbiddenReason) {
		this.forbiddenReason = forbiddenReason;
	}
	/**
	 * 获取：
	 */
	public String getForbiddenReason() {
		return forbiddenReason;
	}
	/**
	 * 设置：阶段
	 */
	public void setStage(String stage) {
		this.stage = stage;
	}
	/**
	 * 获取：阶段
	 */
	public String getStage() {
		return stage;
	}
	/**
	 * 设置：
	 */
	public void setApplyAttachGroupId(String applyAttachGroupId) {
		this.applyAttachGroupId = applyAttachGroupId;
	}
	/**
	 * 获取：
	 */
	public String getApplyAttachGroupId() {
		return applyAttachGroupId;
	}
	/**
	 * 设置：
	 */
	public void setGuaranteeAttachId(String guaranteeAttachId) {
		this.guaranteeAttachId = guaranteeAttachId;
	}
	/**
	 * 获取：
	 */
	public String getGuaranteeAttachId() {
		return guaranteeAttachId;
	}
	/**
	 * 设置：
	 */
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	/**
	 * 获取：
	 */
	public String getOrderId() {
		return orderId;
	}
	/**
	 * 设置：
	 */
	public void setCompanyInfoId(String companyInfoId) {
		this.companyInfoId = companyInfoId;
	}
	/**
	 * 获取：
	 */
	public String getCompanyInfoId() {
		return companyInfoId;
	}
	/**
	 * 设置：
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * 获取：
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * 设置：
	 */
	public void setGuaranteeMoney(String guaranteeMoney) {
		this.guaranteeMoney = guaranteeMoney;
	}
	/**
	 * 获取：
	 */
	public String getGuaranteeMoney() {
		return guaranteeMoney;
	}
	/**
	 * 设置：
	 */
	public void setGuaranteeServiceMoney(String guaranteeServiceMoney) {
		this.guaranteeServiceMoney = guaranteeServiceMoney;
	}
	/**
	 * 获取：
	 */
	public String getGuaranteeServiceMoney() {
		return guaranteeServiceMoney;
	}
	/**
	 * 设置：
	 */
	public void setAttachSign(String attachSign) {
		this.attachSign = attachSign;
	}
	/**
	 * 获取：
	 */
	public String getAttachSign() {
		return attachSign;
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
}
