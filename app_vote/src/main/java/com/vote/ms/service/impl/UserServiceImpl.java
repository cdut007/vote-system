package com.vote.ms.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.vote.common.utils.PageUtils;
import com.vote.common.utils.Query;

import com.vote.ms.dao.UserDao;
import com.vote.ms.entity.UserEntity;
import com.vote.ms.service.UserService;


@Service("userService")
public class UserServiceImpl extends ServiceImpl<UserDao, UserEntity> implements UserService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<UserEntity> page = this.selectPage(
                new Query<UserEntity>(params).getPage(),
                new EntityWrapper<UserEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public UserEntity queryByUserName(String username) {
        return baseMapper.queryByUserName(username);
    }

    @Override
    public UserEntity queryByUserMobile(String mobile) {
        return baseMapper.queryByUserMobile(mobile);
    }

}
