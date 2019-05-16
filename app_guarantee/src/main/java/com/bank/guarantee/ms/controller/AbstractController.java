package com.bank.guarantee.ms.controller;

import com.bank.guarantee.ms.entity.UserEntity;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Controller公共组件
 */
public abstract class AbstractController {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	protected UserEntity getUser() {
		return (UserEntity) SecurityUtils.getSubject().getPrincipal();
	}

	protected String getUserId() {
		return getUser().getId();
	}
}
