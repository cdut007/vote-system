package com.vote.ms.service;


import com.vote.ms.entity.UserEntity;
import com.vote.ms.entity.UserTokenEntity;

import java.util.Set;

/**
 * shiro相关接口
 */
public interface ShiroService {
    /**
     * 获取用户权限列表
     */
    Set<String> getUserPermissions(String userId);

    UserTokenEntity queryByToken(String token);

    /**
     * 根据用户ID，查询用户
     * @param userId
     */
    UserEntity queryUser(String userId);
}
