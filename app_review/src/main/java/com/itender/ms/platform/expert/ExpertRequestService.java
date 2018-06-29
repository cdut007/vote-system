package com.itender.ms.platform.expert;

import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;

import com.itender.ms.utils.DateUtils;
import com.sxca.pspde.webservice.server.*;
import org.apache.commons.lang3.StringUtils;
import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service
public class ExpertRequestService {
    private static Logger logger = LoggerFactory.getLogger(ExpertRequestService.class);
    private static final String requestDomain = "http://218.26.169.140:8081/pspde/services/pspdews?wsdl";

    public Result apply(EXPERTAPPLY expertapply) {
        boolean success = false;
        String msg = null;
        PspdeWS testWSPort = createRequestPort();
        // 调用ws方法
        Result result = testWSPort.expertApply(getAppKey(), getAppSecerety(), getPlatfromSerialNumber(), convertToXml(expertapply, "utf-8"), getJCPlatformCreditCode()
        );
        success = result.isSuccess();
        msg = result.getErrorMessage();
        System.out.println("============================================================");
        System.out.println("提交【提交抽取专家申请表】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
        return result;
    }

    private static String getJCPlatformCreditCode() {
        return "999999999999999000";
    }

    private static String getAppSecerety() {

        return "111111";
    }

    private static String getAppKey() {

        return "1400000009";
    }

    private static String getPlatfromSerialNumber() {
        String formatDate = DateUtils.formatDate(new Date(), "yyyyMMdd");
        String last6 = "213122";
        String sn = "1400000009".concat(formatDate).concat(last6);
        return sn;
    }

    public Result expertSpecialtyEdit(EXPERTAPPLYEDIT expertapplyedit) {
        PspdeWS testWSPort = createRequestPort();
        boolean success = false;
        String msg = null;


        // 调用ws方法
        Result result = testWSPort.expertSpecialtyEdit(getAppKey(), getAppSecerety(),
                getPlatfromSerialNumber(), convertToXml(expertapplyedit, "utf-8"));
        success = result.isSuccess();
        msg = result.getErrorMessage();
        System.out.println("============================================================");
        System.out.println("提交【提交抽取专家申请表】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
        return result;
    }


    public Result extract(String platId) {
        // 调用ws方法
        System.out.println("platId="+platId);
        PspdeWS testWSPort = createRequestPort();
        Result result = testWSPort.extract(getAppKey(), getAppSecerety(),
                getPlatfromSerialNumber(), platId);
        boolean success = result.isSuccess();
        String msg = result.getErrorMessage();
        System.out.println("============================================================");
        System.out.println("提交【提交抽取专家申请表】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
        return result;
    }

    public ExtractResult getExtractResult(String platId) {
        System.out.println("platId="+platId);
        // 调用ws方法
        boolean success = false;
        String msg = null;

        PspdeWS testWSPort = createRequestPort();
        ExtractResult result = testWSPort.getExtractResult(getAppKey(), getAppSecerety(),
                getPlatfromSerialNumber(), platId);

        success = result.isSuccess();
        msg = result.getErrorMessage();
        System.out.println("============================================================");
        System.out.println("提交【提交抽取专家申请表】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        List<ExpertInfoWS> li = (List<ExpertInfoWS>) result.getExpertInfoWSList();
        for (ExpertInfoWS eiw : li) {
            System.out.println("专家姓名--->" + eiw.getExpertName());
            System.out.println("验证码--->" + eiw.getVerificationCode());
            System.out.println("专家身份证号--->" + eiw.getIdCardNum());
            System.out.println("专家性别--->" + eiw.getSex());
            System.out.println("专家单位名称--->" + eiw.getExpertOrgName());
            System.out.println("专家所属地区--->" + eiw.getExpertArea());
            System.out.println("专家级别--->" + eiw.getExpertLevel());
            System.out.println("专家级别--->" + eiw.getExpertSpecialty());
        }
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
        return result;
    }

    public ExpertApplyStatusResult getApplyStatus(String platId) {
        // 调用ws方法
        boolean success = false;
        String msg = null;
        System.out.println("platId="+platId);

        PspdeWS testWSPort = createRequestPort();
        ExpertApplyStatusResult result = testWSPort.getExpertApplyStatus(getAppKey(), getAppSecerety(),
                getPlatfromSerialNumber(), platId);
        success = result.isSuccess();
        msg = result.getErrorMessage();
        System.out.println("============================================================");
        System.out.println("提交【提交抽取专家申请表】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        System.out.println("抽取专家状态--->" + result.getExpertApplyStatus());
        System.out.println("需要修改的抽取条件------>" + result.getExpertSpecialtyWSList());
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
        return result;
    }


    private static PspdeWS createRequestPort() {


        URL wsdlLocation_t = null;
        try {
            // url按照现场部署的路径修改
            wsdlLocation_t = new URL(requestDomain);
        } catch (MalformedURLException e) {
            logger.error(e.getMessage(), e);
        }
        QName serviceName_t = new QName("http://server.webservice.pspde.sxca.com/", "PspdeWSService");
        PspdeWSService testService = new PspdeWSService(wsdlLocation_t, serviceName_t);

        PspdeWS pspdeWSPort = testService.getPspdeWSPort();
        return pspdeWSPort;
    }

    public static void main(String[] args) throws UnsupportedEncodingException, DocumentException, JAXBException {
        boolean success = false;
        String msg = null;

        PspdeWS testWSPort = createRequestPort();

        EXPERTAPPLY section = new EXPERTAPPLY();
        EXPERTSPECIALTYWS section1 = new EXPERTSPECIALTYWS();
        EXPERTSPECIALTYWS section3 = new EXPERTSPECIALTYWS();
        AVOIDORGWSLIST section2 = new AVOIDORGWSLIST();
        AVOIDORGWSLIST section4 = new AVOIDORGWSLIST();

        section1.setFirstLevelAreaCode("140100");
        section1.setSpecialtyFirstTypeCode("A01");
        section1.setSpecialtySecondTypeCode("A0101");
        section1.setSpecialtyThirdTypeCode("A010101");
        section1.setExpertCount("2");
        section1.setExpertCheckInTime("20170411095507");
        section1.setExpertCheckInAddress("太原市");
        section1.setBidEvaluateTime("-1");
        section3.setFirstLevelAreaCode("140100");
        section3.setSpecialtyFirstTypeCode("A01");
        section3.setSpecialtySecondTypeCode("A0101");
        section3.setSpecialtyThirdTypeCode("A010101");
        section3.setExpertCount("2");
        section3.setExpertCheckInTime("20170411095507");
        section3.setExpertCheckInAddress("太原市");
        section3.setBidEvaluateTime("-1");

        section2.setOrgName("回避单位名称1");
        section2.setOrgCode("orgCode1");
        section4.setOrgName("回避单位名称2");
        section4.setOrgCode("orgCode2");
        //platId=99a06eee-27f7-4aa2-ac18-486610af011d&extractTerminalCode=140000001
        // &planExtractDate=20180627173000&bidOpenTime=20180627173000
        // &bidOpenAddress=1&
        // bidEvaluateTime=20180627173000&bidEvaluateAddress=1&
        // tendereeOrg=四川招标测试单位一&tendereePrincipal=xhh
        // &tendereePhone=02887654321&agencyOrg=四川代理机构测试1&agencyPrincipal=1
        // &agencyPhone=02877887788&watchdogOrg=1&watchdogPrincipal=1&watchdogPhone=13122222222
        // &bidEvaluateCommittee=5&investment=50.0000&bidContent=1
        // &areaCode=140100&callbackUrl=http://www.jcebid.com/
        section.setPlatId("99a06eee-27f7-4aa2-ac18-486610af011d");
        // section.setProjectCode("M1401000155021581");
        // section.setTenderProjectCode("M1401000155021581001");
        // section.setBidSectionCodes("M1401000155021581001002");
        // section.setNoticeId("dceb91ab-6dbc-42b0-9fae-9a4a760fc5fe");
        section.setExtractTerminalCode("140000001");
        section.setPlanExtractDate("20180627173000");
        section.setBidOpenTime("20180627173000");
        section.setBidOpenAddress("1");
        section.setBidEvaluateTime("20180627173000");
        section.setBidEvaluateAddress("1");
        section.setTendereeOrg("四川招标测试单位一");
        section.setTendereePrincipal("xhh");
        section.setTendereePhone("02887654321");
        section.setAgencyOrg("四川代理机构测试1");
        section.setAgencyPrincipal("1");
        section.setAgencyPhone("02877887788");
        section.setWatchdogOrg("1");
        section.setWatchdogPrincipal("1");
        section.setWatchdogPhone("13122222222");
        section.setBidEvaluateCommittee("5");
        section.setInvestment("50.0000");
        section.setBidContent("1");
        section.setAreaCode("140100");

        section.setCallbackUrl("http://www.jcebid.com/");
        section.setSignature("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");
        ArrayList<EXPERTSPECIALTYWS> l1 = new ArrayList<EXPERTSPECIALTYWS>();
        ArrayList<AVOIDORGWSLIST> l2 = new ArrayList<AVOIDORGWSLIST>();
        ArrayList<String> l3 = new ArrayList<String>();
        l1.add(section1);
        l1.add(section3);
        l2.add(section2);
        l2.add(section4);
        l3.add("c661c8fa-bb2b-46b6-a931-55a06a796784");
        section.setExpertSpecialtyWSList(l1);
        section.setRemarks("dwwee2");
        section.setAvoidOrgWSList(l2);
        section.setRelateNoticeList(l3);

        // 调用ws方法
        String formatDate = DateUtils.formatDate(new Date(), "yyyyMMdd");


        String last6 = "213122";


        String sn = "1400000009".concat(formatDate).concat(last6);
        Result result = testWSPort.expertApply("1400000009", "111111", sn, convertToXml(section, "utf-8"), "999999999999999000"
        );
        success = result.isSuccess();
        msg = result.getErrorMessage();
        System.out.println("============================================================");
        System.out.println("提交【提交抽取专家申请表】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
    }

    private static String convertToXml(Object obj, String encoding) {
        String result = null;
        try {
            JAXBContext context = JAXBContext.newInstance(obj.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.setProperty(Marshaller.JAXB_ENCODING, encoding);

            StringWriter writer = new StringWriter();
            marshaller.marshal(obj, writer);
            result = writer.toString();
            logger.info("Expert XML：=="+result);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return result;
    }

}
