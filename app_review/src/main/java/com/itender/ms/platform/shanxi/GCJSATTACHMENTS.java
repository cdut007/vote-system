package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { 
		"attachmentSetCode", //附件关联数据集标识符
		"attachmentCount", //关联附件数量
		"attachmentName", //附件名称
		"attachmentType",//附件类型
		"attachmentFileName", //附件文件名
		"url" //附件URL地址
		})

@XmlRootElement(name = "GCJS_ATTACHMENTS")
public class GCJSATTACHMENTS {

	@XmlElement(name = "ATTACHMENT_SET_CODE", required = true)
	protected String attachmentSetCode;
	@XmlElement(name = "ATTACHMENT_COUNT", required = true)
	protected String attachmentCount;
	@XmlElement(name = "ATTACHMENT_NAME", required = true)
	protected String attachmentName;
	@XmlElement(name = "ATTACHMENT_TYPE", required = true)
	protected String attachmentType;
	@XmlElement(name = "ATTACHMENT_FILE_NAME", required = true)
	protected String attachmentFileName;
	@XmlElement(name = "URL", required = true)
	protected String url;

	public String getAttachmentSetCode() {
		return attachmentSetCode;
	}

	public void setAttachmentSetCode(String attachmentSetCode) {
		this.attachmentSetCode = attachmentSetCode;
	}

	public String getAttachmentCount() {
		return attachmentCount;
	}

	public void setAttachmentCount(String attachmentCount) {
		this.attachmentCount = attachmentCount;
	}

	public String getAttachmentName() {
		return attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAttachmentType() {
		return attachmentType;
	}

	public void setAttachmentType(String attachmentType) {
		this.attachmentType = attachmentType;
	}

	public String getAttachmentFileName() {
		return attachmentFileName;
	}

	public void setAttachmentFileName(String attachmentFileName) {
		this.attachmentFileName = attachmentFileName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
