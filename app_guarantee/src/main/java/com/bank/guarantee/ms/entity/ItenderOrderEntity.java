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
@TableName("itender_order")
public class ItenderOrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private String id;
	/**
	 * 订单类型（platform,promise）
	 */
	private String type;
	/**
	 * 
	 */
	private String orderId;
	/**
	 * 支付金额
	 */
	private String price;
	/**
	 * 支付二维码
	 */
	private String qrCodeUrl;
	/**
	 * success,fail,verfiy
	 */
	private String status;
	/**
	 * 
	 */
	private Date createTime;
	/**
	 * 
	 */
	private String confirmPrice;
	/**
	 * 
	 */
	private Date payTime;
	/**
	 * 
	 */
	private String bankOrderNum;

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
	 * 设置：订单类型（platform,promise）
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * 获取：订单类型（platform,promise）
	 */
	public String getType() {
		return type;
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
	 * 设置：支付金额
	 */
	public void setPrice(String price) {
		this.price = price;
	}
	/**
	 * 获取：支付金额
	 */
	public String getPrice() {
		return price;
	}
	/**
	 * 设置：支付二维码
	 */
	public void setQrCodeUrl(String qrCodeUrl) {
		this.qrCodeUrl = qrCodeUrl;
	}
	/**
	 * 获取：支付二维码
	 */
	public String getQrCodeUrl() {
		return qrCodeUrl;
	}
	/**
	 * 设置：success,fail,verfiy
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * 获取：success,fail,verfiy
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
	public void setConfirmPrice(String confirmPrice) {
		this.confirmPrice = confirmPrice;
	}
	/**
	 * 获取：
	 */
	public String getConfirmPrice() {
		return confirmPrice;
	}
	/**
	 * 设置：
	 */
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	/**
	 * 获取：
	 */
	public Date getPayTime() {
		return payTime;
	}
	/**
	 * 设置：
	 */
	public void setBankOrderNum(String bankOrderNum) {
		this.bankOrderNum = bankOrderNum;
	}
	/**
	 * 获取：
	 */
	public String getBankOrderNum() {
		return bankOrderNum;
	}
}
