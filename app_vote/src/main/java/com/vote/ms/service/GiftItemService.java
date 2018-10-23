package com.vote.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.vote.common.utils.PageUtils;
import com.vote.ms.entity.GiftItemEntity;

import java.util.Map;

/**
 * 投票票数列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-23 16:16:51
 */
public interface GiftItemService extends IService<GiftItemEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

