package com.bank.guarantee.ms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;

/**
 * 附件表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:05
 */
@TableName("attach")
public class AttachEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键
	 */
	@TableId
	private String id;
	/**
	 * 文件名称
	 */
	private String fileName;
	/**
	 * 上传用户ID
	 */
	private String uploadUserId;
	/**
	 * 文件大小
	 */
	private BigDecimal length;
	/**
	 * 文件类型
	 */
	private String fileType;
	/**
	 * md5
	 */
	private String md5;
	/**
	 * 保存路径
	 */
	private String path;
	/**
	 * 上传时间
	 */
	private Date uploadTime;
	/**
	 * 附件组id
	 */
	private String groupId;
	/**
	 * 
	 */
	private String contentType;

	/**
	 * 设置：主键
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 获取：主键
	 */
	public String getId() {
		return id;
	}
	/**
	 * 设置：文件名称
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	/**
	 * 获取：文件名称
	 */
	public String getFileName() {
		return fileName;
	}
	/**
	 * 设置：上传用户ID
	 */
	public void setUploadUserId(String uploadUserId) {
		this.uploadUserId = uploadUserId;
	}
	/**
	 * 获取：上传用户ID
	 */
	public String getUploadUserId() {
		return uploadUserId;
	}
	/**
	 * 设置：文件大小
	 */
	public void setLength(BigDecimal length) {
		this.length = length;
	}
	/**
	 * 获取：文件大小
	 */
	public BigDecimal getLength() {
		return length;
	}
	/**
	 * 设置：文件类型
	 */
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	/**
	 * 获取：文件类型
	 */
	public String getFileType() {
		return fileType;
	}
	/**
	 * 设置：md5
	 */
	public void setMd5(String md5) {
		this.md5 = md5;
	}
	/**
	 * 获取：md5
	 */
	public String getMd5() {
		return md5;
	}
	/**
	 * 设置：保存路径
	 */
	public void setPath(String path) {
		this.path = path;
	}
	/**
	 * 获取：保存路径
	 */
	public String getPath() {
		return path;
	}
	/**
	 * 设置：上传时间
	 */
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	/**
	 * 获取：上传时间
	 */
	public Date getUploadTime() {
		return uploadTime;
	}
	/**
	 * 设置：附件组id
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	/**
	 * 获取：附件组id
	 */
	public String getGroupId() {
		return groupId;
	}
	/**
	 * 设置：
	 */
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	/**
	 * 获取：
	 */
	public String getContentType() {
		return contentType;
	}
}
