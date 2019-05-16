package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 选手列表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@TableName("participant")
public class ParticipantEntity implements Serializable {
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
	 * 选手名称
	 */
	private String username;
	/**
	 * 选手手机号
	 */
	private String mobile;
	/**
	 * 选手封面
	 */
	private String coverId;
	/**
	 * 视频链接
	 */
	private String videoLink;
	/**
	 * 选手描述
	 */
	private String description;

	/**
	 * 选手序号
	 */
	private int num;

	/**
	 * 选手活动浏览量
	 */
	private int scanCount;



    /**
     * 选手礼物数量
     */
    private int giftCount;

	/**
	 * 选手投票计数
	 */
	private int voteCount;

	/**
	 * 创建时间
	 */
	private Date createTime;

    public void setGiftCount(int giftCount) {
        this.giftCount = giftCount;
    }

    public int getGiftCount() {
        return giftCount;
    }

    public void setScanCount(int scanCount) {
		this.scanCount = scanCount;
	}

	public void setVoteCount(int voteCount) {
		this.voteCount = voteCount;
	}

	public int getScanCount() {
		return scanCount;
	}

	public int getVoteCount() {
		return voteCount;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getNum() {
		return num;
	}

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
	 * 设置：选手名称
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * 获取：选手名称
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * 设置：选手手机号
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * 获取：选手手机号
	 */
	public String getMobile() {
		return mobile;
	}
	/**
	 * 设置：选手封面
	 */
	public void setCoverId(String coverId) {
		this.coverId = coverId;
	}
	/**
	 * 获取：选手封面
	 */
	public String getCoverId() {
		return coverId;
	}
	/**
	 * 设置：视频链接
	 */
	public void setVideoLink(String videoLink) {
		this.videoLink = videoLink;
	}
	/**
	 * 获取：视频链接
	 */
	public String getVideoLink() {
		return videoLink;
	}
	/**
	 * 设置：选手描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * 获取：选手描述
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
}
