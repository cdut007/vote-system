package com.bank.guarantee.ms.service.impl;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.R;
import com.bank.guarantee.ms.dao.UserTokenDao;
import com.bank.guarantee.ms.entity.UserTokenEntity;
import com.bank.guarantee.ms.oauth2.TokenGenerator;
import com.bank.guarantee.ms.service.UserTokenService;
import org.springframework.stereotype.Service;

import java.util.Date;


@Service("UserTokenService")
public class UserTokenServiceImpl extends ServiceImpl<UserTokenDao, UserTokenEntity> implements UserTokenService {
    //12小时后过期
    private final static int EXPIRE = 3600 * 12;


    @Override
    public R createToken(String userId) {
        //生成一个token
        String token = TokenGenerator.generateValue();

        //当前时间
        Date now = new Date();
        //过期时间
        Date expireTime = new Date(now.getTime() + EXPIRE * 1000);

        //判断是否生成过token
        UserTokenEntity tokenEntity = this.selectById(userId);
        if(tokenEntity == null){
            tokenEntity = new UserTokenEntity();
            tokenEntity.setUserId(userId);
            tokenEntity.setToken(token);
            tokenEntity.setUpdateTime(now);
            tokenEntity.setExpireTime(expireTime);

            //保存token
            this.insert(tokenEntity);
        }else{
            tokenEntity.setToken(token);
            tokenEntity.setUpdateTime(now);
            tokenEntity.setExpireTime(expireTime);

            //更新token
            this.updateById(tokenEntity);
        }

        R r = R.ok().put("token", token).put("expire", EXPIRE);

        return r;
    }

    @Override
    public void logout(String userId) {
        //生成一个token
        String token = TokenGenerator.generateValue();

        //修改token
        UserTokenEntity tokenEntity = new UserTokenEntity();
        tokenEntity.setUserId(userId);
        tokenEntity.setToken(token);
        this.updateById(tokenEntity);
    }
}
