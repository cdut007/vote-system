package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderRoomMapper;
import com.itender.ms.service.ItenderRoomService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.*;


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
		itenderRoom.setCreateTime(new Date(System.currentTimeMillis()));
		int rows = itenderRoomMapper.insertSelective(itenderRoom);

		return rows == 0?null:itenderRoom;
	}

	@Override
	public List<ItenderRoom> findAll() throws APIException {
		return itenderRoomMapper.selectAll();
	}

	@Override
	public PageInfo<ItenderRoom> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderRoom.class);
		example.setOrderByClause("create_time desc");
        List<ItenderRoom> itenderRoom = itenderRoomMapper.selectByExample(example);
        return new PageInfo<>(itenderRoom);
	}

	@Override
	public PageInfo<ItenderRoom> findPageByFilterBookRooms(Integer pageNum, Integer pagesize , List<ItenderBook> bookList) throws APIException {
		PageHelper.startPage(pageNum,pagesize);
		Set<String> roomSet=new HashSet<String>();
		for (int i = 0; i < bookList.size(); i++) {
			roomSet.add(bookList.get(i).getRoomId());
		}
		logger.info("find bookList :"+bookList.toString());

		List<String> roomIds = new ArrayList<>(roomSet);

		logger.info("find the roomIds :"+roomIds.toString() +" room size:"+roomIds.size());


		List<ItenderRoom> itenderRoom = itenderRoomMapper.filterAvaliableRoom(roomIds);

		logger.info("find the filter romm left size:"+itenderRoom.size());

		return new PageInfo<>(itenderRoom);
	}

	@Override
	public Integer deleteById(String id) {
		ItenderRoom itenderRoom = new ItenderRoom();
		itenderRoom.setId(id);
		return itenderRoomMapper.delete(itenderRoom);
	}

	@Override
	public ItenderRoom findById(String id) {
		return itenderRoomMapper.selectByPrimaryKey(id);
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
