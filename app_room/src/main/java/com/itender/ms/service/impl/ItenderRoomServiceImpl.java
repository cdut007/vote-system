package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderRoomMapper;
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
public class ItenderRoomServiceImpl implements ItenderRoomService {
	private static final Logger logger = LoggerFactory.getLogger(ItenderRoomServiceImpl.class);
	private static final String KEY = "com.itender";
    @Autowired
    private ItenderRoomMapper itenderRoomMapper;





	public static void main(String[] args) throws APIException{


	}


	@Override
	public ItenderRoom add(ItenderRoom itenderRoom) throws APIException {
		return null;
	}

	@Override
	public List<ItenderRoom> findAll() throws APIException {
		return null;
	}

	@Override
	public PageInfo<ItenderRoom> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderRoom.class);
        List<ItenderRoom> itenderRoom = itenderRoomMapper.selectByExample(example);
        return new PageInfo<>(itenderRoom);
	}

	@Override
	public Integer deleteById(String id) {
		return null;
	}

	@Override
	public ItenderRoom findById(String id) {
		return null;
	}


	@Override
	public ItenderRoom updateRoom(ItenderRoom room) throws APIException {
		if(room == null){
			return null;
		}

		int rows = itenderRoomMapper.updateRoom(room);
		return rows == 0?null:room;
	}
}
