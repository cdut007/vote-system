package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.enums.BookStatus;
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

import java.util.ArrayList;
import java.util.Date;
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
		itenderBook.setCreateTime(new Date(System.currentTimeMillis()));
		int rows = itenderBookMapper.insertSelective(itenderBook);

		return rows == 0?null:itenderBook;
	}

	@Override
	public List<ItenderBook> findAll() throws APIException {
		return itenderBookMapper.selectAll();
	}

	@Override
	public List<ItenderBook> findByBeginTime(long startTime,long endTime) throws APIException {

		//搜索出在开始时间到结束时间期间有哪些房间被占用。
		return checkBookListStatus(itenderBookMapper.findBookRoomByTime(new Date(startTime),new Date(endTime)));
	}

	@Override
	public List<ItenderBook> exportBookRoomByTime(long startTime,long endTime) throws APIException {

		//搜索出在开始时间到结束时间期间有哪些房间被占用。
		return checkBookListStatus(itenderBookMapper.exportBookRoomByTime(new Date(startTime),new Date(endTime)));
	}




	@Override
	public PageInfo<ItenderBook> findPage(Integer pageNum, Integer pagesize) throws APIException {
		PageHelper.startPage(pageNum,pagesize);

        Example example = new Example(ItenderBook.class);
		example.setOrderByClause("create_time desc");
        List<ItenderBook> itenderBook = itenderBookMapper.selectByExample(example);
        itenderBook  = checkBookListStatus(itenderBook);
        return new PageInfo<>(itenderBook);
	}

	@Override
	public Integer deleteById(String id) {
		ItenderBook itenderBook = new ItenderBook();
		itenderBook.setId(id);
		itenderBook.setStatus(BookStatus.cancel.name());
		return itenderBookMapper.delete(itenderBook);
	}

	@Override
	public ItenderBook findById(String id) {
		return checkBookStatus(itenderBookMapper.selectByPrimaryKey(id));
	}


	@Override
	public ItenderBook cancelRoom(String bookId, String roomId) throws APIException {
		ItenderBook book = findById(bookId);
		if(book!=null){
			book.setStatus(BookStatus.cancel.name());
		}

		itenderBookMapper.updateByPrimaryKey(book);

		return checkBookStatus(book);
	}


	private  List<ItenderBook> checkBookListStatus(List<ItenderBook> itenderBookList){
		if(itenderBookList!=null && !itenderBookList.isEmpty()){
			int size = itenderBookList.size();
			List<ItenderBook> newBookList = new ArrayList<>();
			for (int i = 0; i < size; i++) {
				newBookList.add(checkBookStatus(itenderBookList.get(i)));
			}
			return  newBookList;
		}
		return  itenderBookList;
	}
	private ItenderBook checkBookStatus(ItenderBook itenderBook){
		if(itenderBook!=null){
			if(BookStatus.ordered.name().equals(itenderBook.getStatus())){
				//check time
				Date bookStartDate = itenderBook.getBeginTime();
				Date bookEndDate = itenderBook.getEndTime();
				long currentTime = System.currentTimeMillis();
				if(bookStartDate.getTime() <= currentTime && bookEndDate.getTime() > currentTime){
					itenderBook.setStatus(BookStatus.occupy.name());
					itenderBookMapper.updateByPrimaryKey(itenderBook);
				}else if(bookEndDate.getTime() <= currentTime){
					//expired
					itenderBook.setStatus(BookStatus.expired.name());
					itenderBookMapper.updateByPrimaryKey(itenderBook);
				}
			}else if(BookStatus.occupy.name().equals(itenderBook.getStatus())){
				long currentTime = System.currentTimeMillis();
				Date bookEndDate = itenderBook.getEndTime();
				if(bookEndDate.getTime() <= currentTime){
					//expired
					itenderBook.setStatus(BookStatus.expired.name());
					itenderBookMapper.updateByPrimaryKey(itenderBook);
				}
			}

		}

		return  itenderBook;
	}
}
