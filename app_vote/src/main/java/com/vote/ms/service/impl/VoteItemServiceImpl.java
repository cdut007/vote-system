package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;
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
        Page<VoteItemEntity> page = this.selectPage(
                new Query<VoteItemEntity>(params).getPage(),
                new EntityWrapper<VoteItemEntity>()
        );

        return new PageUtils(page);
    }

}
