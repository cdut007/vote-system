package com.itender.ms.platform.expert;

import javax.xml.bind.annotation.*;
import java.util.List;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "platId",
//    "projectCode",
//    "tenderProjectCode",
//    "bidSectionCodes",
//    "noticeId",
    "extractTerminalCode",
    "planExtractDate",
    "bidOpenTime",
    "bidOpenAddress",
    "bidEvaluateTime",
    "bidEvaluateAddress",
    "tendereeOrg",
    "tendereePrincipal",
    "tendereePhone",
    "agencyOrg",
    "agencyPrincipal",
    "agencyPhone",
    "watchdogOrg",
    "watchdogPrincipal",
    "watchdogPhone",
    "bidEvaluateCommittee",
    "investment",
    "bidContent",
    "areaCode",
    "callbackUrl",
    "signature",
    "expertSpecialtyWSList",
    "avoidOrgWSList",
    "relateNoticeList",
		"remarks"
})
/**
 * 抽取专家申请表
 * @author xuexr
 *
 */
@XmlRootElement(name = "expertApply")
public class EXPERTAPPLY {
	@XmlElement(name = "platId", required = true)
	protected String platId;//数据在交易平台的唯一标识
//	@XmlElement(name = "projectCode", required = true)
//	protected String projectCode;//项目编号
//	@XmlElement(name = "tenderProjectCode", required = true)
//	protected String tenderProjectCode;//招标项目编号
//	@XmlElement(name = "bidSectionCodes", required = true)
//	protected String bidSectionCodes;//标段包编号多个编号之间用半角分号隔开
//	@XmlElement(name = "noticeId", required = true)
//	protected String noticeId;//关联公告ID
	@XmlElement(name = "extractTerminalCode", required = true)
	protected String extractTerminalCode;//抽取终端编号
	@XmlElement(name = "planExtractDate", required = true)
	protected String planExtractDate;//拟抽取日期
	@XmlElement(name = "bidOpenTime", required = true)
	protected String bidOpenTime;//开标时间
	@XmlElement(name = "bidOpenAddress", required = true)
	protected String bidOpenAddress;//开标地点
	@XmlElement(name = "bidEvaluateTime", required = true)
	protected String bidEvaluateTime;//评标时间
	@XmlElement(name = "bidEvaluateAddress", required = true)
	protected String bidEvaluateAddress;//评标地点
	@XmlElement(name = "tendereeOrg", required = true)
	protected String tendereeOrg;//业主单位
	@XmlElement(name = "tendereePrincipal", required = true)
	protected String tendereePrincipal;//业主单位负责人
	@XmlElement(name = "tendereePhone", required = true)
	protected String tendereePhone;//业主单位电话
	@XmlElement(name = "agencyOrg", required = true)
	protected String agencyOrg;//代理机构名称
	@XmlElement(name = "agencyPrincipal", required = true)
	protected String agencyPrincipal;//代理机构负责人
	@XmlElement(name = "agencyPhone", required = true)
	protected String agencyPhone;//代理机构负责人电话
	@XmlElement(name = "watchdogOrg", required = true)
	protected String watchdogOrg;//监督单位名称
	@XmlElement(name = "watchdogPrincipal", required = true)
	protected String watchdogPrincipal;//监督单位负责人
	@XmlElement(name = "watchdogPhone", required = true)
	protected String watchdogPhone;//监督单位负责人电话
	@XmlElement(name = "bidEvaluateCommittee", required = true)
	protected String bidEvaluateCommittee;//评标委员会人数
	@XmlElement(name = "investment", required = true)
	protected String investment;//本次抽取项目或标段投资额
	@XmlElement(name = "bidContent", required = true)
	protected String bidContent;//招标内容
	@XmlElement(name = "areaCode", required = true)
	protected String areaCode;//项目所属区域编号
	@XmlElement(name = "callbackUrl", required = true)
	protected String callbackUrl;//回调方法
	@XmlElement(name = "signature", required = true)
	protected String signature;//数字签章
	@XmlElement(name = "remarks", required = true)
	protected String remarks;//申请表备注
	
	@XmlElement(name = "expertSpecialtyWSList", required = true)
	protected List<EXPERTSPECIALTYWS> expertSpecialtyWSList;//抽取专家条件组
	@XmlElement(name = "avoidOrgWSList", required = true)
	protected List<AVOIDORGWSLIST> avoidOrgWSList;//回避单位组
	@XmlElement(name = "relateNoticeList", required = true)
	protected List<String> relateNoticeList;//关联公告ID集
	
	public List<String> getRelateNoticeList() {
		return relateNoticeList;
	}
	public void setRelateNoticeList(List<String> relateNoticeList) {
		this.relateNoticeList = relateNoticeList;
	}
	public String getCallbackUrl() {
		return callbackUrl;
	}
	public void setCallbackUrl(String callbackUrl) {
		this.callbackUrl = callbackUrl;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getPlatId() {
		return platId;
	}
	public void setPlatId(String platId) {
		this.platId = platId;
	}
//	public String getProjectCode() {
//		return projectCode;
//	}
//	public void setProjectCode(String projectCode) {
//		this.projectCode = projectCode;
//	}
//	public String getTenderProjectCode() {
//		return tenderProjectCode;
//	}
//	public void setTenderProjectCode(String tenderProjectCode) {
//		this.tenderProjectCode = tenderProjectCode;
//	}
//	public String getBidSectionCodes() {
//		return bidSectionCodes;
//	}
//	public void setBidSectionCodes(String bidSectionCodes) {
//		this.bidSectionCodes = bidSectionCodes;
//	}
//	public String getNoticeId() {
//		return noticeId;
//	}
//	public void setNoticeId(String noticeId) {
//		this.noticeId = noticeId;
//	}
	public String getExtractTerminalCode() {
		return extractTerminalCode;
	}
	public void setExtractTerminalCode(String extractTerminalCode) {
		this.extractTerminalCode = extractTerminalCode;
	}
	public String getPlanExtractDate() {
		return planExtractDate;
	}
	public void setPlanExtractDate(String planExtractDate) {
		this.planExtractDate = planExtractDate;
	}
	public String getBidOpenTime() {
		return bidOpenTime;
	}
	public void setBidOpenTime(String bidOpenTime) {
		this.bidOpenTime = bidOpenTime;
	}
	public String getBidOpenAddress() {
		return bidOpenAddress;
	}
	public void setBidOpenAddress(String bidOpenAddress) {
		this.bidOpenAddress = bidOpenAddress;
	}
	public String getBidEvaluateTime() {
		return bidEvaluateTime;
	}
	public void setBidEvaluateTime(String bidEvaluateTime) {
		this.bidEvaluateTime = bidEvaluateTime;
	}
	public String getBidEvaluateAddress() {
		return bidEvaluateAddress;
	}
	public void setBidEvaluateAddress(String bidEvaluateAddress) {
		this.bidEvaluateAddress = bidEvaluateAddress;
	}
	public String getTendereeOrg() {
		return tendereeOrg;
	}
	public void setTendereeOrg(String tendereeOrg) {
		this.tendereeOrg = tendereeOrg;
	}
	public String getTendereePrincipal() {
		return tendereePrincipal;
	}
	public void setTendereePrincipal(String tendereePrincipal) {
		this.tendereePrincipal = tendereePrincipal;
	}
	public String getTendereePhone() {
		return tendereePhone;
	}
	public void setTendereePhone(String tendereePhone) {
		this.tendereePhone = tendereePhone;
	}
	public String getAgencyOrg() {
		return agencyOrg;
	}
	public void setAgencyOrg(String agencyOrg) {
		this.agencyOrg = agencyOrg;
	}
	public String getAgencyPrincipal() {
		return agencyPrincipal;
	}
	public void setAgencyPrincipal(String agencyPrincipal) {
		this.agencyPrincipal = agencyPrincipal;
	}
	public String getAgencyPhone() {
		return agencyPhone;
	}
	public void setAgencyPhone(String agencyPhone) {
		this.agencyPhone = agencyPhone;
	}
	public String getWatchdogOrg() {
		return watchdogOrg;
	}
	public void setWatchdogOrg(String watchdogOrg) {
		this.watchdogOrg = watchdogOrg;
	}
	public String getWatchdogPrincipal() {
		return watchdogPrincipal;
	}
	public void setWatchdogPrincipal(String watchdogPrincipal) {
		this.watchdogPrincipal = watchdogPrincipal;
	}
	public String getWatchdogPhone() {
		return watchdogPhone;
	}
	public void setWatchdogPhone(String watchdogPhone) {
		this.watchdogPhone = watchdogPhone;
	}
	public String getBidEvaluateCommittee() {
		return bidEvaluateCommittee;
	}
	public void setBidEvaluateCommittee(String bidEvaluateCommittee) {
		this.bidEvaluateCommittee = bidEvaluateCommittee;
	}
	public String getInvestment() {
		return investment;
	}
	public void setInvestment(String investment) {
		this.investment = investment;
	}
	public String getBidContent() {
		return bidContent;
	}
	public void setBidContent(String bidContent) {
		this.bidContent = bidContent;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public List<EXPERTSPECIALTYWS> getExpertSpecialtyWSList() {
		return expertSpecialtyWSList;
	}
	public void setExpertSpecialtyWSList(
			List<EXPERTSPECIALTYWS> expertSpecialtyWSList) {
		this.expertSpecialtyWSList = expertSpecialtyWSList;
	}
	public List<AVOIDORGWSLIST> getAvoidOrgWSList() {
		return avoidOrgWSList;
	}
	public void setAvoidOrgWSList(List<AVOIDORGWSLIST> avoidOrgWSList) {
		this.avoidOrgWSList = avoidOrgWSList;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
