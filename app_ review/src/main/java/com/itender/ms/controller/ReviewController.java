package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderReview;
import com.itender.ms.enums.ReviewStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Api(description = "审批管理模块接口")
@Validated
@Controller
@RequestMapping("/review")
public class ReviewController {
	 private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ItenderReviewService itenderReviewService;


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "review/review_main";
    }

    @ApiIgnore
    @RequestMapping("/review")
    public String review(HttpServletRequest request,HttpServletResponse response){
        return "review/review_main";
    }


    @ApiIgnore
    @RequestMapping(value = "",method = RequestMethod.GET)
    public String reviewPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_main");
    }



    @ApiIgnore
    @RequestMapping(value = "/review_list",method = RequestMethod.GET)
    public String reviewListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_list");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_detail",method = RequestMethod.GET)
    public String reviewDetailPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_detail");
    }




    @ApiOperation(value = "审批列表接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/listReview",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> reviewAll(HttpServletRequest request,
                                                       @RequestParam(required = false) Integer pageNum,
                                                       @RequestParam(required = false) Integer pagesize,
                                                    @RequestParam(required = false) String keyword
    ) throws APIException{

        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderReview> page = null;
        itenderReviewService.setSearchInfo(keyword);
        page = itenderReviewService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }

    @ApiIgnore
    @RequestMapping(value = "/add_page",method = RequestMethod.GET)
    public String addReviewPage(HttpServletRequest request,HttpServletResponse response){

        return ViewUtil.forward("review/review_add");
    }

    @ApiIgnore
    @RequestMapping(value = "/edit_page",method = RequestMethod.GET)
    public String editReviewPage(HttpServletRequest request,HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }
        request.setAttribute("itenderReview",review);
        return ViewUtil.forward("review/review_edit");
    }


    public static boolean isLinux(String OS){
        return OS.indexOf("linux")>=0;
    }

    public static boolean isMacOS(String OS){
        return OS.indexOf("mac")>=0&&OS.indexOf("os")>0&&OS.indexOf("x")<0;
    }

    public static boolean isMacOSX(String OS){
        return OS.indexOf("mac")>=0&&OS.indexOf("os")>0&&OS.indexOf("x")>0;
    }

    public static boolean isWindows(String OS){
        return OS.indexOf("windows")>=0;
    }


    @ApiOperation(value = "添加审批接口",notes = "用于新增审批信息")
    @RequestMapping(value = "/addReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReview(HttpServletRequest request,
                                                           @ApiParam(name = "name",value = "审批",required = true)ItenderReview review,@RequestParam("file") MultipartFile file) throws APIException{
        Map<String,Object> result = new HashMap<>();

        // 文件上传后的路径
        String root = "C:\\\\";
        String os = System.getProperty("os.name").toLowerCase();
        if(isMacOS(os) || isMacOSX(os)){
            root = "/Users/mac/Downloads";
        }else if (isLinux(os)){
            root = "";
        }

        String filePath = root + File.separator+"data"+File.separator+"review_files"+File.separator;
        // 解决中文问题，liunx下中文路径，图片显示问题
        // fileName = UUID.randomUUID() + suffixName;
        File dest = new File(filePath + file.getOriginalFilename());
        // 检测是否存在目录
        if (!dest.getParentFile().exists()) {
           boolean success =  dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

      //  review.setStatus(ReviewStatus.normal.name());
        review = itenderReviewService.add(review);
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "删除审批接口",notes = "用于删除审批信息")
    @RequestMapping(value = "/delReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> delReview(HttpServletRequest request,
                                                           @ApiParam(name = "reviewId",value = "审批ID",required = true) @RequestParam(required = true) String reviewId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        logger.debug("==删除审批id=="+reviewId);
        int row = itenderReviewService.deleteById(reviewId);
        if(row == 0){
            result.put("status", false);
            result.put("msg", "删除审批失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReview(HttpServletRequest request,@ApiParam(name = "name",value = "审批",required = true) @RequestBody ItenderReview review
    ) throws APIException{
        logger.debug("==审批信息=="+review.toString());
        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = itenderReviewService.findById(review.getId());
        if(reviewExsit == null){
            result.put("status", false);
            result.put("msg", "未找到相关审批信息！");
            return ResponseEntity.ok(result);
        }


         review = itenderReviewService.updateReview(review);
        if(review == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }

}
