package com.itender.ms.evaluation;

import java.math.BigDecimal;
import java.util.List;

public interface IReasonableLowPriceEvaluation {

    public int calculateByMethod1(List<Tender> tenders);

    public int calculateByMethod2(List<Tender> tenders);

    public int calculateByMethod3(List<Tender> tenders);


}
