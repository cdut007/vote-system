
package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;
import java.math.BigDecimal;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",//项目编号
    "tenderprojectcode",//招标项目编号
    "bidsectioncode",//标段（包）编号
    "unifieddealcode",//相关统一交易标识码
    "noticename",//公告标题
    "noticecontent",//公告内容
    "noticesendtime",//公告发布时间
    "noticemedia",//公告发布媒体
    "url",//公示源URL
    "noticenature",//公告性质
    "bulletintype",//公告类型
    "winbiddername",//中标投标人名称
    "biddercodetype",//中标投标人类别
    "winbiddercode",//中标投标人代码
    "bidderrole",//中标投标人角色
    "bidamount",//中标金额（单位：万元）
    "platformcode",//交易系统标识码
    "pubserviceplatcode",//公共服务平台标识码
    "datatimestamp",//数据时间戳
    "psprelatenoticeid",//关联公告id
    "pspfirstnoticeid",//首次公告id
    "psprelateresultnoticeid",//关联结果公告id
    "pspbidopentime",//开标时间
    
    //2018-05-03
    "tendercode",//招标编号
    "othercontent",//其他内容
    "bulletinduty",//公示发布责任人
    "examinername",//交易平台数据验证责任人姓名
    "attachmentcode",//附件关联标识号
    "tradeplat",//交易平台或发布工具标识码(中国招标投标公共服务平台分配)
    "npubserviceplatcode",//公共服务平台标识码(中国招标投标公共服务平台分配)
    
    "rate",//中标费率
    "otherwinprice",//其他类型中标价

     //2018-06-20
    "nbiddercodetype"//中标人代码类型
})
@XmlRootElement(name = "GCJS_RESULT_NOTICE")
public class GCJSRESULTNOTICE {
	public static final String GCJS_RESULT_NOTICE="GCJS_RESULT_NOTICE";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;
    @XmlElement(name = "NOTICE_NAME", required = true)
    protected String noticename;
    @XmlElement(name = "NOTICE_CONTENT", required = true)
    protected String noticecontent;
    @XmlElement(name = "NOTICE_SEND_TIME", required = true)
    protected String noticesendtime;
    @XmlElement(name = "NOTICE_MEDIA", required = true)
    protected String noticemedia;
    @XmlElement(name = "URL", required = true)
    protected String url;
    @XmlElement(name = "NOTICE_NATURE", required = true)
    protected String noticenature;
    @XmlElement(name = "BULLETIN_TYPE", required = true)
    protected String bulletintype;
    @XmlElement(name = "WIN_BIDDER_NAME", required = true)
    protected String winbiddername;
    @XmlElement(name = "BIDDER_CODE_TYPE", required = true)
    protected String biddercodetype;
    @XmlElement(name = "WIN_BIDDER_CODE", required = true)
    protected String winbiddercode;
    @XmlElement(name = "BIDDER_ROLE", required = true)
    protected String bidderrole;
    @XmlElement(name = "BID_AMOUNT", required = true)
    protected String bidamount;
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;
    @XmlElement(name = "PSP_RELATE_NOTICE_ID", required = true)
    protected String psprelatenoticeid;//关联公告id
    @XmlElement(name = "PSP_FIRST_NOTICE_ID", required = true)
    protected String pspfirstnoticeid;//首次公告id
    @XmlElement(name = "PSP_RELATE_RESULT_NOTICE_ID", required = true)
    protected String psprelateresultnoticeid;//关联结果公告id
    @XmlElement(name = "PSP_BID_OPEN_TIME", required = true)
    protected String pspbidopentime;//开标时间
    
    
    @XmlElement(name = "TENDER_CODE", required = true)
    protected String tendercode;
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
    
    @XmlElement(name = "RATE", required = true)
    protected String rate;
    @XmlElement(name = "OTHER_WIN_PRICE", required = true)
    protected String otherwinprice;

    @XmlElement(name = "N_BIDDER_CODE_TYPE", required = true)
    protected String nbiddercodetype;
    
    
    public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getOtherwinprice() {
		return otherwinprice;
	}

	public void setOtherwinprice(String otherwinprice) {
		this.otherwinprice = otherwinprice;
	}

	public String getPSPRELATERESULTNOTICEID() {
		return psprelateresultnoticeid;
	}

	public void setPSPRELATERESULTNOTICEID(String psprelateresultnoticeid) {
		this.psprelateresultnoticeid = psprelateresultnoticeid;
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
     * Gets the value of the bidsectioncode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDSECTIONCODE() {
        return bidsectioncode;
    }

    /**
     * Sets the value of the bidsectioncode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDSECTIONCODE(String value) {
        this.bidsectioncode = value;
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
     * Gets the value of the noticename property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNOTICENAME() {
        return noticename;
    }

    /**
     * Sets the value of the noticename property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNOTICENAME(String value) {
        this.noticename = value;
    }

    /**
     * Gets the value of the noticecontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNOTICECONTENT() {
        return noticecontent;
    }

    /**
     * Sets the value of the noticecontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNOTICECONTENT(String value) {
        this.noticecontent = value;
    }

    /**
     * Gets the value of the noticesendtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNOTICESENDTIME() {
        return noticesendtime;
    }

    /**
     * Sets the value of the noticesendtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNOTICESENDTIME(String value) {
        this.noticesendtime = value;
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
     * Gets the value of the noticenature property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNOTICENATURE() {
        return noticenature;
    }

    /**
     * Sets the value of the noticenature property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNOTICENATURE(String value) {
        this.noticenature = value;
    }

    /**
     * Gets the value of the bulletintype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBULLETINTYPE() {
        return bulletintype;
    }

    /**
     * Sets the value of the bulletintype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBULLETINTYPE(String value) {
        this.bulletintype = value;
    }

    /**
     * Gets the value of the winbiddername property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWINBIDDERNAME() {
        return winbiddername;
    }

    /**
     * Sets the value of the winbiddername property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWINBIDDERNAME(String value) {
        this.winbiddername = value;
    }

    /**
     * Gets the value of the biddercodetype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDERCODETYPE() {
        return biddercodetype;
    }

    /**
     * Sets the value of the biddercodetype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDERCODETYPE(String value) {
        this.biddercodetype = value;
    }

    /**
     * Gets the value of the winbiddercode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWINBIDDERCODE() {
        return winbiddercode;
    }

    /**
     * Sets the value of the winbiddercode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWINBIDDERCODE(String value) {
        this.winbiddercode = value;
    }

    /**
     * Gets the value of the bidderrole property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDERROLE() {
        return bidderrole;
    }

    /**
     * Sets the value of the bidderrole property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDERROLE(String value) {
        this.bidderrole = value;
    }

    /**
     * Gets the value of the bidamount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public String getBIDAMOUNT() {
        return bidamount;
    }

    /**
     * Sets the value of the bidamount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setBIDAMOUNT(String value) {
        this.bidamount = value;
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

    /**
     * 获取nbiddercodetype属性的值。
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getNBIDDERCODETYPE() {
        return nbiddercodetype;
    }

    /**
     * 设置nbiddercodetype属性的值。
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setNBIDDERCODETYPE(String value) {
        this.nbiddercodetype = value;
    }

}
