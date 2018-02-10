package com.itender.ms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderIndustry;
import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.service.ItenderIndustryService;
import com.itender.ms.service.ItenderPrivilegeService;
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
import com.itender.ms.domain.ItenderRole;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderRoleService;
import com.itender.ms.util.CommonUtility;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import springfox.documentation.annotations.ApiIgnore;

@Api(description = "用户角色接口")
@Validated
@Controller
@RequestMapping("/management/role")
public class UserRoleController {
	private static final Logger logger = LoggerFactory.getLogger(UserRoleController.class);
	
	@Autowired
	private ItenderRoleService itenderRoleService;
	@Autowired
	private ItenderPrivilegeService itenderPrivilegeService;
	@Autowired
	private ItenderIndustryService itenderIndustryService;

	@ApiIgnore
	@RequestMapping(value = "/listRole", method = RequestMethod.GET)
	public String roleList(HttpServletRequest request, HttpServletResponse response){
		return ViewUtil.forward("/user/role_list");
	}

	@ApiOperation(value = "角色列表接口",notes = "用于查询所有角色信息")
    @RequestMapping(value = "/listRole",method = RequestMethod.POST)
	public ResponseEntity<LayuiTableData> roleAll(HttpServletRequest request,
												  @RequestParam(required = false) Integer pageNum,
												  @RequestParam(required = false) Integer pagesize
	) throws APIException{

		pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;
        
        PageInfo<ItenderRole> page = itenderRoleService.findPage(pageNum, pagesize);
		return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
	}

	@ApiIgnore
	@RequestMapping(value = "/roleDetils",method = RequestMethod.GET)
	public String roleDetilsModal(HttpServletRequest request,HttpServletResponse response) throws APIException{
		String roleId = request.getParameter("id");
		ItenderRole itenderRole = null;
		if(CommonUtility.isNonEmpty(roleId)){
			itenderRole = itenderRoleService.findById(roleId);
		}
		List<ItenderIndustry> itenderIndustries = itenderIndustryService.findAll();
		List<ItenderIndustry> exsitTypes = itenderIndustryService.findByRoleId(roleId);
		List<String> exsitRoleType = exsitTypes.stream().map(roleType ->{
			return roleType.getIndustryName();
		}).collect(Collectors.toList());
		request.setAttribute("itenderRole",itenderRole);
		request.setAttribute("roleTypes",itenderIndustries);//角色属性
		request.setAttribute("exsitTypes",exsitRoleType);//已拥有的角色属性
		return ViewUtil.forward("/user/role_detils_modal");
	}

	@ApiIgnore
	@RequestMapping(value = "/addRole",method = RequestMethod.GET)
	public String addRoleModal(HttpServletRequest request,HttpServletResponse response) throws APIException {
        List<ItenderPrivilege> privileges = itenderPrivilegeService.findAll();
        List<ItenderIndustry> itenderIndustries = itenderIndustryService.findAll();
        List<ItenderPrivilege> privilegesLev1 = privileges.stream().filter(privilege->{
            return privilege.getLevel()==1;
        }).collect(Collectors.toList());
        List<ItenderPrivilege> privilegesLev2 = privileges.stream().filter(privilege->{
            return privilege.getLevel()==2;
        }).collect(Collectors.toList());
        List<ItenderPrivilege> privilegesLev3 = privileges.stream().filter(privilege->{
            return privilege.getLevel()==3;
        }).collect(Collectors.toList());

        request.setAttribute("privilegesLev1",privilegesLev1);//Level的Role
        request.setAttribute("privilegesLev2",privilegesLev2);//Leve2的Role
        request.setAttribute("privilegesLev3",privilegesLev3);//Leve3的Role
		request.setAttribute("roleTypes",itenderIndustries);//角色属性

		return ViewUtil.forward("/user/role_add_modal");
	}
	
	@ApiOperation(value = "添加角色接口",notes = "用于新增角色信息")
    @RequestMapping(value = "/addRole",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> addRole(HttpServletRequest request,
			@ApiParam(name = "roleName",value = "角色名",required = true) @RequestParam(name = "roleName",required = true) String roleName,
			@ApiParam(name = "roleType",value = "角色属性") @RequestParam(name = "roleType",required = false) String[] roleType,
			@ApiParam(name = "privilegeId",value = "权限ID") @RequestParam(name = "privilegeId",required = false) String[] privilegeId
			) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderRole role = new ItenderRole();
		role.setRoleName(roleName);

		if((privilegeId == null || privilegeId.length == 0)&&(roleType == null || roleType.length == 0)){
    		role = itenderRoleService.add(role);
        }else{
		    role = itenderRoleService.addRole(role,privilegeId,roleType);
        }
		if(role == null){
			result.put("status", false);
			result.put("msg", "添加角色失败！");
		}else{
			result.put("status",true);
		}
		result.put("data", role);
		return ResponseEntity.ok(result);
	}
	
	@ApiOperation(value = "删除角色接口",notes = "用于删除角色信息")
    @RequestMapping(value = "/delRole",method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> delRole(HttpServletRequest request,
			@ApiParam(name = "roleId",value = "角色ID",required = true) @RequestParam(required = true) String roleId
			) throws APIException{
		Map<String,Object> result = new HashMap<>();

		int row = itenderRoleService.deleteById(roleId);
		if(row == 0){
			result.put("status", false);
			result.put("msg", "删除角色失败！");
		}else{
			result.put("status", true);
		}
		return ResponseEntity.ok(result);
	}

	@ApiOperation(value = "更新角色接口",notes = "用于更新角色信息")
	@RequestMapping(value = "/updateRole",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> updateRole(HttpServletRequest request,
			@ApiParam(name = "roleId",value = "角色ID",required = true) @RequestParam(required = true) String roleId,
			@ApiParam(name = "roleName",value = "角色名",required = true) @RequestParam(required = true) String roleName,
			@ApiParam(name = "roleTypeId",value = "角色属性") @RequestParam(name = "roleTypeId",required = false) String[] roleTypeId
	) throws APIException{
		Map<String,Object> result = new HashMap<>();

		ItenderRole itenderRole = itenderRoleService.findById(roleId);
		if(itenderRole == null){
			result.put("status", false);
			result.put("msg", "未找到相关角色信息！");
			return ResponseEntity.ok(result);
		}
		itenderRole.setRoleName(roleName);

		int row = itenderRoleService.updateRole(itenderRole,roleTypeId);
		if(row == 0){
			result.put("status", false);
			result.put("msg", "更新角色发生异常！");
		}else{
			result.put("status", true);
		}
		return ResponseEntity.ok(result);
	}
	
	@ApiOperation(value = "角色授权接口",notes = "用于给角色分配相关权限")
    @RequestMapping(value = "/authRole",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> roleAuthorize(HttpServletRequest request,
			@ApiParam(name = "roleId",value = "角色ID",required = true) @RequestParam(required = true) String roleId,
			@ApiParam(name = "privilegeId",value = "权限ID",required = true) @RequestParam(required = true) String[] privilegeId
			) throws APIException {
		Map<String,Object> result = new HashMap<>();

		if(privilegeId==null||privilegeId.length==0){
			privilegeId = new String[]{""};
		}

		boolean status = itenderRoleService.authRolePrivilege(roleId, privilegeId);
		if(!status){
			logger.debug("分配角色出错！");
		}
		
		result.put("status", status);
		return ResponseEntity.ok(result);
	}
	
	@ApiOperation(value = "设置角色接口",notes = "用于向用户分配角色")
    @RequestMapping(value = "/authUser",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> userAuthorize(HttpServletRequest request,
			@ApiParam(name = "userId",value = "用户ID",required = true) @RequestParam(required = true) String userId,
			@ApiParam(name = "roleId",value = "角色ID",required = true) @RequestParam(required = true) String[] roleId
			) throws APIException {
		Map<String,Object> result = new HashMap<>();

		if(roleId==null||roleId.length==0){
			roleId = new String[]{""};
		}

		boolean status = itenderRoleService.authUserRole(userId, roleId);
		if(!status){
			logger.debug("分配角色出错！");
		}

		result.put("status", status);
		return ResponseEntity.ok(result);
	}

	@ApiIgnore
	@RequestMapping(value = "/rolePrivilegeEditModal",method = RequestMethod.GET)
	public String userRoleEditModal(HttpServletRequest request, HttpServletResponse response) throws APIException {
		String roleId = request.getParameter("id");
		ItenderRole role = null;
		List<String> existPrivilege = null;
		if(CommonUtility.isNonEmpty(roleId)){
			role = itenderRoleService.findByRoleId(roleId);
			existPrivilege = role.getPrivileges().stream().map(mapper ->{
				return mapper.getId();
			}).collect(Collectors.toList());
		}

		List<ItenderPrivilege> privileges = itenderPrivilegeService.findAll();
		List<ItenderPrivilege> privilegesLev1 = privileges.stream().filter(privilege->{
			return privilege.getLevel()==1;
		}).collect(Collectors.toList());
		List<ItenderPrivilege> privilegesLev2 = privileges.stream().filter(privilege->{
			return privilege.getLevel()==2;
		}).collect(Collectors.toList());
		List<ItenderPrivilege> privilegesLev3 = privileges.stream().filter(privilege->{
			return privilege.getLevel()==3;
		}).collect(Collectors.toList());

		request.setAttribute("existPrivilege",existPrivilege);//已被赋予的role
		request.setAttribute("targetRole",role);
		request.setAttribute("privilegesLev1",privilegesLev1);//Level的Role
        request.setAttribute("privilegesLev2",privilegesLev2);//Leve2的Role
        request.setAttribute("privilegesLev3",privilegesLev3);//Leve3的Role
		return ViewUtil.forward("/user/role_privilege_modal");
	}

}
