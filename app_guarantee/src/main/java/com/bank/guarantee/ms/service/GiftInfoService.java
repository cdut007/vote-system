package com.bank.guarantee.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.ms.entity.GiftInfoEntity;

import java.util.Map;

/**
 * 
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-23 16:16:51
 */
public interface GiftInfoService extends IService<GiftInfoEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

