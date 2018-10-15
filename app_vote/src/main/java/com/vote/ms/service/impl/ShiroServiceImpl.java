package com.vote.ms.service.impl;

import com.vote.common.utils.Constant;
import com.vote.ms.dao.SysMenuDao;
import com.vote.ms.dao.UserDao;
import com.vote.ms.dao.UserTokenDao;
import com.vote.ms.entity.SysMenuEntity;
import com.vote.ms.entity.UserEntity;
import com.vote.ms.entity.UserTokenEntity;
import com.vote.ms.service.ShiroService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ShiroServiceImpl implements ShiroService {
    @Autowired
    private SysMenuDao sysMenuDao;
    @Autowired
    private UserDao sysUserDao;
    @Autowired
    private UserTokenDao sysUserTokenDao;

    @Override
    public Set<String> getUserPermissions(String userId) {
        List<String> permsList;

        //系统管理员，拥有最高权限
        if(userId.equals(Constant.SUPER_ADMIN)){
            List<SysMenuEntity> menuList = sysMenuDao.selectList(null);
            permsList = new ArrayList<>(menuList.size());
            for(SysMenuEntity menu : menuList){
                permsList.add(menu.getPerms());
            }
        }else{
            permsList = new ArrayList<>();// sysUserDao.queryAllPerms(userId);
        }
        //用户权限列表
        Set<String> permsSet = new HashSet<>();
        for(String perms : permsList){
            if(StringUtils.isBlank(perms)){
                continue;
            }
            permsSet.addAll(Arrays.asList(perms.trim().split(",")));
        }
        return permsSet;
    }

    @Override
    public UserTokenEntity queryByToken(String token) {
        return sysUserTokenDao.queryByToken(token);
    }

    @Override
    public UserEntity queryUser(String userId) {
        return sysUserDao.selectById(userId);
    }
}
