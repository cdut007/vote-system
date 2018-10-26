package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.Query;

import com.vote.ms.dao.ActivityDao;
import com.vote.ms.entity.ActivityEntity;
import com.vote.ms.service.ActivityService;


@Service("activityService")
public class ActivityServiceImpl extends ServiceImpl<ActivityDao, ActivityEntity> implements ActivityService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {

        Query<ActivityEntity> activityEntityQuery = new Query<ActivityEntity>(params);
        if(params.get("createrId") != null){
            HashMap<String,Object> filterParams = new HashMap<>();
            filterParams.put("creater_id",params.get("createrId"));
            activityEntityQuery.getPage().setCondition(filterParams);
        }
        Page<ActivityEntity> page = this.selectPage(activityEntityQuery.getPage(),
                new EntityWrapper<ActivityEntity>()
        );

        return new PageUtils(page);
    }

}
