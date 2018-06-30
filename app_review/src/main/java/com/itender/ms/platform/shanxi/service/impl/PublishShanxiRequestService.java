package com.itender.ms.platform.shanxi.service.impl;

import com.itender.ms.platform.Config;
import com.itender.ms.platform.shanxi.GCJSCONTRACTPERFORMANCE;
import com.itender.ms.platform.webservice.Result;
import com.itender.ms.platform.webservice.ServiceClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class PublishShanxiRequestService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 合同与履约
     */
    public Result transferContractPerformance(String platId, GCJSCONTRACTPERFORMANCE cpws) {
        {

            Result result;
            ServiceClient client;
            boolean success = false;
            String msg = null;
            try {
                client = new ServiceClient(Config.getAddress(), Config.getAppKey(), Config.getAppSecerety());
                 result = client.receiveInfo(Config.getPlatfromSerialNumber(), "GCJS_CONTRACT_PERFORMANCE",
                        cpws, platId, Config.getJCPlatformCreditCode());
                success = result.isSuccess();
                msg = result.getErrorMessage();
                this.logger.info("提交【保存合同与履约实体: " + cpws.getCONTRACTNAME() + "】到公共服务平台" + (success ? "成功" : "失败") + "！&& msg: " + msg);

            } catch (Exception e) {
                 result =new Result();
                result.setSuccess(false);
                result.setErrorCode("-1001");
                result.setErrorMessage(e.getMessage());
                logger.error(e.getMessage(), e);
            }
            return result;
        }
    }


}
