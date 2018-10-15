package com.vote.ms.service.impl;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.google.code.kaptcha.Producer;
import com.vote.ms.dao.CaptchaDao;
import com.vote.ms.entity.CaptchaEntity;
import com.vote.ms.exception.APIException;
import com.vote.ms.service.CaptchaService;
import com.vote.ms.utils.DateUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.util.Date;

/**
 * 验证码
 *
 */
@Service("CaptchaService")
public class CaptchaServiceImpl extends ServiceImpl<CaptchaDao, CaptchaEntity> implements CaptchaService {
    @Autowired
    private Producer producer;

    @Override
    public BufferedImage getCaptcha(String uuid) {
        if(StringUtils.isBlank(uuid)){
            throw new APIException("uuid不能为空");
        }
        //生成文字验证码
        String code = producer.createText();

        CaptchaEntity captchaEntity = new CaptchaEntity();
        captchaEntity.setUuid(uuid);
        captchaEntity.setCode(code);
        //5分钟后过期
        captchaEntity.setExpireTime(DateUtils.addDateMinutes(new Date(), 5));
        this.insert(captchaEntity);

        return producer.createImage(code);
    }

    @Override
    public boolean validate(String uuid, String code) {
        CaptchaEntity captchaEntity = this.selectOne(new EntityWrapper<CaptchaEntity>().eq("uuid", uuid));
        if(captchaEntity == null){
            return false;
        }

        //删除验证码
        this.deleteById(uuid);

        if(captchaEntity.getCode().equalsIgnoreCase(code) && captchaEntity.getExpireTime().getTime() >= System.currentTimeMillis()){
            return true;
        }

        return false;
    }
}
