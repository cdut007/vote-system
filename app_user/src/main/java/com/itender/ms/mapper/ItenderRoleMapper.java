package com.itender.ms.mapper;

import java.util.List;

import com.itender.ms.domain.ItenderRole;
import tk.mybatis.mapper.common.Mapper;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:48
 */
public interface ItenderRoleMapper extends Mapper<ItenderRole> {
	public ItenderRole selectByRoleId(String roleId);
	
	public List<ItenderRole> selectAllRole();

	public List<ItenderRole> selectByIds(String[] ids);
}
