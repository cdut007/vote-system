

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;
import java.math.BigDecimal;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",//项目编号
    "tenderprojectcode",//招标项目编号
    "bidsectioncode",//标段（包）编码
    "unifieddealcode",//相关统一交易标识码
    "biddername",//投标人名称
    "biddercodetype",//投标人类别
    "bidderorgcode",//投标人代码
    "bidderrole",//投标人角色
    "bidmanager",//投标单位项目负责人
    "biddocdownloadtime",//标书下载时间
    "marginpayform",//保证金递交方式
    "marginreceivetime",//保证金递交时间
    "unionenterprisename",//联合体名称（如有）
    "unionorgansetcode",//联合体组织机构代码证（联合体招标时填写）
    "unioncontactname",//联合体联系人（如有）
    "unioncontactphone",//联合体联系电话（如有）
    "bidderinfoversion",//投标人信息版本
    "bidprice",//投标报价金额（单位：万元）
    "timelimit",//投标工期
    "checkintime",//投标文件递交时间
    "platformcode",//交易系统标识码
    "pubserviceplatcode",//公共服务平台标识码
    "datatimestamp",//数据时间戳
    "pricecurrency",//投标报价币种
    "priceunit",//投标报价单位
    "signature"//数字签名
})
/**
 * 投标人名单
 * @author ruru
 *
 */
@XmlRootElement(name = "GCJS_TENDER_LIST")
public class GCJSTENDERLIST {
	
	
	public static final String GCJS_TENDER_LIST = "GCJS_TENDER_LIST";

	
	
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;
    @XmlElement(name = "BIDDER_NAME", required = true)
    protected String biddername;
    @XmlElement(name = "BIDDER_CODE_TYPE", required = true)
    protected String biddercodetype;
    @XmlElement(name = "BIDDER_ORG_CODE", required = true)
    protected String bidderorgcode;
    @XmlElement(name = "BIDDER_ROLE", required = true)
    protected String bidderrole;
    @XmlElement(name = "BID_MANAGER", required = true)
    protected String bidmanager;
    @XmlElement(name = "BID_DOC_DOWNLOAD_TIME", required = true)
    protected String biddocdownloadtime;
    @XmlElement(name = "MARGIN_PAY_FORM", required = true)
    protected String marginpayform;
    @XmlElement(name = "MARGIN_RECEIVE_TIME", required = true)
    protected String marginreceivetime;
    @XmlElement(name = "UNION_ENTERPRISE_NAME")
    protected String unionenterprisename;
    @XmlElement(name = "UNION_ORGAN_SET_CODE")
    protected String unionorgansetcode;
    @XmlElement(name = "UNION_CONTACT_NAME")
    protected String unioncontactname;
    @XmlElement(name = "UNION_CONTACT_PHONE")
    protected String unioncontactphone;
    @XmlElement(name = "BIDDER_INFO_VERSION")
    protected String bidderinfoversion;
    @XmlElement(name = "BID_PRICE", required = true)
    protected String bidprice;
    @XmlElement(name = "TIME_LIMIT", required = true)
    protected Integer timelimit;
    @XmlElement(name = "CHECKIN_TIME", required = true)
    protected String checkintime;
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;
    @XmlElement(name = "PRICE_CURRENCY")
    protected String pricecurrency;
    @XmlElement(name = "PRICE_UNIT", required = true)
    protected String priceunit;
    @XmlElement(name = "SIGNATURE", required = true)
    protected String signature;
      

    public String getSIGNATURE() {
		return signature;
	}

	public void setSIGNATURE(String signature) {
		this.signature = signature;
	}
	
	public String getPRICECURRENCY() {
		return pricecurrency;
	}
	
	public void setPRICECURRENCY(String pricecurrency) {
		this.pricecurrency = pricecurrency;
	}

	public String getPRICEUNIT() {
		return priceunit;
	}

	public void setPRICEUNIT(String priceunit) {
		this.priceunit = priceunit;
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
     * Gets the value of the biddername property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDERNAME() {
        return biddername;
    }

    /**
     * Sets the value of the biddername property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDERNAME(String value) {
        this.biddername = value;
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
     * Gets the value of the bidderorgcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDERORGCODE() {
        return bidderorgcode;
    }

    /**
     * Sets the value of the bidderorgcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDERORGCODE(String value) {
        this.bidderorgcode = value;
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
     * Gets the value of the bidmanager property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDMANAGER() {
        return bidmanager;
    }

    /**
     * Sets the value of the bidmanager property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDMANAGER(String value) {
        this.bidmanager = value;
    }

    /**
     * Gets the value of the biddocdownloadtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDOCDOWNLOADTIME() {
        return biddocdownloadtime;
    }

    /**
     * Sets the value of the biddocdownloadtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDOCDOWNLOADTIME(String value) {
        this.biddocdownloadtime = value;
    }

    /**
     * Gets the value of the marginpayform property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMARGINPAYFORM() {
        return marginpayform;
    }

    /**
     * Sets the value of the marginpayform property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMARGINPAYFORM(String value) {
        this.marginpayform = value;
    }

    /**
     * Gets the value of the marginreceivetime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMARGINRECEIVETIME() {
        return marginreceivetime;
    }

    /**
     * Sets the value of the marginreceivetime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMARGINRECEIVETIME(String value) {
        this.marginreceivetime = value;
    }

    /**
     * Gets the value of the unionenterprisename property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUNIONENTERPRISENAME() {
        return unionenterprisename;
    }

    /**
     * Sets the value of the unionenterprisename property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUNIONENTERPRISENAME(String value) {
        this.unionenterprisename = value;
    }

    /**
     * Gets the value of the unionorgansetcode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUNIONORGANSETCODE() {
        return unionorgansetcode;
    }

    /**
     * Sets the value of the unionorgansetcode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUNIONORGANSETCODE(String value) {
        this.unionorgansetcode = value;
    }

    /**
     * Gets the value of the unioncontactname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUNIONCONTACTNAME() {
        return unioncontactname;
    }

    /**
     * Sets the value of the unioncontactname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUNIONCONTACTNAME(String value) {
        this.unioncontactname = value;
    }

    /**
     * Gets the value of the unioncontactphone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUNIONCONTACTPHONE() {
        return unioncontactphone;
    }

    /**
     * Sets the value of the unioncontactphone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUNIONCONTACTPHONE(String value) {
        this.unioncontactphone = value;
    }

    /**
     * Gets the value of the bidderinfoversion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDERINFOVERSION() {
        return bidderinfoversion;
    }

    /**
     * Sets the value of the bidderinfoversion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDERINFOVERSION(String value) {
        this.bidderinfoversion = value;
    }

    /**
     * Gets the value of the bidprice property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public String getBIDPRICE() {
        return bidprice;
    }

    /**
     * Sets the value of the bidprice property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setBIDPRICE(String value) {
        this.bidprice = value;
    }

    /**
     * Gets the value of the timelimit property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public Integer getTIMELIMIT() {
        return timelimit;
    }

    /**
     * Sets the value of the timelimit property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTIMELIMIT(Integer value) {
        this.timelimit = value;
    }

    /**
     * Gets the value of the checkintime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCHECKINTIME() {
        return checkintime;
    }

    /**
     * Sets the value of the checkintime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCHECKINTIME(String value) {
        this.checkintime = value;
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
