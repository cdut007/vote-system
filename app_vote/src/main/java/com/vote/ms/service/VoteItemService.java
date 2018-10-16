package com.vote.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.vote.common.utils.PageUtils;
import com.vote.ms.entity.VoteItemEntity;

import java.util.Map;

/**
 * 投票票数列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
public interface VoteItemService extends IService<VoteItemEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

