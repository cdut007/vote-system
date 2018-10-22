package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.Query;

import com.vote.ms.dao.VoteItemDao;
import com.vote.ms.entity.VoteItemEntity;
import com.vote.ms.service.VoteItemService;


@Service("voteItemService")
public class VoteItemServiceImpl extends ServiceImpl<VoteItemDao, VoteItemEntity> implements VoteItemService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Query<VoteItemEntity> voteItemEntityQuery = new Query<VoteItemEntity>(params);
        if(params.get("activityId") != null){
            HashMap<String,Object> filterParams = new HashMap<>();
            filterParams.put("activity_id",params.get("activityId"));
            if(params.get("playerId")!=null){
                filterParams.put("player_id",params.get("playerId"));
            }

            voteItemEntityQuery.getPage().setCondition(filterParams);
        }
        Page<VoteItemEntity> page = this.selectPage(
                voteItemEntityQuery.getPage(),
                new EntityWrapper<VoteItemEntity>()
        );

        return new PageUtils(page);
    }

}
