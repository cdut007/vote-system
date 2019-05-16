package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.GiftItemDao;
import com.bank.guarantee.ms.entity.GiftItemEntity;
import com.bank.guarantee.ms.service.GiftItemService;


@Service("giftItemService")
public class GiftItemServiceImpl extends ServiceImpl<GiftItemDao, GiftItemEntity> implements GiftItemService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Query<GiftItemEntity> giftItemEntityQuery = new Query<GiftItemEntity>(params);
        if(params.get("activityId") != null){
            HashMap<String,Object> filterParams = new HashMap<>();
            filterParams.put("activity_id",params.get("activityId"));
            giftItemEntityQuery.getPage().setCondition(filterParams);
        }
        Page<GiftItemEntity> page = this.selectPage(giftItemEntityQuery.getPage(),
                new EntityWrapper<GiftItemEntity>()
        );

        return new PageUtils(page);
    }

}
