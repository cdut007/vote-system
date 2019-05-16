package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ItenderApplyDao;
import com.bank.guarantee.ms.entity.ItenderApplyEntity;
import com.bank.guarantee.ms.service.ItenderApplyService;


@Service("itenderApplyService")
public class ItenderApplyServiceImpl extends ServiceImpl<ItenderApplyDao, ItenderApplyEntity> implements ItenderApplyService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ItenderApplyEntity> page = this.selectPage(
                new Query<ItenderApplyEntity>(params).getPage(),
                new EntityWrapper<ItenderApplyEntity>()
        );

        return new PageUtils(page);
    }

}
