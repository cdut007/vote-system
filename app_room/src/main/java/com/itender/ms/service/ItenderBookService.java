package com.itender.ms.service;

import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.exception.APIException;

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



}
