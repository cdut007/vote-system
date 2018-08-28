package com.itender.ms.controller;

import com.itender.ms.bank.CBC.JiaoTongBankService;
import com.itender.ms.bank.CITIC.Ajax;
import com.itender.ms.bank.CITIC.BankService;
import com.itender.ms.bank.VirtualAccountService;
import com.itender.ms.bank.unionpay.UnionpayService;
import com.itender.ms.bank.unionpay.gnetpg.BarcodeUnionpayService;
import com.itender.ms.domain.TbDictionary;
import com.itender.ms.domain.TbDictionaryExample;
import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbDictionaryMapper;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.*;

@Validated
@Controller
@RequestMapping("/bank")
public class BankController {


    @Autowired
    private BankService bankService;


    @Autowired
    private JiaoTongBankService jiaoTongBankService;


    @Autowired
    private VirtualAccountService virtualAccountService;


    @Autowired
    private UnionpayService unionpayService;


    @Autowired
    private BarcodeUnionpayService barcodeUnionpayService;


    private static final Logger logger = LoggerFactory.getLogger(BankController.class);


    @ApiOperation(value = "启动监听服务", notes = "启动监听服务")
    @RequestMapping(value = "/startServer", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> startServer(HttpServletRequest request,
                                                           @RequestParam(required = true) boolean enable
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();

        new Thread(new Runnable() {
            @Override
            public void run() {
                createReceviewServer();

            }
        }).start();


        result.put("code", IEvaluation.CODE_ERROR_UNKONWN);

        return ResponseEntity.ok(result);
    }



    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "form", name = "payOrderId", value = " 订单编号（重复发送，不重复生成）", required = true, dataType = "String", defaultValue = "90000000000000000001"),
            @ApiImplicitParam(paramType = "form", name = "totalPrice", value = "支付金额", required = true, dataType = "String", defaultValue = "0.01")

    })



    @ApiOperation(value = "callback", notes = "callback")
    @RequestMapping(value = "/unionpay/CallBackUrl", method = RequestMethod.POST)
    public ResponseEntity<Ajax> CallBackUrl(HttpServletRequest request
    ) throws APIException {

        logger.info("callback info=="+request.getParameterMap().toString());
        return ResponseEntity.ok(new Ajax());

    }


    @ApiOperation(value = "银联退款退回", notes = "银联退款退回")
    @RequestMapping(value = "/unionpayRefund", method = RequestMethod.POST)
    public ResponseEntity<Ajax> unionpayRefund(HttpServletRequest request,
                                              @RequestParam(required = true) String payOrderId,
                                              @RequestParam(required = true) String totalPrice,
                                              @RequestParam(required = true) String RefundAmount,
                                              @RequestParam(required = true) String shoppingDate
    ) throws APIException {
        return ResponseEntity.ok(barcodeUnionpayService.refund(payOrderId, totalPrice, RefundAmount, shoppingDate));
    }





    @ApiOperation(value = "创建二维码支付订单", notes = "创建二维码支付订单")
    @RequestMapping(value = "/createBarcodeOrder", method = RequestMethod.POST)
    public ResponseEntity<Ajax> createBarcodeOrder(HttpServletRequest request,
                                            @RequestParam(required = true) String payOrderId,
                                            @RequestParam(required = true) String totalPrice,
                                                   HttpServletResponse response
    ) throws APIException {
        Ajax ajax = barcodeUnionpayService.createOrder(payOrderId, totalPrice);


        return ResponseEntity.ok(ajax);

    }


    @ApiOperation(value = "创建支付订单", notes = "创建支付订单")
    @RequestMapping(value = "/createOrder", method = RequestMethod.POST)
    public ResponseEntity<Ajax> createOrder(HttpServletRequest request,
                                                 @RequestParam(required = true) String payOrderId,
                                                 @RequestParam(required = true) String totalPrice,
                                                 @RequestParam(required = false) String type
    ) throws APIException {


            return ResponseEntity.ok(unionpayService.createOrder(payOrderId, totalPrice));

    }






    @ApiOperation(value = "注销虚拟账户", notes = "注销虚拟账户")
    @RequestMapping(value = "/destroySubAccount", method = RequestMethod.POST)
    public ResponseEntity<Ajax> destroySubAccount(HttpServletRequest request,
                                                 @RequestParam(required = true) String subAccNo,
                                                 @RequestParam(required = false) String type
    ) throws APIException {

        if ("jiaotong".equals(type)) {
            try {
                Ajax ajax = jiaoTongBankService.destroySubAccount(subAccNo);
                if(ajax.isSuccess()){
                  boolean succ=  virtualAccountService.releasaeSubAccount(subAccNo);
                  if(succ){
                      return ResponseEntity.ok(ajax);
                  }else {
                      ajax.setSuccess(false);
                      ajax.setMsg("本地数据库释放失败");
                      return ResponseEntity.ok(ajax);
                  }
                }
                return ResponseEntity.ok(ajax);
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.ok(new Ajax(false, e.getLocalizedMessage()));
            }

        }else {
            return  ResponseEntity.ok(new Ajax());
            //return ResponseEntity.ok(jiaoTongBankService.destroySubAccount(subAccNo));
        }
    }



    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "form", name = "projectItemName", value = "子账户标识：标段编号+交易流水号（重复发送，不重复生成）", required = true, dataType = "String", defaultValue = "标段1"),
            @ApiImplicitParam(paramType = "form", name = "tenderUnitName", value = "子账户名称", required = true, dataType = "String", defaultValue = "投标单位1"),
            @ApiImplicitParam(paramType = "form", name = "depositEndTimeInMillis", value = "保证金截止日期", required = true, dataType = "String", defaultValue = "1533270183000"),
            @ApiImplicitParam(paramType = "form", name = "IsRetire", value = "是否退息", required = true, dataType = "String", defaultValue = "1")

    })
    @ApiOperation(value = "创建虚拟账户", notes = "创建虚拟账户,返回子账户")
    @RequestMapping(value = "/createSubAccount", method = RequestMethod.POST)
    public ResponseEntity<Ajax> createSubAccount(HttpServletRequest request,
                                                 @RequestParam(required = true) String projectItemName,
                                                 @RequestParam(required = true) String tenderUnitName,
                                                 @RequestParam(required = true) long depositEndTimeInMillis,
                                                 @RequestParam(required = true) String IsRetire,
                                                 @RequestParam(required = false) String type
    ) throws APIException {

        if ("jiaotong".equals(type)) {
            try {
                return ResponseEntity.ok(jiaoTongBankService.createSubAccount(projectItemName + tenderUnitName));
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.ok(new Ajax(false, e.getLocalizedMessage()));
            }

        }else {
            return ResponseEntity.ok(bankService.createSubAccount(projectItemName, tenderUnitName, depositEndTimeInMillis, IsRetire));
        }
    }


    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "form", name = "subAccount", value = "子账户标识", required = true, dataType = "String", defaultValue = "3113710004951386970"),
            @ApiImplicitParam(paramType = "form", name = "bankNo", value = "付款人账户", required = true, dataType = "String", defaultValue = "7119910130900000001"),
            @ApiImplicitParam(paramType = "form", name = "bankName", value = "付款人银行名称", required = true, dataType = "String", defaultValue = "中信银行总行营业部账务中心"),
            @ApiImplicitParam(paramType = "form", name = "name", value = "付款人户名", required = true, dataType = "String", defaultValue = "桐驰钞烦椭墒拼光"),
            @ApiImplicitParam(paramType = "form", name = "timeMillis", value = "到账日期", required = true, dataType = "String", defaultValue = "1533270183000"),
            @ApiImplicitParam(paramType = "form", name = "depositTransSeqNo", value = "来账序号，从银行回调中获取", required = true, dataType = "String", defaultValue = "20180622J0000000567269"),
            @ApiImplicitParam(paramType = "form", name = "remark", value = "附言", required = true, dataType = "String", defaultValue = "保证金"),
            @ApiImplicitParam(paramType = "form", name = "Amount", value = "到账金额", required = true, dataType = "String", defaultValue = "200.00"),

    })
    @ApiOperation(value = "保证金到账通知", notes = "保证金到账通知")
    @RequestMapping(value = "/depositReceiveNotify", method = RequestMethod.POST)
    public ResponseEntity<Ajax> depositReceiveNotify(HttpServletRequest request,
                                                     @RequestParam(required = true) String depositTransSeqNo,
                                                     @RequestParam(required = true) long timeMillis,
                                                     @RequestParam(required = true) String Amount,
                                                     @RequestParam(required = true) String bankNo,
                                                     @RequestParam(required = true) String bankName,
                                                     @RequestParam(required = true) String name,
                                                     @RequestParam(required = true) String subAccount, String remark
    ) throws APIException {
        return ResponseEntity.ok(bankService.depositReceiveNotify(depositTransSeqNo, timeMillis, Amount, bankNo, bankName, name, subAccount, remark));
    }


    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "form", name = "subAccount", value = "子账户标识", required = true, dataType = "String", defaultValue = "3113710004951386970"),
            @ApiImplicitParam(paramType = "form", name = "transInAccount", value = "转入账户", required = true, dataType = "String", defaultValue = "7119910130900000001"),
            @ApiImplicitParam(paramType = "form", name = "transInAccountBank", value = "转入银行名称", required = true, dataType = "String", defaultValue = "中信银行总行营业部账务中心"),
            @ApiImplicitParam(paramType = "form", name = "transInAccountName", value = "转入户名", required = true, dataType = "String", defaultValue = "桐驰钞烦椭墒拼光"),
            @ApiImplicitParam(paramType = "form", name = "transInAmt", value = "转入本金金额", required = true, dataType = "String", defaultValue = "100.00"),
            @ApiImplicitParam(paramType = "form", name = "isRetire", value = "是否结息", required = true, dataType = "String", defaultValue = "1"),
            @ApiImplicitParam(paramType = "form", name = "bankType", value = "退款类别", required = true, dataType = "String", defaultValue = "1"),
            @ApiImplicitParam(paramType = "form", name = "reason", value = "扣款原因", required = true, dataType = "String", defaultValue = ""),

    })
    @ApiOperation(value = "保证金退回", notes = "保证金退回")
    @RequestMapping(value = "/depositRefund", method = RequestMethod.POST)
    public ResponseEntity<Ajax> depositRefund(HttpServletRequest request,
                                              @RequestParam(required = true) String subAccount,
                                              @RequestParam(required = true) String transInAccount,
                                              @RequestParam(required = true) String transInAccountBank,
                                              @RequestParam(required = true) String transInAccountName,
                                              @RequestParam(required = true) String transInAmt,
                                              @RequestParam(required = true) String isRetire,
                                              @RequestParam(required = true) String bankType,
                                              @RequestParam String reason
    ) throws APIException {
        return ResponseEntity.ok(bankService.depositRefund(subAccount, transInAccount, transInAccountBank, transInAccountName, transInAmt, isRetire, bankType, reason));
    }




    @ApiOperation(value = "查询order", notes = "查询order")
    @RequestMapping(value = "/queryBarcodeOrderStatus", method = RequestMethod.POST)
    public ResponseEntity<Ajax> queryBarcodeOrderStatus(HttpServletRequest request,
                                             @RequestParam(required = true) String orderId,
                                             @RequestParam(required = false) String beginDate,
                                             @RequestParam(required = false) String shoppingDate,
                                             @RequestParam(required = false) String endDate
    ) throws APIException {

            try {

                return ResponseEntity.ok(barcodeUnionpayService.queryTransationByOrderId(orderId,beginDate,endDate,shoppingDate));
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.ok(new Ajax(false, e.getLocalizedMessage()));
            }

    }




    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "form", name = "subAccount", value = "子账户标识", required = true, dataType = "String", defaultValue = ""),

    })
    @ApiOperation(value = "查询虚拟账户", notes = "查询虚拟账户")
    @RequestMapping(value = "/queryDeposit", method = RequestMethod.POST)
    public ResponseEntity<Ajax> queryDeposit(HttpServletRequest request,
                                             @RequestParam(required = true) String subAccount,
                                             @RequestParam(required = false) String type,
                                             @RequestParam(required = false) String startDate,
                                             @RequestParam(required = false) String endDate
    ) throws APIException {

        if ("jiaotong".equals(type)) {
            try {
                if(startDate==null){
                    startDate = JiaoTongBankService.getNowDateStr();
                }

                if(endDate==null){
                    endDate = JiaoTongBankService.getNowDateStr();
                }
                return ResponseEntity.ok(jiaoTongBankService.queryTransationDetail(new String[]{subAccount},startDate,endDate));
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.ok(new Ajax(false, e.getLocalizedMessage()));
            }

        } else if("unionpay".equals(type)){
            try {
                Date payDate = new Date();
                if(startDate!=null){
                    payDate.setTime(Long.parseLong(startDate));
                }


                return ResponseEntity.ok(unionpayService.queryTransationByOrderId(subAccount,payDate));
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.ok(new Ajax(false, e.getLocalizedMessage()));
            }
        }  else {
            return ResponseEntity.ok(bankService.queryDeposit(subAccount));
        }
    }


    ServerSocket server = null;

    private void createReceviewServer() {
        try {

            try {
                server = new ServerSocket(6070);
                //b)指定绑定的端口，并监听此端口。
                System.out.println("服务器启动");
                //创建一个ServerSocket在端口5209监听客户请求
            } catch (Exception e) {
                System.out.println("没有启动监听：" + e);
                //出错，打印出错信息
            }
            Socket socket = null;
            try {
                socket = server.accept();
                System.out.println("服务器请求到成功");
                //2、调用accept()方法开始监听，等待客户端的连接
                //使用accept()阻塞等待客户请求，有客户
                //请求到来则产生一个Socket对象，并继续执行
            } catch (Exception e) {
                System.out.println("accept Error." + e.getLocalizedMessage());
                //出错，打印出错信息
            }
            //3、获取输入流，并读取客户端信息
            String line;
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream(), "GBK"));
            //由Socket对象得到输入流，并构造相应的BufferedReader对象
            //  PrintWriter writer=new PrintWriter(socket.getOutputStream());

            //在标准输出上打印从客户端读入的字符串
            line = in.readLine();

            logger.info("Server" + line);
            //从标准输入读入一字符串
            //4、获取输出流，响应客户端的请求
            String result = line;
            while (!StringUtils.isEmpty(line)) {
                //如果该字符串为 "bye"，则停止循环
                //   writer.println(line);
                //向客户端输出该字符串
                //   writer.flush();
                //刷新输出流，使Client马上收到该字符串
                logger.info("Server" + line);
                //从Client读入一字符串，并打印到标准输出上
                line = in.readLine();
                if (!StringUtils.isEmpty(line)) {
                    result += line;

                    if (line.contains("</root>")) {
                        break;
                    }
                }



                //从系统标准输入读入一字符串
            } //继续循环

            logger.info("收到银行到账result." + result);

//          	<body>
//< Lzxh >来帐序号</ Lzxh >
//< InDate >到账日期</ InDate >
//< InTime >到账时间</ InTime >
//< InAmount >到账金额</ InAmount >
//< InBankNo >付款人银行帐号</ InBankNo >
//< InBankName >付款人银行行名</ InBankName >
//< InName >付款人户名</ InName >
//< IAcctNo >收款账号</ IAcctNo >
//< Fy >附言</ Fy >
//	</body>


            if (!StringUtils.isEmpty(result)) {
                String headTail = "</head>";
                int endHead = result.indexOf(headTail);
                if (endHead >= 0) {
                    Document doc = DocumentHelper.parseText(result.substring(8));
                    //指向根节点
                    Element root = doc.getRootElement();

                    Element headElement = root.element("head");

                    bankService.depositReceiveNotify(socket,
                            headElement.elementTextTrim("TransDate"), headElement.elementTextTrim("TransTime"), headElement.elementTextTrim("SeqNo"), null);
//                    String headContent=result.substring(0,endHead+headTail.length());
//                    testBankXmlRequest(headContent);

                } else {
                    System.out.println("not found ***====" + result);
                }
            } else {
                System.out.println("not found ====" + result);
            }

            //5、关闭资源
            // writer.close(); //关闭Socket输出流
            in.close(); //关闭Socket输入流
            socket.close(); //关闭Socket
            server.close(); //关闭ServerSocket

            createReceviewServer();
        } catch (Exception e) {//出错，打印出错信息
            e.printStackTrace();
            System.out.println("Error." + e.getLocalizedMessage());
            logger.info("收到银行到账result Error." + e.getLocalizedMessage());

        }



    }







}
