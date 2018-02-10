package com.itender.ms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@ApiIgnore
@Controller
@RequestMapping("/nopermission")
public class NoPermissionController {

	/**    
	 *非ajax访问返回跳转页面
	 * @param   
	 * @return   
	 */ 
	@RequestMapping("")
	public String NoPermissionAjax(HttpServletRequest request, HttpServletResponse response){
			return "nopermission";
	}

}
