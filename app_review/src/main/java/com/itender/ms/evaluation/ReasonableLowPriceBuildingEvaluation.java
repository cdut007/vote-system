package com.itender.ms.evaluation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

//合理低价法
public class ReasonableLowPriceBuildingEvaluation extends TrafficEvaluation {
    private Logger logger = LoggerFactory.getLogger(getClass());


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

    private int selectedNum;

    public int getSelectedNum() {
        return selectedNum;
    }

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
        this.finalControlPrice = controlPrice.multiply(MathTool.getFormatValue(new BigDecimal(ratio), 3));
        this.finalControlPrice = MathTool.getFormatValue(this.finalControlPrice, 2);
    }

    //评标基准价基础参数设置
    public void setRatiosAndBenchmarkMethod(float ratio, float weightedRatio, int strategySubType) {
        this.ratio = ratio;
        this.weightedRatio = weightedRatio;
        this.benchmarkMethod = strategySubType;
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
            case benchmark_method_2:
                code = calculateByMethod2(tenders);
                break;
            case benchmark_method_3:
                code = calculateByMethod3(tenders);
                break;
            default:

        }

        return code;
    }


    private String errMsg;
    @Override
    public String getErrorMsg() {
        return errMsg;
    }

    private int calculateByMethod2(List<Tender> tenders) {
        int code = checkRatio3();
        if (code != CODE_OK) {
            return code;
        }
        List<Tender> checkTenders = new ArrayList<>(tenders);
        code = checkTenderPrice(checkTenders);
        if (code != CODE_OK) {
            return code;
        }
        checkTenders = EvaluationFactory.getTenderListByValidStatus(tenders, true);
        logger.info("当前有效的投标家数=================：" + checkTenders.size());
        if (checkTenders.size() < 2) {
            logger.info(errMsg="当前有效评标价不够两家，无法进行等差区间运算");
            return CODE_ERROR_SELECT_CONDITION;
        }
        BigDecimal B_Vaule = calcuBValue(checkTenders);
        logger.info("当前b值=================：" + B_Vaule);
        benchmarkPrice = calcuBenchMark2(B_Vaule);

        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);
        return CODE_OK;
    }

    private BigDecimal calcuBValue(List<Tender> validTenders) {
        //从高到低划分为5个等差报价区
        //间’对各区间的评标价进行算术平均值计算（“四舍五入’’保留小
        //数点后两位’当评标价等于区间临界值时’列入较高一个区间计算
        //平均值’最高评标价不参与区间计算）’然后再将各区间的算术平
        //均值（非零）进行第二次算术平均值计算’所得数值即为B值
        Collections.sort(validTenders);


        //获得等差基数 - 5个等差区间
        BigDecimal basePrice = validTenders.get(0).getPrice();
        BigDecimal skip = (validTenders.get(validTenders.size() - 1).getPrice().subtract(basePrice)).divide(new BigDecimal(5));
        List<List<BigDecimal>> avgSkipList = new ArrayList<List<BigDecimal>>();

        //最高投标价格不参与计算
        validTenders.remove(validTenders.size() - 1);

        for (int i = 0; i < 5; i++) {
            List<BigDecimal> sectionList = new ArrayList<BigDecimal>();
            int index = 0;
            for (Tender tender : validTenders) {
                if (tender.getPrice().compareTo(basePrice.add(new BigDecimal(i).multiply(skip))) >= 0 && tender.getPrice().compareTo(basePrice.add(new BigDecimal(i + 1).multiply(skip))) < 0) {
                    sectionList.add(tender.getPrice());
                } else if (i == 4 && index == validTenders.size() - 1) {
                    //最后一个区段
                }
                index++;
            }
            if (sectionList.size() > 0) {
                avgSkipList.add(sectionList);
            }

        }

        List<BigDecimal> avgList = new ArrayList<BigDecimal>();

        for (List<BigDecimal> sectionList : avgSkipList) {
            avgList.add(MathTool.avg1(sectionList));
        }

        if(avgList.isEmpty()){
            return  basePrice;
        }

        BigDecimal b = MathTool.avg1(avgList);

        return MathTool.getFormatValue(b, 2);

    }

    private BigDecimal calcuBenchMark2(BigDecimal B_Vaule) {
        //评标基准价＝B× （1—k）

        float deltaRatio = 1 - ratio;
        BigDecimal benchmarkPrice = B_Vaule.multiply(MathTool.getFormatValue(new BigDecimal(deltaRatio), 3));
        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }

    private int calculateByMethod3(List<Tender> tenders) {
        int code = checkRatio3();
        if (code != CODE_OK) {
            return code;
        }
        List<Tender> checkTenders = new ArrayList<>(tenders);
        code = checkTenderPrice(checkTenders);
        if (code != CODE_OK) {
            return code;
        }

        checkTenders = EvaluationFactory.getTenderListByValidStatus(tenders, true);
        logger.info("当前有效的投标家数=================：" + checkTenders.size());
        code = checkTenderPrice3(checkTenders);
        if (code != CODE_OK) {
            return code;
        }
        //评标基准价＝评标价平均值×（1ˉk）
        //计算基准价
        benchmarkPrice = calcuBenchMark3(checkTenders);
        logger.info("基准价3=================：" + benchmarkPrice);

        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);

        return CODE_OK;
    }

    private int checkRatio3() {
        if (ratio < 0.005f || ratio > 0.03f) {
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }

        //下浮系数检查
        float stepCheck = ratio - 0.005f;
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

    private int checkTenderPrice3(List<Tender> tenders) {
        //（1）有效投标人数量在10（含）以内时’随机抽取50％数量’
        //但不小于3个;
        //（2）有效投标人数量在l0～20（含）时’随机抽取40％数量’
        //但不小于6个;
        //（3）有效投标人数量大于20时’随机抽取30％数量’但不小
        //于9个。
        //检查投标报价
        List<Tender> selectedTenders = new ArrayList<>();
        for (Tender tender : tenders
                ) {
            if (tender.isSelected()) {
                selectedTenders.add(tender);
            }
        }
        int tendersSize = tenders.size();
        int checkLen, minLen;
        if (tendersSize <= 10) {
            minLen = 3;
            checkLen = (int) (tendersSize * 0.5f);
        } else if (tendersSize > 10 && tendersSize <= 20) {
            checkLen = (int) (tendersSize * 0.4f);
            minLen = 6;
        } else {
            checkLen = (int) (tendersSize * 0.3f);
            minLen = 9;
        }

        int selectedSize = selectedTenders.size();
        logger.info("当前抽中的投标家数=================：" + selectedSize);
        logger.info("当前至少需要抽取的投标家数=================：" + minLen);
        logger.info("当前需要抽的投标家数=================：" + Math.max(minLen, checkLen));
        if (selectedSize < minLen) {
            selectedNum = minLen;
            logger.info(errMsg="应抽取参与评标基准价计算单位数量为"+selectedNum);

            return CODE_ERROR_SELECT_CONDITION;
        }

        if (selectedSize != checkLen && checkLen > minLen) {
            selectedNum = checkLen;
            logger.info(errMsg="应抽取参与评标基准价计算单位数量为"+selectedNum);
            return CODE_ERROR_SELECT_CONDITION;
        }


        return CODE_OK;
    }

    private BigDecimal calcuBenchMark3(List<Tender> tenders) {
        BigDecimal avgValidTenderPrice = new BigDecimal(0);
        if (!tenders.isEmpty()) {
            avgValidTenderPrice = MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(tenders));
        }

        float deltaRatio = 1 - ratio;
        BigDecimal benchmarkPrice = avgValidTenderPrice.multiply(MathTool.getFormatValue(new BigDecimal(deltaRatio), 3));
        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
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
        List<Tender> checkTenders = new ArrayList<>(tenders);
        code = checkTenderPrice(checkTenders);
        if (code != CODE_OK) {
            return code;
        }

        checkTenders = EvaluationFactory.getTenderListByValidStatus(tenders, true);

        if (checkTenders.size() > 5) {
            Tender tenderTop = tenders.remove(tenders.size() - 1);
            logger.info("有效评标价=================去掉最高投标：" + tenderTop.toString());
            Tender tenderLow = tenders.remove(0);
            logger.info("有效评标价=================去掉最低投标：" + tenderLow.toString());

        }

        //计算基准价
        benchmarkPrice = calcuBenchMark(checkTenders);
        logger.info("基准价1=================：" + benchmarkPrice);

        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);

        return CODE_OK;
    }

    private BigDecimal calcuBenchMark(List<Tender> tenders) {
        BigDecimal avgValidTenderPrice = new BigDecimal(0);
        if (!tenders.isEmpty()) {
            avgValidTenderPrice = MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(tenders));
        }

        float deltaRatio = 1 - weightedRatio;
        BigDecimal benchmarkPrice = finalControlPrice.multiply(MathTool.getFormatValue(new BigDecimal(weightedRatio), 3)).add(avgValidTenderPrice.multiply(MathTool.getFormatValue(new BigDecimal(deltaRatio), 3)));
        benchmarkPrice = benchmarkPrice.multiply(MathTool.getFormatValue(new BigDecimal(this.ratio), 3));
        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }

    private int checkTenderPrice(List<Tender> tenders) {
        //评标价检查,当评标价有5个及以上时’应去掉其中的最高值和最低值’再
        //进行算术平均值计算·评标价低于理论成本价的’不再参与后续计算。
        List<Tender> checkTenders = new ArrayList<>(tenders);
        if (checkTenders.size() >= 5) {
            Collections.sort(checkTenders);
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
        logger.info("=================理论成本价：" + reasonableCostPrice);
        //有效评标价指介于理论成本价（含）与最终最高投标限价（含）
        //范围内的评标价. 当有效评标价数量大于5时’可去掉其中的最高
        //和最低值’再进行算术平均值计算

        for (int i = tenders.size() - 1; i >= 0; i--) {
            Tender tender = tenders.get(i);
            if (tender.getPrice().compareTo(reasonableCostPrice) < 0 || tender.getPrice().compareTo(finalControlPrice) > 0) {
                tender.setKickout(true);
                logger.info("有效评标价=================去掉不满足条件投标：" + tender.toString());
            }
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

        if (controlRatio < 0.005f || controlRatio > 0.03f) {
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
            tender.setDeviationValue(MathTool.getFormatValue(deviationValue.floatValue(),4));
            float E = LowERatio;
            //有效评标价＞评标基准价时’E取1～2
            if (tender.getPrice().compareTo(benchmarkPrice) > 0) {
                E = HighERatio;
            }
            tender.setScore(MathTool.getFormatValue(100 - 100 * E * deviationValue.floatValue(), 3));
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
