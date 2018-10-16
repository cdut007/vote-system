package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.Query;

import com.vote.ms.dao.ParticipantDao;
import com.vote.ms.entity.ParticipantEntity;
import com.vote.ms.service.ParticipantService;


@Service("participantService")
public class ParticipantServiceImpl extends ServiceImpl<ParticipantDao, ParticipantEntity> implements ParticipantService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ParticipantEntity> page = this.selectPage(
                new Query<ParticipantEntity>(params).getPage(),
                new EntityWrapper<ParticipantEntity>()
        );

        return new PageUtils(page);
    }

}
