package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.domain.ItenderRolePrivilege;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderPrivilegeMapper;
import com.itender.ms.mapper.ItenderRolePrivilegeMapper;
import com.itender.ms.service.ItenderPrivilegeService;
import com.itender.ms.util.PrivilegeUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:50
 */
@Service
public class ItenderPrivilegeServiceImpl implements ItenderPrivilegeService {
    private static final Logger logger = LoggerFactory.getLogger(ItenderPrivilegeServiceImpl.class);

    @Autowired
    private ItenderPrivilegeMapper itenderPrivilegeMapper;
    @Autowired
    private ItenderRolePrivilegeMapper itenderRolePrivilegeMapper;

    @Override
    public ItenderPrivilege add(ItenderPrivilege itenderPrivilege) throws APIException {
        int rows = itenderPrivilegeMapper.insertSelective(itenderPrivilege);
        return rows == 0?null:itenderPrivilege;
    }

    @Override
    public List<ItenderPrivilege> findAll() throws APIException {
        return itenderPrivilegeMapper.selectAll();
    }
    
    @Override
    public PageInfo<ItenderPrivilege> findPage(Integer pageNum, Integer pagesize) throws APIException {
    	PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderPrivilege.class);
        List<ItenderPrivilege> itenderPrivilege = itenderPrivilegeMapper.selectByExample(example);
        return new PageInfo<>(itenderPrivilege);
    }

    @Override
    public Integer deleteById(String id) {
        ItenderPrivilege itenderPrivilege = new ItenderPrivilege();
        itenderPrivilege.setId(id);
        return itenderPrivilegeMapper.delete(itenderPrivilege);
    }

    @Override
    public ItenderPrivilege findById(String id) {
        ItenderPrivilege itenderPrivilege = new ItenderPrivilege();
        itenderPrivilege.setId(id);
        return itenderPrivilegeMapper.selectOne(itenderPrivilege);
    }

	@Override
	public List<ItenderPrivilege> findAllPrivilegeByUserId(String userId) {
		return itenderPrivilegeMapper.selectByUserId(userId);
	}

    @Override
    public int updatePrivilege(ItenderPrivilege itenderPrivilege) {
        return itenderPrivilegeMapper.updatePrivilege(itenderPrivilege);
    }

    @Override
    public void addIfNotExsit(List<ItenderPrivilege> itenderPrivileges){
        for(ItenderPrivilege p : itenderPrivileges){
            if(itenderPrivilegeMapper.isExist(p.getPrivilegeUri(),p.getPrivilegeMethod())==0){
                itenderPrivilegeMapper.insert(p);
            }
        }
    }

    @Override
    public void initPrivilege(){
        List<ItenderPrivilege> itenderPrivileges = PrivilegeUtil.getInstance().getPrivilegesFromJsonFile();
        this.addIfNotExsit(itenderPrivileges);
    }

}
