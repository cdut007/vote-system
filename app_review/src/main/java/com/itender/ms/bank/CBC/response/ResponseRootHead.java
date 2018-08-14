package com.itender.ms.bank.CBC.response;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;

@XmlAccessorType(XmlAccessType.FIELD)
public class ResponseRootHead {
	@JacksonXmlProperty(localName = "TransCode")
	private String transCode;
	@JacksonXmlProperty(localName = "TransDate")
	private String transDate;
	@JacksonXmlProperty(localName = "TransTime")
	private String transTime;
	@JacksonXmlProperty(localName = "SeqNo")
	private String seqNo;
	@JacksonXmlProperty(localName = "ZoneName")
	private String zoneName;

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

	public String getZoneName() {
		return zoneName;
	}

	public void setZoneName(String zoneName) {
		this.zoneName = zoneName;
	}

}
