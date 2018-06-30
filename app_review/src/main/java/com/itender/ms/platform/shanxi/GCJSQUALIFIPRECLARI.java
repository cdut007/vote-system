

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncodes",
    "unifieddealcodes",
    "doccode",
    "applicantqualifications",
    "applicationvalidtime",
    "docsubmitendtime",
    "docsubmitmethod",
    "docopentime",
    "docopenmethod",
    "evaluationmethod",
    "clarifycontent",
    "submittime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "docname",
    "url"
})
/****
 * 资格预审/资格预审澄清
 * @author Administrator
 *
 */
@XmlRootElement(name = "GCJS_QUALIFI_PRE_CLARI")
public class GCJSQUALIFIPRECLARI {
	public static final String GCJS_QUALIFI_PRE_CLARI="GCJS_QUALIFI_PRE_CLARI";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODES", required = true)
    protected String bidsectioncodes;//标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODES", required = true)
    protected String unifieddealcodes;//相关统一交易标识码
    @XmlElement(name = "DOC_CODE", required = true)
    protected String doccode;//文件编号
    @XmlElement(name = "APPLICANT_QUALIFICATIONS", required = true)
    protected String applicantqualifications;//申请资格
    @XmlElement(name = "APPLICATION_VALID_TIME", required = true)
    protected String applicationvalidtime;//申请有效期
    @XmlElement(name = "DOC_SUBMIT_END_TIME", required = true)
    protected String docsubmitendtime;//申请文件递交截止时间
    @XmlElement(name = "DOC_SUBMIT_METHOD", required = true)
    protected String docsubmitmethod;//申请文件递交方法
    @XmlElement(name = "DOC_OPEN_TIME", required = true)
    protected String docopentime;//文件开启时间
    @XmlElement(name = "DOC_OPEN_METHOD", required = true)
    protected String docopenmethod;//文件开启方式
    @XmlElement(name = "EVALUATION_METHOD", required = true)
    protected String evaluationmethod;//评审办法
    @XmlElement(name = "CLARIFY_CONTENT", required = true)
    protected String clarifycontent;//对文件澄清与修改的主要内容
    @XmlElement(name = "SUBMIT_TIME", required = true)
    protected String submittime;//上传时间
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "DOC_NAME", required = true)
    protected String docname;//文件名称
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
     * Gets the value of the doccode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCCODE() {
        return doccode;
    }

    /**
     * Sets the value of the doccode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCCODE(String value) {
        this.doccode = value;
    }

    /**
     * Gets the value of the applicantqualifications property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPLICANTQUALIFICATIONS() {
        return applicantqualifications;
    }

    /**
     * Sets the value of the applicantqualifications property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPLICANTQUALIFICATIONS(String value) {
        this.applicantqualifications = value;
    }

    /**
     * Gets the value of the applicationvalidtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPLICATIONVALIDTIME() {
        return applicationvalidtime;
    }

    /**
     * Sets the value of the applicationvalidtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPLICATIONVALIDTIME(String value) {
        this.applicationvalidtime = value;
    }

    /**
     * Gets the value of the docsubmitendtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCSUBMITENDTIME() {
        return docsubmitendtime;
    }

    /**
     * Sets the value of the docsubmitendtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCSUBMITENDTIME(String value) {
        this.docsubmitendtime = value;
    }

    /**
     * Gets the value of the docsubmitmethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCSUBMITMETHOD() {
        return docsubmitmethod;
    }

    /**
     * Sets the value of the docsubmitmethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCSUBMITMETHOD(String value) {
        this.docsubmitmethod = value;
    }

    /**
     * Gets the value of the docopentime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCOPENTIME() {
        return docopentime;
    }

    /**
     * Sets the value of the docopentime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCOPENTIME(String value) {
        this.docopentime = value;
    }

    /**
     * Gets the value of the docopenmethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCOPENMETHOD() {
        return docopenmethod;
    }

    /**
     * Sets the value of the docopenmethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCOPENMETHOD(String value) {
        this.docopenmethod = value;
    }

    /**
     * Gets the value of the evaluationmethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEVALUATIONMETHOD() {
        return evaluationmethod;
    }

    /**
     * Sets the value of the evaluationmethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEVALUATIONMETHOD(String value) {
        this.evaluationmethod = value;
    }

    /**
     * Gets the value of the clarifycontent property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCLARIFYCONTENT() {
        return clarifycontent;
    }

    /**
     * Sets the value of the clarifycontent property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCLARIFYCONTENT(String value) {
        this.clarifycontent = value;
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
     * Gets the value of the docname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCNAME() {
        return docname;
    }

    /**
     * Sets the value of the docname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCNAME(String value) {
        this.docname = value;
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
