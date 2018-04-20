package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.*;
import com.itender.ms.enums.ReviewRole;
import com.itender.ms.enums.ReviewStatus;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.service.ItenderUserService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(description = "审批管理模块接口")
@Validated
@Controller
@RequestMapping("/review")
public class ReviewController {
	 private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ItenderReviewService itenderReviewService;


    @Autowired
    private ItenderUserService itenderUserService;


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
    @RequestMapping(value = "/review_all_list",method = RequestMethod.GET)
    public String reviewAllListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_all_list");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_list",method = RequestMethod.GET)
    public String reviewListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_list");
    }

    @ApiIgnore
    @RequestMapping(value = "/review_sign",method = RequestMethod.GET)
    public String reviewSignPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_sign");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_all_detail",method = RequestMethod.GET)
    public String reviewAllDetailPage(HttpServletRequest request, HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }

        request.setAttribute("itenderReview",review);

        return ViewUtil.forward("/review/review_all_detail");
    }

    @ApiIgnore
    @RequestMapping(value = "/review_detail",method = RequestMethod.GET)
    public String reviewDetailPage(HttpServletRequest request, HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }

        request.setAttribute("itenderReview",review);

        return ViewUtil.forward("/review/review_detail");
    }


    @ApiOperation(value = "审批文件接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/confirms",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> confirms(HttpServletRequest request,
                                                    @RequestParam(required = false) String id
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(user == null){
            result.put("status", false);
            result.put("msg", "用户不存在，查询审批失败！");
            return ResponseEntity.ok(result);
        }
        itenderReviewService.setCurrentUser(user);
        ItenderReview review = itenderReviewService.findById(id);

        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review.getConfirms());

        return ResponseEntity.ok(result);

   }

    @ApiOperation(value = "审批文件附件接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/attaches",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> attachs(HttpServletRequest request,
                                                       @RequestParam(required = false) String id
    ) throws APIException{

        ItenderReview review = itenderReviewService.findById(id);
        Map<String,Object> result = new HashMap<>();
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review.getAttaches());

        return ResponseEntity.ok(result);

    }



    @ApiOperation(value = "审批列表接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/listReview",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> reviewAll(HttpServletRequest request,
                                                       @RequestParam(required = false) Integer pageNum,
                                                       @RequestParam(required = false) Integer pagesize,
                                                    @RequestParam(required = false) String keyword,
                                                    @RequestParam(required = false) boolean all
    ) throws APIException{
        ItenderUser user=null ;
        if(!all){
             user = (ItenderUser)request.getSession().getAttribute("user");

            if(user == null){
                return ResponseEntity.ok(PageDataConvert.convertToLayuiData(new PageInfo(),200,"success"));
            }
        }


        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderReview> page = null;
        itenderReviewService.setCurrentUser(user);
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
    @RequestMapping(value = "/choose_operator_page",method = RequestMethod.GET)
    public String chooseOperatorPage(HttpServletRequest request,HttpServletResponse response){
        String operator = request.getParameter("operator");
        String id = request.getParameter("id");
        List<ItenderUser> itenderUsers = itenderUserService.findByUserOperator(operator);
        request.setAttribute("id",id);
        request.setAttribute("itenderUsers",itenderUsers);
        return ViewUtil.forward("review/choose_operator");
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


    @ApiOperation(value = "添加审批附件接口",notes = "用于新增审批信息")
    @RequestMapping(value = "/addReviewAttach",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReviewAttach(HttpServletRequest request,ItenderReview review,@RequestParam("file") MultipartFile file) throws APIException{
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



    @ApiOperation(value = "添加审批接口",notes = "用于新增审批信息,审批类型: tender (招标登记表，招标文件审批),notice_delay（公告变更）, notice_update（公告延期）,notice_cancel（再次公告）,notice_again（控制价&清单）,notice_price_verfiy（公告延期）,bid_winning（中标通知书）")
    @RequestMapping(value = "/addReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReview(HttpServletRequest request,
                                                        @RequestBody ItenderReview review) throws APIException{
        Map<String,Object> result = new HashMap<>();
        review.setCreateTime(new Date());
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




    @ApiOperation(value = "更新签章接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateSignResult",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateSignResult(HttpServletRequest request,
                                                               @ApiParam(name = "signId",value = "signId",required = true) @RequestParam(required = true) String signId,
                                                               @ApiParam(name = "description",value = "description",required = false) @RequestParam(required = false) String description,
                                                               @ApiParam(name = "confirmId",value = "confirmId",required = true) @RequestParam(required = true) String confirmId,
                                                               @ApiParam(name = "signResult",value = "signResult",required = true) @RequestParam(required = true) String signResult
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();

        ItenderSign itenderSign = itenderReviewService.updateSignResult(confirmId,signId,signResult,description);
        if(itenderSign == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderSign);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "获取审批人列表",notes = "用于更新审批信息")
    @RequestMapping(value = "/getOperators",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> getOperators(HttpServletRequest request,
                                                                 @ApiParam(name = "operator",value = "operator",required = true) @RequestParam(required = true) String operator
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        List<ItenderUser> itenderUsers = itenderUserService.findByUserOperator(operator);

        if(itenderUsers == null){
            result.put("status", false);
            result.put("msg", "没有查询到相关人员！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderUsers);
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReviewStatus",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReviewStatus(HttpServletRequest request, @ApiParam(name = "id",value = "审批ID",required = true) @RequestParam(required = true) String id,
                                                                 @ApiParam(name = "assigneeId",value = "assigneeId",required = true) @RequestParam(required = true) String assigneeId,
                                                                 @ApiParam(name = "status",value = "status",required = true) @RequestParam(required = true) String status
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = null;

        ItenderUser itenderUser = itenderUserService.findByUserId(assigneeId);
        reviewExsit = itenderReviewService.updateReviewStatus(id,assigneeId,itenderUser.getOperator(),status);
        if(reviewExsit == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", reviewExsit);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "退回审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/rollbackReviewStatus",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> rollbackReviewStatus(HttpServletRequest request, @ApiParam(name = "id",value = "审批ID",required = true) @RequestParam(required = true) String id
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = null;

        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(user == null){
            result.put("status", false);
            return ResponseEntity.ok(result);
        }


       int resultCode = itenderReviewService.rollbackReviewStatus(id,user.getId());
        if(resultCode != 0 ){
            result.put("status", false);
            result.put("msg", "回退审批失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReview(HttpServletRequest request,@RequestBody ItenderReview review
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
