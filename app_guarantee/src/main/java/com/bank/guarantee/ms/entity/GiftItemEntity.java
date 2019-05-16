package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 投票票数列表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-23 16:16:51
 */
@TableName("gift_item")
public class GiftItemEntity implements Serializable {
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
	 * 投票者id
	 */
	private String voterId;
	/**
	 * 投票者姓名
	 */
	private String voterName;
	/**
	 * 投票描述
	 */
	private String description;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 参赛者id
	 */
	private String playerId;
	/**
	 * 礼物票数
	 */
	private Integer voteCount;
	/**
	 * 支付订单id
	 */
	private String orderId;
	/**
	 * 礼物id
	 */
	private String giftId;
	/**
	 * 
	 */
	private Integer giftNum;

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
	 * 设置：投票者id
	 */
	public void setVoterId(String voterId) {
		this.voterId = voterId;
	}
	/**
	 * 获取：投票者id
	 */
	public String getVoterId() {
		return voterId;
	}
	/**
	 * 设置：投票者姓名
	 */
	public void setVoterName(String voterName) {
		this.voterName = voterName;
	}
	/**
	 * 获取：投票者姓名
	 */
	public String getVoterName() {
		return voterName;
	}
	/**
	 * 设置：投票描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * 获取：投票描述
	 */
	public String getDescription() {
		return description;
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
	 * 设置：参赛者id
	 */
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	/**
	 * 获取：参赛者id
	 */
	public String getPlayerId() {
		return playerId;
	}
	/**
	 * 设置：礼物票数
	 */
	public void setVoteCount(Integer voteCount) {
		this.voteCount = voteCount;
	}
	/**
	 * 获取：礼物票数
	 */
	public Integer getVoteCount() {
		return voteCount;
	}
	/**
	 * 设置：支付订单id
	 */
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	/**
	 * 获取：支付订单id
	 */
	public String getOrderId() {
		return orderId;
	}
	/**
	 * 设置：礼物id
	 */
	public void setGiftId(String giftId) {
		this.giftId = giftId;
	}
	/**
	 * 获取：礼物id
	 */
	public String getGiftId() {
		return giftId;
	}
	/**
	 * 设置：
	 */
	public void setGiftNum(Integer giftNum) {
		this.giftNum = giftNum;
	}
	/**
	 * 获取：
	 */
	public Integer getGiftNum() {
		return giftNum;
	}
}
