package com.itender.ms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.enums.DeviceStatus;
import com.itender.ms.service.ItenderDeviceService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import io.swagger.annotations.ApiParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderRoomService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import springfox.documentation.annotations.ApiIgnore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(description = "房间管理模块接口")
@Validated
@Controller
@RequestMapping("/room")
public class RoomController {
	 private static final Logger logger = LoggerFactory.getLogger(RoomController.class);

	@Autowired
	private ItenderRoomService itenderRoomService;

    @Autowired
    private ItenderDeviceService itenderDeviceService;


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "room/room_list";
    }

    @ApiIgnore
    @RequestMapping(value = "/room_page",method = RequestMethod.GET)
    public String roomPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/room/room_list");
    }

    @ApiIgnore
    @RequestMapping(value = "/add_page",method = RequestMethod.GET)
    public String addRoomPage(HttpServletRequest request,HttpServletResponse response){

        try {
            request.setAttribute("availableDeviceList",itenderDeviceService.getAvailableDeviceList());
        } catch (APIException e) {
            e.printStackTrace();
        }
        return ViewUtil.forward("room/room_add");
    }

    @ApiIgnore
    @RequestMapping(value = "/edit_page",method = RequestMethod.GET)
    public String editRoomPage(HttpServletRequest request,HttpServletResponse response){
        String roomId = request.getParameter("id");
        ItenderRoom room = null;
        if(CommonUtility.isNonEmpty(roomId)){
            room = itenderRoomService.findById(roomId);
        }
        request.setAttribute("itenderRoom",room);
        try {
            request.setAttribute("availableDeviceList",itenderDeviceService.getAvailableDeviceList());
        } catch (APIException e) {
            e.printStackTrace();
        }
        return ViewUtil.forward("room/room_edit");
    }



    @ApiOperation(value = "房间列表接口",notes = "用于查询所有房间信息")
    @RequestMapping(value = "/listRoom",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> logAll(HttpServletRequest request,
                                                    @RequestParam(required = false) Integer pageNum,
                                                    @RequestParam(required = false) Integer pagesize
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderRoom> page = itenderRoomService.findPage(pageNum, pagesize);

        List<ItenderRoom> roomList = page.getList();
        if(roomList!=null && roomList.size() > 0){
            List<ItenderDevice> deviceList  = itenderDeviceService.getRoomDeviceList();
            for (int i = 0; i < roomList.size(); i++) {
                 ItenderRoom room = roomList.get(i);
                 String devices_infos = "";
                 List<ItenderDevice> roomDeviceList  = new ArrayList<>();
                 int size = deviceList.size();
                for (int j = 0; j < size; j++) {
                    ItenderDevice device  = deviceList.get(j);
                    if(room.getId().equals(device.getRoomId())){
                        roomDeviceList.add(device);
                        devices_infos += device.getName() + "、";
                    }

                }
                if(devices_infos.length()>0){
                    devices_infos =  devices_infos.substring(0,devices_infos.length() -1);
                }
                 room.setDeviceList(roomDeviceList);
                 room.setDevices_info(devices_infos);

            }


        }

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }



    @ApiOperation(value = "添加房间接口",notes = "用于新增房间信息")
    @RequestMapping(value = "/addRoom",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addRoom(HttpServletRequest request,
                                                        @ApiParam(name = "name",value = "房间",required = true) @RequestBody ItenderRoom room) throws APIException{
        Map<String,Object> result = new HashMap<>();

        room = itenderRoomService.add(room);
        List<ItenderDevice> deviceList = room.getDeviceList();
        for (int i = 0; i < deviceList.size(); i++) {
            itenderDeviceService.bindRoom(deviceList.get(i),room.getId());
        }
        if(!CommonUtility.isNonEmpty(room.getId())){
            result.put("status", false);
            result.put("msg", "添加房间失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", room);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "删除房间接口",notes = "用于删除房间信息")
    @RequestMapping(value = "/delRoom",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> delRoom(HttpServletRequest request,
                                                           @ApiParam(name = "roomId",value = "房间ID",required = true) @RequestParam(required = true) String roomId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        logger.debug("==删除房间id=="+roomId);
         ItenderRoom room = itenderRoomService.findById(roomId);
        int row = itenderRoomService.deleteById(roomId);
        List<ItenderDevice> deviceList = getDeviceListByRoom(roomId);
        for (int i = 0; i < deviceList.size(); i++) {
            itenderDeviceService.unbindRoom(deviceList.get(i));
        }

        if(row == 0){
            result.put("status", false);
            result.put("msg", "删除房间失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "更新房间接口",notes = "用于更新房间信息")
    @RequestMapping(value = "/updateRoom",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateRoom(HttpServletRequest request,@ApiParam(name = "name",value = "设备",required = true) @RequestBody ItenderRoom room
    ) throws APIException{
        logger.debug("==房间信息=="+room.toString());
        Map<String,Object> result = new HashMap<>();



        ItenderRoom roomExsit = itenderRoomService.findById(room.getId());
        if(roomExsit == null){
            result.put("status", false);
            result.put("msg", "未找到相关房间信息！");
            return ResponseEntity.ok(result);
        }

        List<ItenderDevice> exsitDeviceList = getDeviceListByRoom(roomExsit.getId());
        for (int i = 0; i < exsitDeviceList.size(); i++) {
            itenderDeviceService.unbindRoom(exsitDeviceList.get(i));
        }


        List<ItenderDevice> deviceList = room.getDeviceList();
        for (int i = 0; i < deviceList.size(); i++) {
            itenderDeviceService.bindRoom(deviceList.get(i),room.getId());
        }


        room = itenderRoomService.updateRoom(room);
        if(room == null){
            result.put("status", false);
            result.put("msg", "更新房间失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", room);
        return ResponseEntity.ok(result);
    }


    private List<ItenderDevice> getDeviceListByRoom(String roomId){
        List<ItenderDevice>  deviceList = new ArrayList<>();
        try {
            deviceList = itenderDeviceService.getRoomDeviceList();
        } catch (APIException e) {
            e.printStackTrace();
        }
        List<ItenderDevice>  deviceRoomList = new ArrayList<>();
        for (int i = 0; i < deviceList.size(); i++) {
            if(roomId.equals(deviceList.get(i).getRoomId())){
                deviceRoomList.add(deviceList.get(i));
            }
        }
        return  deviceRoomList;
    }



}
