package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderBook;
import com.itender.ms.domain.ItenderDevice;
import com.itender.ms.domain.ItenderIndustry;
import com.itender.ms.domain.ItenderRoom;
import com.itender.ms.enums.BookStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderBookService;
import com.itender.ms.service.ItenderDeviceService;
import com.itender.ms.service.ItenderIndustryService;
import com.itender.ms.service.ItenderRoomService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(description = "预订房间模块接口")
@Validated
@Controller
@RequestMapping("/book")
public class BookController {
	 private static final Logger logger = LoggerFactory.getLogger(BookController.class);

    @Autowired
    private ItenderBookService itenderBookService;


    @Autowired
    private ItenderRoomService itenderRoomService;



    @Autowired
    private ItenderIndustryService itenderIndustryService;



    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "book/book_list";
    }

    @ApiIgnore
    @RequestMapping(value = "/book_page",method = RequestMethod.GET)
    public String bookPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/book/book_list");
    }

    @ApiIgnore
    @RequestMapping(value = "/add_page",method = RequestMethod.GET)
    public String addBookPage(HttpServletRequest request,HttpServletResponse response){

        String roomId = request.getParameter("id");
        ItenderRoom room = null;
        if(CommonUtility.isNonEmpty(roomId)){
            room = itenderRoomService.findById(roomId);
        }
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        request.setAttribute("beginTime",beginTime);
        request.setAttribute("endTime",endTime);
        request.setAttribute("itenderRoom",room);

        try {
            List<ItenderIndustry> industryList = itenderIndustryService.findAll();

            request.setAttribute("industryList",industryList);
        } catch (APIException e) {
            e.printStackTrace();
        }


        return ViewUtil.forward("book/book_add");
    }



    @ApiOperation(value = "预订列表接口",notes = "用于查询所有预订房间信息")
    @RequestMapping(value = "/listBookRecord",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> bookRecordList(HttpServletRequest request,
                                                  @RequestParam(required = false) Integer pageNum,
                                                  @RequestParam(required = false) Integer pagesize
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderBook> page = itenderBookService.findPage(pageNum, pagesize);



        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }



    @ApiOperation(value = "预订房间列表接口",notes = "用于查询所有可预订房间信息")
    @RequestMapping(value = "/listBook",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> bookAll(HttpServletRequest request,
                                                    @RequestParam(required = false) Integer pageNum,
                                                    @RequestParam(required = false) Integer pagesize,
                                                  @RequestParam(required = false) Long beginTime,
                                                  @RequestParam(required = false) Long endTime

    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?50:pagesize;//一次取完
        //订房开始时间大于订单截止时间的房间才可用
        logger.debug("==获取开始时间="+beginTime);
        logger.debug("==获取结束时间="+endTime);

        if(beginTime == null){
            beginTime = new Long(0L);
        }

        if(endTime == null){
            endTime = new Long(0L);
        }

        List<ItenderBook> bookList = itenderBookService.findByBeginTime(beginTime,endTime);


        PageInfo<ItenderRoom> page = null;

        if(bookList!=null && bookList.size() > 0 ){

            page = itenderRoomService.findPageByFilterBookRooms(pageNum, pagesize,bookList);
        }else{
             page = itenderRoomService.findPage(pageNum, pagesize);
        }



        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }



    @ApiOperation(value = "添加预订接口",notes = "用于新增预订房间信息")
    @RequestMapping(value = "/addBook",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addBook(HttpServletRequest request,
                                                        @ApiParam(name = "name",value = "预订房间",required = true) @RequestBody ItenderBook book) throws APIException{
        Map<String,Object> result = new HashMap<>();
        book.setStatus(BookStatus.ordered.name());
        book = itenderBookService.add(book);

        if(!CommonUtility.isNonEmpty(book.getId())){
            result.put("status", false);
            result.put("msg", "预订房间失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", book);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "取消预订接口",notes = "用于取消预订房间信息")
    @RequestMapping(value = "/cancelBook",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> cancelBook(HttpServletRequest request,
                                                           @ApiParam(name = "bookId",value = "订单ID",required = true) @RequestParam(required = true) String bookId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        logger.debug("==取消预订id=="+bookId);
        ItenderBook book = itenderBookService.findById(bookId);
        book = itenderBookService.cancelRoom(bookId,book.getRoomId());

        if(book == null){
            result.put("status", false);
            result.put("msg", "取消预订房间失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }




}
