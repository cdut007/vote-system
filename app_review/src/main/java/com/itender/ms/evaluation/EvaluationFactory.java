package com.itender.ms.evaluation;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class EvaluationFactory {
   private static final HashMap<Integer,String> codeMsgMap = new HashMap<>();
    static {
        codeMsgMap.put(IEvaluation.CODE_OK,"计算成功");
        codeMsgMap.put(IEvaluation.CODE_ERROR_RATIO,"系数校验不对，请检查抽取系数");
        codeMsgMap.put(IEvaluation.CODE_ERROR_UNKONWN,"未知错误");
    }

    public static String getMsgByCode(int code){
        return codeMsgMap.get(code);
    }

  public static final  int TYPE_BUILDING = 0x01;

  public static final  int TYPE_TRAFFIC= 0x02;

    public static IEvaluation createEvalution(int catagory, int strategyType){
        IEvaluation evalution = null;
        switch(catagory){
            case TYPE_BUILDING:
                evalution = BuildingEvaluation.createEvalution(strategyType);
                break;
            case TYPE_TRAFFIC:
                evalution = TrafficEvaluation.createEvalution(strategyType);
                break;
            default:
                evalution = null;
        }
        return evalution;
    }

    public static List<Tender> getTenderListByValidStatus(List<Tender> tenders, boolean valid) {

        List<Tender> validList = new ArrayList<>();
        for (Tender tender:tenders
                ) {
            if(tender.isKickout() != valid){
                validList.add(tender);
            }

        }
        return validList;
    }
    public static List<BigDecimal> covertTendersToPriceList(List<Tender> tenders){
        List<BigDecimal> priceList = new ArrayList<>();
        for (Tender tender:tenders
             ) {
            priceList.add(tender.getPrice());
        }
        return priceList;
    }




    public static void main(String[] args) {


        IEvaluation evalution = EvaluationFactory.createEvalution(TYPE_TRAFFIC,TrafficEvaluation.TYPE_LOW_PRICE);

        ReasonableLowPriceTrafficEvaluation reasonableLowPriceTrafficEvalution = (ReasonableLowPriceTrafficEvaluation) evalution;

        reasonableLowPriceTrafficEvalution.setControlPriceAndRatio(new BigDecimal(71000000),0.03f);
        reasonableLowPriceTrafficEvalution.setRatiosAndBenchmarkMethod(0.99f,0.4f,1);
        reasonableLowPriceTrafficEvalution.setHighERatio(2f);
        reasonableLowPriceTrafficEvalution.setLowERatio(1f);

        List<Tender> tenders = new ArrayList<>();
        Tender tender = new Tender();
        tender.setId("1");
        tender.setPrice(new BigDecimal(65840000));
        tenders.add(tender);
        tender = new Tender();
        tender.setId("2");
        tender.setPrice(new BigDecimal(64750000));
        tenders.add(tender);
        tender = new Tender();
        tender.setId("3");
        tender.setPrice(new BigDecimal(69850000));
        tenders.add(tender);

       int code = reasonableLowPriceTrafficEvalution.calculate(tenders);
        System.out.println("code="+code);
        System.out.println("getFinalControlPrice="+reasonableLowPriceTrafficEvalution.getFinalControlPrice());
        System.out.println("getReasonableCostPrice="+reasonableLowPriceTrafficEvalution.getReasonableCostPrice());
        System.out.println("getBenchmarkPrice="+reasonableLowPriceTrafficEvalution.getBenchmarkPrice());
        Collections.sort(tenders);
        System.out.println(tenders.toString());

    }


}
