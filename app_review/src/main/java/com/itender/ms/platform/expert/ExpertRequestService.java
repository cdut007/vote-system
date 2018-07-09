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

import com.itender.ms.platform.Config;
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
    private static final String requestDomain = Config.shanxiDomain+"/pspde/services/pspdews?wsdl";

    public Result apply(EXPERTAPPLY expertapply) {
        boolean success = false;
        String msg = null;
        PspdeWS testWSPort = createRequestPort();
        // 调用ws方法
        Result result = testWSPort.expertApply(Config.getAppKey(), Config.getAppSecerety(), Config.getPlatfromSerialNumber(), convertToXml(expertapply, "utf-8"), Config.getJCPlatformCreditCode()
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



    public String getExtractResultInform(String platId) {
        PspdeWS testWSPort = createRequestPort();
        boolean success = false;
        String msg = null;


        // 调用ws方法
        String result = testWSPort.getExtractResultInform(Config.getAppKey(), Config.getAppSecerety(),
                Config.getPlatfromSerialNumber(),platId);

        System.out.println("============================================================");
        System.out.println("【获取抽取结果通知单】省公共服务平台" + result);

        System.out.println("============================================================");
        return result;
    }

    public List<String> findUnitList() {
        PspdeWS testWSPort = createRequestPort();
        boolean success = false;
        String msg = null;


        // 调用ws方法
        List<String> result = testWSPort.findUnitList(Config.getAppKey(), Config.getAppSecerety(),
                Config.getPlatfromSerialNumber());

        System.out.println("============================================================");
        System.out.println("【获取专家库标准单位名称】到省公共服务平台" + (success ? "成功" : "失败") + "！");
        if (StringUtils.isNotBlank(msg)) {
            System.out.println("错误原因:" + msg);
        }
        System.out.println("============================================================");
        return result;
    }


    public Result expertSpecialtyEdit(EXPERTAPPLY expertapplyedit) {
        PspdeWS testWSPort = createRequestPort();
        boolean success = false;
        String msg = null;


        // 调用ws方法
        Result result = testWSPort.expertSpecialtyEdit(Config.getAppKey(), Config.getAppSecerety(),
                Config.getPlatfromSerialNumber(), convertToXml(expertapplyedit, "utf-8"));
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
        Result result = testWSPort.extract(Config.getAppKey(), Config.getAppSecerety(),
                Config.getPlatfromSerialNumber(), platId);
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
        ExtractResult result = testWSPort.getExtractResult(Config.getAppKey(),Config. getAppSecerety(),
                Config.getPlatfromSerialNumber(), platId);

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
        ExpertApplyStatusResult result = testWSPort.getExpertApplyStatus(Config.getAppKey(), Config.getAppSecerety(),
                Config.getPlatfromSerialNumber(), platId);
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
