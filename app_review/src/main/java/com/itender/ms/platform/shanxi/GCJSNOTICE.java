
package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;
import java.math.BigDecimal;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",
    "tenderprojectcode",
    "bidsectioncodes",
    "unifieddealcodes",
    "noticename",
    "noticecontent",
    "noticesendtime",
    "noticemedia",
    "url",
    "noticenature",
    "bulletintype",
    "docgetstarttime",
    "docgetendtime",
    "tenderdocgetmethod",
    "biddocreferendtime",
    "bidopentime",
    "docprice",
    "biddocrefermethod",
    "syndicatedflag",
    "bulletinduty",
    "bulletindutycodetype",
    "platformcode",
    "pubserviceplatcode",
    "datatimestamp",
    "pspreleasetype",
    "pspaccordtolaw",
    "pspbidschemeapprovecode",
    "pspholidaywork",
    "psprelatenoticeid",
    "pspfirstnoticeid",
    
    //2018-05-03
    "tendercode",//招标编号
    "bidurl",//招标文件/资格预审申请递交地址
    "bidopenmethod",//开标方式/文件开启方式
    "ispostpone",//是否延期开标
    "tenderername",//招标人名称
    "tendercodetype",//招标人代码类型
    "tenderercode",//招标人代码
    "tendereraddress",//招标人地址
    "tenderercontactor",//招标人联系人
    "tendererphonenumber",//招标人联系电话
    "tendereremail",//招标人电子邮箱
    "tenderagencyname",//招标代理机构名称
    "tenderagencycodetype",//招标代理机构代码类型
    "tenderagencycode",//招标代理机构代码
    "tenderagencyaddress",//招标代理机构地址
    "tenderagencycontactor",//招标代理机构联系人
    "tenderagencyphonenumber",//招标代理机构联系电话
    "tenderagencyemail",//招标代理机构电子邮箱
    "examinername",//交易平台数据验证责任人姓名
    "tradeplat",//交易平台或发布工具标识码(中国招标投标公共服务平台分配)
    "npubserviceplatcode"//公共服务平台标识码(中国招标投标公共服务平台分配)
    
})
/**
 * 招标公告与资格预审公告
 * @author Developer
 *
 */
@XmlRootElement(name = "GCJS_NOTICE")
public class GCJSNOTICE {
	public static final String GCJS_NOTICE="GCJS_NOTICE";
    @XmlElement(name = "PROJECT_CODE", required = true)
    protected String projectcode;//项目编号
    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
    protected String tenderprojectcode;//招标项目编号
    @XmlElement(name = "BID_SECTION_CODES", required = true)
    protected String bidsectioncodes;//相关标段（包）编号
    @XmlElement(name = "UNIFIED_DEAL_CODES", required = true)
    protected String unifieddealcodes;//统一交易标识码
    @XmlElement(name = "NOTICE_NAME", required = true)
    protected String noticename;//公告标题
    @XmlElement(name = "NOTICE_CONTENT", required = true)
    protected String noticecontent;//公告内容
    @XmlElement(name = "NOTICE_SEND_TIME", required = true)
    protected String noticesendtime;//公告发布时间
    @XmlElement(name = "NOTICE_MEDIA", required = true)
    protected String noticemedia;//公告发布媒体
    @XmlElement(name = "URL", required = true)
    protected String url;//公告源URL
    @XmlElement(name = "NOTICE_NATURE", required = true)
    protected String noticenature;//公告性质
    @XmlElement(name = "BULLETIN_TYPE", required = true)
    protected String bulletintype;//公告类型
    @XmlElement(name = "DOC_GET_START_TIME", required = true)
    protected String docgetstarttime;//招标文件/资格预审文件获取时间
    @XmlElement(name = "DOC_GET_END_TIME", required = true)
    protected String docgetendtime;//招标文件/资格预审文件获取截至时间
    @XmlElement(name = "TENDER_DOC_GET_METHOD", required = true)
    protected String tenderdocgetmethod;//招标文件/资格预审文件获取方法
    @XmlElement(name = "BID_DOC_REFER_END_TIME", required = true)
    protected String biddocreferendtime;//投标文件/资格预审申请文件递交截止时间
    @XmlElement(name = "BID_OPEN_TIME", required = true)
    protected String bidopentime;//开标时间
    @XmlElement(name = "DOC_PRICE", required = true)
    protected BigDecimal docprice;//文件售价（单位：元）
    @XmlElement(name = "BID_DOC_REFER_METHOD", required = true)
    protected String biddocrefermethod;//投标文件/资格预审申请文件递交方法
    @XmlElement(name = "SYNDICATED_FLAG", required = true)
    protected String syndicatedflag;//是否允许联合体投标
    @XmlElement(name = "BULLETIN_DUTY", required = true)
    protected String bulletinduty;//公告发布责任人
    @XmlElement(name = "BULLETIN_DUTY_CODE_TYPE", required = true)
    protected String bulletindutycodetype;//交易平台验证责任人
    @XmlElement(name = "PLATFORM_CODE", required = true)
    protected String platformcode;//交易系统标识码
    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
    protected String pubserviceplatcode;//公共服务平台标识码
    @XmlElement(name = "DATA_TIMESTAMP", required = true)
    protected String datatimestamp;//数据时间戳
    @XmlElement(name = "PSP_RELEASE_TYPE", required = true)
    protected String pspreleasetype;//发布类别
    @XmlElement(name = "PSP_ACCORD_TO_LAW", required = true)
    protected String pspaccordtolaw;//是否依法招标
    @XmlElement(name = "PSP_BID_SCHEME_APPROVE_CODE")
    protected String pspbidschemeapprovecode;//招标方案核准号
    @XmlElement(name = "PSP_HOLIDAY_WORK", required = true)
    protected String pspholidaywork;//法定节假日是否正常工作  0|1
    @XmlElement(name = "PSP_RELATE_NOTICE_ID", required = true)
    protected String psprelatenoticeid;//关联公告id
    @XmlElement(name = "PSP_FIRST_NOTICE_ID", required = true)
    protected String pspfirstnoticeid;//首次公告id
    
    
    @XmlElement(name = "TENDER_CODE", required = true)
    protected String tendercode;
    @XmlElement(name = "BID_URL", required = true)
    protected String bidurl;
    @XmlElement(name = "BID_OPEN_METHOD", required = true)
    protected String bidopenmethod;
    @XmlElement(name = "IS_POSTPONE", required = true)
    protected String ispostpone;
    @XmlElement(name = "TENDERER_NAME", required = true)
    protected String tenderername;
    @XmlElement(name = "TENDER_CODE_TYPE", required = true)
    protected String tendercodetype;
    @XmlElement(name = "TENDERER_CODE", required = true)
    protected String tenderercode;
    @XmlElement(name = "TENDERER_ADDRESS", required = true)
    protected String tendereraddress;
    @XmlElement(name = "TENDERER_CONTACTOR", required = true)
    protected String tenderercontactor;
    @XmlElement(name = "TENDERER_PHONE_NUMBER", required = true)
    protected String tendererphonenumber;
    @XmlElement(name = "TENDERER_EMAIL", required = true)
    protected String tendereremail;
    @XmlElement(name = "TENDER_AGENCY_NAME", required = true)
    protected String tenderagencyname;
    @XmlElement(name = "TENDER_AGENCY_CODE_TYPE", required = true)
    protected String tenderagencycodetype;
    @XmlElement(name = "TENDER_AGENCY_CODE", required = true)
    protected String tenderagencycode;
    @XmlElement(name = "TENDER_AGENCY_ADDRESS", required = true)
    protected String tenderagencyaddress;
    @XmlElement(name = "TENDER_AGENCY_CONTACTOR", required = true)
    protected String tenderagencycontactor;
    @XmlElement(name = "TENDER_AGENCY_PHONE_NUMBER", required = true)
    protected String tenderagencyphonenumber;
    @XmlElement(name = "TENDER_AGENCY_EMAIL", required = true)
    protected String tenderagencyemail;
    @XmlElement(name = "EXAMINER_NAME", required = true)
    protected String examinername;
    @XmlElement(name = "TRADE_PLAT", required = true)
    protected String tradeplat;
    @XmlElement(name = "N_PUB_SERVICE_PLAT_CODE", required = true)
    protected String npubserviceplatcode;

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
     * Gets the value of the docgetstarttime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCGETSTARTTIME() {
        return docgetstarttime;
    }

    /**
     * Sets the value of the docgetstarttime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCGETSTARTTIME(String value) {
        this.docgetstarttime = value;
    }

    /**
     * Gets the value of the docgetendtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDOCGETENDTIME() {
        return docgetendtime;
    }

    /**
     * Sets the value of the docgetendtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDOCGETENDTIME(String value) {
        this.docgetendtime = value;
    }

    /**
     * Gets the value of the tenderdocgetmethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERDOCGETMETHOD() {
        return tenderdocgetmethod;
    }

    /**
     * Sets the value of the tenderdocgetmethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERDOCGETMETHOD(String value) {
        this.tenderdocgetmethod = value;
    }

    /**
     * Gets the value of the biddocreferendtime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDOCREFERENDTIME() {
        return biddocreferendtime;
    }

    /**
     * Sets the value of the biddocreferendtime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDOCREFERENDTIME(String value) {
        this.biddocreferendtime = value;
    }

    /**
     * Gets the value of the bidopentime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDOPENTIME() {
        return bidopentime;
    }

    /**
     * Sets the value of the bidopentime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDOPENTIME(String value) {
        this.bidopentime = value;
    }

    /**
     * Gets the value of the docprice property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getDOCPRICE() {
        return docprice;
    }

    /**
     * Sets the value of the docprice property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setDOCPRICE(BigDecimal value) {
        this.docprice = value;
    }

    /**
     * Gets the value of the biddocrefermethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDDOCREFERMETHOD() {
        return biddocrefermethod;
    }

    /**
     * Sets the value of the biddocrefermethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDDOCREFERMETHOD(String value) {
        this.biddocrefermethod = value;
    }

    /**
     * Gets the value of the syndicatedflag property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSYNDICATEDFLAG() {
        return syndicatedflag;
    }

    /**
     * Sets the value of the syndicatedflag property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSYNDICATEDFLAG(String value) {
        this.syndicatedflag = value;
    }

    /**
     * Gets the value of the bulletinduty property.
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
     * Sets the value of the bulletinduty property.
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
     * Gets the value of the bulletindutycodetype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBULLETINDUTYCODETYPE() {
        return bulletindutycodetype;
    }

    /**
     * Sets the value of the bulletindutycodetype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBULLETINDUTYCODETYPE(String value) {
        this.bulletindutycodetype = value;
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
     * Gets the value of the pspreleasetype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPSPRELEASETYPE() {
        return pspreleasetype;
    }

    /**
     * Sets the value of the pspreleasetype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPSPRELEASETYPE(String value) {
        this.pspreleasetype = value;
    }

    /**
     * Gets the value of the pspaccordtolaw property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPSPACCORDTOLAW() {
        return pspaccordtolaw;
    }

    /**
     * Sets the value of the pspaccordtolaw property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPSPACCORDTOLAW(String value) {
        this.pspaccordtolaw = value;
    }

    /**
     * Gets the value of the pspbidschemeapprovecode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPSPBIDSCHEMEAPPROVECODE() {
        return pspbidschemeapprovecode;
    }

    /**
     * Sets the value of the pspbidschemeapprovecode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPSPBIDSCHEMEAPPROVECODE(String value) {
        this.pspbidschemeapprovecode = value;
    }

    /**
     * Gets the value of the pspholidaywork property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPSPHOLIDAYWORK() {
        return pspholidaywork;
    }

    /**
     * Sets the value of the pspholidaywork property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPSPHOLIDAYWORK(String value) {
        this.pspholidaywork = value;
    }

    /**
     * Gets the value of the psprelatenoticeid property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPSPRELATENOTICEID() {
        return psprelatenoticeid;
    }

    /**
     * Sets the value of the psprelatenoticeid property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPSPRELATENOTICEID(String value) {
        this.psprelatenoticeid = value;
    }

    /**
     * Gets the value of the pspfirstnoticeid property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPSPFIRSTNOTICEID() {
        return pspfirstnoticeid;
    }

    /**
     * Sets the value of the pspfirstnoticeid property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPSPFIRSTNOTICEID(String value) {
        this.pspfirstnoticeid = value;
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
     * 获取bidurl属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDURL() {
        return bidurl;
    }

    /**
     * 设置bidurl属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDURL(String value) {
        this.bidurl = value;
    }

    /**
     * 获取bidopenmethod属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBIDOPENMETHOD() {
        return bidopenmethod;
    }

    /**
     * 设置bidopenmethod属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBIDOPENMETHOD(String value) {
        this.bidopenmethod = value;
    }

    /**
     * 获取ispostpone属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getISPOSTPONE() {
        return ispostpone;
    }

    /**
     * 设置ispostpone属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setISPOSTPONE(String value) {
        this.ispostpone = value;
    }

    /**
     * 获取tenderername属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERNAME() {
        return tenderername;
    }

    /**
     * 设置tenderername属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERNAME(String value) {
        this.tenderername = value;
    }

    /**
     * 获取tendercodetype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERCODETYPE() {
        return tendercodetype;
    }

    /**
     * 设置tendercodetype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERCODETYPE(String value) {
        this.tendercodetype = value;
    }

    /**
     * 获取tenderercode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERCODE() {
        return tenderercode;
    }

    /**
     * 设置tenderercode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERCODE(String value) {
        this.tenderercode = value;
    }

    /**
     * 获取tendereraddress属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERADDRESS() {
        return tendereraddress;
    }

    /**
     * 设置tendereraddress属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERADDRESS(String value) {
        this.tendereraddress = value;
    }

    /**
     * 获取tenderercontactor属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERCONTACTOR() {
        return tenderercontactor;
    }

    /**
     * 设置tenderercontactor属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERCONTACTOR(String value) {
        this.tenderercontactor = value;
    }

    /**
     * 获取tendererphonenumber属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERERPHONENUMBER() {
        return tendererphonenumber;
    }

    /**
     * 设置tendererphonenumber属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERERPHONENUMBER(String value) {
        this.tendererphonenumber = value;
    }

    /**
     * 获取tendereremail属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDEREREMAIL() {
        return tendereremail;
    }

    /**
     * 设置tendereremail属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDEREREMAIL(String value) {
        this.tendereremail = value;
    }

    /**
     * 获取tenderagencyname属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYNAME() {
        return tenderagencyname;
    }

    /**
     * 设置tenderagencyname属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYNAME(String value) {
        this.tenderagencyname = value;
    }

    /**
     * 获取tenderagencycodetype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYCODETYPE() {
        return tenderagencycodetype;
    }

    /**
     * 设置tenderagencycodetype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYCODETYPE(String value) {
        this.tenderagencycodetype = value;
    }

    /**
     * 获取tenderagencycode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYCODE() {
        return tenderagencycode;
    }

    /**
     * 设置tenderagencycode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYCODE(String value) {
        this.tenderagencycode = value;
    }

    /**
     * 获取tenderagencyaddress属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYADDRESS() {
        return tenderagencyaddress;
    }

    /**
     * 设置tenderagencyaddress属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYADDRESS(String value) {
        this.tenderagencyaddress = value;
    }

    /**
     * 获取tenderagencycontactor属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYCONTACTOR() {
        return tenderagencycontactor;
    }

    /**
     * 设置tenderagencycontactor属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYCONTACTOR(String value) {
        this.tenderagencycontactor = value;
    }

    /**
     * 获取tenderagencyphonenumber属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYPHONENUMBER() {
        return tenderagencyphonenumber;
    }

    /**
     * 设置tenderagencyphonenumber属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYPHONENUMBER(String value) {
        this.tenderagencyphonenumber = value;
    }

    /**
     * 获取tenderagencyemail属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTENDERAGENCYEMAIL() {
        return tenderagencyemail;
    }

    /**
     * 设置tenderagencyemail属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTENDERAGENCYEMAIL(String value) {
        this.tenderagencyemail = value;
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

	@Override
	public String toString() {
		return "GCJSNOTICE [projectcode=" + projectcode + ", tenderprojectcode=" + tenderprojectcode
				+ ", bidsectioncodes=" + bidsectioncodes + ", unifieddealcodes=" + unifieddealcodes + ", noticename="
				+ noticename + ", noticecontent=" + noticecontent + ", noticesendtime=" + noticesendtime
				+ ", noticemedia=" + noticemedia + ", url=" + url + ", noticenature=" + noticenature + ", bulletintype="
				+ bulletintype + ", docgetstarttime=" + docgetstarttime + ", docgetendtime=" + docgetendtime
				+ ", tenderdocgetmethod=" + tenderdocgetmethod + ", biddocreferendtime=" + biddocreferendtime
				+ ", bidopentime=" + bidopentime + ", docprice=" + docprice + ", biddocrefermethod=" + biddocrefermethod
				+ ", syndicatedflag=" + syndicatedflag + ", bulletinduty=" + bulletinduty + ", bulletindutycodetype="
				+ bulletindutycodetype + ", platformcode=" + platformcode + ", pubserviceplatcode=" + pubserviceplatcode
				+ ", datatimestamp=" + datatimestamp + ", pspreleasetype=" + pspreleasetype + ", pspaccordtolaw="
				+ pspaccordtolaw + ", pspbidschemeapprovecode=" + pspbidschemeapprovecode + ", pspholidaywork="
				+ pspholidaywork + ", psprelatenoticeid=" + psprelatenoticeid + ", pspfirstnoticeid=" + pspfirstnoticeid
				+ ", tendercode=" + tendercode + ", bidurl=" + bidurl + ", bidopenmethod=" + bidopenmethod
				+ ", ispostpone=" + ispostpone + ", tenderername=" + tenderername + ", tendercodetype=" + tendercodetype
				+ ", tenderercode=" + tenderercode + ", tendereraddress=" + tendereraddress + ", tenderercontactor="
				+ tenderercontactor + ", tendererphonenumber=" + tendererphonenumber + ", tendereremail="
				+ tendereremail + ", tenderagencyname=" + tenderagencyname + ", tenderagencycodetype="
				+ tenderagencycodetype + ", tenderagencycode=" + tenderagencycode + ", tenderagencyaddress="
				+ tenderagencyaddress + ", tenderagencycontactor=" + tenderagencycontactor
				+ ", tenderagencyphonenumber=" + tenderagencyphonenumber + ", tenderagencyemail=" + tenderagencyemail
				+ ", examinername=" + examinername + ", tradeplat=" + tradeplat + ", npubserviceplatcode="
				+ npubserviceplatcode + "]";
	}

	
    

}
