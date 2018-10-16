package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.Query;

import com.vote.ms.dao.VoterDao;
import com.vote.ms.entity.VoterEntity;
import com.vote.ms.service.VoterService;


@Service("voterService")
public class VoterServiceImpl extends ServiceImpl<VoterDao, VoterEntity> implements VoterService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<VoterEntity> page = this.selectPage(
                new Query<VoterEntity>(params).getPage(),
                new EntityWrapper<VoterEntity>()
        );

        return new PageUtils(page);
    }

}
