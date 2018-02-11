package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderRoom;
import tk.mybatis.mapper.common.Mapper;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderBookMapper extends Mapper<ItenderBook> {

    public int cancelRoom(String bookId,String roomId);

}
