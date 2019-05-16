package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 封面列表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@TableName("cover")
public class CoverEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 活动id
	 */
	private String activityId;
	/**
	 * 类型   0：活动   1：选手
	 */
	private String category;
	/**
	 * 类型   0：图片   1：视频
	 */
	private String type;
	/**
	 * 封面地址
	 */
	private String coverLink;
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
	 * 设置：活动id
	 */
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	/**
	 * 获取：活动id
	 */
	public String getActivityId() {
		return activityId;
	}
	/**
	 * 设置：类型   0：活动   1：选手
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * 获取：类型   0：活动   1：选手
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * 设置：类型   0：图片   1：视频
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * 获取：类型   0：图片   1：视频
	 */
	public String getType() {
		return type;
	}
	/**
	 * 设置：封面地址
	 */
	public void setCoverLink(String coverLink) {
		this.coverLink = coverLink;
	}
	/**
	 * 获取：封面地址
	 */
	public String getCoverLink() {
		return coverLink;
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
