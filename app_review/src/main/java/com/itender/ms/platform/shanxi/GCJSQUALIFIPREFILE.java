

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "bidsectioncodes",
    "tenderprojectcode",
    "unifieddealcodes",
    "applicantionname",
    "applicantioncode",
    "qualificationelement",
    "bidmanager",
    "applysubmittime",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp"
})
/****
 *  资格预审申请文件
 * @author Administrator
 *
 */
@XmlRootElement(name = "GCJS_QUALIFI_PRE_FILE")
public class GCJSQUALIFIPREFILE {
	
	public static final String GCJS_QUALIFI_PRE_FILE="GCJS_QUALIFI_PRE_FILE";

    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "BID_SECTION_CODES", required = true)
    protected String bidsectioncodes;//标段（包）编码
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "UNIFIED_DEAL_CODES", required = true)
    protected String unifieddealcodes;//相关统一交易标识码
    @XmlElement(name = "APPLICANTION_NAME", required = true)
    protected String applicantionname;//申请人名称
    @XmlElement(name = "APPLICANTION_CODE", required = true)
    protected String applicantioncode;//申请人代码
    @XmlElement(name = "QUALIFICATION_ELEMENT", required = true)
    protected String qualificationelement;//投标资格条件
    @XmlElement(name = "BID_MANAGER", required = true)
    protected String bidmanager;//投标单位项目负责人
    @XmlElement(name = "APPLY_SUBMIT_TIME", required = true)
    protected String applysubmittime;//申请递交时间
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
     * Gets the value of the applicantionname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPLICANTIONNAME() {
        return applicantionname;
    }

    /**
     * Sets the value of the applicantionname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPLICANTIONNAME(String value) {
        this.applicantionname = value;
    }

    /**
     * Gets the value of the applicantioncode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPLICANTIONCODE() {
        return applicantioncode;
    }

    /**
     * Sets the value of the applicantioncode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPLICANTIONCODE(String value) {
        this.applicantioncode = value;
    }

    /**
     * Gets the value of the qualificationelement property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getQUALIFICATIONELEMENT() {
        return qualificationelement;
    }

    /**
     * Sets the value of the qualificationelement property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setQUALIFICATIONELEMENT(String value) {
        this.qualificationelement = value;
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
     * Gets the value of the applysubmittime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAPPLYSUBMITTIME() {
        return applysubmittime;
    }

    /**
     * Sets the value of the applysubmittime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAPPLYSUBMITTIME(String value) {
        this.applysubmittime = value;
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
