

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",//项目编号
    "tenderprojectcode",//招标项目编号
    "unifieddealcode",//统一交易标识码
    "tenderprojectname",//招标项目名称
    "tenderprojecttype",//招标项目类型
    "regioncode",//招标项目所在行政区域代码
    "tendercontent",//招标内容与范围及招标方案说明
    "ownername",//项目业主名称
    "tenderername",//招标人名称
    "tenderercodetype",//招标人类别
    "tenderercode",//招标人代码
    "tendererrole",//招标人角色
    "tenderagencyname",//招标代理机构名称
    "tenderagencycodetype",//招标代理机构类别
    "tenderagencycode",//招标代理机构代码
    "tenderagencyrole",//招标代理机构角色
    "tendermode",//招标方式
    "tenderorganizeform",//招标组织形式
    "createtime",//招标项目建立时间
    "supervisedeptname",//监督部门名称
    "supervisedeptcode",//监督部门代码

      //2018-06-08
    "supervisedepttype",//监督部门类别

    "approvedeptname",//审核部门名称
    "approvedeptcode",//审核部门代码
    "platformcode",//交易平台标识码
    "pubserviceplatcode",//公共服务平台标识码
    "datatimestamp",//数据时间戳
    
    //2018-05-03
    "tenderprojectindustriestype",//招标项目行业分类
    "reportduty",//申报责任人
    "tradeplat",//交易平台或发布工具标识码
    "tendercodetype",//招标人代码类型
    "ntenderagencycodetype",//招标代理机构代码类型
    "npubserviceplatcode"//公共服务平台标识码
    
})
/**
 * 招标项目
 *
 * @author Frank
 *
 */
@XmlRootElement(name = "GCJS_TENDER_PROJECT")
public class GCJSTENDERPROJECT {
	public static final String GCJS_TENDER_PROJECT="GCJS_TENDER_PROJECT";
	
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;
    @XmlElement(name = "UNIFIED_DEAL_CODE")
    protected String unifieddealcode;	// 如果招标项目不包含标段（包），此项为必填。
    @XmlElement(name = "TENDER_PROJECT_NAME", required = true)
    protected String tenderprojectname;
    @XmlElement(name = "TENDER_PROJECT_TYPE", required = true)
    protected String tenderprojecttype;
    @XmlElement(name = "REGION_CODE", required = true)
    protected String regioncode;
    @XmlElement(name = "TENDER_CONTENT", required = true)
    protected String tendercontent;
    @XmlElement(name = "OWNER_NAME", required = true)
    protected String ownername;
    @XmlElement(name = "TENDERER_NAME", required = true)
    protected String tenderername;
    @XmlElement(name = "TENDERER_CODE_TYPE", required = true)
    protected String tenderercodetype;
    @XmlElement(name = "TENDERER_CODE", required = true)
    protected String tenderercode;
    @XmlElement(name = "TENDERER_ROLE", required = true)
    protected String tendererrole;
    @XmlElement(name = "TENDER_AGENCY_NAME", required = true)
    protected String tenderagencyname;
    @XmlElement(name = "TENDER_AGENCY_CODE_TYPE", required = true)
    protected String tenderagencycodetype;
    @XmlElement(name = "TENDER_AGENCY_CODE", required = true)
    protected String tenderagencycode;
    @XmlElement(name = "TENDER_AGENCY_ROLE", required = true)
    protected String tenderagencyrole;
    @XmlElement(name = "TENDER_MODE", required = true)
    protected String tendermode;
    @XmlElement(name = "TENDER_ORGANIZE_FORM", required = true)
    protected String tenderorganizeform;
    @XmlElement(name = "CREATE_TIME", required = true)
    protected String createtime;
    @XmlElement(name = "SUPERVISE_DEPT_NAME", required = true)
    protected String supervisedeptname;
    @XmlElement(name = "SUPERVISE_DEPT_CODE")
    protected String supervisedeptcode;
    @XmlElement(name = "APPROVE_DEPT_NAME", required = true)
    protected String approvedeptname;
    @XmlElement(name = "APPROVE_DEPT_CODE")
    protected String approvedeptcode;
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;
    
    
    @XmlElement(name = "TENDER_PROJECT_INDUSTRIES_TYPE", required = true)
    protected String tenderprojectindustriestype;
    @XmlElement(name = "REPORT_DUTY", required = true)
    protected String reportduty;
    @XmlElement(name = "TRADE_PLAT", required = true)
    protected String tradeplat;
    @XmlElement(name = "TENDER_CODE_TYPE", required = true)
    protected String tendercodetype;
    @XmlElement(name = "N_TENDER_AGENCY_CODE_TYPE", required = true)
    protected String ntenderagencycodetype;
    @XmlElement(name = "N_PUB_SERVICE_PLAT_CODE", required = true)
    protected String npubserviceplatcode;


    @XmlElement(name = "SUPERVISE_DEPT_TYPE", required = true)
    protected String supervisedepttype;




    /**
     * 获取supervisedepttype属性的值。
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getSUPERVISEDEPTTYPE() {
        return supervisedepttype;
    }

    /**
     * 设置supervisedepttype属性的值。
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setSUPERVISEDEPTTYPE(String value) {
        this.supervisedepttype = value;
    }

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
     * Gets the value of the tenderprojectcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERPROJECTCODE() {
        return tenderprojectcode;
    }

    /**
     * Sets the value of the tenderprojectcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERPROJECTCODE(String value) {
        this.tenderprojectcode = value;
    }

    /**
     * Gets the value of the unifieddealcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUNIFIEDDEALCODE() {
        return unifieddealcode;
    }

    /**
     * Sets the value of the unifieddealcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUNIFIEDDEALCODE(String value) {
        this.unifieddealcode = value;
    }

    /**
     * Gets the value of the tenderprojectname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERPROJECTNAME() {
        return tenderprojectname;
    }

    /**
     * Sets the value of the tenderprojectname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERPROJECTNAME(String value) {
        this.tenderprojectname = value;
    }

    /**
     * Gets the value of the tenderprojecttype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERPROJECTTYPE() {
        return tenderprojecttype;
    }

    /**
     * Sets the value of the tenderprojecttype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERPROJECTTYPE(String value) {
        this.tenderprojecttype = value;
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
     * Gets the value of the tendercontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERCONTENT() {
        return tendercontent;
    }

    /**
     * Sets the value of the tendercontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERCONTENT(String value) {
        this.tendercontent = value;
    }

    /**
     * Gets the value of the ownername property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOWNERNAME() {
        return ownername;
    }

    /**
     * Sets the value of the ownername property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOWNERNAME(String value) {
        this.ownername = value;
    }

    /**
     * Gets the value of the tenderername property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERNAME() {
        return tenderername;
    }

    /**
     * Sets the value of the tenderername property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERNAME(String value) {
        this.tenderername = value;
    }

    /**
     * Gets the value of the tenderercodetype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERCODETYPE() {
        return tenderercodetype;
    }

    /**
     * Sets the value of the tenderercodetype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERCODETYPE(String value) {
        this.tenderercodetype = value;
    }

    /**
     * Gets the value of the tenderercode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERCODE() {
        return tenderercode;
    }

    /**
     * Sets the value of the tenderercode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERCODE(String value) {
        this.tenderercode = value;
    }

    /**
     * Gets the value of the tendererrole property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERROLE() {
        return tendererrole;
    }

    /**
     * Sets the value of the tendererrole property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERROLE(String value) {
        this.tendererrole = value;
    }

    /**
     * Gets the value of the tenderagencyname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYNAME() {
        return tenderagencyname;
    }

    /**
     * Sets the value of the tenderagencyname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYNAME(String value) {
        this.tenderagencyname = value;
    }

    /**
     * Gets the value of the tenderagencycodetype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYCODETYPE() {
        return tenderagencycodetype;
    }

    /**
     * Sets the value of the tenderagencycodetype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYCODETYPE(String value) {
        this.tenderagencycodetype = value;
    }

    /**
     * Gets the value of the tenderagencycode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYCODE() {
        return tenderagencycode;
    }

    /**
     * Sets the value of the tenderagencycode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYCODE(String value) {
        this.tenderagencycode = value;
    }

    /**
     * Gets the value of the tenderagencyrole property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYROLE() {
        return tenderagencyrole;
    }

    /**
     * Sets the value of the tenderagencyrole property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYROLE(String value) {
        this.tenderagencyrole = value;
    }

    /**
     * Gets the value of the tendermode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERMODE() {
        return tendermode;
    }

    /**
     * Sets the value of the tendermode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERMODE(String value) {
        this.tendermode = value;
    }

    /**
     * Gets the value of the tenderorganizeform property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERORGANIZEFORM() {
        return tenderorganizeform;
    }

    /**
     * Sets the value of the tenderorganizeform property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERORGANIZEFORM(String value) {
        this.tenderorganizeform = value;
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
     * Gets the value of the supervisedeptname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSUPERVISEDEPTNAME() {
        return supervisedeptname;
    }

    /**
     * Sets the value of the supervisedeptname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSUPERVISEDEPTNAME(String value) {
        this.supervisedeptname = value;
    }

    /**
     * Gets the value of the supervisedeptcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSUPERVISEDEPTCODE() {
        return supervisedeptcode;
    }

    /**
     * Sets the value of the supervisedeptcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSUPERVISEDEPTCODE(String value) {
        this.supervisedeptcode = value;
    }

    /**
     * Gets the value of the approvedeptname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPROVEDEPTNAME() {
        return approvedeptname;
    }

    /**
     * Sets the value of the approvedeptname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPROVEDEPTNAME(String value) {
        this.approvedeptname = value;
    }

    /**
     * Gets the value of the approvedeptcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPROVEDEPTCODE() {
        return approvedeptcode;
    }

    /**
     * Sets the value of the approvedeptcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPROVEDEPTCODE(String value) {
        this.approvedeptcode = value;
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
    
    
    /**
     * 获取tenderprojectindustriestype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERPROJECTINDUSTRIESTYPE() {
        return tenderprojectindustriestype;
    }

    /**
     * 设置tenderprojectindustriestype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERPROJECTINDUSTRIESTYPE(String value) {
        this.tenderprojectindustriestype = value;
    }

    /**
     * 获取reportduty属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getREPORTDUTY() {
        return reportduty;
    }

    /**
     * 设置reportduty属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setREPORTDUTY(String value) {
        this.reportduty = value;
    }

    /**
     * 获取tradeplat属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTRADEPLAT() {
        return tradeplat;
    }

    /**
     * 设置tradeplat属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTRADEPLAT(String value) {
        this.tradeplat = value;
    }

    /**
     * 获取tendercodetype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERCODETYPE() {
        return tendercodetype;
    }

    /**
     * 设置tendercodetype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERCODETYPE(String value) {
        this.tendercodetype = value;
    }

    /**
     * 获取ntenderagencycodetype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNTENDERAGENCYCODETYPE() {
        return ntenderagencycodetype;
    }

    /**
     * 设置ntenderagencycodetype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNTENDERAGENCYCODETYPE(String value) {
        this.ntenderagencycodetype = value;
    }

    /**
     * 获取npubserviceplatcode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNPUBSERVICEPLATCODE() {
        return npubserviceplatcode;
    }

    /**
     * 设置npubserviceplatcode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNPUBSERVICEPLATCODE(String value) {
        this.npubserviceplatcode = value;
    }

	@Override
	public String toString() {
		return "GCJSTENDERPROJECT [projectcode=" + projectcode + ", tenderprojectcode=" + tenderprojectcode
				+ ", unifieddealcode=" + unifieddealcode + ", tenderprojectname=" + tenderprojectname
				+ ", tenderprojecttype=" + tenderprojecttype + ", regioncode=" + regioncode + ", tendercontent="
				+ tendercontent + ", ownername=" + ownername + ", tenderername=" + tenderername + ", tenderercodetype="
				+ tenderercodetype + ", tenderercode=" + tenderercode + ", tendererrole=" + tendererrole
				+ ", tenderagencyname=" + tenderagencyname + ", tenderagencycodetype=" + tenderagencycodetype
				+ ", tenderagencycode=" + tenderagencycode + ", tenderagencyrole=" + tenderagencyrole + ", tendermode="
				+ tendermode + ", tenderorganizeform=" + tenderorganizeform + ", createtime=" + createtime
				+ ", supervisedeptname=" + supervisedeptname + ", supervisedeptcode=" + supervisedeptcode
				+ ", approvedeptname=" + approvedeptname + ", approvedeptcode=" + approvedeptcode + ", platformcode="
				+ platformcode + ", pubserviceplatcode=" + pubserviceplatcode + ", datatimestamp=" + datatimestamp
				+ ", tenderprojectindustriestype=" + tenderprojectindustriestype + ", reportduty=" + reportduty
				+ ", tradeplat=" + tradeplat + ", tendercodetype=" + tendercodetype + ", ntenderagencycodetype="
				+ ntenderagencycodetype + ", npubserviceplatcode=" + npubserviceplatcode + "]";
	}
	
    
    
}
