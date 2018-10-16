package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.Query;

import com.vote.ms.dao.CoverDao;
import com.vote.ms.entity.CoverEntity;
import com.vote.ms.service.CoverService;


@Service("coverService")
public class CoverServiceImpl extends ServiceImpl<CoverDao, CoverEntity> implements CoverService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<CoverEntity> page = this.selectPage(
                new Query<CoverEntity>(params).getPage(),
                new EntityWrapper<CoverEntity>()
        );

        return new PageUtils(page);
    }

}
