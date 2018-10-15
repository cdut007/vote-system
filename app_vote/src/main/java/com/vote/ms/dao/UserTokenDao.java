package com.vote.ms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.vote.ms.entity.UserTokenEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserTokenDao extends BaseMapper<UserTokenEntity> {

    UserTokenEntity queryByToken(String token);

}