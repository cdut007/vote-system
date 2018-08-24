package com.itender.ms.bank.CBC;

import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.itender.ms.bank.CBC.component.BankInvoker;
import com.itender.ms.bank.CBC.request.RequestAp;
import com.itender.ms.bank.CBC.request.RequestHead;
import com.itender.ms.bank.CBC.request.RequestRoot;
import com.itender.ms.bank.CBC.request.RequestRootHead;
import com.itender.ms.bank.CBC.response.ResponseAp;
import com.itender.ms.bank.CBC.response.ResponseRoot;
import com.itender.ms.bank.CITIC.Ajax;
import com.itender.ms.bank.CITIC.BankService;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;

import javax.annotation.Resource;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class JiaoTongBankService {
    private static String mainAccNo="141000240012016007604";//"8113701015700000004";
    private static final Logger logger = LoggerFactory.getLogger(JiaoTongBankService.class);
    private static final String COMMON_REMARK = "";
    public static final String SYSTEM_ID = "EBMP";


    static final byte[] CHUNK_ONE_SEPARATOR = {'\n'};
    //默认配置的是UTF-8
    public static String encoding_UTF8 = "UTF-8";


    /*****
     * 银行对接 报文交互实现
     */
    @Resource
    private BankInvoker bankInvoker = new BankInvoker();
    /*****
     * 招标通测试时间
     */
    public static String TEST_BANK_TIME = "";//="20160613";



    /*****
     * 2次BASE64 编码
     *
     * @param original
     * @param charsetName
     *
     * @return
     *
     * @throws UnsupportedEncodingException
     */
    private String twoTimesBaseEncode(String original, String charsetName) throws UnsupportedEncodingException {
        String firstTimeBase64 = Base64Utils.encodeToString(original.getBytes(charsetName));
        String secondTimeBase64 = Base64Utils.encodeToString(firstTimeBase64.getBytes(charsetName));
        return secondTimeBase64;
    }


    public Ajax queryTransationDetail(String[] subAccNo, String startDate, String endDate) throws Exception {
        Ajax ajax = new Ajax();
        if (subAccNo.length == 0)
            return ajax;
        logger.debug("虚拟账号交易明细查询:" + mainAccNo + "-:-" + subAccNo);
        RequestAp ap = new RequestAp();
        RequestHead head = new RequestHead("FHTS01", "1");
        ap.setHead(head);
        Body<String, Object> body = new Body<String, Object>();
        XmlMapper xml = new XmlMapper();
        {
            RequestRoot requestRoot = new RequestRoot();
            RequestRootHead requestRootHead = new RequestRootHead("DL4006", UUID.randomUUID().toString());
            requestRoot.setHead(requestRootHead);
            Body<String, Object> requestRootBody = new Body<String, Object>();
            requestRootBody.put("MainAccNo", mainAccNo);
            requestRootBody.put("SubAccTotal", subAccNo.length);
            // TODO 招标通测试
            if (StringUtils.isNotBlank(TEST_BANK_TIME)) {
                int startDayBefore = Integer.valueOf(DateUtils.formatDate(new Date(), "yyyyMMdd")) - Integer.valueOf(startDate);
                startDate = String.valueOf(Integer.valueOf(TEST_BANK_TIME) - startDayBefore);
                int endDayBefore = Integer.valueOf(DateUtils.formatDate(new Date(), "yyyyMMdd")) - Integer.valueOf(endDate);
                endDate = String.valueOf(Integer.valueOf(TEST_BANK_TIME) - endDayBefore);
            }
            requestRootBody.put("StartDate", startDate);
            requestRootBody.put("EndDate", endDate);
            requestRoot.setBody(requestRootBody);

            String xmlString = xml.writeValueAsString(requestRoot);
            SAXReader reader = new SAXReader();
            Document document = reader.read(new InputStreamReader(new ByteArrayInputStream((xmlString).getBytes(encoding_UTF8)), encoding_UTF8));
            Element rootElement = document.getRootElement();
            Element bodyElement = rootElement.element("body");
            Element subAccListElement = bodyElement.addElement("SubAccList");
            for (String no : subAccNo) {
                Element subAccRowElement = subAccListElement.addElement("SubAccRow");
                Element subAccNoElement = subAccRowElement.addElement("SubAccNo");
                subAccNoElement.addText(no);
            }
            xmlString = document.getRootElement().asXML();
            logger.debug("xml:" + xmlString);
            String secondTimeBase64 = twoTimesBaseEncode(xmlString, encoding_UTF8);
            body.put("data", secondTimeBase64);
        }
        body.put("rem", COMMON_REMARK);
        body.put("systemId", SYSTEM_ID);
        ap.setBody(body);
        ResponseAp responseAp = bankInvoker.call(ap);

        body = responseAp.getBody();
        {
            String RspMsgContent = body.getString("RspMsgContent");
            String secondTimeBase64 = twoTimesBaseDecode(RspMsgContent, encoding_UTF8);
            SAXReader reader = new SAXReader();
            Document document = reader.read(new InputStreamReader(new ByteArrayInputStream((secondTimeBase64).getBytes(encoding_UTF8)), encoding_UTF8));
            Element rootElement = document.getRootElement();
            Element bodyElement = rootElement.element("body");
            if (!"EBMP000000".equals(bodyElement.elementText("Status"))) {
                String statusText = bodyElement.elementText("StatusText");
                logger.error("======================================================");
                logger.error("虚拟账户交易明细查询失败");
                logger.error("失败原因：" + statusText);
                logger.error("=======================================================");
                if (!"无符合条件的记录".equals(statusText)) {
                    throw new RuntimeException(statusText);
                }
            }
            ajax.setData(secondTimeBase64);
            Element listElement = bodyElement.element("List");
            List<Element> cardRowElementList = listElement.elements("CardRow");
            for (int i = 0, l = cardRowElementList.size(); i < l; i++) {
                Element cardRowElement = cardRowElementList.get(i);
               // SubAccountTransactionRecord transactionRecord = new SubAccountTransactionRecord();
                /*****
                 * 初始化交易明细
                 */
//                transactionRecord.setSubAccNo(cardRowElement.elementText("SubAccNo"));
//                transactionRecord.setTranType(cardRowElement.elementText("TranType"));
//                transactionRecord.setTranDate(cardRowElement.elementText("TranDate"));
//                transactionRecord.setTranTime(cardRowElement.elementText("TranTime"));
//                transactionRecord.setHostFlw(cardRowElement.elementText("HostFlw"));
//                transactionRecord.setHostSeq(cardRowElement.elementText("HostSeq"));
//                transactionRecord.setOppAccNo(cardRowElement.elementText("OppAccNo"));
//                transactionRecord.setOppAccName(cardRowElement.elementText("OppAccName"));
//                transactionRecord.setOppBranchName(cardRowElement.elementText("OppBranchName"));
//                transactionRecord.setCDFg(cardRowElement.elementText("CDFg"));
//                transactionRecord.setTranAmt(new BigDecimal(cardRowElement.elementText("TranAmt")));
//                transactionRecord.setAccBal(new BigDecimal(cardRowElement.elementText("AccBal")));
//                transactionRecord.setXtsFam(new BigDecimal(cardRowElement.elementText("XtsFam")));
//                transactionRecord.setResume(cardRowElement.elementText("Resume"));
//                transactionRecord.setOppBankNo(cardRowElement.elementText("OppBankNo"));
//                list.add(transactionRecord);
            }
        }
        ajax.setSuccess(true);
        return ajax;
    }

    public  Ajax  queryDeposit(String subAccNo) throws Exception {
        logger.info("虚拟账号余额查询 ");
        RequestAp ap = new RequestAp();
        RequestHead head = new RequestHead("FHTS01", "1");
        ap.setHead(head);
        Body<String, Object> body = new Body<String, Object>();
        XmlMapper xml = new XmlMapper();
        {
            RequestRoot requestRoot = new RequestRoot();
            RequestRootHead requestRootHead = new RequestRootHead("DL4005", UUID.randomUUID().toString());
            requestRoot.setHead(requestRootHead);
            Body<String, Object> requestRootBody = new Body<String, Object>();
            requestRootBody.put("MainAccNo", mainAccNo);
            requestRootBody.put("SubAccNo", subAccNo);
            requestRoot.setBody(requestRootBody);
            String xmlString = xml.writeValueAsString(requestRoot);
            String secondTimeBase64 = twoTimesBaseEncode(xmlString, encoding_UTF8);
            body.put("data", secondTimeBase64);
        }
        body.put("rem", COMMON_REMARK);
        body.put("systemId", SYSTEM_ID);
        ap.setBody(body);
        ResponseAp responseAp = bankInvoker.call(ap);
        body = responseAp.getBody();
        {
            String RspMsgContent = body.getString("RspMsgContent");
            String secondTimeBase64 = twoTimesBaseDecode(RspMsgContent, encoding_UTF8);
            ResponseRoot responseRoot = xml.readValue(secondTimeBase64, ResponseRoot.class);
            if (!"EBMP000000".equals(responseRoot.getBody().get("Status"))) {
                String statusText = responseRoot.getBody().getString("StatusText");
                logger.error("======================================================");
                logger.error("虚拟账号余额查询失败");
                logger.error("失败原因：" + statusText);
                logger.error("=======================================================");
                throw new RuntimeException(statusText);
            }
            body = responseRoot.getBody();

        }
//        ISubAccountInfo subAccInfo = new SubAccountInfo();
//        subAccInfo.setSubAccNo(body.getString("SubAccNo"));
//        subAccInfo.setSubAccNm(body.getString("SubAccNm"));
//        subAccInfo.setKyAmt(body.getBigDecimal("KyAmt"));
//        subAccInfo.setSjAmt(body.getBigDecimal("SjAmt"));
        Ajax ajax = new Ajax();
        ajax.setSuccess(true);
        ajax.setData(body.toString());
        return ajax;
    }


    public Ajax destroySubAccount(String subAccNo) throws Exception {
        logger.info("注销虚拟账户");
        RequestAp ap = new RequestAp();
        RequestHead head = new RequestHead("FHTS01", "1");
        ap.setHead(head);
        Body<String, Object> body = new Body<String, Object>();
        XmlMapper xml = new XmlMapper();
        {
            RequestRoot requestRoot = new RequestRoot();
            RequestRootHead requestRootHead = new RequestRootHead("DL2005", UUID.randomUUID().toString());
            requestRoot.setHead(requestRootHead);
            Body<String, Object> requestRootBody = new Body<String, Object>();
            requestRootBody.put("MainAccNo", mainAccNo);
            requestRootBody.put("SubAccNo", subAccNo);
            requestRoot.setBody(requestRootBody);
            String xmlString = xml.writeValueAsString(requestRoot);
            String secondTimeBase64 = twoTimesBaseEncode(xmlString, encoding_UTF8);
            body.put("data", secondTimeBase64);
        }
        body.put("rem", COMMON_REMARK);
        body.put("systemId", SYSTEM_ID);
        ap.setBody(body);
        ResponseAp responseAp = bankInvoker.call(ap);
        body = responseAp.getBody();
        {
            String RspMsgContent = body.getString("RspMsgContent");
            String secondTimeBase64 = twoTimesBaseDecode(RspMsgContent, encoding_UTF8);
            ResponseRoot responseRoot = xml.readValue(secondTimeBase64, ResponseRoot.class);
            if (!"EBMP000000".equals(responseRoot.getBody().get("Status"))) {
                String statusText = responseRoot.getBody().getString("StatusText");
                logger.error("======================================================");
                logger.error("注销虚拟账户");
                logger.error("失败原因：" + statusText);
                logger.error("=======================================================");
                throw new RuntimeException(statusText);
            }
        }

        Ajax ajax = new Ajax();
        ajax.setSuccess(true);
        ajax.setMsg("注销虚拟账户成功");
        ajax.setData(subAccNo);
        return ajax;
    }

    public Ajax  createSubAccount(String subAccNm) throws Exception{
        logger.info("生成虚拟账户 ");
        RequestAp ap = new RequestAp();
        RequestHead head = new RequestHead("FHTS01", "1");
        ap.setHead(head);
        Body<String, Object> body = new Body<String, Object>();
        XmlMapper xml = new XmlMapper();
        {
            RequestRoot requestRoot = new RequestRoot();
            RequestRootHead requestRootHead = new RequestRootHead("DL2004", UUID.randomUUID().toString());
            requestRoot.setHead(requestRootHead);
            Body<String, Object> requestRootBody = new Body<String, Object>();
            requestRootBody.put("MainAccNo", mainAccNo);
            requestRootBody.put("AccGenType", "0");
            requestRootBody.put("SubAccNo", "");
            requestRootBody.put("SubAccNm", subAccNm);
            requestRootBody.put("CalInterestFlag", "0");
            requestRootBody.put("FeeType", "0");
            requestRoot.setBody(requestRootBody);
            String xmlString = xml.writeValueAsString(requestRoot);
            String secondTimeBase64 = twoTimesBaseEncode(xmlString, encoding_UTF8);
            body.put("data", secondTimeBase64);
        }
        body.put("rem", COMMON_REMARK);
        body.put("systemId", SYSTEM_ID);
        ap.setBody(body);
        ResponseAp responseAp = bankInvoker.call(ap);
        body = responseAp.getBody();
        {
            String RspMsgContent = body.getString("RspMsgContent");
            String secondTimeBase64 = twoTimesBaseDecode(RspMsgContent, encoding_UTF8);
            System.out.println(secondTimeBase64);
            ResponseRoot responseRoot = xml.readValue(secondTimeBase64, ResponseRoot.class);
            if (!"EBMP000000".equals(responseRoot.getBody().get("Status"))) {
                String statusText = responseRoot.getBody().getString("StatusText");
                logger.error("======================================================");
                logger.error("生成虚拟账户失败");
                logger.error("失败原因：" + statusText);
                logger.error("=======================================================");
                if (statusText.equals("交易日期不是当天")) {
                    //如果服务器返回 交易日期不是当天 那么吧测试时间设置为服务器返回的时间
                    this.setTEST_BANK_TIME(responseRoot.getHead().getTransDate());
                }
                throw new RuntimeException(statusText);
            }
            body = responseRoot.getBody();
        }
        String subAccNo = body.getString("SubAccNo");
        logger.info("======================================================");
        logger.info("生成虚拟账户成功");
        logger.info("账户：" + subAccNo);
        logger.info("户名：" + subAccNm);
        logger.info("=======================================================");
        Ajax ajax = new Ajax();
        ajax.setSuccess(true);
        ajax.setData(subAccNo);
        return ajax;
    }

    public String getTEST_BANK_TIME() {
        return TEST_BANK_TIME;
    }

    public void setTEST_BANK_TIME(String tEST_BANK_TIME) {
        TEST_BANK_TIME = tEST_BANK_TIME;
    }

    /*****
     * 2次iBASE64解码
     *
     * @param original
     * @param charsetName
     *
     * @return
     *
     * @throws UnsupportedEncodingException
     */
    private String twoTimesBaseDecode(String original, String charsetName) throws UnsupportedEncodingException {
        logger.debug("base64 in:" + original);
        String firstTimeBase64 = new String(Base64Utils.decodeFromString(original), charsetName);
        try {
            String secondTimeBase64 = new String(Base64Utils.decodeFromString(firstTimeBase64), charsetName);
            logger.info("base64 out2:" + secondTimeBase64);
            return secondTimeBase64;
        } catch (Exception e) {
            try {
                Base64 base64 = new Base64(76, CHUNK_ONE_SEPARATOR);
                String last = new String(base64.decode(firstTimeBase64), charsetName);
                logger.info("base64 out2.0:" + last);
                return last;
            } catch (Exception e1) {
                logger.info("base64 out1:" + firstTimeBase64);
                return firstTimeBase64;
            }
        }
    }

    public static String getNowDateStr() {
        String nowDateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
        if (StringUtils.isNoneBlank(TEST_BANK_TIME))
            nowDateStr = TEST_BANK_TIME;
        return nowDateStr;
    }

}
