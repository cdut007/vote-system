package com.itender.ms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.View;

import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
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

import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderPrivilegeService;
import com.itender.ms.util.CommonUtility;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import springfox.documentation.annotations.ApiIgnore;

@Api(description = "用户权限接口")
@Validated
@Controller
@RequestMapping("/management/privilege")
public class UserPrivilegeController {
	private static final Logger logger = LoggerFactory.getLogger(UserPrivilegeController.class);
	
	@Autowired
	private ItenderPrivilegeService itenderPrivilegeService;

	@ApiIgnore
	@RequestMapping(value = "/listPrivilege",method = RequestMethod.GET)
	public String privilegePage(HttpServletRequest request, HttpServletResponse response){
		return ViewUtil.forward("/user/privilege_list");
	}

	@ApiOperation(value = "权限列表接口",notes = "用于查询所有权限信息")
    @RequestMapping(value = "/listPrivilege",method = RequestMethod.POST)
	public ResponseEntity<LayuiTableData> privilegeAll(HttpServletRequest request,
													   @RequestParam(required = false) Integer pageNum,
													   @RequestParam(required = false) Integer pagesize
	) throws APIException{

		pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;
        
        PageInfo<ItenderPrivilege> page = itenderPrivilegeService.findPage(pageNum, pagesize);

		return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
	}

	@ApiIgnore
	@RequestMapping(value = "/privilegeDetils",method = RequestMethod.GET)
	public String addPrivilegeModal(HttpServletRequest request,HttpServletResponse response){
		String privilegeId = request.getParameter("id");
		ItenderPrivilege privilege = null;
		if(CommonUtility.isNonEmpty(privilegeId)){
			privilege = itenderPrivilegeService.findById(privilegeId);
		}
		request.setAttribute("itenderPrivilege",privilege);
		return ViewUtil.forward("user/privilege_detils_modal");
	}

	@ApiOperation(value = "添加权限接口",notes = "用于新增权限信息")
    @RequestMapping(value = "/addPrivilege",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> addPrivilege(HttpServletRequest request,
			@ApiParam(name = "privilegeName",value = "权限名",required = true) @RequestParam(required = true) String privilegeName,
			@ApiParam(name = "privilegeUri",value = "资源URI",required = true) @RequestParam(required = true) String privilegeUri,
			@ApiParam(name = "privilegeMethod",value = "请求方法",required = true) @RequestParam(required = true) String privilegeMethod,
			@ApiParam(name = "alias",value = "别名",required = true) @RequestParam(required = true) String alias,
			@ApiParam(name = "icon",value = "图标",required = false) @RequestParam(required = false) String icon,
			@ApiParam(name = "seq",value = "序号",required = false) @RequestParam(required = false) Integer seq,
			@ApiParam(name = "level",value = "等级",required = true) @RequestParam(required = true) Integer level,
			@ApiParam(name = "ref",value = "关联",required = true) @RequestParam(required = true) String ref
			) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderPrivilege privilege = new ItenderPrivilege();
		privilege.setPrivilegeName(privilegeName);
		privilege.setPrivilegeUri(privilegeUri);
		privilege.setPrivilegeMethod(privilegeMethod);
		privilege.setAlias(alias);
		privilege.setIcon(icon);
		privilege.setSeq(seq);
		privilege.setLevel(level);
		privilege.setRef(ref);
		privilege = itenderPrivilegeService.add(privilege);
		if(!CommonUtility.isNonEmpty(privilege.getId())){
			result.put("status", false);
			result.put("msg", "添加权限失败！");
		}else{
			result.put("status", true);
		}
		result.put("data", privilege);
		return ResponseEntity.ok(result);
	}
	
	@ApiOperation(value = "删除权限接口",notes = "用于删除权限信息")
    @RequestMapping(value = "/delPrivilege",method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> delPrivilege(HttpServletRequest request,
			@ApiParam(name = "privilegeId",value = "权限ID",required = true) @RequestParam(required = true) String privilegeId
			) throws APIException{
		Map<String,Object> result = new HashMap<>();

		int row = itenderPrivilegeService.deleteById(privilegeId);
		if(row == 0){
			result.put("status", false);
			result.put("msg", "删除权限失败！");
		}else{
			result.put("status", true);
		}
		return ResponseEntity.ok(result);
	}

	@ApiOperation(value = "更新权限接口",notes = "用于更新权限信息")
	@RequestMapping(value = "/updatePrivilege",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> updatePrivilege(HttpServletRequest request,
			@ApiParam(name = "privilegeId",value = "权限ID",required = true) @RequestParam(required = true) String privilegeId,
			@ApiParam(name = "privilegeName",value = "权限名",required = true) @RequestParam(required = true) String privilegeName,
			@ApiParam(name = "privilegeUri",value = "资源URI",required = true) @RequestParam(required = true) String privilegeUri,
			@ApiParam(name = "privilegeMethod",value = "请求方法",required = true) @RequestParam(required = true) String privilegeMethod,
			@ApiParam(name = "alias",value = "别名",required = true) @RequestParam(required = true) String alias,
			@ApiParam(name = "icon",value = "图标",required = false) @RequestParam(required = false) String icon,
			@ApiParam(name = "seq",value = "序号",required = false) @RequestParam(required = false) Integer seq,
			@ApiParam(name = "level",value = "等级",required = true) @RequestParam(required = true) Integer level,
  @ApiParam(name = "ref",value = "关联",required = true) @RequestParam(required = true) String ref
	) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderPrivilege privilege = itenderPrivilegeService.findById(privilegeId);
		if(privilege == null){
			result.put("status", false);
			result.put("msg", "未找到相关权限信息！");
			return ResponseEntity.ok(result);
		}
		privilege.setPrivilegeName(privilegeName);
		privilege.setPrivilegeUri(privilegeUri);
		privilege.setPrivilegeMethod(privilegeMethod);
		privilege.setAlias(alias);
		privilege.setIcon(icon);
		privilege.setSeq(seq);
		privilege.setLevel(level);
		privilege.setRef(ref);

		int row = itenderPrivilegeService.updatePrivilege(privilege);
		if(row <= 0){
			result.put("status", false);
			result.put("msg", "添加权限失败！");
		}else{
			result.put("status", true);
		}
		result.put("data", privilege);
		return ResponseEntity.ok(result);
	}
	
}
