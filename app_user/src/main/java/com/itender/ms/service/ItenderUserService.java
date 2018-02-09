package com.itender.ms.service;

import com.itender.ms.domain.ItenderUser;
import com.itender.ms.exception.APIException;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:49
 */
public interface ItenderUserService extends ItenderServiceBase<ItenderUser> {

	public ItenderUser findByUserId(String userId);
	/**
	 * 按用户名和密码查询用户
	 * @param username
	 * @param password
	 * @return
	 */
	public ItenderUser findByNameAndPassword(String username,String password) throws APIException;
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	public ItenderUser updateUser(ItenderUser user) throws APIException;

	public boolean updatePassword(String userId,String password) throws APIException;
	
	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @param isSession
	 * @return
	 * @throws APIException
	 */
	public ItenderUser userLogin(String username, String password, boolean isSession)throws APIException;

	/**
	 * 密码加密
	 * @param password
	 * @return
	 */
	public String enPassword(String password) throws APIException;
	/**
	 * 解密
	 * @param password
	 * @return
	 */
	public String dePassword(String password) throws APIException;
}
