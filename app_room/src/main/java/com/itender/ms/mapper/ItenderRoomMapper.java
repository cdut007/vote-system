package com.itender.ms.mapper;

import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.domain.ItenderRoom;

import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderRoomMapper extends Mapper<ItenderRoom> {

    public int updateRoom(ItenderRoom itenderRoom);


    public List<ItenderRoom> filterAvaliableRoom(@Param(value = "roomIds") List<String> roomIds);

}
