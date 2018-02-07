package com.itender.ms.mapper;

import java.util.List;

import com.itender.ms.domain.ItenderPrivilege;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

/**
 *
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:19
 */
public interface ItenderPrivilegeMapper extends Mapper<ItenderPrivilege> {
	public List<ItenderPrivilege> selectByUserId(String userId);
	public int updatePrivilege(ItenderPrivilege itenderPrivilege);
	public List<ItenderPrivilege> selectByIds(String[] ids);

	/**
	 * 是否存在
	 * @param privilegeUrl
	 * @param privilegeMethod
	 * @return
	 */
	public int isExist(@Param("privilegeUri") String privilegeUri, @Param("privilegeMethod") String privilegeMethod);

	public int insert(ItenderPrivilege itenderPrivilege);
}
