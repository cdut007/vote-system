package com.itender.ms.workflow.service;

import com.mhb.project.entity.TBExpert;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    public List<String> retrieveGuardianIdSignByItem(String projectItemId) {
        return new ArrayList<>();
    }

    public List<String> retrieveTenderUserIdDecode(String expertApplyId) {
        return new ArrayList<>();
    }


    public List<TBExpert> retrieveExpertSign(String expertApplyId) {
        return new ArrayList<>();
    }

    public List<String> retrieveTenderUserIdDecodeAfterFirst(String expertApplyId, String projectItemId) {

        return new ArrayList<>();
    }

    public List<String> retrieveExpertIdSign(String expertApplyId) {
        return new ArrayList<>();
    }

    public List<String> retrieveTenderUserIdSign(String expertApplyId) {
        return new ArrayList<>();
    }

}
