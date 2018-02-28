package com.itender.ms.service;

import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.exception.APIException;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderBookService extends ItenderServiceBase<ItenderBook> {


    /**
     * 取消预订
     * @param bookId,roomId
     * @return
     */
    public ItenderBook cancelRoom(String bookId,String roomId) throws APIException;


    public List<ItenderBook> findByBeginTime(long startTime,long endTime) throws APIException;


    public void setSearchInfo(long startTime,long endTime,String roomId);

    /**
     * 导出订单记录
     * @param startTime,endTime
     * @return
     */
    public List<ItenderBook> exportBookRoomByTime(long startTime,long endTime,String roomId) throws APIException;








}
