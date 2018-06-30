//

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "projectname",
    "regioncode",
    "investprojectcode",
    "address",
    "legalperson",
    "industriestype",
    "fundsource",
    "contributionscale",
    "projectscale",
    "contactor",
    "contactinformation",
    "approvalname",
    "approvalnumber",
    "approvalauthority",
    "createtime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "isEnter",
    "PspBidSchemeApproveCode"
})
/*****
 * 
 * 项目
 * @author Administrator
 *
 */
@XmlRootElement(name = "GCJS_PROJECT")
public class GCJSPROJECT {
	private static final String GCJS_PROJECT="GCJS_PROJECT";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编码
    @XmlElement(name = "PROJECT_NAME", required = true)
    protected String projectname;//项目名称
    @XmlElement(name = "REGION_CODE", required = true)
    protected String regioncode;//项目所在行政区域代码
    @XmlElement(name = "INVEST_PROJECT_CODE", required = true)
    protected String investprojectcode;//投资项目统一代码
    @XmlElement(name = "ADDRESS", required = true)
    protected String address;//项目地址
    @XmlElement(name = "LEGAL_PERSON", required = true)
    protected String legalperson;//项目法人
    @XmlElement(name = "INDUSTRIES_TYPE", required = true)
    protected String industriestype;//项目行业分类
    @XmlElement(name = "FUND_SOURCE", required = true)
    protected String fundsource;//资金来源
    @XmlElement(name = "CONTRIBUTION_SCALE")
    protected String contributionscale;//出资比例
    @XmlElement(name = "PROJECT_SCALE", required = true)
    protected String projectscale;//项目规模
    @XmlElement(name = "CONTACTOR", required = true)
    protected String contactor;//联系人
    @XmlElement(name = "CONTACT_INFORMATION", required = true)
    protected String contactinformation;//联系方式
    @XmlElement(name = "APPROVAL_NAME", required = true)
    protected String approvalname;//项目审批文件名称
    @XmlElement(name = "APPROVAL_NUMBER")
    protected String approvalnumber;//项目审批文号
    @XmlElement(name = "APPROVAL_AUTHORITY")
    protected String approvalauthority;//项目审批单位
    @XmlElement(name = "CREATE_TIME", required = true)
    protected String createtime;//项目建立时间
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "IS_ENTER", required = true)
    protected String isEnter;
    @XmlElement(name = "PSP_BID_SCHEME_APPROVE_CODE")
    protected String PspBidSchemeApproveCode;
    /**
     * Gets the value of the projectcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPROJECTCODE() {
        return projectcode;
    }

    /**
     * Sets the value of the projectcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPROJECTCODE(String value) {
        this.projectcode = value;
    }

    /**
     * Gets the value of the projectname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPROJECTNAME() {
        return projectname;
    }
    
    public String getIsEnter() {
		return isEnter;
	}

	public void setIsEnter(String isEnter) {
		this.isEnter = isEnter;
	}

	public String getPspBidSchemeApproveCode() {
		return PspBidSchemeApproveCode;
	}

	public void setPspBidSchemeApproveCode(String pspBidSchemeApproveCode) {
		PspBidSchemeApproveCode = pspBidSchemeApproveCode;
	}

	/**
     * Sets the value of the projectname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPROJECTNAME(String value) {
        this.projectname = value;
    }

    /**
     * Gets the value of the regioncode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getREGIONCODE() {
        return regioncode;
    }

    /**
     * Sets the value of the regioncode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setREGIONCODE(String value) {
        this.regioncode = value;
    }

    /**
     * Gets the value of the investprojectcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getINVESTPROJECTCODE() {
        return investprojectcode;
    }

    /**
     * Sets the value of the investprojectcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setINVESTPROJECTCODE(String value) {
        this.investprojectcode = value;
    }

    /**
     * Gets the value of the address property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getADDRESS() {
        return address;
    }

    /**
     * Sets the value of the address property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setADDRESS(String value) {
        this.address = value;
    }

    /**
     * Gets the value of the legalperson property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLEGALPERSON() {
        return legalperson;
    }

    /**
     * Sets the value of the legalperson property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLEGALPERSON(String value) {
        this.legalperson = value;
    }

    /**
     * Gets the value of the industriestype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getINDUSTRIESTYPE() {
        return industriestype;
    }

    /**
     * Sets the value of the industriestype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setINDUSTRIESTYPE(String value) {
        this.industriestype = value;
    }

    /**
     * Gets the value of the fundsource property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFUNDSOURCE() {
        return fundsource;
    }

    /**
     * Sets the value of the fundsource property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFUNDSOURCE(String value) {
        this.fundsource = value;
    }

    /**
     * Gets the value of the contributionscale property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCONTRIBUTIONSCALE() {
        return contributionscale;
    }

    /**
     * Sets the value of the contributionscale property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCONTRIBUTIONSCALE(String value) {
        this.contributionscale = value;
    }

    /**
     * Gets the value of the projectscale property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPROJECTSCALE() {
        return projectscale;
    }

    /**
     * Sets the value of the projectscale property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPROJECTSCALE(String value) {
        this.projectscale = value;
    }

    /**
     * Gets the value of the contactor property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCONTACTOR() {
        return contactor;
    }

    /**
     * Sets the value of the contactor property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCONTACTOR(String value) {
        this.contactor = value;
    }

    /**
     * Gets the value of the contactinformation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCONTACTINFORMATION() {
        return contactinformation;
    }

    /**
     * Sets the value of the contactinformation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCONTACTINFORMATION(String value) {
        this.contactinformation = value;
    }

    /**
     * Gets the value of the approvalname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPROVALNAME() {
        return approvalname;
    }

    /**
     * Sets the value of the approvalname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPROVALNAME(String value) {
        this.approvalname = value;
    }

    /**
     * Gets the value of the approvalnumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPROVALNUMBER() {
        return approvalnumber;
    }

    /**
     * Sets the value of the approvalnumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPROVALNUMBER(String value) {
        this.approvalnumber = value;
    }

    /**
     * Gets the value of the approvalauthority property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPROVALAUTHORITY() {
        return approvalauthority;
    }

    /**
     * Sets the value of the approvalauthority property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPROVALAUTHORITY(String value) {
        this.approvalauthority = value;
    }

    /**
     * Gets the value of the createtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCREATETIME() {
        return createtime;
    }

    /**
     * Sets the value of the createtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCREATETIME(String value) {
        this.createtime = value;
    }

    /**
     * Gets the value of the platformcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPLATFORMCODE() {
        return platformcode;
    }

    /**
     * Sets the value of the platformcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPLATFORMCODE(String value) {
        this.platformcode = value;
    }

    /**
     * Gets the value of the pubserviceplatcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBSERVICEPLATCODE() {
        return pubserviceplatcode;
    }

    /**
     * Sets the value of the pubserviceplatcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBSERVICEPLATCODE(String value) {
        this.pubserviceplatcode = value;
    }

    /**
     * Gets the value of the datatimestamp property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDATATIMESTAMP() {
        return datatimestamp;
    }

    /**
     * Sets the value of the datatimestamp property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDATATIMESTAMP(String value) {
        this.datatimestamp = value;
    }

}
