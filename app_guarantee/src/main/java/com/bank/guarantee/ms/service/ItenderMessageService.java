package com.bank.guarantee.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.ms.entity.ItenderMessageEntity;

import java.util.Map;

/**
 * 
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:04
 */
public interface ItenderMessageService extends IService<ItenderMessageEntity> {

    PageUtils queryPage(Map<String, Object> params);
}
