package com.itender.ms.controller;

import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.View;

import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.ItenderRole;
import com.itender.ms.service.ItenderRoleService;
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

import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderUser;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderUserService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import springfox.documentation.annotations.ApiIgnore;

@Api(description = "用户管理模块接口")
@Validated
@Controller
@RequestMapping("/management/user")
public class UserController {
	 private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private ItenderUserService itenderUserService;
	@Autowired
	private ItenderRoleService itenderRoleService;

	@ApiIgnore
	@RequestMapping("")
	public String index(HttpServletRequest request,HttpServletResponse response){
		return "user/index";
	}

	@ApiOperation(value = "用户登录接口",notes = "用于用户登录")
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> login(
    		@ApiParam(name = "username",value = "用户名",required = true) @RequestParam(required = true) String username,
    		@ApiParam(name = "password",value = "密码",required = true) @RequestParam(required = true) String password,
    		HttpServletRequest req) throws APIException{
		Map<String,Object> result = new HashMap<>();
    	ItenderUser user = itenderUserService.userLogin(username, password, true);
    	if(user == null){
    		result.put("status", false);
    		result.put("msg", "用户名或密码错误！");
    	}else{
    		result.put("status", true);
    		result.put("msg", "登录成功!");
    	}
    	
        return ResponseEntity.ok(result);
    }
    
	@ApiOperation(value = "用户注销接口",notes = "用于用户退出系统")
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public ResponseEntity<Map<String,Object>> logout(HttpServletRequest request) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");
		String username = user == null?"":user.getUserName();
		logger.info("user [" + username + "] logout");
		request.getSession().removeAttribute("user");
		result.put("status", true);
        return ResponseEntity.ok(result);
    }

    @ApiIgnore
	@RequestMapping(value = "/register",method = RequestMethod.GET)
    public String userRegisterPage(HttpServletRequest request, HttpServletResponse response){
		return ViewUtil.forward("/user/user_add_modal");
	}

	@ApiOperation(value = "用户注册接口",notes = "用于注册新用户")
    @RequestMapping(value = "/register",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> userRegister(HttpServletRequest request,
			@ApiParam(name = "username",value = "用户名",required = true) @RequestParam(required = true) String username,
    		@ApiParam(name = "password",value = "密码",required = true) @RequestParam(required = true) String password,
    		@ApiParam(name = "email",value = "Email",required = true) @RequestParam(required = false) String email
    		) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = new ItenderUser();
		user.setUserName(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setRegisterTime(new Date());
		user.setRegisterIp(request.getRemoteAddr());
		user.setDefaultAdmin(false);
		user = itenderUserService.add(user);
		if(user.getId() != null){
			result.put("status", true);		
			result.put("data", user);
		}else{
			result.put("status", false);	
		}
		return ResponseEntity.ok(result);
	}
	
	@ApiOperation(value = "删除用户接口",notes = "用于删除用户")
    @RequestMapping(value = "/delUser",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> delUser(HttpServletRequest request,
    		@ApiParam(name = "userId",value = "用户ID",required = true) @RequestParam(required = true) String userId,
    		@ApiParam(name = "operator",value = "操作员",required = true) @RequestParam(required = true) String operator
    		) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = itenderUserService.findByUserId(userId);
		if(user == null){
			result.put("message", "用户不存在！");
			result.put("status", false);
			return ResponseEntity.ok(result);
		}

		int row = itenderUserService.deleteById(user.getId());
		if(row != 0){
			logger.debug("[ "+operator+" ] 成功删除用户 ["+user.toString()+" ]");
			result.put("status", true);
		}else{
			logger.debug("[ "+operator+" ] 删除用户 ["+user.getUserName()+" ]失败！");
			result.put("status", false);
		}
        return ResponseEntity.ok(result);
    }

    @ApiIgnore
	@RequestMapping(value = "/detilsModal",method = RequestMethod.GET)
    public String userDetiles(HttpServletRequest request, HttpServletResponse response) throws APIException{
		String userId = request.getParameter("id");
		ItenderUser user = null;
		if(CommonUtility.isNonEmpty(userId)){
			user = itenderUserService.findById(userId);
			user.setPassword(itenderUserService.dePassword(user.getPassword()));
		}
		request.setAttribute("currentUser",user);
		return ViewUtil.forward("/user/user_detils_modal");
	}

	@ApiOperation(value = "用户详情接口",notes = "用于查询用户详细信息")
    @RequestMapping(value = "/detils",method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> userDetils(HttpServletRequest request,
			@ApiParam(name = "userId",value = "用户ID",required = true) @RequestParam(required = true) String userId){
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = itenderUserService.findById(userId);
		result.put("data", user);
		return ResponseEntity.ok(result);
	}

	@ApiIgnore
	@RequestMapping(value = "/listUser", method = RequestMethod.GET)
	public String userList(HttpServletRequest request, HttpServletResponse response){
		return ViewUtil.forward("/user/user_list");
	}

	@ApiOperation(value = "用户列表接口",notes = "用于查询所有用户信息")
    @RequestMapping(value = "/listUser",method = RequestMethod.POST)
	public ResponseEntity<LayuiTableData> userAll(HttpServletRequest request, HttpServletResponse res,
												  @RequestParam(required = false) Integer pageNum,
												  @RequestParam(required = false) Integer pagesize
	) throws APIException{
		pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;
        
        PageInfo<ItenderUser> page = itenderUserService.findPage(pageNum, pagesize);

		return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
	}
	
	@ApiOperation(value = "修改密码接口",notes = "用于用户修改密码")
    @RequestMapping(value = "/updatePwd",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updatePwd(HttpServletRequest request,
    		@ApiParam(name = "userId",value = "用户ID",required = true) @RequestParam(required = true) String userId,
    		@ApiParam(name = "oldPassword",value = "原密码",required = true) @RequestParam(required = true) String oldPassword,
    		@ApiParam(name = "newPassword",value = "新密码",required = true) @RequestParam(required = true) String newPassword
    		) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = itenderUserService.findById(userId);
		if(user == null){
			result.put("status", false);
			result.put("msg", "用户不存在！");
			return ResponseEntity.ok(result);
		}
		if(!oldPassword.equals(itenderUserService.dePassword(user.getPassword()))){
			result.put("status", false);
			result.put("msg", "原始密码错误！");
			return ResponseEntity.ok(result);
		}

		boolean status = itenderUserService.updatePassword(userId,newPassword);
		if(!status){
			logger.error("更新密码数据异常！");
			result.put("status", false);
			result.put("msg", "更新密码数据异常！");
			return ResponseEntity.ok(result);
		}
		result.put("status", true);
        return ResponseEntity.ok(result);
    }

	@ApiOperation(value = "修改用户信息接口",notes = "用于修改用户信息")
	@RequestMapping(value = "/updateUser",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> updateUser(HttpServletRequest request,
			@ApiParam(name = "userId",value = "用户ID",required = true) @RequestParam(required = true) String userId,
														 @ApiParam(name = "nickName",value = "用户姓名") @RequestParam(required = false) String nickName,
														 @ApiParam(name = "phone",value = "联系电话") @RequestParam(required = false) String phone,
														 @ApiParam(name = "company",value = "单位") @RequestParam(required = false) String company,
														 @ApiParam(name = "position",value = "职位") @RequestParam(required = false) String position,
														 @ApiParam(name = "email",value = "Email") @RequestParam(required = false) String email,
			@ApiParam(name = "password",value = "新密码",required = true) @RequestParam(required = true) String password
	) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = itenderUserService.findById(userId);
		if(user == null){
			result.put("status", false);
			result.put("msg", "用户不存在！");
			return ResponseEntity.ok(result);
		}
		user.setNickName(nickName);
		user.setPhone(phone);
		user.setCompany(company);
		user.setPosition(position);
		user.setEmail(email);
		user.setPassword(password);
		user = itenderUserService.updateUser(user);
		if(user == null){
			logger.error("更新用户数据异常！");
			result.put("status", false);
			return ResponseEntity.ok(result);
		}
		result.put("status", true);
		return ResponseEntity.ok(result);
	}

	@ApiIgnore
	@RequestMapping(value = "/updateMy",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> updatemy(HttpServletRequest request,
		 @ApiParam(name = "userId",value = "用户ID",required = true) @RequestParam(required = true) String userId,
		 @ApiParam(name = "email",value = "Email",required = true) @RequestParam(required = true) String email,
		 @ApiParam(name = "nickName",value = "用户姓名") @RequestParam(required = false) String nickName,
		@ApiParam(name = "phone",value = "联系电话") @RequestParam(required = false) String phone,
		@ApiParam(name = "company",value = "单位") @RequestParam(required = false) String company,
		@ApiParam(name = "position",value = "职位") @RequestParam(required = false) String position,
		 @ApiParam(name = "password",value = "新密码",required = true) @RequestParam(required = true) String password
	) throws APIException{
		Map<String,Object> result = new HashMap<>();
		ItenderUser user = itenderUserService.findById(userId);
		if(user == null){
			result.put("status", false);
			result.put("msg", "错误！用户不存在！");
			return ResponseEntity.ok(result);
		}
		user.setNickName(nickName);
		user.setPhone(phone);
		user.setCompany(company);
		user.setPosition(position);
		user.setEmail(email);
		user.setPassword(password);
		user = itenderUserService.updateUser(user);
		if(user == null){
			logger.error("更新用户数据异常！");
			result.put("status", false);
			return ResponseEntity.ok(result);
		}
		result.put("status", true);
		return ResponseEntity.ok(result);
	}

	@ApiIgnore
	@RequestMapping(value = "/userRoleEditModal",method = RequestMethod.GET)
	public String userRoleEditModal(HttpServletRequest request, HttpServletResponse response) throws APIException {
		String userId = request.getParameter("id");
		ItenderUser user = null;
		List<String> existRole = null;
		if(CommonUtility.isNonEmpty(userId)){
			user = itenderUserService.findByUserId(userId);
			user.setPassword(itenderUserService.dePassword(user.getPassword()));
			existRole = user.getRoles().stream().map(mapper ->{
				return mapper.getRoleName();
			}).collect(Collectors.toList());
		}

		List<ItenderRole> roles = itenderRoleService.findAll();
		request.setAttribute("existRole",existRole);//已被赋予的role
		request.setAttribute("targetUser",user);
		request.setAttribute("allRoles",roles);//所有role
		return ViewUtil.forward("/user/user_role_modal");
	}

}
