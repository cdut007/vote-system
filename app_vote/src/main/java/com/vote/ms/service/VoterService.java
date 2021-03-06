package com.vote.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.vote.common.utils.PageUtils;
import com.vote.ms.entity.VoterEntity;

import java.util.Map;

/**
 * 投票人列表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
public interface VoterService extends IService<VoterEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

