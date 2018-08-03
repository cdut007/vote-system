package com.itender.ms.bank.CITIC;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.*;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;

@Service
public class BankService {

    private static String AcctNo="8113701015700000004";
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
            br = new BufferedReader(new InputStreamReader(inputStream,"GBK"));
            String info = "", line;
            while ((line = br.readLine()) != null) {
                logger.info(line);
                info += line;
            }
            logger.info("获取相应结果"+info);
            br.close();
            inputStream.close();
            outputStream.close();
            socket.close();
            logger.info("断开连接");

            return  info;
        } catch (UnknownHostException e1) {
            logger.info("创建连接失败");
        } catch (IOException e1) {
            logger.info("发送数据失败");
        }

        return null;
    }


    private  String getStringByteLen(String content){
                String XML=content;
                long len = content.getBytes().length;
                String byteSize = String.format("%06d",len);
                 logger.info(len+"获取到XML长度为"+byteSize);
                return  ""+byteSize+XML;

    }

    public Ajax createSubAccount(String projectItemName,String tenderUnitName,long depositEndTimeInMillis,String IsRetire){

        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate+"0"+((int)(Math.random()*100));
        String BaseAcctNo = projectItemName+SeqNo;
        String BaseAcctName = tenderUnitName;
        String depositEndDate = format.format(depositEndTimeInMillis);
        String depositEndTime = formatTime.format(depositEndTimeInMillis);

        String requestXML="<?xml version='1.0' encoding='GBK'?>\n" +
                "<root type=\"request\">\n" +
                "<head>\n" +
                "<TransCode>G00001</TransCode>\n" +
                "<TransDate>"+transferDate+"</TransDate>\n" +
                "<TransTime>"+transferTime+"</TransTime>\n" +
                "<SeqNo>"+SeqNo+"</SeqNo>\n" +
                "</head>\n" +
                "<body>\n" +
                "<AcctNo>"+AcctNo+"</AcctNo>\n" +
                "<AcctBank>中信银行</AcctBank>\n" +
                "<BaseAcctNo>"+BaseAcctNo+"</BaseAcctNo>\n" +
                "<BaseAcctName>"+BaseAcctName+"</BaseAcctName>\n" +
                "<BZJEndDate>"+depositEndDate+"</BZJEndDate>\n" +
                "<BZJEndTime>"+depositEndTime+"</BZJEndTime>\n" +
                "<IsRetire>"+IsRetire+"</IsRetire>\n" +
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
            String IaccountNo = parseXMLValueByName(result,"IAcctNo");
            if(StringUtils.isEmpty(IaccountNo)){
                ajax.setSuccess(false);
                String retcode = parseXMLValueByName(result,"retcode");
                ajax.setData(retcode);
                ajax.setMsg(parseXMLValueByName(result,"retmsg"));
            }else{
                ajax.setSuccess(true);
                ajax.setData(IaccountNo);
            }

            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return  ajax;
    }

    private String parseXMLValueByName(String result,String nameTag){
        if(!StringUtils.isEmpty(result)){
            String tagTail = "</"+nameTag+">";
            String tagHead = "<"+nameTag+">";
            int startHead = result.indexOf(tagHead);
            int endHead = result.indexOf(tagTail);
            if(startHead>=0 && endHead>=0){
                String value=result.substring(startHead+tagHead.length(),endHead);
                logger.info(nameTag+"获取到XML值为"+value);
                return value;
            }else{
                System.out.println("not found ***===="+result);
            }
        }else{
            System.out.println("not found ===="+result);
        }
        return null;
    }

    public Ajax depositReceiveNotify(String depositTransSeqNo,long timeMillis,String Amount,String bankNo,String bankName,String name,String subAccount,String remark){
        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate+"0"+((int)(Math.random()*100));
        String depositDate = format.format(timeMillis);
        String depositTime = formatTime.format(timeMillis);

        String requestXML="<?xml version=\"1.0\" encoding=\"GBK\"?>\n" +
                "<root>\n" +
                "  <head>\n" +
                "    <TransCode>G00002</TransCode>\n" +
                "    <TransDate>"+transferDate+"</TransDate>\n" +
                "    <TransTime>"+transferTime+"</TransTime>\n" +
                "    <SeqNo>"+SeqNo+"</SeqNo>\n" +
                "  </head>\n" +
                "  <body>\n" +
                "    <Lzxh>"+depositTransSeqNo+"</Lzxh>\n" +
                "    <InDate>"+depositDate+"</InDate>\n" +
                "    <InTime>"+depositTime+"</InTime>\n" +
                "    <InAmount>"+Amount+"</InAmount>\n" +
                "    <InBankNo>"+bankNo+"</InBankNo>\n" +
                "    <InBankName>"+bankName+"</InBankName>\n" +
                "    <InName>"+name+"</InName>\n" +
                "    <InAccNo>"+subAccount+"</InAccNo>\n" +
                "    <Fy>"+remark+"</Fy>\n" +
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
            String resultCode = parseXMLValueByName(result,"TransResult");
            if(StringUtils.isEmpty(resultCode)){
                ajax.setSuccess(false);
                String retcode = parseXMLValueByName(result,"retcode");
                ajax.setData(retcode);
                ajax.setMsg(parseXMLValueByName(result,"retmsg"));
            }else{
                ajax.setSuccess(resultCode.equals("1"));
            }

            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return  ajax;
    }

    public  Ajax queryDeposit(String subAccount){
        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate+"0"+((int)(Math.random()*100));
        String requestXML="<?xml version='1.0' encoding='GBK'?>\n" +
                "<root type=\"request\">\n" +
                "<head>\n" +
                "    <TransCode>G00003</TransCode>\n" +
                "    <TransDate>"+transferDate+"</TransDate>\n" +
                "    <TransTime>"+transferTime+"</TransTime>\n" +
                "    <SeqNo>"+SeqNo+"</SeqNo>\n" +
                "</head>\n" +
                "<body>\n" +
                "   <IAcctNo>"+subAccount+"</IAcctNo>\n" +
                "</body>\n" +
                "</root>";

        try {

            String result = callBankXmlRequest(requestXML);
            ajax.setMsg(result);
            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }

        ajax.setSuccess(false);
        return  ajax;
    }


    public Ajax depositRefund(String subAccount,String transInAccount,String transInAccountBank,String transInAccountName,String transInAmt,String isRetire,String bankType,String reason){
        Ajax ajax = new Ajax();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        long currentTime = System.currentTimeMillis();
        String transferDate = format.format(currentTime);
        SimpleDateFormat formatTime = new SimpleDateFormat("HHmmss");
        String transferTime = formatTime.format(currentTime);
        String SeqNo = transferDate+"0"+((int)(Math.random()*100));

        String requestXML="<?xml version='1.0' encoding='GBK'?>\n" +
                "<root type=\"request\">\n" +
                "<head>\n" +
                "    <TransCode>G00004</TransCode>\n" +
                "    <TransDate>"+transferDate+"</TransDate>\n" +
                "    <TransTime>"+transferTime+"</TransTime>\n" +
                "    <SeqNo>"+SeqNo+"</SeqNo>\n" +
                "</head>\n" +
                "<body>\n" +
                "<IAcctNo>"+subAccount+"</IAcctNo>\n" +
                "<InAcctNo>"+transInAccount+"</InAcctNo>\n" +
                "<InAcctBank>"+transInAccountBank+"</InAcctBank>\n" +
                "<InName>"+transInAccountName+"</InName>\n" +
                "<InTranAmt>"+transInAmt+"</InTranAmt>\n" +
                "<IsRetire>"+isRetire+"</IsRetire>\n" +
                "<BackType>"+bankType+"</BackType>\n" +
                "<Reason>"+reason+"</Reason>\n" +
                "</body>\n" +
                "</root>";
        try {

            String result = callBankXmlRequest(requestXML);
            String resultCode = parseXMLValueByName(result,"Result");
            ajax.setSuccess(resultCode.equals("1"));
            String remark = parseXMLValueByName(result,"Remark");
            ajax.setMsg(remark);

            if(StringUtils.isEmpty(resultCode)){
                ajax.setSuccess(false);
                String retcode = parseXMLValueByName(result,"retcode");
                ajax.setData(retcode);
                ajax.setMsg(parseXMLValueByName(result,"retmsg"));
            }
            return ajax;
        } catch (Exception e) {
            e.printStackTrace();
            ajax.setMsg(e.getLocalizedMessage());
        }


        ajax.setSuccess(false);
        return  ajax;
    }

}
