package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.*;
import com.itender.ms.enums.BookStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderBookService;
import com.itender.ms.service.ItenderDeviceService;
import com.itender.ms.service.ItenderIndustryService;
import com.itender.ms.service.ItenderRoomService;
import com.itender.ms.util.CommonUtility;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 现场监控
 * @author Mao.Zeng@MG
 * @date 2018/3/1 15:49
 */
@Controller
@RequestMapping(value = "/supervision")
@ApiIgnore
public class SupervisionController {
    private static final Logger logger = LoggerFactory.getLogger(SupervisionController.class);

    @Autowired
    private ItenderBookService itenderBookService;
    @Autowired
    private ItenderDeviceService itenderDeviceService;
    @Autowired
    private ItenderRoomService itenderRoomService;
    @Autowired
    private ItenderIndustryService itenderIndustryService;

    @RequestMapping(value = "")
    public String supervisionIndex(HttpServletRequest request) throws APIException{

        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");
        List<ItenderIndustry> itenderIndustries = null;
        if(user != null){
            itenderIndustries = itenderIndustryService.findByUserId(user.getId());
        }

        List<ItenderBook> itenderBooks = new ArrayList<>();
        for(ItenderIndustry itenderIndustry: itenderIndustries){
            List<ItenderBook> itenderBooks1 = itenderBookService.findByIndustry(itenderIndustry.getIndustryName());
            itenderBooks.addAll(itenderBooks1);
        }

        List<ItenderBook> visibleRoomList = itenderBooks.stream().filter(itenderBook -> {
            return itenderBook.getStatus().equals(BookStatus.occupy.toString());
        }).collect(Collectors.toList());
        List<ItenderBook> unvisibleRoomList = itenderBooks.stream().filter(itenderBook -> {
            return itenderBook.getStatus().equals(BookStatus.ordered.toString());
        }).collect(Collectors.toList());


        request.setAttribute("visibleRoomList",visibleRoomList);//已开始可查看房间列表
        request.setAttribute("unvisibleRoomList",unvisibleRoomList);//未开始可查看房间列表
        request.setAttribute("roomList",itenderBooks);//所有房间列表

        return "/supervision/index";
    }

    @RequestMapping(value = "/startVideo")
    public String startSupervise(HttpServletRequest request) throws APIException{
        String roomId = request.getParameter("room");
        request.setAttribute("roomId",roomId);
        return "/supervision/startVideo";
    }


    @RequestMapping(value = "/roomDevList")
    public ResponseEntity<Map<String,Object>> devList(HttpServletRequest request,@RequestParam(name = "roomId") String roomId) throws APIException{
        Map<String,Object> result = new HashMap<>();
        List<ItenderDevice> devices = new ArrayList<>();
        if(CommonUtility.isNonEmpty(roomId)){
            devices = itenderDeviceService.getRoomDeviceListByRoomId(roomId);
        }
        result.put("data",devices);
        return ResponseEntity.ok(result);
    }

    @RequestMapping(value = "/searchRoom",method = RequestMethod.GET)
    public ResponseEntity<Map<String,Object>> filterDev(HttpServletRequest request,
                                                        @RequestParam(required = false) Long beginTime,
                                                        @RequestParam(required = false) Long endTime,
                                                        @RequestParam(required = false) String roomId) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");
        List<ItenderIndustry> itenderIndustries = new ArrayList<>();
        List<String> industyNames = new ArrayList<>();
        if(user != null){
            itenderIndustries = itenderIndustryService.findByUserId(user.getId());
            industyNames = itenderIndustries.stream().map(itenderIndustry -> {
                return itenderIndustry.getIndustryName();
            }).collect(Collectors.toList());
        }
        if(beginTime == null){
            beginTime = new Long(0L);
        }
        if(endTime == null){
            long tenYear =  315360000000L;
            endTime = System.currentTimeMillis()+tenYear;
        }


        itenderBookService.setSearchInfo(beginTime,endTime,roomId);
        Integer pageNum = 1;
        Integer pagesize = 10000;
        PageInfo<ItenderBook> page = itenderBookService.findPage(pageNum,pagesize);
        List<ItenderBook> itenderBooks = page.getList();

        List<String> finalIndustyNames = industyNames;
        List<ItenderBook> roomList = itenderBooks.stream().filter(itenderBook -> {
            return finalIndustyNames.contains(itenderBook.getIndustry());
        }).collect(Collectors.toList());

        result.put("data",roomList);

        return ResponseEntity.ok(result);
    }

    /**
     * 操作记录
     * @param
     * @return
     */
    @RequestMapping(value = "/logRecord",method = RequestMethod.GET)
    public ResponseEntity<Map<String,Object>> logRecord(HttpServletRequest request,@RequestParam(name = "option") String option){
        Map<String,Object> result = new HashMap<>();
        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(option.equals("startVideo")){
            logger.debug("[ "+user.getNickName()+" ] 进入监控实况预览！");
        }else if(option.equals("exitVideo")){
            logger.debug("[ "+user.getNickName()+" ] 离开监控实况预览！");
        }
        result.put("status",true);
        return ResponseEntity.ok(result);
    }
}
