package com.itender.ms.controller;

import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
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
        Map<String, Object> data = new HashMap<>();
         try{
             IEvaluation evalution = EvaluationFactory.createEvalution(catagory,strategyType);

             if(catagory == EvaluationFactory.TYPE_TRAFFIC){
                 ReasonableLowPriceTrafficEvaluation reasonableLowPriceTrafficEvalution = (ReasonableLowPriceTrafficEvaluation) evalution;

                 reasonableLowPriceTrafficEvalution.setControlPriceAndRatio(new BigDecimal(controlPrice),controlRatio);
                 if(weightedRatio==null){
                     weightedRatio = 0f;
                 }
                 reasonableLowPriceTrafficEvalution.setRatiosAndBenchmarkMethod(ratio,weightedRatio,strategySubType);
                 reasonableLowPriceTrafficEvalution.setHighERatio(HighERatio);
                 reasonableLowPriceTrafficEvalution.setLowERatio(LowERatio);
                 int code = evalution.calculate(tenders);
                 result.put("code",code);
                 data.put("reasonableCostPrice",reasonableLowPriceTrafficEvalution.getReasonableCostPrice());
                 data.put("finalControlPrice",reasonableLowPriceTrafficEvalution.getFinalControlPrice());
                 data.put("benchmarkPrice",reasonableLowPriceTrafficEvalution.getBenchmarkPrice());
                 String msg = EvaluationFactory.getMsgByCode(code);
                 if(StringUtils.isEmpty(msg)){
                     msg = evalution.getErrorMsg();
                 }
                 result.put("msg", msg);
             }else if(catagory == EvaluationFactory.TYPE_BUILDING){
                 ReasonableLowPriceBuildingEvaluation reasonableLowPriceBuildingEvaluation = (ReasonableLowPriceBuildingEvaluation) evalution;

                 reasonableLowPriceBuildingEvaluation.setControlPriceAndRatio(new BigDecimal(controlPrice),controlRatio);
                 if(weightedRatio==null){
                     weightedRatio = 0f;
                 }
                 reasonableLowPriceBuildingEvaluation.setRatiosAndBenchmarkMethod(ratio,weightedRatio,strategySubType);

                 int code = evalution.calculate(tenders);
                 result.put("code",code);
                 data.put("finalControlPrice",reasonableLowPriceBuildingEvaluation.getFinalControlPrice());
                 data.put("reasonableCostPrice",reasonableLowPriceBuildingEvaluation.getReasonableCostPrice());
                 data.put("benchmarkPrice",reasonableLowPriceBuildingEvaluation.getBenchmarkPrice());
                 String msg = EvaluationFactory.getMsgByCode(code);
                 if(StringUtils.isEmpty(msg)){
                     msg = evalution.getErrorMsg();
                 }
                 result.put("msg", msg);
             }else if(catagory == EvaluationFactory.TYPE_MUNICIPAL){
                 ReasonableLowPriceMunicipalEvaluation reasonableLowPriceMunicipalEvaluation = (ReasonableLowPriceMunicipalEvaluation) evalution;

                 reasonableLowPriceMunicipalEvaluation.setControlPriceAndRatio(new BigDecimal(controlPrice),controlRatio);
                 if(weightedRatio==null){
                     weightedRatio = 0f;
                 }
                 reasonableLowPriceMunicipalEvaluation.setRatiosAndBenchmarkMethod(ratio,weightedRatio,strategySubType);

                 int code = evalution.calculate(tenders);
                 result.put("code",code);
                 data.put("finalControlPrice",reasonableLowPriceMunicipalEvaluation.getFinalControlPrice());
                 data.put("reasonableCostPrice",reasonableLowPriceMunicipalEvaluation.getReasonableCostPrice());
                 data.put("benchmarkPrice",reasonableLowPriceMunicipalEvaluation.getBenchmarkPrice());
                 String msg = EvaluationFactory.getMsgByCode(code);
                 if(StringUtils.isEmpty(msg)){
                     msg = evalution.getErrorMsg();
                 }
                 result.put("msg", msg);
             }


             Collections.sort(tenders);

             data.put("tenders",tenders);

             result.put("data", data);
         }catch (Exception e){
             e.printStackTrace();
             result.put("code",IEvaluation.CODE_ERROR_UNKONWN);
             result.put("msg", EvaluationFactory.getMsgByCode(IEvaluation.CODE_ERROR_UNKONWN));
         }




        return ResponseEntity.ok(result);
    }

}
