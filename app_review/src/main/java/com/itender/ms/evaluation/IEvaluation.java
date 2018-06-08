package com.itender.ms.evaluation;

import java.math.BigDecimal;
import java.util.List;

public interface IEvaluation {
    public  int calculate(List<Tender> tenders);


    public static final int CODE_ERROR_SCORE = -1005;

    public static final int CODE_ERROR_UNKONWN = -1003;

    public static final int CODE_ERROR_RATIO = -1001;

    public static final int CODE_ERROR_SELECT_CONDITION = -1002;

    public static final int CODE_ERROR_BID = -1004;//一般不足三家

    public static final int CODE_OK = 0;


    public String getErrorMsg();


    public static final int benchmark_method_1 = 0x01;
    public static final int benchmark_method_2 = 0x02;
    public static final int benchmark_method_3 = 0x03;


    public BigDecimal getFinalControlPrice();


    public BigDecimal getBenchmarkPrice();

    public BigDecimal getReasonableCostPrice();


}
