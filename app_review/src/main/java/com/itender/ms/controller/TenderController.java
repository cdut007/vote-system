package com.itender.ms.controller;

import com.itender.ms.exception.APIException;
import com.itender.ms.platform.expert.EXPERTAPPLY;
import com.itender.ms.platform.expert.ExpertRequestService;
import com.itender.ms.platform.shanxi.GCJSCONTRACTPERFORMANCE;
import com.itender.ms.platform.shanxi.service.impl.PublishShanxiRequestService;
import com.sxca.pspde.webservice.server.ExpertApplyStatusResult;
import com.sxca.pspde.webservice.server.ExtractResult;
import com.sxca.pspde.webservice.server.Result;
import io.swagger.annotations.ApiOperation;
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
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Validated
@Controller
@RequestMapping("/tender")
public class TenderController {


    private static final Logger logger = LoggerFactory.getLogger(TenderController.class);


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "tender/tender";
    }


    @Autowired
    private PublishShanxiRequestService publishShanxiRequestService;

    @ApiOperation(value = "合同履约", notes = "合同履约")
    @RequestMapping(value = "/transferContractPerformance", method = RequestMethod.POST)
    public ResponseEntity<
            com.itender.ms.platform.webservice.Result> transferContractPerformance(HttpServletRequest request,
                                              @RequestParam(required = true) String platId,
                                              @RequestBody(required = true) GCJSCONTRACTPERFORMANCE gcjscontractperformance
    ) throws APIException {
        com.itender.ms.platform.webservice.Result response = publishShanxiRequestService.transferContractPerformance(platId, gcjscontractperformance);
        return ResponseEntity.ok(response);
    }


}
