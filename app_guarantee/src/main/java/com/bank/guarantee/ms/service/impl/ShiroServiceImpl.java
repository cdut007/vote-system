package com.bank.guarantee.ms.service.impl;

import com.bank.guarantee.common.utils.Constant;
import com.bank.guarantee.ms.dao.SysMenuDao;
import com.bank.guarantee.ms.dao.UserDao;
import com.bank.guarantee.ms.dao.UserTokenDao;
import com.bank.guarantee.ms.entity.SysMenuEntity;
import com.bank.guarantee.ms.entity.UserEntity;
import com.bank.guarantee.ms.entity.UserTokenEntity;
import com.bank.guarantee.ms.service.ShiroService;
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
