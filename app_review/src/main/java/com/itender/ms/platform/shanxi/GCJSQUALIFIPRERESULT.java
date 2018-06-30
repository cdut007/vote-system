

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncode",
    "unifieddealcode",
    "passedapplicantlist",
    "resultcreatetime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "noticename",
    "url"
})
/****
 * 资格预审结果
 * @author Administrator
 *
 */
@XmlRootElement(name = "GCJS_QUALIFI_PRE_RESULT")
public class GCJSQUALIFIPRERESULT {
	public static final String GCJS_QUALIFI_PRE_RESULT="GCJS_QUALIFI_PRE_RESULT";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;//标段（包）编码
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;//相关统一交易标识码
    @XmlElement(name = "PASSED_APPLICANT_LIST", required = true)
    protected String passedapplicantlist;//通过资格预审的申请人名单
    @XmlElement(name = "RESULT_CREATE_TIME", required = true)
    protected String resultcreatetime;//资格评审结果生成时间
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "NOTICE_NAME", required = true)
    protected String noticename;//资格预审结果标题
    @XmlElement(name = "URL", required = true)
    protected String url;//结果发布源URL

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
     * Gets the value of the passedapplicantlist property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPASSEDAPPLICANTLIST() {
        return passedapplicantlist;
    }

    /**
     * Sets the value of the passedapplicantlist property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPASSEDAPPLICANTLIST(String value) {
        this.passedapplicantlist = value;
    }

    /**
     * Gets the value of the resultcreatetime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRESULTCREATETIME() {
        return resultcreatetime;
    }

    /**
     * Sets the value of the resultcreatetime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRESULTCREATETIME(String value) {
        this.resultcreatetime = value;
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
