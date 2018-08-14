package com.itender.ms.bank.CBC.request;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.itender.ms.bank.CBC.Head;
import com.itender.ms.bank.CBC.JiaoTongBankService;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import java.text.SimpleDateFormat;
import java.util.Date;


@XmlAccessorType(XmlAccessType.FIELD)
public class RequestHead extends Head {
	@JacksonXmlProperty(localName = "tr_code")
	private String trCode;
	@JacksonXmlProperty(localName = "corp_no")
	private String corpNo;//="9000700168";
	@JacksonXmlProperty(localName = "user_no")
	private String userNo;//="00003";
	@JacksonXmlProperty(localName = "req_no")
	private String reqNo;
	@JacksonXmlProperty(localName = "tr_acdt")
	private String trAcdt;
	@JacksonXmlProperty(localName = "tr_time")
	private String trTime;
	@JacksonXmlProperty(localName = "atom_tr_count")
	private String atomTrCount;
	@JacksonXmlProperty(localName = "channel")
	private String channel="0";
	@JacksonXmlProperty(localName = "reserved")
	private String reserved;

	public RequestHead(String trCode, String atomTrCount) {
		super();
		this.trCode = trCode;
		this.corpNo="9000700168";//ConfigBean.getStringProperty("bank.organCode");
		this.userNo="00003";//ConfigBean.getStringProperty("bank.userCode");
		this.atomTrCount = atomTrCount;
		this.trAcdt=JiaoTongBankService.getNowDateStr();
		this.trTime=new SimpleDateFormat("HHmmss").format(new Date());
	}

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

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getReqNo() {
		return reqNo;
	}

	public void setReqNo(String reqNo) {
		this.reqNo = reqNo;
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

	public String getAtomTrCount() {
		return atomTrCount;
	}

	public void setAtomTrCount(String atomTrCount) {
		this.atomTrCount = atomTrCount;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
	}

}
