

package com.itender.ms.platform.shanxi;

import javax.xml.bind.annotation.*;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "projectcode",//项目名称
    "tenderprojectcode",//招标项目名称
    "bidsectioncode",//标段(包)名称
    "unifieddealcode",//统一交易标识码
    "exceptioninfor",//异常信息
    "approvalresult",//审核结果
    "approvaltime",//审核时间
    "platformcode",//交易平台标识码
    "pubserviceplatcode",//公共服务平台标识码
    "datatimestamp",//数据时间戳
    "exceptionname",//异常报告名称
})
/**
 * 招标异常报告
 *
 * @author Frank
 *
 */
@XmlRootElement(name = "GCJS_EXCEPTION_REPORT")
public class GCJSTENDEREXCEPTION {
	public static final String GCJS_TENDER_PROJECT="GCJS_EXCEPTION_REPORT";
	
	    @XmlElement(name = "TENDER_PROJECT_CODE", required = true)
	    protected String tenderprojectcode;
	    @XmlElement(name = "BID_SECTION_CODE", required = true)
	    protected String bidsectioncode;
	    @XmlElement(name = "UNIFIED_DEAL_CODE", required = true)
	    protected String unifieddealcode;
	    @XmlElement(name = "EXCEPITON_INFOR", required = true)
	    protected String exceptioninfor;
	    @XmlElement(name = "APPROVAL_RESULT", required = true)
	    protected String approvalresult;
	    @XmlElement(name = "APPROVAL_TIME", required = true)
	    protected String approvaltime;
	    @XmlElement(name = "PLATFORM_CODE", required = true)
	    protected String platformcode;
	    @XmlElement(name = "PUB_SERVICE_PLAT_CODE", required = true)
	    protected String pubserviceplatcode;
	    @XmlElement(name = "DATA_TIMESTAMP", required = true)
	    protected String datatimestamp;
	    @XmlElement(name = "PROJECT_CODE", required = true)
	    protected String projectcode;
	    @XmlElement(name = "EXCEPITON_NAME", required = true)
	    protected String exceptionname;

    public String getProjectcode() {
        return projectcode;
    }

    public void setProjectcode(String projectcode) {
        this.projectcode = projectcode;
    }

    public String getTenderprojectcode() {
        return tenderprojectcode;
    }

    public void setTenderprojectcode(String tenderprojectcode) {
        this.tenderprojectcode = tenderprojectcode;
    }


    public String getBidsectioncode() {
        return bidsectioncode;
    }

    public void setBidsectioncode(String bidsectioncode) {
        this.bidsectioncode = bidsectioncode;
    }

    public String getUnifieddealcode() {
        return unifieddealcode;
    }

    public void setUnifieddealcode(String unifieddealcode) {
        this.unifieddealcode = unifieddealcode;
    }

    public String getExceptioninfor() {
        return exceptioninfor;
    }

    public void setExceptioninfor(String exceptioninfor) {
        this.exceptioninfor = exceptioninfor;
    }

    public String getApprovalresult() {
        return approvalresult;
    }

    public void setApprovalresult(String approvalresult) {
        this.approvalresult = approvalresult;
    }

    public String getApprovaltime() {
        return approvaltime;
    }

    public void setApprovaltime(String approvaltime) {
        this.approvaltime = approvaltime;
    }

    public String getPlatformcode() {
        return platformcode;
    }

    public void setPlatformcode(String platformcode) {
        this.platformcode = platformcode;
    }

    public String getPubserviceplatcode() {
        return pubserviceplatcode;
    }

    public void setPubserviceplatcode(String pubserviceplatcode) {
        this.pubserviceplatcode = pubserviceplatcode;
    }

    public String getDatatimestamp() {
        return datatimestamp;
    }

    public void setDatatimestamp(String datatimestamp) {
        this.datatimestamp = datatimestamp;
    }

    public String getExceptionname() {
        return exceptionname;
    }

    public void setExceptionname(String exceptionname) {
        this.exceptionname = exceptionname;
    }
    
}
