package com.bank.guarantee.ms.service;

import com.baomidou.mybatisplus.service.IService;
import com.bank.guarantee.common.utils.R;
import com.bank.guarantee.ms.entity.UserTokenEntity;

/**
 * 用户Token
 *
 */
public interface UserTokenService extends IService<UserTokenEntity> {

	/**
	 * 生成token
	 * @param userId  用户ID
	 */
	R createToken(String userId);

	/**
	 * 退出，修改token值
	 * @param userId  用户ID
	 */
	void logout(String userId);

}
