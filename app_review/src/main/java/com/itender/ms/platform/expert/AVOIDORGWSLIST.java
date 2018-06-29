package com.itender.ms.platform.expert;

import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
	"orgName",
	"orgCode"
})
/**
 *  回避单位组
 * @author xuexr
 *
 */
@XmlRootElement(name = "avoidOrgWSList")
public class AVOIDORGWSLIST {
	@XmlElement(name = "orgName", required = true)
	protected String orgName;//回避单位名称
	@XmlElement(name = "orgCode", required = true)
	protected String orgCode;//回避单位统一社会信用代码
	
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

}
