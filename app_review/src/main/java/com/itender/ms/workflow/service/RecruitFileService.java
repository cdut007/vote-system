package com.itender.ms.workflow.service;

import com.mhb.project.entity.TBRecruitFile;
import org.springframework.stereotype.Service;

@Service
public class RecruitFileService {

    public TBRecruitFile findRecruitFile(String projectItemId) {
          return  new TBRecruitFile();
    }


    public String findEvaluationMethodId(String id) {
        return id;
    }

    public boolean needBenchMark_fj(String projectItemId, String expertApplyId) {
        return false;
    }



    public boolean needBenchMark(String projectItemId, String expertApplyId, String envelopeTypeOrder) {
        return false;
    }
}
