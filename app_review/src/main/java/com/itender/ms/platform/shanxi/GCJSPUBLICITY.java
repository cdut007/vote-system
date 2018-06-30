
package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;

/**
 * 中标公示
 */


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncodes",
    "unifieddealcode",
    "publicityname",
    "publicitycontent",
    "publicityrefertime",
    "noticemedia",
    "url",
    "publicitytype",
    "publicitystarttime",
    "publicityendtime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "psprelatenoticeid",
    "pspfirstnoticeid",
    "psprelatepublicityid",
    "pspbidopentime",
    
    //2018-05-03
    "tendercode",//招标编号
    "objectionmethod",//提出异议的渠道和方式
    "othercontent",//其他内容
    "bulletinduty",//公示发布责任人
    "examinername",//交易平台数据验证责任人姓名
    "attachmentcode",//附件关联标识号
    "tradeplat",//交易平台或发布工具标识码(中国招标投标公共服务平台分配)
    "npubserviceplatcode"//公共服务平台标识码(中国招标投标公共服务平台分配)
})
/***
 * 中标公示
 * @author Administrator
 *
 */

@XmlRootElement(name = "GCJS_PUBLICITY")
public class GCJSPUBLICITY {
	
	public static final String GCJS_PUBLICITY="GCJS_PUBLICITY";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODES", required = true)
    protected String bidsectioncodes;//标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;//相关统一交易标识码
    @XmlElement(name = "PUBLICITY_NAME", required = true)
    protected String publicityname;//公示标题
    @XmlElement(name = "PUBLICITY_CONTENT", required = true)
    protected String publicitycontent;//公示内容
    @XmlElement(name = "PUBLICITY_REFER_TIME", required = true)
    protected String publicityrefertime;//公示提交时间
    @XmlElement(name = "NOTICE_MEDIA", required = true)
    protected String noticemedia;//公示发布媒体
    @XmlElement(name = "URL", required = true)
    protected String url;//公示源URL
    @XmlElement(name = "PUBLICITY_TYPE", required = true)
    protected String publicitytype;//公示类型
    @XmlElement(name = "PUBLICITY_START_TIME", required = true)
    protected String publicitystarttime;//公示开始时间
    @XmlElement(name = "PUBLICITY_END_TIME", required = true)
    protected String publicityendtime;//公示结束时间
	@XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode = "";//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "PSP_RELATE_NOTICE_ID", required = true)
    protected String psprelatenoticeid;//关联公告id
    @XmlElement(name = "PSP_FIRST_NOTICE_ID", required = true)
    protected String pspfirstnoticeid;//首次公告id
    @XmlElement(name = "PSP_RELATE_PUBLICITY_ID", required = true)
    protected String psprelatepublicityid;//中标候选人id
    @XmlElement(name = "PSP_BID_OPEN_TIME", required = true)
    protected String pspbidopentime;//开标时间
    
    
    
    @XmlElement(name = "TENDER_CODE", required = true)
    protected String tendercode;
    @XmlElement(name = "OBJECTION_METHOD", required = true)
    protected String objectionmethod;
    @XmlElement(name = "OTHER_CONTENT", required = true)
    protected String othercontent;
    @XmlElement(name = "BULLETIN_DUTY", required = true)
    protected String bulletinduty;
    @XmlElement(name = "EXAMINER_NAME", required = true)
    protected String examinername;
    @XmlElement(name = "ATTACHMENT_CODE", required = true)
    protected String attachmentcode;
    @XmlElement(name = "TRADE_PLAT", required = true)
    protected String tradeplat;
    @XmlElement(name = "N_PUB_SERVICE_PLAT_CODE", required = true)
    protected String npubserviceplatcode;
  
	public String getPSPRELATEPUBLICITYID() {
		return psprelatepublicityid;
	}

	public void setPSPRELATEPUBLICITYID(String psprelatepublicityid) {
		this.psprelatepublicityid = psprelatepublicityid;
	}


	public String getPSPFIRSTNOTICEID() {
		return pspfirstnoticeid;
	}

	public void setPSPFIRSTNOTICEID(String pspfirstnoticeid) {
		this.pspfirstnoticeid = pspfirstnoticeid;
	}

	public String getPSPBIDOPENTIME() {
		return pspbidopentime;
	}

	public void setPSPBIDOPENTIME(String pspbidopentime) {
		this.pspbidopentime = pspbidopentime;
	}


    
    public String getPSPRELATENOTICEID() {
		return psprelatenoticeid;
	}

	public void setPSPRELATENOTICEID(String psprelatenoticeid) {
		this.psprelatenoticeid = psprelatenoticeid;
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
     * Gets the value of the bidsectioncodes property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDSECTIONCODES() {
        return bidsectioncodes;
    }

    /**
     * Sets the value of the bidsectioncodes property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDSECTIONCODES(String value) {
        this.bidsectioncodes = value;
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
     * Gets the value of the publicityname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBLICITYNAME() {
        return publicityname;
    }

    /**
     * Sets the value of the publicityname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBLICITYNAME(String value) {
        this.publicityname = value;
    }

    /**
     * Gets the value of the publicitycontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBLICITYCONTENT() {
        return publicitycontent;
    }

    /**
     * Sets the value of the publicitycontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBLICITYCONTENT(String value) {
        this.publicitycontent = value;
    }

    /**
     * Gets the value of the publicityrefertime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBLICITYREFERTIME() {
        return publicityrefertime;
    }

    /**
     * Sets the value of the publicityrefertime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBLICITYREFERTIME(String value) {
        this.publicityrefertime = value;
    }

    /**
     * Gets the value of the noticemedia property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNOTICEMEDIA() {
        return noticemedia;
    }

    /**
     * Sets the value of the noticemedia property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNOTICEMEDIA(String value) {
        this.noticemedia = value;
    }

    /**
     * Gets the value of the url property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getURL() {
        return url;
    }

    /**
     * Sets the value of the url property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setURL(String value) {
        this.url = value;
    }

    /**
     * Gets the value of the publicitytype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBLICITYTYPE() {
        return publicitytype;
    }

    /**
     * Sets the value of the publicitytype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBLICITYTYPE(String value) {
        this.publicitytype = value;
    }

    /**
     * Gets the value of the publicitystarttime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBLICITYSTARTTIME() {
        return publicitystarttime;
    }

    /**
     * Sets the value of the publicitystarttime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBLICITYSTARTTIME(String value) {
        this.publicitystarttime = value;
    }

    /**
     * Gets the value of the publicityendtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPUBLICITYENDTIME() {
        return publicityendtime;
    }

    /**
     * Sets the value of the publicityendtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPUBLICITYENDTIME(String value) {
        this.publicityendtime = value;
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
     * 获取tendercode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERCODE() {
        return tendercode;
    }

    /**
     * 设置tendercode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERCODE(String value) {
        this.tendercode = value;
    }

    /**
     * 获取objectionmethod属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOBJECTIONMETHOD() {
        return objectionmethod;
    }

    /**
     * 设置objectionmethod属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOBJECTIONMETHOD(String value) {
        this.objectionmethod = value;
    }

    /**
     * 获取othercontent属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOTHERCONTENT() {
        return othercontent;
    }

    /**
     * 设置othercontent属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOTHERCONTENT(String value) {
        this.othercontent = value;
    }

    /**
     * 获取bulletinduty属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBULLETINDUTY() {
        return bulletinduty;
    }

    /**
     * 设置bulletinduty属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBULLETINDUTY(String value) {
        this.bulletinduty = value;
    }

    /**
     * 获取examinername属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEXAMINERNAME() {
        return examinername;
    }

    /**
     * 设置examinername属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEXAMINERNAME(String value) {
        this.examinername = value;
    }

    /**
     * 获取attachmentcode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getATTACHMENTCODE() {
        return attachmentcode;
    }

    /**
     * 设置attachmentcode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setATTACHMENTCODE(String value) {
        this.attachmentcode = value;
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

}
