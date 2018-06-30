package com.itender.ms.controller;

import com.itender.ms.domain.TbDictionary;
import com.itender.ms.domain.TbDictionaryExample;
import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbDictionaryMapper;
import com.itender.ms.platform.expert.EXPERTAPPLY;
import com.itender.ms.platform.expert.EXPERTAPPLYEDIT;
import com.itender.ms.platform.expert.ExpertRequestService;
import com.itender.ms.workflow.service.IWorkFlowService;
import com.sxca.pspde.webservice.server.ExpertApplyStatusResult;
import com.sxca.pspde.webservice.server.ExtractResult;
import com.sxca.pspde.webservice.server.Result;
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
@RequestMapping("/expert")
public class ExpertController {


    private static final Logger logger = LoggerFactory.getLogger(ExpertController.class);


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "expert/expert";
    }


    @Autowired
    private ExpertRequestService expertRequestService;

    @ApiOperation(value = "抽取专家申请表", notes = "抽取专家申请表")
    @RequestMapping(value = "/apply", method = RequestMethod.POST)
    public ResponseEntity<Result> startServer(HttpServletRequest request,
                                                           @RequestBody(required = true) EXPERTAPPLY expertapply
    ) throws APIException {
        Result response =  expertRequestService.apply(expertapply);
        return ResponseEntity.ok(response);
    }

    @ApiOperation(value = "修改抽取专家条件", notes = "修改抽取专家条件")
    @RequestMapping(value = "/expertSpecialtyEdit", method = RequestMethod.POST)
    public ResponseEntity<Result> expertSpecialtyEdit(HttpServletRequest request,
                                                      @RequestBody(required = true) EXPERTAPPLY expertapplyedit
    ) throws APIException {
        Result response = expertRequestService.expertSpecialtyEdit(expertapplyedit);
        return ResponseEntity.ok(response);
    }

    @ApiOperation(value = "查询抽取专家申请表状态", notes = "查询抽取专家申请表状态")
    @RequestMapping(value = "/getApplyStatus", method = RequestMethod.POST)
    public ResponseEntity<ExpertApplyStatusResult> getApplyStatus(HttpServletRequest request,
                                                                  @RequestParam(required = true) String platId

    ) throws APIException {

        ExpertApplyStatusResult response = expertRequestService.getApplyStatus(platId);
        return ResponseEntity.ok(response);
    }

    @ApiOperation(value = "发送抽取请求", notes = "发送抽取请求")
    @RequestMapping(value = "/extract", method = RequestMethod.POST)
    public ResponseEntity<Result> extract(HttpServletRequest request,
                                                       @RequestParam(required = true) String platId

    ) throws APIException {

        Result response = expertRequestService.extract(platId);
        return ResponseEntity.ok(response);
    }


    @ApiOperation(value = "获取抽取结果", notes = "获取抽取结果")
    @RequestMapping(value = "/getExtractResult", method = RequestMethod.POST)
    public ResponseEntity<ExtractResult> getExtractResult(HttpServletRequest request,
                                                                @RequestParam(required = true) String platId

    ) throws APIException {
       ExtractResult response = expertRequestService.getExtractResult(platId);
        return ResponseEntity.ok(response);
    }

}
