package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ItenderTaskDao;
import com.bank.guarantee.ms.entity.ItenderTaskEntity;
import com.bank.guarantee.ms.service.ItenderTaskService;


@Service("itenderTaskService")
public class ItenderTaskServiceImpl extends ServiceImpl<ItenderTaskDao, ItenderTaskEntity> implements ItenderTaskService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ItenderTaskEntity> page = this.selectPage(
                new Query<ItenderTaskEntity>(params).getPage(),
                new EntityWrapper<ItenderTaskEntity>()
        );

        return new PageUtils(page);
    }

}
