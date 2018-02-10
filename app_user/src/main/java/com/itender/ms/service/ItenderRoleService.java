package com.itender.ms.service;

import com.itender.ms.domain.ItenderRole;
import com.itender.ms.exception.APIException;

import java.util.List;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:49
 */
public interface ItenderRoleService extends ItenderServiceBase<ItenderRole>{

	/**    
	 *   新增角色，并赋权限
	 * @param   
	 * @return   
	 */ 
	public ItenderRole addRole(ItenderRole itenderRole,String[] privilegeId,String[] roleTypeId) throws APIException;

	public ItenderRole findByRoleId(String roleId);
	
	/**
	 * 给用户分配角色
	 * @param userId
	 * @param roleId
	 * @return
	 */
	public boolean authUserRole(String userId,String[] roleId) throws APIException;
	
	/**
	 * 给角色赋予相关权限
	 * @param roleId
	 * @param privilegeId
	 * @return
	 */
	public boolean authRolePrivilege(String roleId,String[] privilegeId) throws APIException;

	/**
	 * 设置角色属性
	 * @param   roleId
	 * @param   roleTypeId
	 * @return
	 */
	public boolean setRoleType(String roleId,String[] roleTypeId) throws APIException;

	/**
	 * 更新角色信息
	 * @param itenderRole
	 * @return
	 */
	public int updateRole(ItenderRole itenderRole,String[] roleTypeIds)  throws APIException;
}
