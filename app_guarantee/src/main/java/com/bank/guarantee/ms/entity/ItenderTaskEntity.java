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
@TableName("itender_task")
public class ItenderTaskEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 
	 */
	private String name;
	/**
	 * 预报名，使用费，报名，确认资格，竞价，公布最高价，现场竞价，确认竞价结果，签约，结果公示(preJoin,price,join,confirm,bid,maxPrice,bidNow,confirmBidResult,sign,result)
	 */
	private String moduleName;
	/**
	 * 
	 */
	private String jsonData;
	/**
	 * 
	 */
	private String assignUserId;
	/**
	 * 
	 */
	private String reason;
	/**
	 * 
	 */
	private String isDel;
	/**
	 * 
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
	 * 设置：预报名，使用费，报名，确认资格，竞价，公布最高价，现场竞价，确认竞价结果，签约，结果公示(preJoin,price,join,confirm,bid,maxPrice,bidNow,confirmBidResult,sign,result)
	 */
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	/**
	 * 获取：预报名，使用费，报名，确认资格，竞价，公布最高价，现场竞价，确认竞价结果，签约，结果公示(preJoin,price,join,confirm,bid,maxPrice,bidNow,confirmBidResult,sign,result)
	 */
	public String getModuleName() {
		return moduleName;
	}
	/**
	 * 设置：
	 */
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}
	/**
	 * 获取：
	 */
	public String getJsonData() {
		return jsonData;
	}
	/**
	 * 设置：
	 */
	public void setAssignUserId(String assignUserId) {
		this.assignUserId = assignUserId;
	}
	/**
	 * 获取：
	 */
	public String getAssignUserId() {
		return assignUserId;
	}
	/**
	 * 设置：
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}
	/**
	 * 获取：
	 */
	public String getReason() {
		return reason;
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
}
