package com.itender.ms.controller;

import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.util.CommonUtility;
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
                                                       @RequestParam(required = false) Integer pagesize
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderDevice> page = itenderDeviceService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }

    @ApiIgnore
    @RequestMapping(value = "/detail",method = RequestMethod.GET)
    public String addDeviceModal(HttpServletRequest request,HttpServletResponse response){
        String deviceId = request.getParameter("id");
        ItenderDevice device = null;
        if(CommonUtility.isNonEmpty(deviceId)){
            device = itenderDeviceService.findById(deviceId);
        }
        request.setAttribute("itenderDevice",device);
        return ViewUtil.forward("device/privilege_detils_modal");
    }

    @ApiOperation(value = "添加设备接口",notes = "用于新增设备信息")
    @RequestMapping(value = "/addDevice",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addDevice(HttpServletRequest request,
                                                           @ApiParam(name = "name",value = "设备名称",required = true) @RequestParam(required = true) String name,
                                                           @ApiParam(name = "model",value = "设备型号",required = true) @RequestParam(required = true) String model,
                                                           @ApiParam(name = "ip",value = "设备ip",required = true) @RequestParam(required = true) String ip,
                                                           @ApiParam(name = "port",value = "设备端口",required = true) @RequestParam(required = true) String port,
                                                           @ApiParam(name = "account",value = "设备账号",required = true) @RequestParam(required = true) String account,
                                                           @ApiParam(name = "password",value = "设备密码",required = true) @RequestParam(required = true) String password,
                                                           @ApiParam(name = "status",value = "设备状态",required = true) @RequestParam(required = true) String status,
                                                           @ApiParam(name = "maintenancePhone",value = "维护电话",required = true) @RequestParam(required = true) String maintenancePhone
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderDevice device = new ItenderDevice();
        device.setName(name);
        device.setName(name);
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
    @RequestMapping(value = "/delDevice",method = RequestMethod.GET)
    public ResponseEntity<Map<String,Object>> delPrivilege(HttpServletRequest request,
                                                           @ApiParam(name = "deviceId",value = "设备ID",required = true) @RequestParam(required = true) String deviceId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();

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
    public ResponseEntity<Map<String,Object>> updateDevice(HttpServletRequest request,
                                                           @ApiParam(name = "deviceId",value = "设备ID",required = true) @RequestParam(required = true) String deviceId,

                                                           @ApiParam(name = "name",value = "设备名称",required = true) @RequestParam(required = true) String name,
                                                              @ApiParam(name = "model",value = "设备型号",required = true) @RequestParam(required = true) String model,
                                                              @ApiParam(name = "ip",value = "设备ip",required = true) @RequestParam(required = true) String ip,
                                                              @ApiParam(name = "port",value = "设备端口",required = true) @RequestParam(required = true) String port,
                                                              @ApiParam(name = "account",value = "设备账号",required = true) @RequestParam(required = true) String account,
                                                              @ApiParam(name = "password",value = "设备密码",required = true) @RequestParam(required = true) String password,
                                                              @ApiParam(name = "status",value = "设备状态",required = true) @RequestParam(required = true) String status,
                                                              @ApiParam(name = "maintenancePhone",value = "维护电话",required = true) @RequestParam(required = true) String maintenancePhone
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderDevice device = itenderDeviceService.findById(deviceId);
        if(device == null){
            result.put("status", false);
            result.put("msg", "未找到相关设备信息！");
            return ResponseEntity.ok(result);
        }


         device = itenderDeviceService.updateDevice(device);
        if(device == null){
            result.put("status", false);
            result.put("msg", "添加设备失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", device);
        return ResponseEntity.ok(result);
    }

}
