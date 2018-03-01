package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderIndustry;
import tk.mybatis.mapper.common.IdsMapper;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 *
 * @author Mao.Zeng@MG
 * @date 2018/2/9 17:09
 */
public interface ItenderIndustryMapper extends Mapper<ItenderIndustry> {

    List<ItenderIndustry> selectByRoleId(String roleId);

    List<ItenderIndustry> selectByIds(String[] ids);

    List<ItenderIndustry> selectByUserId(String userId);
}
