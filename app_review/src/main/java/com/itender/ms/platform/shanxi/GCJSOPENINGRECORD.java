

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncodes",
    "unifieddealcodes",
    "bidopeningactor",
    "bidopeningcontent",
    "bidopeningaddress",
    "bidopeningtime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "noticename",
    "url"
})
/**
 * 开标记录
 * @author Developer
 *
 */
@XmlRootElement(name = "GCJS_OPENING_RECORD")
public class GCJSOPENINGRECORD {
	
	public static final String GCJS_OPENING_RECORD="GCJS_OPENING_RECORD";
	
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODES", required = true)
    protected String bidsectioncodes;//相关标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODES", required = true)
    protected String unifieddealcodes;//相关统一交易标识码
    @XmlElement(name = "BID_OPENING_ACTOR", required = true)
    protected String bidopeningactor;//开标参与人
    @XmlElement(name = "BID_OPENING_CONTENT", required = true)
    protected String bidopeningcontent;//开标记录内容
    @XmlElement(name = "BID_OPENING_ADDRESS", required = true)
    protected String bidopeningaddress;//开标地点
    @XmlElement(name = "BID_OPENING_TIME", required = true)
    protected String bidopeningtime;//开标时间
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "NOTICE_NAME", required = true)
    protected String noticename;//开标记录标题
    @XmlElement(name = "URL", required = true)
    protected String url;//开标记录源URL

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
     * Gets the value of the unifieddealcodes property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUNIFIEDDEALCODES() {
        return unifieddealcodes;
    }

    /**
     * Sets the value of the unifieddealcodes property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUNIFIEDDEALCODES(String value) {
        this.unifieddealcodes = value;
    }

    /**
     * Gets the value of the bidopeningactor property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDOPENINGACTOR() {
        return bidopeningactor;
    }

    /**
     * Sets the value of the bidopeningactor property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDOPENINGACTOR(String value) {
        this.bidopeningactor = value;
    }

    /**
     * Gets the value of the bidopeningcontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDOPENINGCONTENT() {
        return bidopeningcontent;
    }

    /**
     * Sets the value of the bidopeningcontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDOPENINGCONTENT(String value) {
        this.bidopeningcontent = value;
    }

    /**
     * Gets the value of the bidopeningaddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDOPENINGADDRESS() {
        return bidopeningaddress;
    }

    /**
     * Sets the value of the bidopeningaddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDOPENINGADDRESS(String value) {
        this.bidopeningaddress = value;
    }

    /**
     * Gets the value of the bidopeningtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDOPENINGTIME() {
        return bidopeningtime;
    }

    /**
     * Sets the value of the bidopeningtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDOPENINGTIME(String value) {
        this.bidopeningtime = value;
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

}
