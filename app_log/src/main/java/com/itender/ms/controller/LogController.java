package com.itender.ms.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderLog;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderLogService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import springfox.documentation.annotations.ApiIgnore;

@Api(description = "日志管理模块接口")
@Validated
@Controller
@RequestMapping("/log")
public class LogController {
	 private static final Logger logger = LoggerFactory.getLogger(LogController.class);

	@Autowired
	private ItenderLogService itenderLogService;


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "log/log_list";
    }

    @ApiIgnore
    @RequestMapping(value = "/log_page",method = RequestMethod.GET)
    public String logPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/log/log_list");
    }

    @ApiOperation(value = "日志列表接口",notes = "用于查询所有日志信息")
    @RequestMapping(value = "/listLog",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> logAll(HttpServletRequest request,
                                                    @RequestParam(required = false) Integer pageNum,
                                                    @RequestParam(required = false) Integer pagesize
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderLog> page = itenderLogService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }



}
