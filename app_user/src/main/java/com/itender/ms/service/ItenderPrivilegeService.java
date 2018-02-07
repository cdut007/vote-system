package com.itender.ms.service;

import java.util.List;
import java.util.concurrent.ThreadPoolExecutor;

import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.exception.APIException;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:48
 */
public interface ItenderPrivilegeService extends ItenderServiceBase<ItenderPrivilege> {
	
	public List<ItenderPrivilege> findAllPrivilegeByUserId(String userId);

	/**
	 * 更新权限信息
	 * @param itenderPrivilege
	 * @return
	 */
	public int updatePrivilege(ItenderPrivilege itenderPrivilege);

	/**
	 * 添加没有的权限资源
	 * @param itenderPrivileges
	 * @return
	 */
	public void addIfNotExsit(List<ItenderPrivilege> itenderPrivileges);

	/**
	 * 初始化权限
	 */
	public void initPrivilege();
	
}
