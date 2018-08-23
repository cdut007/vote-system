package com.itender.ms.bank.unionpay.gnetpg;

import com.itender.ms.bank.CITIC.Ajax;
import com.itender.ms.bank.unionpay.acp.sdk.AcpService;
import com.itender.ms.bank.unionpay.acp.sdk.LogUtil;
import com.itender.ms.bank.unionpay.acp.sdk.SDKConfig;
import com.itender.ms.workflow.model.JsonObjectIgnoreDuplicates;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.annotation.PostConstruct;
import javax.net.ssl.SSLContext;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.*;

@Service
public class BarcodeUnionpayService {
    //默认配置的是UTF-8
    private static String encoding_UTF8 = "UTF-8";
    private static final Logger logger = LoggerFactory.getLogger(BarcodeUnionpayService.class);

    private String merId = "198";



    public Ajax createOrder(String payOrderId,String totalPrice){
            // 前台页面传过来的
            Ajax ajax = new Ajax();
            Date nowDate = new Date();

            /*** 保存订单 ***/
            String orderId=payOrderId;

            /***
             * 计算银联支付金额
             */

            JSONObject requestData = new JSONObject();

            /*** 商户接入参数 ***/
           requestData.put("MerId", merId); // 商户号码，请改成自己申请的正式商户号或者open上注册得来的777测试商户号
           requestData.put("OrderNo",payOrderId);//非空，每次上送必须唯一
           requestData.put("OrderAmount",totalPrice);//非空，格式：元.角分
           requestData.put("CurrCode","CNY");//非空，CNY ：人民币、HKD：港币、TWD：台币
           requestData.put("OrderType","B2C");//B2C订单,系统默认B2C
           requestData.put("CallBackUrl","http://47.94.241.88:9900/bank/unionpay/CallBackUrl");
           requestData.put("BankCode","77031000");//88978888 扫码支付与移动支付
           requestData.put("LangType","UTF-8");
           requestData.put("BuzType","01");//业务类型移动支付  19 backend
           requestData.put("Reserved01","DeviceInfo=MOBILE|Body=平台费");//保留域1：
           requestData.put("Reserved02","");//保留域2：

           String PKey = "12hi60ohgmp16nbev0gr8au69bodzguz";                //商户私钥
        String FormUrl = "http://test.gnetpg.com:8089/GneteMerchantAPI/api/PayV36";
        System.out.println(FormUrl);

        //组装订单原始数据
        StringBuffer SourceText = new StringBuffer();
        SourceText.append(requestData.get("MerId"));
        SourceText.append(requestData.get("OrderNo"));
        SourceText.append(requestData.get("OrderAmount"));
        SourceText.append(requestData.get("CurrCode"));
        SourceText.append(requestData.get("OrderType"));
        SourceText.append(requestData.get("CallBackUrl"));
        SourceText.append(requestData.get("BankCode"));
        SourceText.append(requestData.get("LangType"));
        SourceText.append(requestData.get("BuzType"));
        SourceText.append(requestData.get("Reserved01"));
        SourceText.append(requestData.get("Reserved02"));

        System.out.println(FormUrl + "");
        System.out.println(SourceText + "");

        //使用Md5对订单原始数据进行加密签名
        String EncodePKey = Md5.md5(PKey, "UTF-8");
        SourceText.append(EncodePKey);
        String SignMsg = Md5.md5(SourceText.toString(), "UTF-8");

        //打印信息
        System.out.println("【订单数据】" + SourceText);
        System.out.println("【加密数据】" + SignMsg);
        requestData.put("SignMsg",SignMsg);

      //  HttpUtils httpUtils = new HttpUtils();
       //String result = httpUtils.doHttpPost(FormUrl,HttpUtils.getParams("POST",requestData),null,null); //
        ResponseEntity resultInfo = clientForm(false,null, FormUrl, HttpMethod.POST, requestData);
        if (resultInfo.getStatusCodeValue() == 302) {
            //parse 關鍵字
            HttpHeaders headers = resultInfo.getHeaders();
            List<String> location  = headers.get("Location");
            if(location!=null && location.size() >0 ){
                ajax.setSuccess(true);
                ajax.setData(location.get(0));
                return ajax;
            }

        }

        String html = (String) resultInfo.getBody();
            LogUtil.writeLog("打印请求HTML，此为请求报文，为联调排查问题的依据：" + html);

        ajax.setSuccess(false);
        ajax.setData(html);
        return  ajax;
    }


    public Ajax queryTransationByOrderId(String orderId,String beginDate,String EndTime,String ShoppingTime){

        Ajax ajax = new Ajax();
        Map<String, String> data = new HashMap<String, String>();
        /*** 银联全渠道系统，产品参数，除了encoding自行选择外其他不需修改 ***/
        data.put("TranType", "100"); //交易类型（固定），100：实时对账
        data.put("JavaCharset", "UTF-8");  //UTF-8
        data.put("Version", "V60"); //版本号（固定）：V60
        data.put("UserId", "198"); //银联业务人员分配,account
        data.put("Pwd", "123!@#QAZ"); //银联业务人员分配,用户密码
        data.put("MerId", merId); //商户ID
        data.put("PayStatus", "2"); //默认2；0：失败订单；1：成功订单；2：全部订单
        if(ShoppingTime!=null){
            data.put("ShoppingTime", PayUtils.GetCurrentDate("yyyy-MM-dd") ); //交易时间
            //格式：YYYY-MM-DD HH:ii:ss，如果上送ShoppingTime那么BeginTime与EndTime将作废
        }else{
            data.put("ShoppingTime","");
        }

        data.put("BeginTime", beginDate);
        data.put("EndTime", EndTime);
        if(orderId!=null){
            data.put("OrderNo", orderId);//指定单个订单号（可空，空时按批量查询）
        }


        String TranType = data.get("TranType");        //交易类型
        String JavaCharset = data.get("JavaCharset");  //编码
        String Version = data.get("Version");		   //版本号
        String UserId = data.get("UserId");            //用户ID
        String Pwd = data.get("Pwd");                  //用户密码
        String MerId = data.get("MerId");              //商户ID
        String PayStatus = data.get("PayStatus");      //支付状态
        String BeginTime = data.get("BeginTime") == null ? "" : data.get("BeginTime");      //交易开始时间
        String OrderNo = data.get("OrderNo");          //商户订单号

        //对密码进行Md5加密
        Pwd = Md5.md5(Pwd, "UTF-8");

        //组装请求参数
        StringBuffer SourceText = new StringBuffer();
        SourceText.append("TranType=").append(TranType);
        SourceText.append("&JavaCharset=").append(JavaCharset);
        SourceText.append("&Version=").append(Version);
        SourceText.append("&UserId=").append(UserId);
        SourceText.append("&Pwd=").append(Pwd);
        SourceText.append("&MerId=").append(MerId);
        SourceText.append("&PayStatus=").append(PayStatus);
        SourceText.append("&ShoppingTime=").append(data.get("ShoppingTime"));
        SourceText.append("&BeginTime=").append(data.get("BeginTime"));
        SourceText.append("&EndTime=").append(data.get("EndTime"));
        SourceText.append("&OrderNo=").append(OrderNo);

        String Param = SourceText.toString();

        System.out.print(Param + "<br><br>");

        //交易结果查询接口地址
        //商户网站域名
        String MerDomain = "http://47.94.241.88:9900/bank/unionpay/CallBackUrl";
        String Url = "http://test.gnetpg.com:8089/GneteMerchantAPI/Trans.action";
        System.out.println("【访问的URL】" + Url);

        HttpUtils http = new HttpUtils();
        String Resp = http.doHttpPost(Url, Param, "UTF-8", MerDomain);

        System.out.println("【交易查询结果】\n" + Resp);

        if(Resp == null || Resp.length() == 0)
        {
            ajax.setSuccess(false);
            ajax.setMsg("【返回的交易结果为空!】");
            System.out.println("【返回的交易结果为空!】");
            return ajax;
        }
        //处理查询结果
        String Code = PayUtils.GetValue(Resp, "Code");
        if(Code != null && !"".equals(Code.trim()))
        {
            String Message = PayUtils.GetValue(Resp, "Message");
            ajax.setSuccess(true);
            ajax.setMsg(Message);
            System.out.println("【对账结果】" + Message);
            return ajax;
        }


        return  ajax;
    }




    public RestTemplate restTemplateRequestFactory(boolean redirect) throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
        TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;

        SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom()
                .loadTrustMaterial(null, acceptingTrustStrategy)
                .build();

        SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext);

        CloseableHttpClient httpClient = null;
        if (redirect) {
            httpClient = HttpClients.custom()
                    .setSSLSocketFactory(csf).setRedirectStrategy(new LaxRedirectStrategy()).build();
        } else {
            httpClient = HttpClients.custom()
                    .setSSLSocketFactory(csf).build();
        }


        HttpComponentsClientHttpRequestFactory requestFactory =
                new HttpComponentsClientHttpRequestFactory();

        requestFactory.setHttpClient(httpClient);

        RestTemplate client = new RestTemplate();
        client.setRequestFactory(requestFactory);

        return client;
    }

    public ResponseEntity clientForm(boolean redirect, String sessionId, String url, HttpMethod method, JSONObject jsonObject) {
        RestTemplate client = null;
        try {
            client = restTemplateRequestFactory(redirect);
        } catch (KeyStoreException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");
        //  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        if (sessionId != null) {
            headers.set("Cookie", sessionId);
        }
        Iterator<String> it = jsonObject.keys();
        String bodyValTemplate = "";
        while (it.hasNext()) {
// 获得key
            String key = it.next();
            String value = jsonObject.optString(key);
            System.out.println("key: " + key + ",value:" + value);
            try {
                bodyValTemplate += "&" + key + "=" + URLEncoder.encode(value, "utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        HttpEntity entity = new HttpEntity(bodyValTemplate, headers);

        //  执行HTTP请求
        try {
            ResponseEntity<String> response = client.exchange(url, method, entity, String.class);
            return response;
        } catch (RestClientException e) {
            e.printStackTrace();
            return null;
        }


    }

}
