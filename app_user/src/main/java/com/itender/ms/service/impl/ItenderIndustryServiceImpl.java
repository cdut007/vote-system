package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderIndustry;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderIndustryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 *
 * @author Mao.Zeng@MG
 * @date 2018/2/10 10:36
 */
@Service
public class ItenderIndustryServiceImpl implements com.itender.ms.service.ItenderIndustryService {

    @Autowired
    private ItenderIndustryMapper itenderIndustryMapper;

    @Override
    public ItenderIndustry add(ItenderIndustry itenderIndustry) throws APIException {
        int row = itenderIndustryMapper.insert(itenderIndustry);
        return row==0?null:itenderIndustry;
    }

    @Override
    public List<ItenderIndustry> findAll() throws APIException {
        return itenderIndustryMapper.selectAll();
    }

    @Override
    public PageInfo<ItenderIndustry> findPage(Integer pageNum, Integer pagesize) throws APIException {
        PageHelper.startPage(pageNum,pagesize);
        Example example = new Example(ItenderIndustry.class);
        List<ItenderIndustry> itenderIndustries = itenderIndustryMapper.selectByExample(example);
        return new PageInfo<>(itenderIndustries);
    }

    @Override
    public Integer deleteById(String id) {
        ItenderIndustry itenderIndustry = new ItenderIndustry();
        itenderIndustry.setId(id);
        return itenderIndustryMapper.delete(itenderIndustry);
    }

    @Override
    public ItenderIndustry findById(String id) {
        return itenderIndustryMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<ItenderIndustry> findByRoleId(String roleId) {
        return itenderIndustryMapper.selectByRoleId(roleId);
    }

    @Override
    public int updateIndustry(ItenderIndustry itenderIndustry) {
        return itenderIndustryMapper.updateByPrimaryKeySelective(itenderIndustry);
    }

    @Override
    public List<ItenderIndustry> findByUserId(String userId) {
        return itenderIndustryMapper.selectByUserId(userId);
    }
}
