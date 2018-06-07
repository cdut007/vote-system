package com.itender.ms.evaluation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

//合理低价法
public class ReasonableLowPriceMunicipalEvaluation extends ReasonableLowPriceBuildingEvaluation {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    protected int checkControlRatio() {
         super.checkControlRatio();
        if (controlRatio < 0.03f || controlRatio > 0.08f) {
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
}
