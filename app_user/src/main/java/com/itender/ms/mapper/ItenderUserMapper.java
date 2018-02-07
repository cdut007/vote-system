package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderUser;

import tk.mybatis.mapper.common.Mapper;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:48
 */
public interface ItenderUserMapper extends Mapper<ItenderUser> {
	
	public ItenderUser selectByUserId(String userId);
	
	public ItenderUser selectByNameAndPassword(ItenderUser itenderUser);
	
	public int updateUser(ItenderUser itenderUser);

}
