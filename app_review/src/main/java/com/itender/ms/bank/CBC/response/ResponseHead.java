package com.itender.ms.bank.CBC.response;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.itender.ms.bank.CBC.Head;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;

@XmlAccessorType(XmlAccessType.FIELD)
public class ResponseHead extends Head {
	@JacksonXmlProperty(localName = "tr_code")
	private String trCode;
	@JacksonXmlProperty(localName = "corp_no")
	private String corpNo;
	@JacksonXmlProperty(localName = "user_no")
	private String userNo;
	@JacksonXmlProperty(localName = "req_no")
	private String reqNo;
	@JacksonXmlProperty(localName = "serial_no")
	private String serialNo;
	@JacksonXmlProperty(localName = "ans_no")
	private String ansNo;
	@JacksonXmlProperty(localName = "next_no")
	private String nextNo;
	@JacksonXmlProperty(localName = "tr_acdt")
	private String trAcdt;
	@JacksonXmlProperty(localName = "tr_time")
	private String trTime;
	@JacksonXmlProperty(localName = "ans_code")
	private String ansCode;
	@JacksonXmlProperty(localName = "ans_info")
	private String ansInfo;
	@JacksonXmlProperty(localName = "particular_code")
	private String particularCode;
	@JacksonXmlProperty(localName = "particular_info")
	private String particularInfo;
	@JacksonXmlProperty(localName = "atom_tr_count")
	private String atomTrCount;
	@JacksonXmlProperty(localName = "reserved")
	private String reserved;
	@JacksonXmlProperty(localName = "channel")
	private String channel;
	@JacksonXmlProperty(localName = "ogl_serial_no")
	private String oglSerialNo;

	public String getTrCode() {
		return trCode;
	}

	public void setTrCode(String trCode) {
		this.trCode = trCode;
	}

	public String getCorpNo() {
		return corpNo;
	}

	public void setCorpNo(String corpNo) {
		this.corpNo = corpNo;
	}

	public String getReqNo() {
		return reqNo;
	}

	public void setReqNo(String reqNo) {
		this.reqNo = reqNo;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getAnsNo() {
		return ansNo;
	}

	public void setAnsNo(String ansNo) {
		this.ansNo = ansNo;
	}

	public String getNextNo() {
		return nextNo;
	}

	public void setNextNo(String nextNo) {
		this.nextNo = nextNo;
	}

	public String getTrAcdt() {
		return trAcdt;
	}

	public void setTrAcdt(String trAcdt) {
		this.trAcdt = trAcdt;
	}

	public String getTrTime() {
		return trTime;
	}

	public void setTrTime(String trTime) {
		this.trTime = trTime;
	}

	public String getAnsCode() {
		return ansCode;
	}

	public void setAnsCode(String ansCode) {
		this.ansCode = ansCode;
	}

	public String getAnsInfo() {
		return ansInfo;
	}

	public void setAnsInfo(String ansInfo) {
		this.ansInfo = ansInfo;
	}

	public String getParticularCode() {
		return particularCode;
	}

	public void setParticularCode(String particularCode) {
		this.particularCode = particularCode;
	}

	public String getParticularInfo() {
		return particularInfo;
	}

	public void setParticularInfo(String particularInfo) {
		this.particularInfo = particularInfo;
	}

	public String getAtomTrCount() {
		return atomTrCount;
	}

	public void setAtomTrCount(String atomTrCount) {
		this.atomTrCount = atomTrCount;
	}

	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getOglSerialNo() {
		return oglSerialNo;
	}

	public void setOglSerialNo(String oglSerialNo) {
		this.oglSerialNo = oglSerialNo;
	}

}
