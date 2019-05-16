package com.bank.guarantee.ms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.bank.guarantee.ms.entity.CaptchaEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 验证码
 *
 */
@Mapper
public interface CaptchaDao extends BaseMapper<CaptchaEntity> {

}