package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderBookMapper;
import com.itender.ms.mapper.ItenderRoomMapper;
import com.itender.ms.service.ItenderBookService;
import com.itender.ms.service.ItenderRoomService;
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
public class ItenderBookServiceImpl implements ItenderBookService {
	private static final Logger logger = LoggerFactory.getLogger(ItenderBookServiceImpl.class);
	private static final String KEY = "com.itender";
    @Autowired
    private ItenderBookMapper itenderBookMapper;





	public static void main(String[] args) throws APIException{


	}


	@Override
	public ItenderBook add(ItenderBook itenderBook) throws APIException {
		int rows = itenderBookMapper.insertSelective(itenderBook);

		return rows == 0?null:itenderBook;
	}

	@Override
	public List<ItenderBook> findAll() throws APIException {
		return null;
	}

	@Override
	public PageInfo<ItenderBook> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderBook.class);
        List<ItenderBook> itenderBook = itenderBookMapper.selectByExample(example);
        return new PageInfo<>(itenderBook);
	}

	@Override
	public Integer deleteById(String id) {
		ItenderBook itenderBook = new ItenderBook();
		itenderBook.setId(id);
		return itenderBookMapper.delete(itenderBook);
	}

	@Override
	public ItenderBook findById(String id) {
		return itenderBookMapper.selectByPrimaryKey(id);
	}


	@Override
	public ItenderBook cancelRoom(String bookId, String roomId) throws APIException {

		return null;
	}
}
