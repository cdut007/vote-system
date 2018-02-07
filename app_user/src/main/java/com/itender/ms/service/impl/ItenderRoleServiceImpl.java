package com.itender.ms.service.impl;

import java.util.List;

import com.itender.ms.enums.ServiceCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.domain.ItenderRole;
import com.itender.ms.domain.ItenderRolePrivilege;
import com.itender.ms.domain.ItenderUser;
import com.itender.ms.domain.ItenderUserRole;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderPrivilegeMapper;
import com.itender.ms.mapper.ItenderRoleMapper;
import com.itender.ms.mapper.ItenderRolePrivilegeMapper;
import com.itender.ms.mapper.ItenderUserMapper;
import com.itender.ms.mapper.ItenderUserRoleMapper;
import com.itender.ms.service.ItenderRoleService;

import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:52
 */
@Service
public class ItenderRoleServiceImpl implements ItenderRoleService {
	private static final Logger logger = LoggerFactory.getLogger(ItenderRoleServiceImpl.class);

    @Autowired
    private ItenderRoleMapper itenderRoleMapper;
    @Autowired
    private ItenderUserRoleMapper itenderUserRoleMapper;
    @Autowired
    private ItenderUserMapper itenderUserMapper;
    @Autowired
    private ItenderPrivilegeMapper itenderPrivilegeMapper;
    @Autowired
    private ItenderRolePrivilegeMapper itenderRolePrivilegeMapper;

    @Override
    public ItenderRole add(ItenderRole itenderRole) throws APIException {
        int rows = itenderRoleMapper.insertSelective(itenderRole);
        return rows == 0?null:itenderRole;
    }

    @Override
    public List<ItenderRole> findAll() throws APIException {
        return itenderRoleMapper.selectAllRole();
    }

    @Override
    public PageInfo<ItenderRole> findPage(Integer pageNum, Integer pagesize) throws APIException {
    	PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderRole.class);
        List<ItenderRole> itenderRole = itenderRoleMapper.selectByExample(example);
        return new PageInfo<>(itenderRole);
    }

    @Override
    public Integer deleteById(String id) {
        ItenderRole itenderRole = new ItenderRole();
        itenderRole.setId(id);
        return itenderRoleMapper.delete(itenderRole);
    }

    @Override
    public ItenderRole findById(String id) {
        return itenderRoleMapper.selectByRoleId(id);
    }

	@Override
	public ItenderRole addRole(ItenderRole itenderRole, String[] privilegeId) throws APIException {
    	boolean status = false;
		int rows = itenderRoleMapper.insertSelective(itenderRole);
		if(rows != 0){
			status = authRolePrivilege(itenderRole.getId(),privilegeId);
		}
		if(!status){
			return null;
		}
		return itenderRole;
	}

	@Override
	public ItenderRole findByRoleId(String roleId) {
		return itenderRoleMapper.selectByRoleId(roleId);
	}

	@Transactional
	@Override
	public boolean authUserRole(String userId, String[] roleId) throws APIException {
		ItenderUser user = itenderUserMapper.selectByUserId(userId);
		if(user == null){
			logger.error("数据异常,用户不存在！");
			throw new APIException(404,"100404","用户不存在！");
		}
		ItenderUserRole userRole = new ItenderUserRole();
		userRole.setUserId(user.getId());
		int row = 0;
		Example userRoleExap = new Example(ItenderUserRole.class);
		Criteria criteria = userRoleExap.createCriteria();
		criteria.andEqualTo("userId",userId);

		if(roleId.length==0){//传入角色ID为空，删除用户所有角色
			row = itenderUserRoleMapper.deleteByExample(userRoleExap);
			return row==0?false:true;
		}

		List<ItenderUserRole> userRoleOld = itenderUserRoleMapper.selectByExample(userRoleExap);
		if(userRoleOld != null && userRoleOld.size()>0){
	        row = itenderUserRoleMapper.deleteByExample(userRoleExap);
			if(row == 0){
				logger.error("更新角色出错！");
				throw new APIException(500,"100500","分配角色出错！");
			}
		}

		List<ItenderRole> roles = itenderRoleMapper.selectByIds(roleId);
		for(ItenderRole role : roles){
			userRole.setRoleId(role.getId());
			row = itenderUserRoleMapper.insert(userRole);
		}

		return row==0?false:true;
	}

	@Transactional
	@Override
	public boolean authRolePrivilege(String roleId, String[] privilegeId) throws APIException {
		ItenderRole role = itenderRoleMapper.selectByRoleId(roleId);
		if(role == null){
			logger.error("数据异常,角色不存在！");
			throw new APIException(404,"100404","角色不存在！");
		}

		ItenderRolePrivilege rolePrivilege = new ItenderRolePrivilege();
		rolePrivilege.setRoleId(roleId);
		int row = 0;
		Example rolePriExmp = new Example(ItenderRolePrivilege.class);
		Criteria criteria = rolePriExmp.createCriteria();
		criteria.andEqualTo("roleId",roleId);

		if(privilegeId.length==0){
			row = itenderRolePrivilegeMapper.deleteByExample(rolePriExmp);
			return row==0?false:true;
		}

		List<ItenderRolePrivilege> exsit = itenderRolePrivilegeMapper.selectByExample(rolePriExmp);
		if(exsit != null && exsit.size()>0){
			row = itenderRolePrivilegeMapper.deleteByExample(rolePriExmp);
			if(row == 0){
				logger.error("更新角色出错！");
				throw new APIException(500,"100500","分配权限出错！");
			}
		}

		List<ItenderPrivilege> privileges = itenderPrivilegeMapper.selectByIds(privilegeId);
		for (ItenderPrivilege privilege : privileges){
			ItenderRolePrivilege rolePrivilegeNew = new ItenderRolePrivilege();
			rolePrivilegeNew.setRoleId(roleId);
			rolePrivilegeNew.setPrivilegeId(privilege.getId());
			row = itenderRolePrivilegeMapper.insert(rolePrivilegeNew);
		}

		return row==0?false:true;
	}

	@Override
	public int updateRole(ItenderRole itenderRole) {
		return itenderRoleMapper.updateByPrimaryKey(itenderRole);
	}

}
