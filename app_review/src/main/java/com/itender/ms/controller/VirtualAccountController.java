package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.bank.VirtualAccountService;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.TbDictionary;
import com.itender.ms.domain.TbDictionaryExample;
import com.itender.ms.domain.TbVirtualAccount;
import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbVirtualAccountMapper;
import io.swagger.annotations.ApiOperation;
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
import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Validated
@Controller
@RequestMapping("/virtualAccount")
public class VirtualAccountController {


    @Autowired
    private VirtualAccountService virtualAccountService;



    private static final Logger logger = LoggerFactory.getLogger(VirtualAccountController.class);


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "virtualAccount/accounts";
    }


    @ApiOperation(value = "列出虚拟账户列表", notes = "列出虚拟账户列表")
    @RequestMapping(value = "/listSubAccounts", method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> enableCalculate(HttpServletRequest request,
                                                          @RequestParam(required = false) Integer pageNum,
                                                          @RequestParam(required = false) Integer pagesize
    ) throws APIException {
        Map<String, Object> result = new HashMap<>();

        pageNum = pageNum == null ? 1 : pageNum;
        pagesize = pagesize == null ? 10 : pagesize;

        PageInfo<TbVirtualAccount> page = null;
        page = virtualAccountService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));

    }





}
