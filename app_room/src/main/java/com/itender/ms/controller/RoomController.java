package com.itender.ms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.service.ItenderDeviceService;
import com.itender.ms.util.ViewUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderRoomService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import springfox.documentation.annotations.ApiIgnore;

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
    public String addDevicePage(HttpServletRequest request,HttpServletResponse response){

        return ViewUtil.forward("room/room_add");
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

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }



}
