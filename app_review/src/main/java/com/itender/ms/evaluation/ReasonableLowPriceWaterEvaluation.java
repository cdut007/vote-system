package com.itender.ms.evaluation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

//合理低价法
public class ReasonableLowPriceWaterEvaluation extends WaterEvaluation {
    private Logger logger = LoggerFactory.getLogger(getClass());


    //最高投标限价
    private BigDecimal finalControlPrice;


    private int benchmarkMethod;
    private BigDecimal benchmarkPrice;
    private BigDecimal reasonableCostPrice;

    private int selectedNum;

    public int getSelectedNum() {
        return selectedNum;
    }


    @Override
    public int calculate(List<Tender> tenders) {
        int code = super.calculate(tenders);
        if (code != CODE_OK) {
            return code;
        }
        //1 检查

        code = calculateByMethod1(tenders);

        return code;
    }


    private String errMsg;

    @Override
    public String getErrorMsg() {
        return errMsg;
    }


//    评标基准价按所有有效投标人评标价的算术平均值为基准（所有有效投标人多于五家（含五家）时，去掉一个最高评标价和一个最低评标价），
//    投标人报价（有计算错误的应为修正后的价格）等于评标基准价时得满分35分，以评标基准价为基准，高于评标基准价一个百分点扣2分；
//    低于评标基准价一个百分扣1分，低于超过8%（不含8%）后，每低于1%扣4分，直至扣为零分为止；百分数为非整数时，采用内插法（下同）。
//    报价得分最低分为0分。计算百分点时保留两位小数（四舍五入）。
//    投标人按照招标文件的要求应对工程量清单所有项目进行报价。投标人有计算错误的，有1处将在报价总得分中扣2分，直至扣完为止

    @Override
    public int calculateByMethod1(List<Tender> tenders) {
        //检查系数
        //检查投标报价
        List<Tender> checkTenders = new ArrayList<>(tenders);

        checkTenders = EvaluationFactory.getTenderListByValidStatus(tenders, true);

        if (checkTenders.size() >= 5) {
            Tender tenderTop = checkTenders.remove(tenders.size() - 1);
            logger.info("有效评标价=================去掉最高投标：" + tenderTop.toString());
            Tender tenderLow = checkTenders.remove(0);
            logger.info("有效评标价=================去掉最低投标：" + tenderLow.toString());

        }

        //计算基准价
        benchmarkPrice = calcuBenchMark(checkTenders);
        logger.info("基准价1=================：" + benchmarkPrice);

        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);

        return CODE_OK;
    }

    @Override
    public int calculateByMethod2(List<Tender> tenders) {
        return 0;
    }

    @Override
    public int calculateByMethod3(List<Tender> tenders) {
        return 0;
    }

    private BigDecimal calcuBenchMark(List<Tender> tenders) {
        BigDecimal avgValidTenderPrice = new BigDecimal(0);
        if (!tenders.isEmpty()) {
            avgValidTenderPrice = MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(tenders));
        }


        BigDecimal benchmarkPrice = avgValidTenderPrice;
        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }


    //投标人报价（有计算错误的应为修正后的价格）等于评标基准价时得满分35分，
    // 以评标基准价为基准，高于评标基准价一个百分点扣2分；低于评标基准价一个百分扣1分，低于超过8%（不含8%）后，
    // 每低于1%扣4分，直至扣为零分为止；百分数为非整数时，采用内插法（下同）。
    // 报价得分最低分为0分。计算百分点时保留两位小数（四舍五入）
    private int calcuScore(List<Tender> tenders) {
        for (Tender tender : tenders
                ) {
            BigDecimal rangeValue = tender.getPrice().subtract(benchmarkPrice);
            float score = 0f;
            logger.info("benchmarkPrice="+benchmarkPrice+" rangeValue=================：" + rangeValue);
            if (rangeValue.doubleValue() > 0) {
                BigDecimal highRange = rangeValue.divide(benchmarkPrice,4).multiply(new BigDecimal(100));
                score = MathTool.getFormatValue(highRange.multiply(new BigDecimal(2)), 2).floatValue();
                tender.setDeviationValue(highRange.divide(new BigDecimal(100),4).floatValue());
            } else {
                BigDecimal lowRange =  MathTool.getFormatValue(rangeValue.divide(benchmarkPrice,2).multiply(new BigDecimal(100)),4);
                tender.setDeviationValue(lowRange.divide(new BigDecimal(100),4).floatValue());
                lowRange = MathTool.abs(lowRange);
                logger.info("lowRange=================：" + lowRange);
                if(lowRange.floatValue() > 8){
                    score = ( lowRange.floatValue() - 8 ) * 4;
                    lowRange = new BigDecimal(8);
                }
                score+=1*lowRange.floatValue();

            }
            score = 35 - score;
            if (score < 0) {
                score = 0;
            }

            tender.setScore(MathTool.getFormatValue(score, 2));
        }
        return CODE_OK;
    }

    @Override
    public BigDecimal getBenchmarkPrice() {
        return benchmarkPrice;
    }

    @Override
    public BigDecimal getReasonableCostPrice() {
        return reasonableCostPrice;
    }

    @Override
    public BigDecimal getFinalControlPrice() {
        return finalControlPrice;
    }
}
