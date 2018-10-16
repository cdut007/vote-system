package com.vote.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 投票活动列表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@TableName("activity")
public class ActivityEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 活动名称
	 */
	private String subject;
	/**
	 * 活动开始时间
	 */
	private Date begin;
	/**
	 * 活动结束时间
	 */
	private Date end;
	/**
	 * 活动内容
	 */
	private String content;
	/**
	 * 类型   0：萌娃   1：清晰   2：浪漫
	 */
	private String theme;
	/**
	 * 类型   0：red   1：green   2：bule
	 */
	private String color;
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
	 * 设置：活动名称
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
	/**
	 * 获取：活动名称
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * 设置：活动开始时间
	 */
	public void setBegin(Date begin) {
		this.begin = begin;
	}
	/**
	 * 获取：活动开始时间
	 */
	public Date getBegin() {
		return begin;
	}
	/**
	 * 设置：活动结束时间
	 */
	public void setEnd(Date end) {
		this.end = end;
	}
	/**
	 * 获取：活动结束时间
	 */
	public Date getEnd() {
		return end;
	}
	/**
	 * 设置：活动内容
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 获取：活动内容
	 */
	public String getContent() {
		return content;
	}
	/**
	 * 设置：类型   0：萌娃   1：清晰   2：浪漫
	 */
	public void setTheme(String theme) {
		this.theme = theme;
	}
	/**
	 * 获取：类型   0：萌娃   1：清晰   2：浪漫
	 */
	public String getTheme() {
		return theme;
	}
	/**
	 * 设置：类型   0：red   1：green   2：bule
	 */
	public void setColor(String color) {
		this.color = color;
	}
	/**
	 * 获取：类型   0：red   1：green   2：bule
	 */
	public String getColor() {
		return color;
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
