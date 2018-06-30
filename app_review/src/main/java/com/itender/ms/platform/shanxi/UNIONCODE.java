
package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectType",
    "projectCode",
    "tenderProjectCode",
    "bidCode",
    "dealType",
    "platformCode",
    "pubServicePlatCode",
    "projectCreatedate",
    "dataTimestamp"
})
/**
 * 统一交易标识码 交易信息
 */
@XmlRootElement(name = "WEB_UNICODE_RECORD")
public class UNIONCODE {
    @XmlElement(name = "PROJECT_TYPE", required = true)
    protected String projectType;//交易项目类型
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectCode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderProjectCode;//招标项目编号
    @XmlElement(name = "BID_CODE", required = true)
    protected String bidCode;//标段包编号
    @XmlElement(name = "DEAL_TYPE", required = true)
    protected String dealType;//公共资源交易分类代码
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformCode;//交易平台标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubServicePlatCode;//服务平台标识码
    @XmlElement(name = "PROJECT_CREATEDATE", required = true)
    protected String projectCreatedate;//项目创建时间
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String dataTimestamp;//数据时间戳
    
    
	public String getProjectType() {
		return projectType;
	}
	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}
	public String getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	public String getTenderProjectCode() {
		return tenderProjectCode;
	}
	public void setTenderProjectCode(String tenderProjectCode) {
		this.tenderProjectCode = tenderProjectCode;
	}
	public String getBidCode() {
		return bidCode;
	}
	public void setBidCode(String bidCode) {
		this.bidCode = bidCode;
	}
	public String getDealType() {
		return dealType;
	}
	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
	public String getPlatformCode() {
		return platformCode;
	}
	public void setPlatformCode(String platformCode) {
		this.platformCode = platformCode;
	}
	public String getPubServicePlatCode() {
		return pubServicePlatCode;
	}
	public void setPubServicePlatCode(String pubServicePlatCode) {
		this.pubServicePlatCode = pubServicePlatCode;
	}
	public String getProjectCreatedate() {
		return projectCreatedate;
	}
	public void setProjectCreatedate(String projectCreatedate) {
		this.projectCreatedate = projectCreatedate;
	}
	public String getDataTimestamp() {
		return dataTimestamp;
	}
	public void setDataTimestamp(String dataTimestamp) {
		this.dataTimestamp = dataTimestamp;
	}   

}
