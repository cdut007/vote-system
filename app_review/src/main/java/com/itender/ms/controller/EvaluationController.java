package com.itender.ms.controller;

import com.itender.ms.domain.TbDictionary;
import com.itender.ms.domain.TbDictionaryExample;
import com.itender.ms.evaluation.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbDictionaryMapper;
import io.swagger.annotations.ApiOperation;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.*;

@Validated
@Controller
@RequestMapping("/evaluation")
public class EvaluationController {


    @Autowired
    private TbDictionaryMapper tbDictionaryMapper;

    private static final Logger logger = LoggerFactory.getLogger(EvaluationController.class);


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

        //设置是否切换算法平台
        TbDictionaryExample tbDictionaryExample = new TbDictionaryExample();
        tbDictionaryExample.createCriteria().andTypeNameEqualTo("平台配置");
        List<TbDictionary> tbDictionaries = tbDictionaryMapper.selectByExample(tbDictionaryExample);
        if (tbDictionaries.size() > 0) {
            for (TbDictionary dictionary:tbDictionaries
                 ) {
                if(dictionary.getItemCode()!=null){
                    result.put("prevStatus", dictionary.getItemCode());
                    dictionary.setItemCode(String.valueOf(enable));
                    tbDictionaryMapper.updateByPrimaryKeySelective(dictionary);
                    result.put("setStatus", dictionary.getItemCode());
                    result.put("code", IEvaluation.CODE_OK);
                    return ResponseEntity.ok(result);
                }
            }

        }

        result.put("code",IEvaluation.CODE_ERROR_UNKONWN);

        return ResponseEntity.ok(result);
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
