package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderBook;
import com.itender.ms.exception.APIException;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;
import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderBookMapper extends Mapper<ItenderBook> {

    public int cancelRoom(String bookId,String roomId);

    public List<ItenderBook> findBookRoomByTime(@Param(value="startTime") Date startTime, @Param(value="endTime") Date endTime);


    public List<ItenderBook> exportBookRoomByTime(@Param(value="startTime") Date startTime, @Param(value="endTime") Date endTime, @Param(value="roomId")String roomId);


    public List<ItenderBook> findByIndustry(@Param(value="industry")String industry);

}
