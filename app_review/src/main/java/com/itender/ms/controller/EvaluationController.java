package com.itender.ms.controller;

import com.itender.ms.domain.TbDictionary;
import com.itender.ms.domain.TbDictionaryExample;
import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbDictionaryMapper;
import com.itender.ms.workflow.service.IWorkFlowService;
import io.swagger.annotations.ApiOperation;
import org.activiti.engine.FormService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.impl.form.DateFormType;
import org.activiti.engine.impl.form.TaskFormDataImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import springfox.documentation.annotations.ApiIgnore;

import javax.annotation.Resource;
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
@RequestMapping("/evaluation")
public class EvaluationController {


    @Autowired
    private TbDictionaryMapper tbDictionaryMapper;

    private static final Logger logger = LoggerFactory.getLogger(EvaluationController.class);



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


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "evaluation/evaluation";
    }


    @ApiOperation(value = "使用平台评标算法", notes = "用于评标算法")
    @RequestMapping(value = "/enableCalculate", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> enableCalculate(HttpServletRequest request,
                                                               @RequestParam(required = true) boolean enable
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();


        // testActivity();
        //设置是否切换算法平台
        TbDictionaryExample tbDictionaryExample = new TbDictionaryExample();
        tbDictionaryExample.createCriteria().andTypeNameEqualTo("平台配置");
        List<TbDictionary> tbDictionaries = tbDictionaryMapper.selectByExample(tbDictionaryExample);
        if (tbDictionaries.size() > 0) {
            for (TbDictionary dictionary : tbDictionaries
                    ) {
                if (dictionary.getItemCode() != null) {
                    result.put("prevStatus", dictionary.getItemCode());
                    dictionary.setItemCode(String.valueOf(enable));
                    tbDictionaryMapper.updateByPrimaryKeySelective(dictionary);
                    result.put("setStatus", dictionary.getItemCode());
                    result.put("code", IEvaluation.CODE_OK);
                    return ResponseEntity.ok(result);
                }
            }

        }

        result.put("code", IEvaluation.CODE_ERROR_UNKONWN);

        return ResponseEntity.ok(result);
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
                System.out.println("Error."+e);
                //出错，打印出错信息
            }
            //3、获取输入流，并读取客户端信息
            String line;
            BufferedReader in=new BufferedReader(new InputStreamReader(socket.getInputStream(),"GBK"));
            //由Socket对象得到输入流，并构造相应的BufferedReader对象
            PrintWriter writer=new PrintWriter(socket.getOutputStream());

            //在标准输出上打印从客户端读入的字符串
            line=in.readLine();

            System.out.println("Client:"+line);

            //从标准输入读入一字符串
            //4、获取输出流，响应客户端的请求
            String result=line;
            while(line!=null){
                //如果该字符串为 "bye"，则停止循环
                writer.println(line);
                //向客户端输出该字符串
                writer.flush();
                //刷新输出流，使Client马上收到该字符串
                System.out.println("Server:"+line);
                //从Client读入一字符串，并打印到标准输出上
                line=in.readLine();
                result+=line;
                //从系统标准输入读入一字符串
            } //继续循环


            System.out.println("result."+result);
            //5、关闭资源
            writer.close(); //关闭Socket输出流
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


    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private FormService formService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private IWorkFlowService workFlowService;

    private void testActivity() {
        Map<String, Object> variableMap = new HashMap<String, Object>();
        variableMap.put("projectInstanceId", "projectInstanceId111");
        // 绑定招标项目名称
        variableMap.put("projectInstanceName", "projectInstanceName111");

        variableMap.put("expertSignEnd", true);

        variableMap.put("envelopeTypeOrder", "first");

        variableMap.put("expertApplyId", "expertApplyId111");
        variableMap.put("projectItemId", "projectItemId111");

        variableMap.put("expertIdSign", "expertIdSign111");
        //查询出监标人
        variableMap.put("guardianIdSign", "guardianIdSign111");
        variableMap.put("preliminaryReview", "0");

        variableMap.put("roleId", "roleId111");

        List<ProcessInstance> processInstanceList = runtimeService.createProcessInstanceQuery()
                .processDefinitionKey("yj_project_item_open").processInstanceBusinessKey("expertApplyId111").active().list();
        for (ProcessInstance processInstance : processInstanceList) {
            workFlowService.deleteProcessInstance(processInstance.getId(), "重新初始化");
        }

        ProcessInstance processInstance = this.runtimeService.startProcessInstanceByKey("yj_project_item_open", "expertApplyId111", variableMap);
        String taskId = this.taskService.createTaskQuery().processInstanceId(processInstance.getId()).singleResult().getId();
        Task task = this.taskService.createTaskQuery().taskId(taskId).singleResult();
        TaskFormDataImpl taskFormData = (TaskFormDataImpl) formService.getTaskFormData(taskId);
        List<FormProperty> formPropertiesList = taskFormData.getFormProperties();

        for (FormProperty formProperty : formPropertiesList) {
        }

        processInstance = this.runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult();


        Map<String, String> formProperties = new HashMap<String, String>();
        for (FormProperty formProperty : formService.getTaskFormData(taskId).getFormProperties()) {

        }
        formService.submitTaskFormData(taskId, formProperties);
    }


    @ApiOperation(value = "评标算法", notes = "用于评标算法")
    @RequestMapping(value = "/calculate", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> calculate(HttpServletRequest request,
                                                         @RequestBody(required = true) List<Tender> tenders,
                                                         @RequestParam(required = true) Float controlPrice,
                                                         @RequestParam(required = false) Float controlRatio,
                                                         @RequestParam(required = false) Float ratio,
                                                         @RequestParam(required = false) Float weightedRatio,
                                                         @RequestParam(required = false) Float LowERatio,
                                                         @RequestParam(required = false) Float HighERatio,
                                                         @RequestParam(required = true) Integer catagory,
                                                         @RequestParam(required = true) Integer strategyType,
                                                         @RequestParam(required = false) Integer strategySubType
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        try {
            IEvaluation evalution = EvaluationFactory.createEvalution(catagory, strategyType);

            if (catagory == EvaluationFactory.TYPE_TRAFFIC) {
                ReasonableLowPriceTrafficEvaluation reasonableLowPriceTrafficEvalution = (ReasonableLowPriceTrafficEvaluation) evalution;

                reasonableLowPriceTrafficEvalution.setControlPriceAndRatio(new BigDecimal(controlPrice), controlRatio);
                if (weightedRatio == null) {
                    weightedRatio = 0f;
                }
                reasonableLowPriceTrafficEvalution.setRatiosAndBenchmarkMethod(ratio, weightedRatio, strategySubType);
                reasonableLowPriceTrafficEvalution.setHighERatio(HighERatio);
                reasonableLowPriceTrafficEvalution.setLowERatio(LowERatio);

            } else if (catagory == EvaluationFactory.TYPE_BUILDING) {
                ReasonableLowPriceBuildingEvaluation reasonableLowPriceBuildingEvaluation = (ReasonableLowPriceBuildingEvaluation) evalution;

                reasonableLowPriceBuildingEvaluation.setControlPriceAndRatio(new BigDecimal(controlPrice), controlRatio);
                if (weightedRatio == null) {
                    weightedRatio = 0f;
                }
                reasonableLowPriceBuildingEvaluation.setRatiosAndBenchmarkMethod(ratio, weightedRatio, strategySubType);


            } else if (catagory == EvaluationFactory.TYPE_MUNICIPAL) {
                ReasonableLowPriceMunicipalEvaluation reasonableLowPriceMunicipalEvaluation = (ReasonableLowPriceMunicipalEvaluation) evalution;

                reasonableLowPriceMunicipalEvaluation.setControlPriceAndRatio(new BigDecimal(controlPrice), controlRatio);
                if (weightedRatio == null) {
                    weightedRatio = 0f;
                }
                reasonableLowPriceMunicipalEvaluation.setRatiosAndBenchmarkMethod(ratio, weightedRatio, strategySubType);


            } else if (catagory == EvaluationFactory.TYPE_WATER) {
                ReasonableLowPriceWaterEvaluation reasonableLowPriceWaterEvaluation = (ReasonableLowPriceWaterEvaluation) evalution;


            }

            int code = evalution.calculate(tenders);
            result.put("code", code);
            data.put("finalControlPrice", evalution.getFinalControlPrice());
            data.put("reasonableCostPrice", evalution.getReasonableCostPrice());
            data.put("benchmarkPrice", evalution.getBenchmarkPrice());
            String msg = evalution.getErrorMsg();
            if (StringUtils.isEmpty(msg)) {
                msg = EvaluationFactory.getMsgByCode(code);
            }
            result.put("msg", msg);


            Collections.sort(tenders);

            data.put("tenders", tenders);

            result.put("data", data);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", IEvaluation.CODE_ERROR_UNKONWN);
            result.put("msg", EvaluationFactory.getMsgByCode(IEvaluation.CODE_ERROR_UNKONWN));
        }


        return ResponseEntity.ok(result);
    }

}
