package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.ItenderCompanyDao;
import com.bank.guarantee.ms.entity.ItenderCompanyEntity;
import com.bank.guarantee.ms.service.ItenderCompanyService;


@Service("itenderCompanyService")
public class ItenderCompanyServiceImpl extends ServiceImpl<ItenderCompanyDao, ItenderCompanyEntity> implements ItenderCompanyService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ItenderCompanyEntity> page = this.selectPage(
                new Query<ItenderCompanyEntity>(params).getPage(),
                new EntityWrapper<ItenderCompanyEntity>()
        );

        return new PageUtils(page);
    }

}
