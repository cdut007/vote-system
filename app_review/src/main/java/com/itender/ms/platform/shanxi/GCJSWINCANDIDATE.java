
package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;
import java.math.BigDecimal;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",//项目编号
    "tenderprojectcode",//招标项目编号
    "bidsectioncode",//标段（包）编号
    "unifieddealcode",//相关统一交易标识码
    "wincandidatename",//中标候选人名称
    "biddercodetype",//中标候选人类别
    "wincandidatecode",//中标候选人代码
    "bidderrole",//中标候选人角色
    "wincandidateorder",//中标候选人排名
    "isfloatrate",//是否采用下浮率
    "evaluationresult",//评分结果
    "bidprice",//投标价格
    "evaluationprice",//评标价格（单位：万元）
    "winprice",//中标价格（单位：万元）
    "platformcode",//交易系统标识码
    "pubserviceplatcode",//公共服务平台标识码
    "datatimestamp",//数据时间戳
    
    
    
    //2018-04-25
    "wincandidatecodetype",//中标候选人代码类型
    "rate",//费率
    "otherbidprice",//其他类型投标报价
    "quality",//质量
    "evaluationstatus",//评标情况
    "wincandidatequalification",//中标候选人响应招标文件的资格能力条件
    "pmname",//项目负责人姓名
    "pmcode",//项目负责人证件号码
    "pmcertificates",//项目负责人相关证书和编号
    
    //2018-05-15
    "timelimit"//工期/交货期/服务期
})
@XmlRootElement(name = "GCJS_WIN_CANDIDATE")
public class GCJSWINCANDIDATE {

	
	public static final String GCJS_WIN_CANDIDATE="GCJS_WIN_CANDIDATE";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;
    @XmlElement(name = "BID_SECTION_CODE", required = true)
    protected String bidsectioncode;
    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
    protected String unifieddealcode;
    @XmlElement(name = "WIN_CANDIDATE_NAME", required = true)
    protected String wincandidatename;
    @XmlElement(name = "BIDDER_CODE_TYPE", required = true)
    protected String biddercodetype;
    @XmlElement(name = "WIN_CANDIDATE_CODE", required = true)
    protected String wincandidatecode;
    @XmlElement(name = "BIDDER_ROLE", required = true)
    protected String bidderrole;
    @XmlElement(name = "WIN_CANDIDATE_ORDER")
    protected int wincandidateorder;
    @XmlElement(name = "IS_FLOAT_RATE", required = true)
    protected String isfloatrate;
    @XmlElement(name = "EVALUATION_RESULT", required = true)
    protected String evaluationresult;
    @XmlElement(name = "BID_PRICE", required = true)
    protected String bidprice;
    @XmlElement(name = "EVALUATION_PRICE", required = true)
    protected String evaluationprice;
    @XmlElement(name = "WIN_PRICE", required = true)
    protected String winprice;
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;
    
    
    @XmlElement(name = "WIN_CANDIDATE_CODE_TYPE", required = true)
    protected String wincandidatecodetype;
    @XmlElement(name = "RATE", required = true)
    protected String rate;
    @XmlElement(name = "OTHER_BID_PRICE", required = true)
    protected String otherbidprice;
    @XmlElement(name = "QUALITY", required = true)
    protected String quality;
    @XmlElement(name = "EVALUATION_STATUS", required = true)
    protected String evaluationstatus;
    @XmlElement(name = "WIN_CANDIDATE_QUALIFICATION", required = true)
    protected String wincandidatequalification;
    @XmlElement(name = "PM_NAME", required = true)
    protected String pmname;
    @XmlElement(name = "PM_CODE", required = true)
    protected String pmcode;
    @XmlElement(name = "PM_CERTIFICATES", required = true)
    protected String pmcertificates;

    
    @XmlElement(name = "TIME_LIMIT", required = true)
    protected String timelimit;
    
    
    public String getTimelimit() {
		return timelimit;
	}

	public void setTimelimit(String timelimit) {
		this.timelimit = timelimit;
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
     * Gets the value of the wincandidatename property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWINCANDIDATENAME() {
        return wincandidatename;
    }

    /**
     * Sets the value of the wincandidatename property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWINCANDIDATENAME(String value) {
        this.wincandidatename = value;
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
     * Gets the value of the wincandidatecode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWINCANDIDATECODE() {
        return wincandidatecode;
    }

    /**
     * Sets the value of the wincandidatecode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWINCANDIDATECODE(String value) {
        this.wincandidatecode = value;
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
     * Gets the value of the wincandidateorder property.
     * 
     */
    public int getWINCANDIDATEORDER() {
        return wincandidateorder;
    }

    /**
     * Sets the value of the wincandidateorder property.
     * 
     */
    public void setWINCANDIDATEORDER(int value) {
        this.wincandidateorder = value;
    }

    /**
     * Gets the value of the isfloatrate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getISFLOATRATE() {
        return isfloatrate;
    }

    /**
     * Sets the value of the isfloatrate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setISFLOATRATE(String value) {
        this.isfloatrate = value;
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
     * Gets the value of the evaluationprice property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public String getEVALUATIONPRICE() {
        return evaluationprice;
    }

    /**
     * Sets the value of the evaluationprice property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setEVALUATIONPRICE(String value) {
        this.evaluationprice = value;
    }

    /**
     * Gets the value of the winprice property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public String getWINPRICE() {
        return winprice;
    }

    /**
     * Sets the value of the winprice property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setWINPRICE(String value) {
        this.winprice = value;
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
     * 获取wincandidatecodetype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWINCANDIDATECODETYPE() {
        return wincandidatecodetype;
    }

    /**
     * 设置wincandidatecodetype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWINCANDIDATECODETYPE(String value) {
        this.wincandidatecodetype = value;
    }

    /**
     * 获取rate属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRATE() {
        return rate;
    }

    /**
     * 设置rate属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRATE(String value) {
        this.rate = value;
    }

    /**
     * 获取otherbidprice属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOTHERBIDPRICE() {
        return otherbidprice;
    }

    /**
     * 设置otherbidprice属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOTHERBIDPRICE(String value) {
        this.otherbidprice = value;
    }

    /**
     * 获取quality属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getQUALITY() {
        return quality;
    }

    /**
     * 设置quality属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setQUALITY(String value) {
        this.quality = value;
    }

    /**
     * 获取evaluationstatus属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEVALUATIONSTATUS() {
        return evaluationstatus;
    }

    /**
     * 设置evaluationstatus属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEVALUATIONSTATUS(String value) {
        this.evaluationstatus = value;
    }

    /**
     * 获取wincandidatequalification属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWINCANDIDATEQUALIFICATION() {
        return wincandidatequalification;
    }

    /**
     * 设置wincandidatequalification属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWINCANDIDATEQUALIFICATION(String value) {
        this.wincandidatequalification = value;
    }

    /**
     * 获取pmname属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPMNAME() {
        return pmname;
    }

    /**
     * 设置pmname属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPMNAME(String value) {
        this.pmname = value;
    }

    /**
     * 获取pmcode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPMCODE() {
        return pmcode;
    }

    /**
     * 设置pmcode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPMCODE(String value) {
        this.pmcode = value;
    }

    /**
     * 获取pmcertificates属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPMCERTIFICATES() {
        return pmcertificates;
    }

    /**
     * 设置pmcertificates属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPMCERTIFICATES(String value) {
        this.pmcertificates = value;
    }

}
