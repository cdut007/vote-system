package com.itender.ms.evaluation;

import java.util.List;

public abstract class BuildingEvaluation implements IEvaluation {


    public static final  int TYPE_LOW_PRICE = 0x01;

    public static IEvaluation createEvalution(int strategyType){
        IEvaluation evalution = null;
        switch(strategyType){
            case TYPE_LOW_PRICE:
                evalution = new ReasonableLowPriceBuildingEvaluation();
                break;

            default:
                evalution = null;
        }
        return evalution;
    }

    @Override
    public int calculate(List<Tender> tenders) {
        //检查是否有重复的id
        return CODE_OK;
    }
}
