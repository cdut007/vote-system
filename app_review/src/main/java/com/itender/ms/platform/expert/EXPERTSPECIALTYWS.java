package com.itender.ms.platform.expert;

import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
	"firstLevelAreaCode",
	"specialtyFirstTypeCode",
	"specialtySecondTypeCode",
	"specialtyThirdTypeCode",
	"expertCount",
	"expertCheckInTime",
	"expertCheckInAddress",
	"bidEvaluateTime",
	"extractStatus"
})
/**
 *  抽取专家条件组
 * @author xuexr
 *
 */
@XmlRootElement(name = "expertSpecialtyWSList")
public class EXPERTSPECIALTYWS {
	@XmlElement(name = "firstLevelAreaCode", required = true)
	protected String firstLevelAreaCode;//地市级区域编号
	@XmlElement(name = "specialtyFirstTypeCode", required = true)
	protected String specialtyFirstTypeCode;//专业一级类别代码
	@XmlElement(name = "specialtySecondTypeCode", required = true)
	protected String specialtySecondTypeCode;//专业二级类别代码
	@XmlElement(name = "specialtyThirdTypeCode", required = true)
	protected String specialtyThirdTypeCode;//专业三级类别代码
	@XmlElement(name = "expertCount", required = true)
	protected String expertCount;//专家人数
	@XmlElement(name = "expertCheckInTime", required = true)
	protected String expertCheckInTime;//专家报到时间
	@XmlElement(name = "expertCheckInAddress", required = true)
	protected String expertCheckInAddress;//专家报到地点
	@XmlElement(name = "bidEvaluateTime", required = true)
	protected String bidEvaluateTime;//评标用时
	@XmlElement(name = "extractStatus")
	protected String extractStatus;//
	
	public String getFirstLevelAreaCode() {
		return firstLevelAreaCode;
	}
	public void setFirstLevelAreaCode(String firstLevelAreaCode) {
		this.firstLevelAreaCode = firstLevelAreaCode;
	}
	public String getSpecialtyFirstTypeCode() {
		return specialtyFirstTypeCode;
	}
	public void setSpecialtyFirstTypeCode(String specialtyFirstTypeCode) {
		this.specialtyFirstTypeCode = specialtyFirstTypeCode;
	}
	public String getSpecialtySecondTypeCode() {
		return specialtySecondTypeCode;
	}
	public void setSpecialtySecondTypeCode(String specialtySecondTypeCode) {
		this.specialtySecondTypeCode = specialtySecondTypeCode;
	}
	public String getSpecialtyThirdTypeCode() {
		return specialtyThirdTypeCode;
	}
	public void setSpecialtyThirdTypeCode(String specialtyThirdTypeCode) {
		this.specialtyThirdTypeCode = specialtyThirdTypeCode;
	}
	public String getExpertCount() {
		return expertCount;
	}
	public void setExpertCount(String expertCount) {
		this.expertCount = expertCount;
	}
	public String getExpertCheckInTime() {
		return expertCheckInTime;
	}
	public void setExpertCheckInTime(String expertCheckInTime) {
		this.expertCheckInTime = expertCheckInTime;
	}
	public String getExpertCheckInAddress() {
		return expertCheckInAddress;
	}
	public void setExpertCheckInAddress(String expertCheckInAddress) {
		this.expertCheckInAddress = expertCheckInAddress;
	}
	public String getBidEvaluateTime() {
		return bidEvaluateTime;
	}
	public void setBidEvaluateTime(String bidEvaluateTime) {
		this.bidEvaluateTime = bidEvaluateTime;
	}
	public String getExtractStatus() {
		return extractStatus;
	}
	public void setExtractStatus(String extractStatus) {
		this.extractStatus = extractStatus;
	}
	
}
