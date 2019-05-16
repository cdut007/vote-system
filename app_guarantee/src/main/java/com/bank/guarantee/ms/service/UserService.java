package com.bank.guarantee.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.ms.entity.UserEntity;

import java.util.Map;

/**
 * 用户表
 *
 * @author 陈泳君
 * @email 316458704@qq.com
 * @date 2018-10-15 10:06:52
 */
public interface UserService extends IService<UserEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 根据用户名，查询系统用户
     */
    UserEntity queryByUserName(String username);


    /**
     * 根据手机号，查询系统用户
     */
    UserEntity queryByUserMobile(String mobile);

}

