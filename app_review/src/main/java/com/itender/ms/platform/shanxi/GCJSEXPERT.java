


package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncode",
    "unifieddealcode",
    "experttype",
    "expertname",
    "idcard",
    "idcardtype",
    "expertcheckintime",
    "ischairman",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp"
})
/**
 * 评标专家
 * @author Developer
 *
 */
@XmlRootElement(name = "GCJS_EXPERT")
public class GCJSEXPERT {

	public static final String GCJS_EXPERT="GCJS_EXPERT";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;//标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;//相关统一交易标识码
    @XmlElement(name = "EXPERT_TYPE", required = true)
    protected String experttype;//专家类别
    @XmlElement(name = "EXPERT_NAME", required = true)
    protected String expertname;//专家姓名
    @XmlElement(name = "ID_CARD", required = true)
    protected String idcard;//专家身份证件号
    @XmlElement(name = "ID_CARD_TYPE", required = true)
    protected String idcardtype;//专家身份证件类型
    @XmlElement(name = "EXPERT_CHECK_IN_TIME", required = true)
    protected String expertcheckintime;//专家签到时间
    @XmlElement(name = "IS_CHAIR_MAN", required = true)
    protected String ischairman;//是否为评标组长
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳

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
     * Gets the value of the experttype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEXPERTTYPE() {
        return experttype;
    }

    /**
     * Sets the value of the experttype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEXPERTTYPE(String value) {
        this.experttype = value;
    }

    /**
     * Gets the value of the expertname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEXPERTNAME() {
        return expertname;
    }

    /**
     * Sets the value of the expertname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEXPERTNAME(String value) {
        this.expertname = value;
    }

    /**
     * Gets the value of the idcard property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIDCARD() {
        return idcard;
    }

    /**
     * Sets the value of the idcard property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIDCARD(String value) {
        this.idcard = value;
    }

    /**
     * Gets the value of the idcardtype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIDCARDTYPE() {
        return idcardtype;
    }

    /**
     * Sets the value of the idcardtype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIDCARDTYPE(String value) {
        this.idcardtype = value;
    }

    /**
     * Gets the value of the expertcheckintime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEXPERTCHECKINTIME() {
        return expertcheckintime;
    }

    /**
     * Sets the value of the expertcheckintime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEXPERTCHECKINTIME(String value) {
        this.expertcheckintime = value;
    }

    /**
     * Gets the value of the ischairman property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getISCHAIRMAN() {
        return ischairman;
    }

    /**
     * Sets the value of the ischairman property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setISCHAIRMAN(String value) {
        this.ischairman = value;
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
