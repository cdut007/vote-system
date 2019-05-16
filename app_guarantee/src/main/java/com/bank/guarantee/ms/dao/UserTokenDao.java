package com.bank.guarantee.ms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.bank.guarantee.ms.entity.UserTokenEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserTokenDao extends BaseMapper<UserTokenEntity> {

    UserTokenEntity queryByToken(String token);

}