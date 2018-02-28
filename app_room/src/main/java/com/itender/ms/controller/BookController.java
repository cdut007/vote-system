package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.*;
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
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

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

        try {
            List<ItenderRoom> roomList = itenderRoomService.findAll();

            request.setAttribute("roomList",roomList);
        } catch (APIException e) {
            e.printStackTrace();
        }


        return "book/book_list";
    }

    @ApiIgnore
    @RequestMapping(value = "/book_page",method = RequestMethod.GET)
    public String bookPage(HttpServletRequest request, HttpServletResponse response){
        try {
            List<ItenderRoom> roomList = itenderRoomService.findAll();

            request.setAttribute("roomList",roomList);
        } catch (APIException e) {
            e.printStackTrace();
        }

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
                                                  @RequestParam(required = false) Integer pagesize,
                                                         @RequestParam(required = false) Long beginTime,
                                                         @RequestParam(required = false) Long endTime,
                                                         @RequestParam(required = false) String roomId
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        logger.debug("==获取查询开始时间="+beginTime);
        logger.debug("==获取查询结束时间="+endTime);
        logger.debug("==获取查询房间="+roomId);

        if(beginTime == null){
            beginTime = new Long(0L);
        }

        if(endTime == null){
            long tenYear =  315360000000L;
            endTime = System.currentTimeMillis()+tenYear;//加10年
        }

        itenderBookService.setSearchInfo(beginTime,endTime,roomId);


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
            endTime = System.currentTimeMillis()+365*10*24*3600*1000;//加10年
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
        //first check book
        List<ItenderBook> bookList = itenderBookService.findByBeginTime(book.getBeginTime().getTime(),book.getEndTime().getTime());
        if(bookList!=null && bookList.size() > 0 ){
            for (int i = 0; i < bookList.size(); i++) {
                if(book.getRoomId()!=null && book.getRoomId().equals(bookList.get(i).getRoomId())){

                    result.put("status", false);
                    result.put("msg", "该时间段已经被预订，请重新选择时间！");
                    result.put("code", "-1002");
                    result.put("data", book);
                    return ResponseEntity.ok(result);
                }
            }
        }


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




    @ApiOperation(value = "下载报表接口",notes = "用于下载报表预订房间信息")
    @RequestMapping(value = "/downloadRecord",method = RequestMethod.GET)
    public void  getExcel (HttpServletRequest request,HttpServletResponse response)
     throws APIException{

        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String roomId = request.getParameter("roomId");
        if(roomId!=null){
            roomId = roomId.trim();
            if(StringUtils.isEmpty(roomId)){
                roomId = null;
            }
        }

        if(beginTime == null){
            beginTime = "0";
        }

        if(endTime == null){
            long tenYear =  315360000000L;
            endTime = String.valueOf(System.currentTimeMillis()+tenYear);//加10年
        }

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String date = formatter.format(new Date(Long.parseLong(beginTime))) +"~"+ formatter.format(new Date(Long.parseLong(endTime)));

        List<ItenderBook> bookList = itenderBookService.exportBookRoomByTime(Long.parseLong(beginTime),Long.parseLong(endTime),roomId);
        //List<ItenderBook> bookList = itenderBookService.findAll();

        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet =wb.createSheet("获取房间预订表格");
        HSSFRow row = null;

        row = sheet.createRow(0);
        row.setHeight((short)(26.25*20));
        row.createCell(0).setCellValue("房间预订信息列表");
        row.getCell(0).setCellStyle(getStyle(wb,0));//设置样式
        for(int i = 1;i <= 3;i++){
            row.createCell(i).setCellStyle(getStyle(wb,0));
        }
        CellRangeAddress rowRegion = new CellRangeAddress(0,0,0,3);
        sheet.addMergedRegion(rowRegion);

        CellRangeAddress columnRegion = new CellRangeAddress(1,4,0,0);
        sheet.addMergedRegion(columnRegion);

        row = sheet.createRow(1);
        row.createCell(0).setCellStyle(getStyle(wb,3));
        row.setHeight((short)(22.50*20));
        row.createCell(1).setCellValue("房间名");
        row.createCell(2).setCellValue("预定时间");
        row.createCell(3).setCellValue("预定事项");
        row.createCell(4).setCellValue("预定单位");
        row.createCell(5).setCellValue("预定人");
        row.createCell(6).setCellValue("联系方式");
        row.createCell(7).setCellValue("预订类型");
        row.createCell(8).setCellValue("创建时间");
        row.createCell(9).setCellValue("是否取消");
        for(int i = 1;i <= 9;i++){
            row.getCell(i).setCellStyle(getStyle(wb,1));
        }

        for(int i = 0;i<bookList.size();i++){
            row = sheet.createRow(i+2);
            ItenderBook book = bookList.get(i);
            row.createCell(1).setCellValue(book.getRoom());
            row.createCell(2).setCellValue(book.getBookTime());
            row.createCell(3).setCellValue(book.getContent());
            row.createCell(4).setCellValue(book.getBookOrganization());
            row.createCell(5).setCellValue(book.getBookUser());
            row.createCell(6).setCellValue(book.getBookUserMobile());
            row.createCell(7).setCellValue(book.getIndustry());
            row.createCell(8).setCellValue(book.getCreateTimeStr());
            if(BookStatus.cancel.name().equals(book.getStatus())){
                row.createCell(9).setCellValue("已取消");
            }else{
                row.createCell(9).setCellValue("");
            }

            for(int j = 1;j <= 9;j++){
                row.getCell(j).setCellStyle(getStyle(wb,2));
            }
        }

        //默认行高
        sheet.setDefaultRowHeight((short)(16.5*20));
        //列宽自适应
        for(int i=0;i<=13;i++){
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        response.setHeader("Content-disposition","attachment;filename="+new String("room_record_")+date+".xls");

        OutputStream os = null;
        try {
            os = response.getOutputStream();
            wb.write(os);
            os.flush();
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


        Map<String,Object> result = new HashMap<>();
        logger.debug("==生成报表完毕==");
        result.put("status", true);
        result.put("msg", "生成报表完毕！");
       // return ResponseEntity.ok(result);

    }

    /**
     * 获取样式
     * @param hssfWorkbook
     * @param styleNum
     * @return
     */
    public HSSFCellStyle getStyle(HSSFWorkbook hssfWorkbook, Integer styleNum){
        HSSFCellStyle style = hssfWorkbook.createCellStyle();
        style.setBorderRight(BorderStyle.THIN);//右边框
        style.setBorderBottom(BorderStyle.THIN);//下边框

        HSSFFont font = hssfWorkbook.createFont();
        font.setFontName("微软雅黑");//设置字体为微软雅黑

        HSSFPalette palette = hssfWorkbook.getCustomPalette();//拿到palette颜色板,可以根据需要设置颜色
        switch (styleNum){
            case(0):{
                style.setAlignment(HorizontalAlignment.CENTER_SELECTION);//跨列居中
                font.setBold(true);//粗体
                font.setFontHeightInPoints((short) 14);//字体大小
                style.setFont(font);
                palette.setColorAtIndex(HSSFColor.BLUE.index,(byte)184,(byte)204,(byte)228);//替换颜色板中的颜色
                style.setFillForegroundColor(HSSFColor.BLUE.index);
                style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            }
            break;
            case(1):{
                font.setBold(true);//粗体
                font.setFontHeightInPoints((short) 11);//字体大小
                style.setFont(font);
            }
            break;
            case(2):{
                font.setFontHeightInPoints((short)10);
                style.setFont(font);
            }
            break;
            case(3):{
                style.setFont(font);

                palette.setColorAtIndex(HSSFColor.GREEN.index,(byte)0,(byte)32,(byte)96);//替换颜色板中的颜色
                style.setFillForegroundColor(HSSFColor.GREEN.index);
                style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            }
            break;
        }

        return style;
    }





}
