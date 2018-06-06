package com.itender.ms.controller;

import com.itender.ms.evaluation.EvaluationFactory;
import com.itender.ms.evaluation.IEvaluation;
import com.itender.ms.evaluation.ReasonableLowPriceTrafficEvaluation;
import com.itender.ms.evaluation.Tender;
import com.itender.ms.exception.APIException;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.*;

@Validated
@Controller
@RequestMapping("/evaluation")
public class EvaluationController {




    private static final Logger logger = LoggerFactory.getLogger(EvaluationController.class);


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "evaluation/evaluation";
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

         try{
             IEvaluation evalution = EvaluationFactory.createEvalution(catagory,strategyType);

             ReasonableLowPriceTrafficEvaluation reasonableLowPriceTrafficEvalution = (ReasonableLowPriceTrafficEvaluation) evalution;

             reasonableLowPriceTrafficEvalution.setControlPriceAndRatio(new BigDecimal(controlPrice),controlRatio);

             reasonableLowPriceTrafficEvalution.setRatiosAndBenchmarkMethod1(ratio,weightedRatio);
             reasonableLowPriceTrafficEvalution.setHighERatio(HighERatio);
             reasonableLowPriceTrafficEvalution.setLowERatio(LowERatio);
             int code = reasonableLowPriceTrafficEvalution.calculate(tenders);
             Collections.sort(tenders);
             result.put("code",code);
             Map<String, Object> data = new HashMap<>();
             data.put("reasonableCostPrice",reasonableLowPriceTrafficEvalution.getReasonableCostPrice());
             data.put("finalControlPrice",reasonableLowPriceTrafficEvalution.getFinalControlPrice());
             data.put("benchmarkPrice",reasonableLowPriceTrafficEvalution.getBenchmarkPrice());
             data.put("tenders",tenders);
             result.put("msg", EvaluationFactory.getMsgByCode(code));
             result.put("data", data);
         }catch (Exception e){
             e.printStackTrace();
             result.put("code",IEvaluation.CODE_ERROR_UNKONWN);
             result.put("msg", EvaluationFactory.getMsgByCode(IEvaluation.CODE_ERROR_UNKONWN));
         }




        return ResponseEntity.ok(result);
    }

}
