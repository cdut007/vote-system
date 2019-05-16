package com.bank.guarantee.ms.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ActivityDao;
import com.bank.guarantee.ms.entity.ActivityEntity;
import com.bank.guarantee.ms.service.ActivityService;


@Service("activityService")
public class ActivityServiceImpl extends ServiceImpl<ActivityDao, ActivityEntity> implements ActivityService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {

        Query<ActivityEntity> activityEntityQuery = new Query<ActivityEntity>(params);
        String subject = (String)params.get("subject");
        if(params.get("createrId") != null){
            HashMap<String,Object> filterParams = new HashMap<>();
            filterParams.put("creater_id",params.get("createrId"));
            activityEntityQuery.getPage().setCondition(filterParams);
        }
        Page<ActivityEntity> page = this.selectPage(activityEntityQuery.getPage(),
                new EntityWrapper<ActivityEntity>().like(StringUtils.isNotBlank(subject),"subject", subject)
        );

        return new PageUtils(page);
    }

}
