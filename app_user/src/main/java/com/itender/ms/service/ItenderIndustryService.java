package com.itender.ms.service;

import com.itender.ms.domain.ItenderIndustry;

import java.util.List;

public interface ItenderIndustryService extends ItenderServiceBase<ItenderIndustry> {
    /**
     * 查询角色类型
     * @param
     * @return
     */
    public List<ItenderIndustry> findByRoleId(String roleId);

    /**
     * 更新行业信息
     * @param
     * @return
     */
    public int updateIndustry(ItenderIndustry itenderIndustry);

    /**
     * 根据用户ID查询其角色类型
     * @param
     * @return
     */
    List<ItenderIndustry> findByUserId(String userId);
}
