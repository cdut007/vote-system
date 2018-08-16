package com.itender.ms.bank.unionpay;

import com.itender.ms.bank.CITIC.Ajax;
import com.itender.ms.bank.unionpay.acp.sdk.AcpService;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class UnionpayService {
    //默认配置的是UTF-8
    private static String encoding_UTF8 = "UTF-8";
    private static final Logger logger = LoggerFactory.getLogger(UnionpayService.class);

    public Ajax queryTransationByOrderId(String orderId,Date payDate){
        Ajax ajax = new Ajax();
        Map<String, String> data = new HashMap<String, String>();
        /*** 银联全渠道系统，产品参数，除了encoding自行选择外其他不需修改 ***/
        data.put("version", "5.0.0"); // 版本号
        data.put("encoding", encoding_UTF8); // 字符集编码
        // 可以使用UTF-8,GBK两种方式
        data.put("signMethod", "01"); // 签名方法 目前只支持01-RSA方式证书加密
        data.put("txnType", "00"); // 交易类型 00-默认
        data.put("txnSubType", "00"); // 交易子类型 默认00
        data.put("bizType", "000201"); // 业务类型 B2C网关支付，手机wap支付

        /*** 商户接入参数 ***/
        data.put("merId", "301160173920001"); // 商户号码，请改成自己申请的商户号或者open上注册得来的777商户号测试
        data.put("accessType", "0"); // 接入类型，商户接入固定填0，不需修改

        /*** 要调通交易以下字段必须修改 ***/
        data.put("orderId", orderId); // ****商户订单号，每次发交易测试需修改为被查询的交易的订单号
        data.put("txnTime",DateUtils.formatDate(payDate==null?new Date():payDate,"yyyyMMddHHmmss")); // ****订单发送时间，每次发交易测试需修改为被查询的交易的订单发送时间

        /** 请求参数设置完毕，以下对请求参数进行签名并发送http post请求，接收同步应答报文-------------> **/

        Map<String, String> reqData = AcpService.sign(data, encoding_UTF8);// 报文中certId,signature的值是在signData方法中获取并自动赋值的，只要证书配置正确即可。
        String url = "https://gateway.95516.com/gateway/api/queryTrans.do";// 交易请求url从配置文件读取对应属性文件acp_sdk.properties中的
        // acpsdk.singleQueryUrl
        // 这里调用signData之后，调用submitUrl之前不能对submitFromData中的键值对做任何修改，如果修改会导致验签不通过
        Map<String, String> rspData = AcpService.post(reqData, url, encoding_UTF8);
        /** 对应答码的处理，请根据您的业务逻辑来编写程序,以下应答码处理逻辑仅供参考-------------> **/
        // 应答码规范参考open.unionpay.com帮助中心 下载 产品接口规范 《平台接入接口规范-第5部分-附录》
        if (!rspData.isEmpty()) {
            if (AcpService.validate(rspData, encoding_UTF8)) {
                logger.info("验证签名成功");
                if ("00".equals(rspData.get("respCode"))) {// 如果查询交易成功
                    // 处理被查询交易的应答码逻辑
                    String origRespCode = rspData.get("origRespCode");
                    if ("00".equals(origRespCode)) {
                        // 交易成功，更新商户订单状态
                        // TODO
                        String queryId=rspData.get("queryId");
                        if(StringUtils.isNotBlank(queryId)){
                            String bankAccountNo=rspData.get("accNo");
                            Date txnTime = null;
                            try {
                                txnTime = org.apache.commons.lang3.time.DateUtils.parseDate(rspData.get("txnTime"), "yyyyMMddHHmmss");
                            } catch (ParseException e) {
                                // NOTHING
                            }
                            ajax.setSuccess(true);
                            ajax.setData(rspData.toString());
                        }

                    } else if ("03".equals(origRespCode) || "04".equals(origRespCode) || "05".equals(origRespCode)) {
                        // 需再次发起交易状态查询交易
                        // TODO
                    } else {
                        // 其他应答码为失败请排查原因
                        // TODO
                    }
                } else {// 查询交易本身失败，或者未查到原交易，检查查询交易报文要素
                    // TODO
                }
            } else {
                ajax.setMsg("验证签名失败");
                logger.info("验证签名失败");
                // TODO 检查验证签名失败的原因
            }
        } else {
            // 未返回正确的http状态
            ajax.setMsg("未获取到返回报文或返回http状态码非200");
            logger.info("未获取到返回报文或返回http状态码非200");
        }
        //String reqMessage = DemoBase.genHtmlResult(reqData);
        //String rspMessage = DemoBase.genHtmlResult(rspData);
        //resp.getWriter().write("</br>请求报文:<br/>" + reqMessage + "<br/>" + "应答报文:</br>" + rspMessage + "");
        return  ajax;
    }

}
