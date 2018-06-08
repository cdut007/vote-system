package com.itender.ms.evaluation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

//合理低价法
public class ReasonableLowPriceBuildingEvaluation extends BuildingEvaluation {
    private Logger logger = LoggerFactory.getLogger(getClass());


    //系数
    protected float ratio, weightedRatio, controlRatio;


    private int benchmarkMethod;
    private BigDecimal benchmarkPrice;
    private BigDecimal reasonableCostPrice;
    //最高投标限价
    private BigDecimal finalControlPrice;


    //二、投标报价评审（55分）
    //（一）理论成本评审
    //投标报价出现低于下列指标之一的，启动理论成本评审，判定投标报价是否低于理论成本，低于理论成本的投标将被否绝。
    //        1、投标报价低于最高投标限价总价85%的；
    //        2、投标报价的分部分项工程费合价低于最高投标限价分部分项工程费合价85%的；
    //        3、投标报价的措施项目费合价低于最高投标限价措施项目费合价70%的。
    //        4、评标委员会一致认为投标报价明显低于其他投标报价的。
    //判定方法：投标报价分部分项工程费中人、材、机合价和措施项目费中人、材、机合价之和减去最高投标限价相对应的人、材、机合价之和的差值记为M，M为负值且│M│大于投标报价利润的，判定为低于其理论成本。
    //（二）评标基准价合成范围确定（合理性评审 ）
    //    当投标人≥5家时，去掉投标报价总价最高的20%家数（四舍五入取整）和最低的20%家（四舍五入取整）后进行算术平均；当投标人＜5家时，则全部投标报价总价进行算术平均。算术平均值下浮一定比例作为参加评标基准价合成和评标的合理最低价。
    //    房屋建筑下浮范围为3%～6%，市政工程下浮范围为3%～8%。招标人可以在招标文件中明确下浮率，也可以在开标时随机抽取（下浮率取整）。
    //低于合理最低价的投标报价不再参加评标基准价的合成，低于理论成本指标的进行理论成本评审。
    //（三）评标基准价合成
    //1、评标基准价＝施工组织设计评分第一的投标报价×15%＋施工组织设计评分第二的投标报价×10%＋资信评分第一的投标报价×15%＋资信评分第二的投标报价×5%＋其他合成范围内所有投标报价的算术平均值×55%（先评审技术标和资信标，并列的报价低的排序在前）。
    //2、评标基准价=最高投标限价×权重+合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算数平均值×权重。
    //    权重为最高投标限价占70%、60%、50%，有效投标报价的算术平均值占30%、40%、50%。参与评标基准价合成的投标报价家数和权重现场由评标委员会代表随机抽取确定。
    //3、评标基准价=合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算术平均值。
    //招标人可根据具体工程选择适当的评标基准价合成方法并在招标文件中载明。
    //4、偏差率
    //偏差率=│投标人报价－评标基准价│/评标基准价×100%
    //（四）投标报价得分
    //投标报价得分=55-偏差率×100
    public void setControlPriceAndRatio(BigDecimal controlPrice, float controlRatio) {
        this.controlRatio = controlRatio;//下浮系数

        this.finalControlPrice = controlPrice;

    }

    @Override
    public BigDecimal getFinalControlPrice() {
        return finalControlPrice;
    }

    @Override
    public BigDecimal getBenchmarkPrice() {
        return benchmarkPrice;
    }

    @Override
    public BigDecimal getReasonableCostPrice() {
        return reasonableCostPrice;
    }


    //评标基准价基础参数设置
    public void setRatiosAndBenchmarkMethod(float ratio, float weightedRatio, int strategySubType) {
        this.ratio = ratio;
        this.weightedRatio = weightedRatio;
        this.benchmarkMethod = strategySubType;
    }

    protected int checkReasonableCostPrice(List<Tender> tenders) {

        for (Tender tender : tenders
                ) {
             if(tender.getSkillScore()>25 || tender.getCreditScore()>20){
                 logger.info(errMsg="施工组织设计不超过25分,投标人资信不超过20分");
                 return CODE_ERROR_RATIO;
             }
        }

        //    当投标人≥5家时，去掉投标报价总价最高的20%家数（四舍五入取整）和最低的20%家（四舍五入取整）后进行算术平均；当投标人＜5家时，则全部投标报价总价进行算术平均。算术平均值下浮一定比例作为参加评标基准价合成和评标的合理最低价。
        //    房屋建筑下浮范围为3%～6%，市政工程下浮范围为3%～8%。招标人可以在招标文件中明确下浮率，也可以在开标时随机抽取（下浮率取整）。
        //低于合理最低价的投标报价不再参加评标基准价的合成，低于理论成本指标的进行理论成本评审。

        if (tenders.size() >= 5) {
            int skipSize = (int) (tenders.size() / 5f + 0.5);

            // 去掉20%最低报价
            for (int i = 0; i < skipSize; i++) {
                tenders.remove(0);
            }

            // 去掉20%最高报价
            for (int i = 0; i < skipSize; i++) {
                tenders.remove(tenders.size() - 1);
            }

        }

        reasonableCostPrice = MathTool.avg1(EvaluationFactory.covertTendersToPriceList(tenders));
        reasonableCostPrice = reasonableCostPrice.multiply(new BigDecimal(1 - ratio));
        reasonableCostPrice = MathTool.getFormatValue(reasonableCostPrice, 3);
        return CODE_OK;
    }

    @Override
    public int calculate(List<Tender> tenders) {
        int code = super.calculate(tenders);
        if (code != CODE_OK) {
            return code;
        }


        code = checkReasonableCostPrice(new ArrayList<>(tenders));
        if (code != CODE_OK) {
            return code;
        }
        //1 检查
        if (benchmarkMethod == benchmark_method_1) {
            code = calculateByMethod1(tenders);
        } else if (benchmarkMethod == benchmark_method_2) {
            code = calculateByMethod2(tenders);
        } else if (benchmarkMethod == benchmark_method_3) {
            code = calculateByMethod3(tenders);
        }

        return code;
    }


    private String errMsg;

    @Override
    public String getErrorMsg() {
        return errMsg;
    }

    @Override
    public int calculateByMethod2(List<Tender> tenders) {
        int code = checkRatio2();
        if (code != CODE_OK) {
            return code;
        }
        List<Tender> checkTenders = new ArrayList<>(tenders);

        benchmarkPrice = calcuBenchMark2(checkTenders);

        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);
        return CODE_OK;
    }


    private BigDecimal calcuBenchMark2(List<Tender> tenders) {
        //2、评标基准价=最高投标限价×权重+合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算数平均值×权重。
        //    权重为最高投标限价占70%、60%、50%，有效投标报价的算术平均值占30%、40%、50%。参与评标基准价合成的投标报价家数和权重现场由评标委员会代表随机抽取确定。

        BigDecimal benchmarkPrice = finalControlPrice.multiply(new BigDecimal(weightedRatio)).add(calcuBenchMark3(tenders).multiply(new BigDecimal(ratio)));
        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }

    @Override
    public int calculateByMethod3(List<Tender> tenders) {

        List<Tender> checkTenders = new ArrayList<>(tenders);

        benchmarkPrice = calcuBenchMark3(checkTenders);

        //评标价得分＝100—100×E× ｜评标价ˉ评标基准价｜／评标基准价
        calcuScore(tenders);
        return CODE_OK;
    }

    private int checkRatio2() {
        if (weightedRatio != 0.7f && weightedRatio != 0.6f && weightedRatio != 0.5f) {
            logger.info(errMsg="加权系数不对,应为0.7， 0.6 ，0.5");
            return CODE_ERROR_RATIO;//加权系数不对
        }


        if (ratio != 0.3f && ratio != 0.4f && ratio != 0.5f) {
            logger.info(errMsg="评标基准价系数不对,应为0.3， 0.4 ，0.5");
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }

        if (weightedRatio + ratio != 1.0f) {
            logger.info(errMsg="评标基准价系数和加权系数之和应为1");
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }
        return CODE_OK;
    }


    private BigDecimal calcuBenchMark3(List<Tender> tenders) {
        //3、评标基准价=合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算术平均值。
        //招标人可根据具体工程选择适当的评标基准价合成方法并在招标文件中载明。
        for (int i = tenders.size() - 1; i >= 0; i--) {
            if (reasonableCostPrice.compareTo(tenders.get(i).getPrice()) > 0) {
                Tender tender = tenders.remove(i);
                logger.info("低于合成理论成本价=================：" + tender.toString());
            }
        }

        if (tenders.size() > 9) {
            //随机，先取前9家
            tenders = tenders.subList(0, 9);
        }

        if (tenders.size() == 9) {
            tenders.remove(0);
            tenders.remove(tenders.size() - 1);
        }

        BigDecimal benchmarkPrice = MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(tenders));

        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }


    @Override
    public int calculateByMethod1(List<Tender> tenders) {
        //检查系数
        int code = checkRatio();
        if (code != CODE_OK) {
            return code;
        }
        //检查投标报价
        List<Tender> checkTenders = new ArrayList<>(tenders);

        //计算基准价
        benchmarkPrice = calcuBenchMark(checkTenders);
        logger.info("基准价1=================：" + benchmarkPrice);

        calcuScore(tenders);

        return CODE_OK;
    }

    private BigDecimal calcuBenchMark(List<Tender> tenders) {

        //1、评标基准价＝施工组织设计评分第一的投标报价×15%
        // ＋施工组织设计评分第二的投标报价×10%
        // ＋资信评分第一的投标报价×15%
        // ＋资信评分第二的投标报价×5%
        // ＋其他合成范围内所有投标报价的算术平均值×55%（先评审技术标和资信标，并列的报价低的排序在前）。
        Collections.sort(tenders, new Comparator<Tender>() {
            @Override
            public int compare(Tender o1, Tender o2) {
                float less = o1.getSkillScore() - o2.getSkillScore();
                if (less < 0) {
                    return 1;
                } else if (less > 0) {
                    return -1;
                }
                return 0;
            }
        });
        BigDecimal benchmarkPrice = tenders.get(0).setTag("del").getPrice().multiply(new BigDecimal(0.15f));
        benchmarkPrice = benchmarkPrice.add(tenders.get(1).setTag("del").getPrice().multiply(new BigDecimal(0.1f)));

        Collections.sort(tenders);

        Collections.sort(tenders, new Comparator<Tender>() {
            @Override
            public int compare(Tender o1, Tender o2) {
                float less = o1.getCreditScore() - o2.getCreditScore();
                if (less < 0) {
                    return 1;
                } else if (less > 0) {
                    return -1;
                }
                return 0;
            }
        });


        benchmarkPrice = benchmarkPrice.add(tenders.get(0).setTag("del").getPrice().multiply(new BigDecimal(0.15f)));
        benchmarkPrice = benchmarkPrice.add(tenders.get(1).setTag("del").getPrice().multiply(new BigDecimal(0.05f)));


        for (int i = tenders.size() - 1; i >= 0; i--) {
            if ("del".equals(tenders.get(i).getTag())) {
                Tender tender = tenders.remove(i);
                logger.info("标记删除=================：" + tender.toString());
            } else {
                if (reasonableCostPrice.compareTo(tenders.get(i).getPrice()) > 0) {
                    Tender tender = tenders.remove(i);
                    logger.info("低于理论成本价=================：" + tender.toString());
                }
            }

        }

        if (!tenders.isEmpty()) {
            benchmarkPrice = benchmarkPrice.add(MathTool.avgBigDecimal(EvaluationFactory.covertTendersToPriceList(tenders)).multiply(new BigDecimal(0.55f)));
        }


        benchmarkPrice = MathTool.getFormatValue(benchmarkPrice, 3);
        return benchmarkPrice;
    }


    protected int checkControlRatio() {
        if (controlRatio < 0.03f || controlRatio > 0.06f) {
            return CODE_ERROR_RATIO;//评标基准价系数不对
        }

        float stepCheck = MathTool.getFormatValue(controlRatio - 0.03f, 2);
        while (stepCheck > 0) {
            stepCheck -= 0.01;
            stepCheck = MathTool.getFormatValue(stepCheck, 2);
        }
        if (stepCheck < 0) {
            return CODE_ERROR_RATIO;
        }

        return CODE_OK;
    }

    private int checkRatio() {
        // 下浮范围为3%～6%，市政工程下浮范围为3%～8% 权重为最高投标限价占70%、60%、50%，有效投标报价的算术平均值占30%、40%、50%


        int code = checkControlRatio();

        if (code != CODE_OK) {
            return code;
        }


        return CODE_OK;
    }

    private int calcuScore(List<Tender> tenders) {

        //4、偏差率
        //偏差率=│投标人报价－评标基准价│/评标基准价×100%
        //（四）投标报价得分
        //投标报价得分=55-偏差率×100

        for (Tender tender : tenders
                ) {
            BigDecimal deviationValue = MathTool.abs(tender.getPrice().subtract(benchmarkPrice)).divide(benchmarkPrice, 6, BigDecimal.ROUND_HALF_UP);
            tender.setDeviationValue(MathTool.getFormatValue(deviationValue.floatValue(), 4));
            tender.setScore(tender.getSkillScore()+tender.getCreditScore()+55 - 100 * MathTool.getFormatValue(deviationValue.floatValue(), 3));
        }
        return CODE_OK;
    }


}
