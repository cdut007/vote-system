package com.itender.ms.evaluation;

import java.util.List;

public interface IEvaluation {
    public  int calculate(List<Tender> tenders);

    public static final int CODE_ERROR_UNKONWN = -1003;

    public static final int CODE_ERROR_RATIO = -1001;

    public static final int CODE_OK = 0;



}
