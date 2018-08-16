package com.itender.ms.bank.unionpay;

import com.itender.ms.bank.CITIC.Ajax;
import com.itender.ms.bank.unionpay.acp.sdk.AcpService;
import com.itender.ms.bank.unionpay.acp.sdk.LogUtil;
import com.itender.ms.bank.unionpay.acp.sdk.SDKConfig;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UnionpayService {
    //默认配置的是UTF-8
    private static String encoding_UTF8 = "UTF-8";
    private static final Logger logger = LoggerFactory.getLogger(UnionpayService.class);

    @PostConstruct
    public void load(){
        SDKConfig.getConfig().loadPropertiesFromSrc();
    }


    public Ajax createOrder(String payOrderId,String totalPrice){
            // 前台页面传过来的
            Ajax ajax = new Ajax();
            Date nowDate = new Date();

            String merId = SDKConfig.getConfig().getMerId();// req.getParameter("merId");
            //String txnAmt = req.getParameter("txnAmt");// 金额

            /*** 保存订单 ***/
            String orderId=payOrderId;

            /***
             * 计算银联支付金额
             */
            BigDecimal sum = new BigDecimal(totalPrice).multiply(new BigDecimal(100));
            DecimalFormat decimalFormat = new DecimalFormat("#");
            String txnAmt = decimalFormat.format(sum);

            Map<String, String> requestData = new HashMap<String, String>();

            /*** 银联全渠道系统，产品参数，除了encoding自行选择外其他不需修改 ***/
            requestData.put("version", SDKConfig.getConfig().getVersion()); // 版本号，全渠道默认值
            requestData.put("encoding", encoding_UTF8); // 字符集编码，可以使用UTF-8,GBK两种方式
            requestData.put("signMethod", "01"); // 签名方法，只支持 01：RSA方式证书加密
            requestData.put("txnType", "01"); // 交易类型 ，01：消费
            requestData.put("txnSubType", "01"); // 交易子类型， 01：自助消费
            requestData.put("bizType", "000201"); // 业务类型，B2C网关支付，手机wap支付
            requestData.put("channelType", "07"); // 渠道类型，这个字段区分B2C网关支付和手机wap支付；07：PC,平板
            // 08：手机

            /*** 商户接入参数 ***/
            requestData.put("merId", merId); // 商户号码，请改成自己申请的正式商户号或者open上注册得来的777测试商户号
            requestData.put("accessType", "0"); // 接入类型，0：直连商户
            requestData.put("orderId", orderId); // 商户订单号，8-40位数字字母，不能含“-”或“_”，可以自行定制规则
            requestData.put("txnTime", DateUtils.formatDate(nowDate, "yyyyMMddHHmmss")); // 订单发送时间，取系统时间，格式为YYYYMMDDhhmmss，必须取当前时间，否则会报txnTime无效
            requestData.put("currencyCode", "156"); // 交易币种（境内商户一般是156 人民币）
            requestData.put("txnAmt", txnAmt); // 交易金额，单位分，不要带小数点
            // requestData.put("reqReserved", "透传字段");
            // //请求方保留域，如需使用请启用即可；透传字段（可以实现商户自定义参数的追踪）本交易的后台通知,对本交易的交易状态查询交易、对账文件中均会原样返回，商户可以按需上传，长度为1-1024个字节

            // 前台通知地址 （需设置为外网能访问 http https均可），支付成功后的页面 点击“返回商户”按钮的时候将异步通知报文post到该地址
            // 如果想要实现过几秒中自动跳转回商户页面权限，需联系银联业务申请开通自动返回商户权限
            // 异步通知参数详见open.unionpay.com帮助中心 下载 产品接口规范 网关支付产品接口规范 消费交易 商户通知
            requestData.put("frontUrl", SDKConfig.getConfig().getFrontResponseUrl());

            // 后台通知地址（需设置为【外网】能访问 http
            // https均可），支付成功后银联会自动将异步通知报文post到商户上送的该地址，失败的交易银联不会发送后台通知
            // 后台通知参数详见open.unionpay.com帮助中心 下载 产品接口规范 网关支付产品接口规范 消费交易 商户通知
            // 注意:1.需设置为外网能访问，否则收不到通知 2.http https均可 3.收单后台通知后需要10秒内返回http200或302状态码
            // 4.如果银联通知服务器发送通知后10秒内未收到返回状态码或者应答码非http200，那么银联会间隔一段时间再次发送。总共发送5次，每次的间隔时间为0,1,2,4分钟。
            // 5.后台通知地址如果上送了带有？的参数，例如：http://abc/web?a=b&c=d
            // 在后台通知处理程序验证签名之前需要编写逻辑将这些字段去掉再验签，否则将会验签失败
            requestData.put("backUrl", SDKConfig.getConfig().getBackResponseUrl());

            // ////////////////////////////////////////////////
            //
            // 报文中特殊用法请查看 PCwap网关跳转支付特殊用法.txt
            //
            // ////////////////////////////////////////////////

            /** 请求参数设置完毕，以下对请求参数进行签名并生成html表单，将表单写入浏览器跳转打开银联页面 **/
            Map<String, String> submitFromData = AcpService.sign(requestData, encoding_UTF8); // 报文中certId,signature的值是在signData方法中获取并自动赋值的，只要证书配置正确即可。

            String requestFrontUrl = SDKConfig.getConfig().getFrontRequestUrl(); // 获取请求银联的前台地址：对应属性文件acp_sdk.properties文件中的acpsdk.frontTransUrl
            String html = AcpService.createAutoFormHtml(requestFrontUrl, submitFromData, encoding_UTF8); // 生成自动跳转的Html表单

            LogUtil.writeLog("打印请求HTML，此为请求报文，为联调排查问题的依据：" + html);
            // 将生成的html写到浏览器中完成自动跳转打开银联支付页面；这里调用signData之后，将html写到浏览器跳转到银联页面之前均不能对html中的表单项的名称和值进行修改，如果修改会导致验签不通过
           // resp.getWriter().write(html);
        ajax.setSuccess(true);
        ajax.setData(html);
        return  ajax;
    }


    public Ajax queryTransationByOrderId(String orderId,Date payDate){
        Ajax ajax = new Ajax();
        Map<String, String> data = new HashMap<String, String>();
        /*** 银联全渠道系统，产品参数，除了encoding自行选择外其他不需修改 ***/
        data.put("version", SDKConfig.getConfig().getVersion()); // 版本号
        data.put("encoding", encoding_UTF8); // 字符集编码
        // 可以使用UTF-8,GBK两种方式
        data.put("signMethod", "01"); // 签名方法 目前只支持01-RSA方式证书加密
        data.put("txnType", "00"); // 交易类型 00-默认
        data.put("txnSubType", "00"); // 交易子类型 默认00
        data.put("bizType", "000201"); // 业务类型 B2C网关支付，手机wap支付

        /*** 商户接入参数 ***/
        data.put("merId", SDKConfig.getConfig().getMerId()); // 商户号码，请改成自己申请的商户号或者open上注册得来的777商户号测试
        data.put("accessType", "0"); // 接入类型，商户接入固定填0，不需修改

        /*** 要调通交易以下字段必须修改 ***/
        data.put("orderId", orderId); // ****商户订单号，每次发交易测试需修改为被查询的交易的订单号
        data.put("txnTime",DateUtils.formatDate(payDate==null?new Date():payDate,"yyyyMMddHHmmss")); // ****订单发送时间，每次发交易测试需修改为被查询的交易的订单发送时间

        /** 请求参数设置完毕，以下对请求参数进行签名并发送http post请求，接收同步应答报文-------------> **/

        Map<String, String> reqData = AcpService.sign(data, encoding_UTF8);// 报文中certId,signature的值是在signData方法中获取并自动赋值的，只要证书配置正确即可。
        String url = SDKConfig.getConfig().getSingleQueryUrl();// 交易请求url从配置文件读取对应属性文件acp_sdk.properties中的
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
