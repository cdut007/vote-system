package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderIndustry;
import com.itender.ms.domain.ItenderIndustry;
import com.itender.ms.domain.ItenderUser;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderIndustryService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.channels.AcceptPendingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 行业类型控制器
 * @author Mao.Zeng@MG
 * @date 2018/2/10 16:41
 */
@Api(description = "行业接口")
@Controller
@RequestMapping("/industry")
public class IndustryController {

    @Autowired
    private ItenderIndustryService itenderIndustryService;


    @ApiIgnore
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String toInsdustry(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/user/industry_list");
    }


    @ApiOperation(value = "行业列表接口",notes = "用于查询行业列表信息")
    @RequestMapping(value = "/listAll",method = RequestMethod.POST)
    public ResponseEntity<List<ItenderIndustry>> industryList(HttpServletRequest request)
            throws APIException{

        List<ItenderIndustry> industryList = itenderIndustryService.findAll();

        return ResponseEntity.ok(industryList);
    }


    @ApiOperation(value = "行业列表接口",notes = "用于查询行业列表信息")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> page(HttpServletRequest request, HttpServletResponse response,
                                               @RequestParam(required = false) Integer pageNum,
                                               @RequestParam(required = false) Integer pagesize)
    throws APIException{
        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;
        PageInfo<ItenderIndustry> page = itenderIndustryService.findPage(pageNum,pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }

    @ApiIgnore
    @RequestMapping(value = "/industryDetils",method = RequestMethod.GET)
    public String industryModal(HttpServletRequest request,HttpServletResponse response){
        String industryId = request.getParameter("id");
        ItenderIndustry industry = null;
        if(CommonUtility.isNonEmpty(industryId)){
            industry = itenderIndustryService.findById(industryId);
        }
        request.setAttribute("itenderIndustry",industry);
        return ViewUtil.forward("/user/industry_detils_modal");
    }

    @ApiOperation(value = "添加行业接口",notes = "用于新增行业信息")
    @RequestMapping(value = "/addIndustry",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addIndustry(HttpServletRequest request,
                                                           @ApiParam(name = "industryName",value = "行业名",required = true) @RequestParam(required = true) String industryName
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();

        ItenderIndustry itenderIndustry = new ItenderIndustry();
        itenderIndustry.setIndustryName(industryName);
        itenderIndustry.setCreateTime(new Date());
        itenderIndustry = itenderIndustryService.add(itenderIndustry);
        if(!CommonUtility.isNonEmpty(itenderIndustry.getId())){
            result.put("status", false);
            result.put("msg", "添加行业异常！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "删除行业接口",notes = "用于删除行业信息")
    @RequestMapping(value = "",method = RequestMethod.DELETE)
    public ResponseEntity<Map<String,Object>> delIndustry(HttpServletRequest request,
         @ApiParam(name = "id",value = "行业ID",required = true) @RequestParam(name = "id") String id
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        if(!CommonUtility.isNonEmpty(id)){
            result.put("status", false);
            result.put("msg", "行业类型ID为空！");
            return ResponseEntity.ok(result);
        }
        int row = itenderIndustryService.deleteById(id);
        if(row == 0){
            result.put("status", false);
            result.put("msg", "删除行业异常！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "更新行业接口",notes = "用于更新行业信息")
    @RequestMapping(value = "",method = RequestMethod.PATCH)
    public ResponseEntity<Map<String,Object>> updateIndustry(HttpServletRequest request,
                                                              @ApiParam(name = "industryId",value = "行业ID",required = true) @RequestParam(required = true) String industryId,
                                                              @ApiParam(name = "industryName",value = "行业名",required = true) @RequestParam(required = true) String industryName
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderUser user = (ItenderUser) request.getSession().getAttribute("user");

        ItenderIndustry itenderIndustry = new ItenderIndustry();
        itenderIndustry.setId(industryId);
        itenderIndustry.setIndustryName(industryName);
        itenderIndustry.setUpdateTime(new Date());
        itenderIndustry.setOperator(user.getId());
        int row = itenderIndustryService.updateIndustry(itenderIndustry);
        if(row == 0){
            result.put("status", false);
            result.put("msg", "更新行业异常！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }


}
