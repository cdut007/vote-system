package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderLog;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderLogMapper;
import com.itender.ms.service.ItenderLogService;
import com.itender.ms.util.PasswordUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;


/**
 * @Author james chen
 * @Date 2018/2/08 16:48
 */
@Service
public class ItenderLogServiceImpl implements ItenderLogService {
	private static final Logger logger = LoggerFactory.getLogger(ItenderLogServiceImpl.class);
	private static final String KEY = "com.itender";
    @Autowired
    private ItenderLogMapper itenderLogMapper;





	public static void main(String[] args) throws APIException{


	}


	@Override
	public ItenderLog add(ItenderLog itenderLog) throws APIException {
		int rows = itenderLogMapper.insertSelective(itenderLog);

		return rows == 0?null:itenderLog;
	}

	@Override
	public List<ItenderLog> findAll() throws APIException {
		return null;
	}

	@Override
	public PageInfo<ItenderLog> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderLog.class);
        List<ItenderLog> itenderLog = itenderLogMapper.selectByExample(example);
        return new PageInfo<>(itenderLog);
	}

	@Override
	public Integer deleteById(String id) {
		return null;
	}

	@Override
	public ItenderLog findById(String id) {
		return null;
	}


}
