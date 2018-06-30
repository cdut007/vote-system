
package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncode",
    "unifieddealcode",
    "bidsectionname",
    "bidsectioncontent",
    "tenderprojectclassifycode",
    "contractreckonprice",
    "bidqualification",
    "begindate",
    "limitetime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "createtime"
})
/**
 * 标段（包）
 * @author Developer
 *
 */
@XmlRootElement(name = "GCJS_SECTION")
public class GCJSSECTION {
	public static final String GCJS_SECTION="GCJS_SECTION";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;//标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;//统一交易标识码
    @XmlElement(name = "BID_SECTION_NAME", required = true)
    protected String bidsectionname;//标段（包）名称
    @XmlElement(name = "BID_SECTION_CONTENT", required = true)
    protected String bidsectioncontent;//标段（包）内容
    @XmlElement(name = "TENDER_PROJECT_CLASSIFY_CODE", required = true)
    protected String tenderprojectclassifycode;//标段（包）分类代码
    @XmlElement(name = "CONTRACT_RECKON_PRICE", required = true)
    protected String contractreckonprice;//标段合同估算价（单位：万元）
    @XmlElement(name = "BID_QUALIFICATION", required = true)
    protected String bidqualification;//投标人资格条件
    @XmlElement(name = "BEGIN_DATE", required = true)
    protected String begindate;//计划开工日期
    @XmlElement(name = "LIMITE_TIME", required = true)
    protected String limitetime;//工期
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "CREATE_TIME", required = true)
    protected String createtime;//标段包创建时间

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
     * Gets the value of the bidsectionname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDSECTIONNAME() {
        return bidsectionname;
    }

    /**
     * Sets the value of the bidsectionname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDSECTIONNAME(String value) {
        this.bidsectionname = value;
    }

    /**
     * Gets the value of the bidsectioncontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDSECTIONCONTENT() {
        return bidsectioncontent;
    }

    /**
     * Sets the value of the bidsectioncontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDSECTIONCONTENT(String value) {
        this.bidsectioncontent = value;
    }

    /**
     * Gets the value of the tenderprojectclassifycode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERPROJECTCLASSIFYCODE() {
        return tenderprojectclassifycode;
    }

    /**
     * Sets the value of the tenderprojectclassifycode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERPROJECTCLASSIFYCODE(String value) {
        this.tenderprojectclassifycode = value;
    }

    /**
     * Gets the value of the contractreckonprice property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCONTRACTRECKONPRICE() {
        return contractreckonprice;
    }

    /**
     * Sets the value of the contractreckonprice property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCONTRACTRECKONPRICE(String value) {
        this.contractreckonprice = value;
    }

    /**
     * Gets the value of the bidqualification property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDQUALIFICATION() {
        return bidqualification;
    }

    /**
     * Sets the value of the bidqualification property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDQUALIFICATION(String value) {
        this.bidqualification = value;
    }

    /**
     * Gets the value of the begindate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBEGINDATE() {
        return begindate;
    }

    /**
     * Sets the value of the begindate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBEGINDATE(String value) {
        this.begindate = value;
    }

    /**
     * Gets the value of the limitetime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLIMITETIME() {
        return limitetime;
    }

    /**
     * Sets the value of the limitetime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLIMITETIME(String value) {
        this.limitetime = value;
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

	@Override
	public String toString() {
		return "GCJSSECTION [projectcode=" + projectcode
				+ ", tenderprojectcode=" + tenderprojectcode
				+ ", bidsectioncode=" + bidsectioncode + ", unifieddealcode="
				+ unifieddealcode + ", bidsectionname=" + bidsectionname
				+ ", bidsectioncontent=" + bidsectioncontent
				+ ", tenderprojectclassifycode=" + tenderprojectclassifycode
				+ ", contractreckonprice=" + contractreckonprice
				+ ", bidqualification=" + bidqualification + ", begindate="
				+ begindate + ", limitetime=" + limitetime + ", platformcode="
				+ platformcode + ", pubserviceplatcode=" + pubserviceplatcode
				+ ", datatimestamp=" + datatimestamp + ", createtime="
				+ createtime + "]";
	}
    
}
