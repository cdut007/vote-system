

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncode",
    "unifieddealcode",
    "evaluationcontent",
    "submittime",
    "endtime",
    "evaluationresult",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "noticename",
    "url"
})
/**
 * 评标报告
 * @author Developer
 *
 */
@XmlRootElement(name = "GCJS_EVALUATION_REPORT")
public class GCJSEVALUATIONREPORT {

	public static final String GCJS_EVALUATION_REPORT="GCJS_EVALUATION_REPORT";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;//标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;//相关统一交易标识码
    @XmlElement(name = "EVALUATION_CONTENT", required = true)
    protected String evaluationcontent;//评标报告正文
    @XmlElement(name = "SUBMIT_TIME", required = true)
    protected String submittime;//评标报告提交时间
    @XmlElement(name = "END_TIME", required = true)
    protected String endtime;//评标结束时间
    @XmlElement(name = "EVALUATION_RESULT", required = true)
    protected String evaluationresult;//评标结果 <!--1.招标失败 2.重新招标 3.评标结果公示 -->
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "NOTICE_NAME", required = true)
    protected String noticename;//评标报告标题
    @XmlElement(name = "URL", required = true)
    protected String url;//报告源URL

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
     * Gets the value of the evaluationcontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEVALUATIONCONTENT() {
        return evaluationcontent;
    }

    /**
     * Sets the value of the evaluationcontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEVALUATIONCONTENT(String value) {
        this.evaluationcontent = value;
    }

    /**
     * Gets the value of the submittime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSUBMITTIME() {
        return submittime;
    }

    /**
     * Sets the value of the submittime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSUBMITTIME(String value) {
        this.submittime = value;
    }

    /**
     * Gets the value of the endtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getENDTIME() {
        return endtime;
    }

    /**
     * Sets the value of the endtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setENDTIME(String value) {
        this.endtime = value;
    }

    /**
     * Gets the value of the evaluationresult property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEVALUATIONRESULT() {
        return evaluationresult;
    }

    /**
     * Sets the value of the evaluationresult property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEVALUATIONRESULT(String value) {
        this.evaluationresult = value;
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
