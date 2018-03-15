package com.itender.ms.controller;

import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.enums.DeviceStatus;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
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
import com.itender.ms.service.ItenderDeviceService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import springfox.documentation.annotations.ApiIgnore;

@Api(description = "设备管理模块接口")
@Validated
@Controller
@RequestMapping("/device")
public class DeviceController {
	 private static final Logger logger = LoggerFactory.getLogger(DeviceController.class);

	@Autowired
	private ItenderDeviceService itenderDeviceService;


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "device/device_list";
    }

    @ApiIgnore
    @RequestMapping(value = "/listDevice",method = RequestMethod.GET)
    public String devicePage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/device/device_list");
    }

    @ApiOperation(value = "设备列表接口",notes = "用于查询所有设备信息")
    @RequestMapping(value = "/listDevice",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> deviceAll(HttpServletRequest request,
                                                       @RequestParam(required = false) Integer pageNum,
                                                       @RequestParam(required = false) Integer pagesize,
                                                    @RequestParam(required = false) String keyword
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderDevice> page = null;
        itenderDeviceService.setSearchInfo(keyword);
        page = itenderDeviceService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }

    @ApiIgnore
    @RequestMapping(value = "/add_page",method = RequestMethod.GET)
    public String addDevicePage(HttpServletRequest request,HttpServletResponse response){

        return ViewUtil.forward("device/device_add");
    }

    @ApiIgnore
    @RequestMapping(value = "/edit_page",method = RequestMethod.GET)
    public String editDevicePage(HttpServletRequest request,HttpServletResponse response){
        String deviceId = request.getParameter("id");
        ItenderDevice device = null;
        if(CommonUtility.isNonEmpty(deviceId)){
            device = itenderDeviceService.findById(deviceId);
        }
        request.setAttribute("itenderDevice",device);
        return ViewUtil.forward("device/device_edit");
    }

    @ApiOperation(value = "添加设备接口",notes = "用于新增设备信息")
    @RequestMapping(value = "/addDevice",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addDevice(HttpServletRequest request,
                                                           @ApiParam(name = "name",value = "设备",required = true) @RequestBody ItenderDevice device) throws APIException{
        Map<String,Object> result = new HashMap<>();
        device.setStatus(DeviceStatus.normal.name());
        device = itenderDeviceService.add(device);
        if(!CommonUtility.isNonEmpty(device.getId())){
            result.put("status", false);
            result.put("msg", "添加设备失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", device);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "删除设备接口",notes = "用于删除设备信息")
    @RequestMapping(value = "/delDevice",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> delDevice(HttpServletRequest request,
                                                           @ApiParam(name = "deviceId",value = "设备ID",required = true) @RequestParam(required = true) String deviceId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        logger.debug("==删除设备id=="+deviceId);
        int row = itenderDeviceService.deleteById(deviceId);
        if(row == 0){
            result.put("status", false);
            result.put("msg", "删除设备失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "更新设备接口",notes = "用于更新设备信息")
    @RequestMapping(value = "/updateDevice",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateDevice(HttpServletRequest request,@ApiParam(name = "name",value = "设备",required = true) @RequestBody ItenderDevice device
    ) throws APIException{
        logger.debug("==设备信息=="+device.toString());
        Map<String,Object> result = new HashMap<>();
        ItenderDevice deviceExsit = itenderDeviceService.findById(device.getId());
        if(deviceExsit == null){
            result.put("status", false);
            result.put("msg", "未找到相关设备信息！");
            return ResponseEntity.ok(result);
        }


         device = itenderDeviceService.updateDevice(device);
        if(device == null){
            result.put("status", false);
            result.put("msg", "跟新设备失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", device);
        return ResponseEntity.ok(result);
    }

}
