package com.bank.guarantee.ms.dao;

import com.bank.guarantee.ms.entity.UserEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户表
 * 
 * @author 陈泳君
 * @email 316458704@qq.com
 * @date 2018-10-15 10:06:52
 */
@Mapper
public interface UserDao extends BaseMapper<UserEntity> {
    /**
     * 根据用户名，查询系统用户
     */
    UserEntity queryByUserName(String username);

    /**
     * 根据用户手机号，查询系统用户
     */
    UserEntity queryByUserMobile(String mobile);

}
