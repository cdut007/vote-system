package com.bank.guarantee.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.GiftInfoDao;
import com.bank.guarantee.ms.entity.GiftInfoEntity;
import com.bank.guarantee.ms.service.GiftInfoService;


@Service("giftInfoService")
public class GiftInfoServiceImpl extends ServiceImpl<GiftInfoDao, GiftInfoEntity> implements GiftInfoService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<GiftInfoEntity> page = this.selectPage(
                new Query<GiftInfoEntity>(params).getPage(),
                new EntityWrapper<GiftInfoEntity>()
        );

        return new PageUtils(page);
    }

}
