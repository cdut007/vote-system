package com.itender.ms.bank.CITIC;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.*;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class BankService {

    private static String AcctNo = "7275210183100000455";//"8113701015700000004";
    private static final Logger logger = LoggerFactory.getLogger(BankService.class);


    private String callBankXmlRequest(String headContent) throws Exception {
        String body = getStringByteLen(headContent);
        logger.info("数据内容：" + body);

        Socket socket = null;
        OutputStream outputStream = null;
        InputStream inputStream = null;
        BufferedReader br = null;
        try {
            //建立TCP连接
            socket = new Socket("168.168.168.1", 30040);
            logger.info("创建连接成功");
            //写入数据
            outputStream = socket.getOutputStream();
            outputStream.write(body.getBytes("GBK"));
            outputStream.flush();
            logger.info("发送数据结束");

            //获取响应
            inputStream = socket.getInputStream();
            br = new BufferedReader(new InputStreamReader(inputStream, "GBK"));
            String info = "", line;
            while ((line = br.readLine()) != null) {
                logger.info(line);
                info += line;
            }
            logger.info("获取相应结果" + info);
            br.close();
            inputStream.close();
            outputStream.close();
            socket.close();
            logger.info("断开连接");

            return info;
        } catch (UnknownHostException e1) {
            logger.info("创建连接失败");
        } catch (IOException e1) {
            logger.info("发送数据失败");
        }

        return null;
    }



    private String getStringByteLen(String content) {
        String XML = content;
        long len = 0;
        try {
            len = content.getBytes("GBK").length;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String byteSize = String.format("%08d", len);
        logger.info(len + "获取到XML长度为" + byteSize);
        return byteSize + XML;

    }

    public static void main(String[] args) {

        String result = "00000579<?xml version=\"1.0\" encoding=\"GBK\"?><root>  <head>    <TransCode>G00002</TransCode>    <TransDate>20180814</TransDate>    <TransTime>153203</TransTime>    <SeqNo>CBPP1605f4940082018081415320302956</SeqNo>  </head>  <body>    <Lzxh>20180814J0000000031528</Lzxh>    <InDate>20180814</InDate>    <InTime>135908</InTime>    <InAmount>500.00</InAmount>    <InBankNo>7119910130900000001</InBankNo>    <InBankName>中信银行总行营业部账务中心</InBankName>    <InName>桐驰钞烦椭墒拼光</InName>    <InAccNo>3115610013311116205</InAccNo>    <Fy>保证金</Fy>  </body></root>";
        if (!StringUtils.isEmpty(result)) {
            String headTail = "</head>";
            int endHead = result.indexOf(headTail);
            if (endHead >= 0) {
                Document doc = null;
                try {
                    doc = DocumentHelper.parseText(result.substring(8));
                } catch (DocumentException e) {
                    e.printStackTrace();
                }
                //指向根节点
                Element root = doc.getRootElement();

                Element headElement = root.element("head");

                String aa = headElement.elementTextTrim("TransCode");
                String bb = headElement.elementTextTrim("TransDate");
                String cc = headElement.elementTextTrim("TransTime");
                String dd = headElement.elementTextTrim("SeqNo");
                String w = 1 + "" + 1;
//                    String headContent=result.substring(0,endHead+headTail.length());
//                    testBankXmlRequest(headContent);

            } else {
            }
        }
    }

    public Ajax createSubAccount(String projectItemName, String tenderUnitName, long depositEndTimeInMillis, String IsRetire) {

        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate + "0" + ((int) (Math.random() * 100));
        String BaseAcctNo = projectItemName + SeqNo;
        String BaseAcctName = tenderUnitName;
        String depositEndDate = format.format(depositEndTimeInMillis);
        String depositEndTime = formatTime.format(depositEndTimeInMillis);

        String requestXML = "<?xml version='1.0' encoding='GBK'?>\n" +
                "<root type=\"request\">\n" +
                "<head>\n" +
                "<TransCode>G00001</TransCode>\n" +
                "<TransDate>" + transferDate + "</TransDate>\n" +
                "<TransTime>" + transferTime + "</TransTime>\n" +
                "<SeqNo>" + SeqNo + "</SeqNo>\n" +
                "</head>\n" +
                "<body>\n" +
                "<AcctNo>" + AcctNo + "</AcctNo>\n" +
                "<AcctBank>中信银行</AcctBank>\n" +
                "<BaseAcctNo>" + BaseAcctNo + "</BaseAcctNo>\n" +
                "<BaseAcctName>" + BaseAcctName + "</BaseAcctName>\n" +
                "<BZJEndDate>" + depositEndDate + "</BZJEndDate>\n" +
                "<BZJEndTime>" + depositEndTime + "</BZJEndTime>\n" +
                "<IsRetire>" + IsRetire + "</IsRetire>\n" +
                "<MatuDay></MatuDay>\n" +
                "</body>\n" +
                "</root>";
        try {
            //  响应报文：
            //<?xml version="1.0" encoding="GBK"?>
            //<root>
            //  <head>
            //    <TransDate>20180622</TransDate>
            //    <TransTime>100000</TransTime>
            //    <SeqNo>20180621001</SeqNo>
            //    <TransCode>G00001</TransCode>
            //  </head>
            //  <body>
            //    <IAcctNo>3113710004951386970</IAcctNo>
            //  </body>
            //</root>
            String result = callBankXmlRequest(requestXML);
            String IaccountNo = parseXMLValueByName(result, "IAcctNo");
            if (StringUtils.isEmpty(IaccountNo)) {
                ajax.setSuccess(false);
                String retcode = parseXMLValueByName(result, "retcode");
                ajax.setData(retcode);
                ajax.setMsg(parseXMLValueByName(result, "retmsg"));
            } else {
                ajax.setSuccess(true);
                ajax.setData(IaccountNo);
            }

            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return ajax;
    }

    private String parseXMLValueByName(String result, String nameTag) {
        if (!StringUtils.isEmpty(result)) {
            String tagTail = "</" + nameTag + ">";
            String tagHead = "<" + nameTag + ">";
            int startHead = result.indexOf(tagHead);
            int endHead = result.indexOf(tagTail);
            if (startHead >= 0 && endHead >= 0) {
                String value = result.substring(startHead + tagHead.length(), endHead);
                logger.info(nameTag + "获取到XML值为" + value);
                return value;
            } else {
                System.out.println("not found ***====" + result);
            }
        } else {
            System.out.println("not found ====" + result);
        }
        return null;
    }


    public Ajax depositReceiveNotify(Socket socket, String transferDate, String transferTime, String SeqNo, String remark) {
        Ajax ajax = new Ajax();


        String requestXML = "<?xml version=\"1.0\" encoding=\"GBK\"?>" +
                "<root>" +
                "<head>" +
                "<TransCode>G00002</TransCode>" +
                "<TransDate>" + transferDate + "</TransDate>" +
                "<TransTime>" + transferTime + "</TransTime>" +
                "<SeqNo>" + SeqNo + "</SeqNo>" +
                "</head>" +
                "<body>" +
                "<TransResult>1</TransResult>" +
                "<Remark>成功</Remark>" +
                "</body>" +
                "</root>";

        try {
            // 响应报文：
            //<?xml version='1.0' encoding='gb2312'?>
            //<root>
            //<head>
            //<TransCode>G00002</TransCode>
            //<TransDate>20180622</TransDate>
            //<TransTime>103234</TransTime>
            //<SeqNo>CBPP1605406e1552018062210405001239</SeqNo>
            //</head>
            //<body>
            //<TransResult>1</TransResult>
            //<Remark></Remark>
            //</body>
            //</root>
            String body = getStringByteLen(requestXML);
            logger.info("数据内容：" + body);


            OutputStream outputStream = null;

            //建立TCP连接
            //写入数据
            outputStream = socket.getOutputStream();
            outputStream.write(body.getBytes("GBK"));
            outputStream.flush();
            logger.info("发送数据结束");


            ajax.setSuccess(true);

            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return ajax;
    }


    //dead
    public Ajax depositReceiveNotify(String depositTransSeqNo, long timeMillis, String Amount, String bankNo, String bankName, String name, String subAccount, String remark) {
        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate + "0" + ((int) (Math.random() * 100));
        String depositDate = format.format(timeMillis);
        String depositTime = formatTime.format(timeMillis);

        String requestXML = "<?xml version=\"1.0\" encoding=\"GBK\"?>\n" +
                "<root>\n" +
                "  <head>\n" +
                "    <TransCode>G00002</TransCode>\n" +
                "    <TransDate>" + transferDate + "</TransDate>\n" +
                "    <TransTime>" + transferTime + "</TransTime>\n" +
                "    <SeqNo>" + SeqNo + "</SeqNo>\n" +
                "  </head>\n" +
                "  <body>\n" +
                "    <Lzxh>" + depositTransSeqNo + "</Lzxh>\n" +
                "    <InDate>" + depositDate + "</InDate>\n" +
                "    <InTime>" + depositTime + "</InTime>\n" +
                "    <InAmount>" + Amount + "</InAmount>\n" +
                "    <InBankNo>" + bankNo + "</InBankNo>\n" +
                "    <InBankName>" + bankName + "</InBankName>\n" +
                "    <InName>" + name + "</InName>\n" +
                "    <InAccNo>" + subAccount + "</InAccNo>\n" +
                "    <Fy>" + remark + "</Fy>\n" +
                "  </body>\n" +
                "</root>";

        try {
            // 响应报文：
            //<?xml version='1.0' encoding='gb2312'?>
            //<root>
            //<head>
            //<TransCode>G00002</TransCode>
            //<TransDate>20180622</TransDate>
            //<TransTime>103234</TransTime>
            //<SeqNo>CBPP1605406e1552018062210405001239</SeqNo>
            //</head>
            //<body>
            //<TransResult>1</TransResult>
            //<Remark></Remark>
            //</body>
            //</root>
            String result = callBankXmlRequest(requestXML);
            String resultCode = parseXMLValueByName(result, "TransResult");
            if (StringUtils.isEmpty(resultCode)) {
                ajax.setSuccess(false);
                String retcode = parseXMLValueByName(result, "retcode");
                ajax.setData(retcode);
                ajax.setMsg(parseXMLValueByName(result, "retmsg"));
            } else {
                ajax.setSuccess(resultCode.equals("1"));
            }

            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return ajax;
    }

    public Ajax queryDeposit(String subAccount) {
        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate + "0" + ((int) (Math.random() * 100));
        String requestXML = "<?xml version='1.0' encoding='GBK'?>\n" +
                "<root type=\"request\">\n" +
                "<head>\n" +
                "    <TransCode>G00003</TransCode>\n" +
                "    <TransDate>" + transferDate + "</TransDate>\n" +
                "    <TransTime>" + transferTime + "</TransTime>\n" +
                "    <SeqNo>" + SeqNo + "</SeqNo>\n" +
                "</head>\n" +
                "<body>\n" +
                "   <IAcctNo>" + subAccount + "</IAcctNo>\n" +
                "</body>\n" +
                "</root>";

        try {

            String result = callBankXmlRequest(requestXML);
            List<Bank> banks = new ArrayList<Bank>();
            Bank bank = null;
            try {
                //丢掉前8位

                Document doc = DocumentHelper.parseText(result.substring(8));
                //指向根节点
                Element root = doc.getRootElement();
                //获取book的属性值
//            String id = book.attributeValue("id");
//            kBook.setId(id);

                List<Element> elements = root.elements("bank");
                if (elements != null) {
                    for (Element element : elements) {
                        bank = new Bank();
                        logger.info("id====" + element.elementTextTrim("id"));
//                    bank.setId(element.attributeValue("id"));
//                    bank.setName(element.element("name").getStringValue());
//                    bank.setAuthor(element.element("author").getStringValue());
//                    bank.setPrice(element.element("price").getStringValue());
//                    bank.setYear(element.element("year").getStringValue());
                        banks.add(bank);
                        bank = null;
                    }
                }


            } catch (DocumentException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            ajax.setMsg(result);
            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return ajax;
    }


    public Ajax depositRefund(String subAccount, String transInAccount, String transInAccountBank, String transInAccountName, String transInAmt, String isRetire, String bankType, String reason) {
        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate + "0" + ((int) (Math.random() * 100));

        String requestXML = "<?xml version='1.0' encoding='GBK'?>\n" +
                "<root type=\"request\">\n" +
                "<head>\n" +
                "    <TransCode>G00004</TransCode>\n" +
                "    <TransDate>" + transferDate + "</TransDate>\n" +
                "    <TransTime>" + transferTime + "</TransTime>\n" +
                "    <SeqNo>" + SeqNo + "</SeqNo>\n" +
                "</head>\n" +
                "<body>\n" +
                "<IAcctNo>" + subAccount + "</IAcctNo>\n" +
                "<InAcctNo>" + transInAccount + "</InAcctNo>\n" +
                "<InAcctBank>" + transInAccountBank + "</InAcctBank>\n" +
                "<InName>" + transInAccountName + "</InName>\n" +
                "<InTranAmt>" + transInAmt + "</InTranAmt>\n" +
                "<IsRetire>" + isRetire + "</IsRetire>\n" +
                "<BackType>" + bankType + "</BackType>\n" +
                "<Reason>" + reason + "</Reason>\n" +
                "</body>\n" +
                "</root>";
        try {

            String result = callBankXmlRequest(requestXML);
            String resultCode = parseXMLValueByName(result, "Result");
            ajax.setSuccess(resultCode.equals("1"));
            String remark = parseXMLValueByName(result, "Remark");
            ajax.setMsg(remark);

            if (StringUtils.isEmpty(resultCode)) {
                ajax.setSuccess(false);
                String retcode = parseXMLValueByName(result, "retcode");
                ajax.setData(retcode);
                ajax.setMsg(parseXMLValueByName(result, "retmsg"));
            }
            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return ajax;
    }

}
