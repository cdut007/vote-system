package com.itender.ms.controller;

import com.itender.ms.bank.CITIC.Ajax;
import com.itender.ms.bank.CITIC.BankService;
import com.itender.ms.domain.TbDictionary;
import com.itender.ms.domain.TbDictionaryExample;
import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbDictionaryMapper;
import com.itender.ms.workflow.service.IWorkFlowService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.activiti.engine.FormService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.impl.form.TaskFormDataImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
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
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Validated
@Controller
@RequestMapping("/bank")
public class BankController {



    @Autowired
    private BankService bankService;

    private static final Logger logger = LoggerFactory.getLogger(BankController.class);



    @ApiOperation(value = "启动监听服务", notes = "启动监听服务")
    @RequestMapping(value = "/startServer", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> startServer(HttpServletRequest request,
                                                               @RequestParam(required = true) boolean enable
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();

        createReceviewServer();


        result.put("code", IEvaluation.CODE_ERROR_UNKONWN);

        return ResponseEntity.ok(result);
    }

    @ApiImplicitParams({
            @ApiImplicitParam(name = "projectItemName", value = "子账户标识：标段编号+交易流水号（重复发送，不重复生成）", required = true, dataType = "String", defaultValue = "标段1"),
            @ApiImplicitParam(name = "tenderUnitName", value = "子账户名称", required = true, dataType = "String", defaultValue = "投标单位1"),
            @ApiImplicitParam(name = "depositEndTimeInMillis", value = "保证金截止日期", required = true, dataType = "String",  defaultValue = "20180803113723"),
            @ApiImplicitParam(name = "IsRetire", value = "是否退息", required = true, dataType = "String",  defaultValue = "1")

    })
    @ApiOperation(value = "创建虚拟账户", notes = "创建虚拟账户,返回子账户")
    @RequestMapping(value = "/createSubAccount", method = RequestMethod.POST)
    public ResponseEntity<Ajax> createSubAccount(HttpServletRequest request,
                                                            @RequestParam(required = true) String projectItemName,
                                                            @RequestParam(required = true) String tenderUnitName,
                                                            @RequestParam(required = true) long depositEndTimeInMillis,
                                                            @RequestParam(required = true) String IsRetire
    ) throws APIException {
        return ResponseEntity.ok(bankService.createSubAccount(projectItemName,tenderUnitName,depositEndTimeInMillis,IsRetire));
    }


    @ApiImplicitParams({
            @ApiImplicitParam(name = "subAccount", value = "子账户标识", required = true, dataType = "String", defaultValue = "3113710004951386970"),
            @ApiImplicitParam(name = "bankNo", value = "付款人账户", required = true, dataType = "String", defaultValue = "7119910130900000001"),
            @ApiImplicitParam(name = "bankName", value = "付款人银行名称", required = true, dataType = "String", defaultValue = "中信银行总行营业部账务中心"),
            @ApiImplicitParam(name = "name", value = "付款人户名", required = true, dataType = "String", defaultValue = "桐驰钞烦椭墒拼光"),
            @ApiImplicitParam(name = "timeMillis", value = "到账日期", required = true, dataType = "String", defaultValue = "20180622095844"),
            @ApiImplicitParam(name = "depositTransSeqNo", value = "来账序号，从银行回调中获取", required = true, dataType = "String", defaultValue = "20180622J0000000567269"),
            @ApiImplicitParam(name = "remark", value = "附言", required = true, dataType = "String", defaultValue = "保证金"),
            @ApiImplicitParam(name = "Amount", value = "到账金额", required = true, dataType = "String", defaultValue = "200.00"),

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
                                                     @RequestParam(required = true) String subAccount,String remark
    ) throws APIException {
        return ResponseEntity.ok(bankService.depositReceiveNotify(depositTransSeqNo,timeMillis,Amount,bankNo,bankName,name,subAccount,remark));
    }


    @ApiImplicitParams({
            @ApiImplicitParam(name = "subAccount", value = "子账户标识", required = true, dataType = "String", defaultValue = "3113710004951386970"),
            @ApiImplicitParam(name = "transInAccount", value = "转入账户", required = true, dataType = "String", defaultValue = "7119910130900000001"),
            @ApiImplicitParam(name = "transInAccountBank", value = "转入银行名称", required = true, dataType = "String", defaultValue = "中信银行总行营业部账务中心"),
            @ApiImplicitParam(name = "transInAccountName", value = "转入户名", required = true, dataType = "String", defaultValue = "桐驰钞烦椭墒拼光"),
            @ApiImplicitParam(name = "transInAmt", value = "转入本金金额", required = true, dataType = "String", defaultValue = "100.00"),
            @ApiImplicitParam(name = "isRetire", value = "是否结息", required = true, dataType = "String", defaultValue = "1"),
            @ApiImplicitParam(name = "bankType", value = "退款类别", required = true, dataType = "String", defaultValue = "1"),
            @ApiImplicitParam(name = "reason", value = "扣款原因", required = true, dataType = "String", defaultValue = ""),

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
        return ResponseEntity.ok(bankService.depositRefund(subAccount,transInAccount,transInAccountBank,transInAccountName,transInAmt,isRetire,bankType,reason));
    }


    @ApiImplicitParams({
            @ApiImplicitParam(name = "subAccount", value = "子账户标识", required = true, dataType = "String", defaultValue = ""),

    })
    @ApiOperation(value = "查询虚拟账户", notes = "查询虚拟账户")
    @RequestMapping(value = "/queryDeposit", method = RequestMethod.POST)
    public ResponseEntity<Ajax> queryDeposit(HttpServletRequest request,
                                                     @RequestParam(required = true) String subAccount
    ) throws APIException {
        return ResponseEntity.ok(bankService.queryDeposit(subAccount));
    }





    ServerSocket server=null;
    private void createReceviewServer() {
        try{

            try{
                  server=new ServerSocket(6070);
                //b)指定绑定的端口，并监听此端口。
                System.out.println("服务器启动成功");
                //创建一个ServerSocket在端口5209监听客户请求
            }catch(Exception e) {
                System.out.println("没有启动监听："+e);
                //出错，打印出错信息
            }
            Socket socket=null;
            try{
                socket=server.accept();
                //2、调用accept()方法开始监听，等待客户端的连接
                //使用accept()阻塞等待客户请求，有客户
                //请求到来则产生一个Socket对象，并继续执行
            }catch(Exception e) {
                System.out.println("accept Error."+e);
                //出错，打印出错信息
            }
            //3、获取输入流，并读取客户端信息
            String line;
            BufferedReader in=new BufferedReader(new InputStreamReader(socket.getInputStream(),"GBK"));
            //由Socket对象得到输入流，并构造相应的BufferedReader对象
          //  PrintWriter writer=new PrintWriter(socket.getOutputStream());

            //在标准输出上打印从客户端读入的字符串
            line=in.readLine();

            System.out.println("Client:"+line);

            //从标准输入读入一字符串
            //4、获取输出流，响应客户端的请求
            String result=line;
            while(!StringUtils.isEmpty(line)){
                //如果该字符串为 "bye"，则停止循环
             //   writer.println(line);
                //向客户端输出该字符串
             //   writer.flush();
                //刷新输出流，使Client马上收到该字符串
                System.out.println("Server:"+line);
                //从Client读入一字符串，并打印到标准输出上
                line=in.readLine();
                if(!StringUtils.isEmpty(line)){
                    result+=line;
                }

                //从系统标准输入读入一字符串
            } //继续循环


            System.out.println("result."+result);
            //5、关闭资源
           // writer.close(); //关闭Socket输出流
            in.close(); //关闭Socket输入流
            socket.close(); //关闭Socket
            server.close(); //关闭ServerSocket

            if(!StringUtils.isEmpty(result)){
                String headTail = "</head>";
                int endHead = result.indexOf(headTail);
                if(endHead>=0){
                    String headContent=result.substring(0,endHead+headTail.length());
                    testBankXmlRequest(headContent);
                }else{
                    System.out.println("not found ***===="+result);
                }
            }else{
                System.out.println("not found ===="+result);
            }

            createReceviewServer();
        }catch(Exception e) {//出错，打印出错信息
            System.out.println("Error."+e);

        }
    }

    private void testBankXmlRequest(String headContent) throws Exception {
        String body = headContent +
                "\t<body>\n" +
                "< TransResult >1</ TransResult >\n" +
                "< Remark >备注</ Remark >\n" +
                "\t</body>\n" +
                "</root>";
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
            logger.info("发送数据结束");

            //获取响应
            inputStream = socket.getInputStream();
            br = new BufferedReader(new InputStreamReader(inputStream,"GBK"));
            String info = "", line;
            while ((line = br.readLine()) != null) {
                logger.info(line);
                info += line;
            }
            logger.info(info);
            br.close();
            inputStream.close();
            outputStream.close();
            socket.close();
            logger.info("断开连接");
        } catch (UnknownHostException e1) {
            logger.info("创建连接失败");
        } catch (IOException e1) {
            logger.info("发送数据失败");
        }
    }




}
