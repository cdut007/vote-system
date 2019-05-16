package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ItenderMessageDao;
import com.bank.guarantee.ms.entity.ItenderMessageEntity;
import com.bank.guarantee.ms.service.ItenderMessageService;


@Service("itenderMessageService")
public class ItenderMessageServiceImpl extends ServiceImpl<ItenderMessageDao, ItenderMessageEntity> implements ItenderMessageService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ItenderMessageEntity> page = this.selectPage(
                new Query<ItenderMessageEntity>(params).getPage(),
                new EntityWrapper<ItenderMessageEntity>()
        );

        return new PageUtils(page);
    }

}
