package com.itender.ms.evaluation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

//合理低价法
public class ReasonableLowPriceTrafficEvaluation extends TrafficEvaluation {
    private Logger logger = LoggerFactory.getLogger(getClass());
    public static final int benchmark_method_1 = 0x01;
    public static final int benchmark_method_2 = 0x02;
    public static final int benchmark_method_3 = 0x03;

    //系数
    private float ratio, weightedRatio, controlRatio;
    //最高投标限价
    private BigDecimal finalControlPrice;

    //有
    //效评标价＞评标基准价时’E取1～2; 当有效评标价≤评标基准价
    //时’E取0.5～1
    private float LowERatio;

    private float HighERatio;

    private int benchmarkMethod;
    private BigDecimal benchmarkPrice;
    private BigDecimal reasonableCostPrice;

    public void setLowERatio(float lowERatio) {
        LowERatio = lowERatio;
    }

    public void setHighERatio(float highERatio) {
        HighERatio = highERatio;
    }


    public void setControlPriceAndRatio(BigDecimal controlPrice, float controlRatio) {
        this.controlRatio = controlRatio;//下浮系数
        //最终最高投标限价＝最高投标限价× （1ˉ下浮系数）
        float ratio = 1.0f - controlRatio;
        this.finalControlPrice = controlPrice.multiply(MathTool.getFormatValue(new BigDecimal(ratio),2));
        this.finalControlPrice = MathTool.getFormatValue(this.finalControlPrice,2);
    }

    //评标基准价基础参数设置
    public void setRatiosAndBenchmarkMethod1(float ratio, float weightedRatio) {
        this.ratio = ratio;
        this.weightedRatio = weightedRatio;
        this.benchmarkMethod = benchmark_method_1;
    }

    @Override
    public int calculate(List<Tender> tenders) {
        int code = super.calculate(tenders);
        if (code != CODE_OK) {
            return code;
        }
        //1 检查
        switch (benchmarkMethod) {
            case benchmark_method_1:
                code = calculateByMethod1(tenders);
                break;

            default:

        }

        return code;
    }


    //评标基准价＝［最终最高投标限价×加权系数＋有效评标价算
    //术平均值× （1-加权系数）] ×评标基准价系数
    //式中:加权系数是从0. 3、 0. 35、 0.4中随机抽取’评标基准价
    //系数是从0.96（含） ～0.99（含）中’按照步长0. 01随机抽取’
    //均由投标人代表或现场监督在开标现场进行。
    //有效评标价指介于理论成本价（含）与最终最高投标限价（含）
    //范围内的评标价. 当有效评标价数量大于5时’可去掉其中的最高
    //和最低值’再进行算术平均值计算
    private int calculateByMethod1(List<Tender> tenders) {
        //检查系数
        int code = checkRatio();
        if (code != CODE_OK) {
            return code;
        }
        //检查投标报价
        List<Tender>  checkTenders= new ArrayList<>(tenders);
        code = checkTenderPrice(checkTenders);
        if (code != CODE_OK) {
            return code;
        }

        //计算基准价
        benchmarkPrice = calcuBenchMark(checkTenders);


        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);

        return CODE_OK;
    }

    private BigDecimal calcuBenchMark(List<Tender> tenders) {
        BigDecimal avgValidTenderPrice = new BigDecimal(0);
        if(!tenders.isEmpty()){
            avgValidTenderPrice = MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(tenders));
        }

        float deltaRatio = 1 - weightedRatio;
        BigDecimal benchmarkPrice = finalControlPrice.multiply(MathTool.getFormatValue(new BigDecimal(weightedRatio),3)).add(avgValidTenderPrice.multiply(MathTool.getFormatValue(new BigDecimal(deltaRatio),3)));
        benchmarkPrice = benchmarkPrice.multiply(MathTool.getFormatValue(new BigDecimal(this.ratio),3));
        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }

    private int  checkTenderPrice(List<Tender> tenders) {
        //评标价检查,当评标价有5个及以上时’应去掉其中的最高值和最低值’再
        //进行算术平均值计算·评标价低于理论成本价的’不再参与后续计算。
        List<Tender>  checkTenders= new ArrayList<>(tenders);
        if (checkTenders.size() >= 5) {
            java.util.Collections.sort(checkTenders);
            Tender tenderTop = checkTenders.remove(checkTenders.size() - 1);
            logger.info("理论成本价=================去掉最高投标：" + tenderTop.toString());
            Tender tenderLow = checkTenders.remove(0);
            logger.info("理论成本价=================去掉最低投标：" + tenderLow.toString());
        }

        BigDecimal avgTenderPrice = MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(checkTenders));
        logger.info("=================最终最高投标限价：" + finalControlPrice);
        //理论成本价＝［最终最高投标限价×50％＋评标价算术平均值
        //×50％］ ×0. 85
        //理论成本价
        reasonableCostPrice = (finalControlPrice.multiply(new BigDecimal(0.5)).add(avgTenderPrice.multiply(new BigDecimal(0.5)))).multiply(new BigDecimal(0.85));
        reasonableCostPrice = MathTool.getFormatValue(reasonableCostPrice, 2);
        //有效评标价指介于理论成本价（含）与最终最高投标限价（含）
        //范围内的评标价. 当有效评标价数量大于5时’可去掉其中的最高
        //和最低值’再进行算术平均值计算

        for (int i = tenders.size() - 1; i >= 0; i--) {
            Tender tender = tenders.get(i);
            if (tender.getPrice().compareTo(reasonableCostPrice) < 0 || tender.getPrice().compareTo(finalControlPrice) > 0) {
                tenders.remove(tender);
                logger.info("有效评标价=================去掉不满足条件投标：" + tender.toString());
            }
        }

        if (tenders.size() > 5) {
            Tender tenderTop = tenders.remove(tenders.size() - 1);
            logger.info("有效评标价=================去掉最高投标：" + tenderTop.toString());
            Tender tenderLow = tenders.remove(0);
            logger.info("有效评标价=================去掉最低投标：" + tenderLow.toString());

        }


        return CODE_OK;
    }

    private int checkRatio() {
        if (weightedRatio != 0.3f && weightedRatio != 0.35f && weightedRatio != 0.4f) {
            return CODE_ERROR_RATIO;//加权系数不对
        }

        if (HighERatio < 1 || HighERatio > 2) {
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }

        if (LowERatio < 0.5 || LowERatio > 1) {
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }


        if (ratio < 0.96f || ratio > 0.99f) {
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }

        float stepCheck = MathTool.getFormatValue(ratio - 0.96f, 2);
        while (stepCheck > 0) {
            stepCheck -= 0.01;
            stepCheck = MathTool.getFormatValue(stepCheck, 2);
        }
        if (stepCheck < 0) {
            return CODE_ERROR_RATIO;
        }

        //下浮系数检查
        stepCheck = controlRatio - 0.005f;
        stepCheck = MathTool.getFormatValue(stepCheck, 3);
        while (stepCheck > 0) {
            stepCheck -= 0.005f;
            stepCheck = MathTool.getFormatValue(stepCheck, 3);
        }
        if (stepCheck < 0) {
            return CODE_ERROR_RATIO;
        }
        return CODE_OK;
    }

    private int calcuScore(List<Tender> tenders) {
        for (Tender tender : tenders
                ) {
            BigDecimal deviationValue = MathTool.abs(tender.getPrice().subtract(benchmarkPrice)).divide(benchmarkPrice, 6, BigDecimal.ROUND_HALF_UP);
            tender.setDeviationValue(deviationValue.floatValue());
            float E = LowERatio;
            //有效评标价＞评标基准价时’E取1～2
            if (tender.getPrice().compareTo(benchmarkPrice) > 0) {
                E = HighERatio;
            }
            tender.setScore(MathTool.getFormatValue(100 - 100 * E * tender.getDeviationValue(), 3));
        }
        return CODE_OK;
    }


    public BigDecimal getBenchmarkPrice() {
        return benchmarkPrice;
    }

    public BigDecimal getReasonableCostPrice() {
        return reasonableCostPrice;
    }

    public BigDecimal getFinalControlPrice() {
        return finalControlPrice;
    }
}
