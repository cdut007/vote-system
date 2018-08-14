package com.itender.ms.bank.CBC.request;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.itender.ms.bank.CBC.JiaoTongBankService;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import java.text.SimpleDateFormat;
import java.util.Date;

@XmlAccessorType(XmlAccessType.FIELD)
public class RequestRootHead {
	@JacksonXmlProperty(localName = "TransCode")
	private String transCode;
	@JacksonXmlProperty(localName = "TransDate")
	private String transDate;
	@JacksonXmlProperty(localName = "TransTime")
	private String transTime;
	@JacksonXmlProperty(localName = "SeqNo")
	private String seqNo;

	public RequestRootHead(String transCode, String seqNo) {
		this.transCode = transCode;
		this.seqNo = seqNo;
		//TODO 招标通测试
		this.transDate = JiaoTongBankService.getNowDateStr();
		this.transTime =new SimpleDateFormat("HHmmss").format(new Date());
	}

	public String getTransCode() {
		return transCode;
	}

	public void setTransCode(String transCode) {
		this.transCode = transCode;
	}

	public String getTransDate() {
		return transDate;
	}

	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}

	public String getTransTime() {
		return transTime;
	}

	public void setTransTime(String transTime) {
		this.transTime = transTime;
	}

	public String getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}

}
