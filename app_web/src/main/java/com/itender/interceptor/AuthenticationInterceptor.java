package com.itender.interceptor;

import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.domain.ItenderUser;
import com.itender.ms.exception.APIException;
import com.itender.ms.util.CommonUtility;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.Writer;
import java.util.List;


public class AuthenticationInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(AuthenticationInterceptor.class);

	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * 检查访问权限
	 * @param URI
	 * @return
	 */
	private boolean permissionCheck(List<String> uris, String URI) {
		boolean result = false;
		for (String regx : uris) {
			if (CommonUtility.simpleWildcardMatch(regx, URI)) {
				result = true;
				break;
			}
		}
		return result;
	}

	/**
	 * 对已登录的用户权限检查
	 * @param user
	 * @param uri
	 * @return
	 * @throws APIException
	 */
	private boolean checkPrivilege(ItenderUser user, String uri,String method) throws APIException {
		if (user == null || !CommonUtility.isNonEmpty(uri)) return false;
		uri = uri.split(";")[0];
		boolean result = false;
		if (user != null && CommonUtility.isNonEmpty(uri)) {
			if (permissionCheck(propertiesConfig.login_uncheck_uri, uri)) {
				return true;
			}
			List<ItenderPrivilege> privileges = user.getPrivileges();
			if (null != privileges && !privileges.isEmpty()) {
				for (ItenderPrivilege p : privileges) {
					if(!CommonUtility.isNonEmpty(p.getPrivilegeUri())) {
						continue;
					}
					if (uri.equals(p.getPrivilegeUri()) && method.equals(p.getPrivilegeMethod())) {
						result = true;
						break;
					}
				}
			}
		}
		return result;
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// ####################################################
		// 若有sessionId,则获取session
		// ####################################################
		HttpSession session = null;
		session = request.getSession();

		ItenderUser user = null;
		user = (ItenderUser) session.getAttribute("user");
		String basePath = request.getContextPath();
		String uri = request.getRequestURI();
		uri = uri.substring(basePath.length(), uri.length());
		String method = request.getMethod();
		//当前节点link
		request.setAttribute("menuLink", uri);
		//获取顶级节点
		String topLink = getTopLink(uri);
		request.setAttribute("topLink", topLink);
		logger.debug("The Request uri:["+uri+"] method:["+method+"]");

		//判断是否为ajax请求，默认不是
		boolean isAjaxRequest = false;
		if(!StringUtils.isEmpty(request.getHeader("x-requested-with")) && request.getHeader("x-requested-with").equals("XMLHttpRequest")){
			isAjaxRequest = true;
		}

		if(!propertiesConfig.backend_check_prefix.equalsIgnoreCase(topLink)
				&& !"/".equals(propertiesConfig.backend_check_prefix)) {
			return true;
		}

		boolean result = false;
		// ####################################################
		// 未登录用户
		// ####################################################
		if (user == null) {
			//指定URL不进行校验
			if (permissionCheck(propertiesConfig.always_uncheck_uri, uri)) {
				result = true;
			} else {
				result = false;
				if(isAjaxRequest){
					response.setStatus(403);
				}else{
					response.sendRedirect(basePath + propertiesConfig.backend_login_uri);
				}
			}
		} 

		// ####################################################
		// 已登录用户
		// ####################################################
		if (user != null) {
			//对默认管理员方行
			if(user.isDefaultAdmin()){
				return true;
			}
			// 放行无需检查的URI
			if (checkPrivilege(user, uri,method)) {
				result = true;
			} else {
				// 没有权限，则跳转到提示页面
				logger.debug("==> No Permission");
				if(propertiesConfig.no_permission_uri.equals(uri)){
					return true;
				}else{
					if(isAjaxRequest){
						response.setContentType("text/html;charset=utf-8");
						Writer out = response.getWriter();
						out.write("{\"status\": false, \"msg\": \"你没有相关权限！\"}");
						out.flush();
					}else {
						response.sendRedirect(basePath + propertiesConfig.no_permission_uri);
					}
				}
			}
		}

		return result;
	}

	private String getTopLink(String uri) {
		if(uri.startsWith("/admin")) {
			String topLink = uri.replaceFirst("/admin/", "");
			String[] phases = topLink.split("/");
			topLink = "/admin/" + phases[0];
			return topLink;
		}else{
			String[] phases = uri.split("/");
			if(phases.length < 2) {
				return "/";
			}else{
				return "/" + phases[1];
			}
		}
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		StringBuffer url = request.getRequestURL();
		String tempContextUrl = url.delete(
				url.length() - request.getRequestURI().length(), url.length())
				.toString();
		request.setAttribute("host", tempContextUrl);
		super.postHandle(request, response, handler, modelAndView);
	}

}
