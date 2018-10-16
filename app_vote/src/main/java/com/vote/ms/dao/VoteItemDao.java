package com.vote.ms.dao;

import com.vote.ms.entity.VoteItemEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 投票票数列表
 * 
 * @author james
 * @email 316458704@qq.com
 * @date 2018-10-16 09:21:13
 */
@Mapper
public interface VoteItemDao extends BaseMapper<VoteItemEntity> {
	
}
