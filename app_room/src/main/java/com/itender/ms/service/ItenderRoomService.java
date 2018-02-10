package com.itender.ms.service;

import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.exception.APIException;

import java.util.List;

/**
 * @Author james chen
 * @Date 2018/2/08 15:48
 */
public interface ItenderRoomService extends ItenderServiceBase<ItenderRoom> {


    /**
     * 更新房间信息
     * @param room
     * @return
     */
    public ItenderRoom updateRoom(ItenderRoom room) throws APIException;



}
