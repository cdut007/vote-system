package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ItenderOrderDao;
import com.bank.guarantee.ms.entity.ItenderOrderEntity;
import com.bank.guarantee.ms.service.ItenderOrderService;


@Service("itenderOrderService")
public class ItenderOrderServiceImpl extends ServiceImpl<ItenderOrderDao, ItenderOrderEntity> implements ItenderOrderService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ItenderOrderEntity> page = this.selectPage(
                new Query<ItenderOrderEntity>(params).getPage(),
                new EntityWrapper<ItenderOrderEntity>()
        );

        return new PageUtils(page);
    }

}
