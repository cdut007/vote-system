package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ParticipantDao;
import com.bank.guarantee.ms.entity.ParticipantEntity;
import com.bank.guarantee.ms.service.ParticipantService;


@Service("participantService")
public class ParticipantServiceImpl extends ServiceImpl<ParticipantDao, ParticipantEntity> implements ParticipantService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Query<ParticipantEntity> participantEntityQuery = new Query<ParticipantEntity>(params);
        if(params.get("activityId") != null){
            HashMap<String,Object> filterParams = new HashMap<>();
            filterParams.put("activity_id",params.get("activityId"));
            participantEntityQuery.getPage().setCondition(filterParams);
        }

        Page<ParticipantEntity> page = this.selectPage(
                participantEntityQuery.getPage(),
                new EntityWrapper<ParticipantEntity>()
        );

        return new PageUtils(page);
    }

}
