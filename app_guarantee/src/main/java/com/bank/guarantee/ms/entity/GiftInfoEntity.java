package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;

/**
 * 
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-23 16:16:51
 */
@TableName("gift_info")
public class GiftInfoEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 礼物主键
	 */
	@TableId
	private String id;
	/**
	 * 
	 */
	private String name;
	/**
	 * 
	 */
	private Integer voteCount;
	/**
	 * 
	 */
	private BigDecimal price;

	/**
	 * 设置：礼物主键
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 获取：礼物主键
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
	 * 设置：
	 */
	public void setVoteCount(Integer voteCount) {
		this.voteCount = voteCount;
	}
	/**
	 * 获取：
	 */
	public Integer getVoteCount() {
		return voteCount;
	}
	/**
	 * 设置：
	 */
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	/**
	 * 获取：
	 */
	public BigDecimal getPrice() {
		return price;
	}
}
