<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<div class="headE">
    <div class="ctr">
        <div class="pos0 left">
            	您好！欢迎访问${util:property('business.platformName')}
        </div>
        <div class="left">
           	<c:if test="${empty CURRENT_USER_SESSION_INFO}">
           		<a class="btn0" href="${util:property('sso.shiro.loginUrl')}">登录</a>
            	<a class="btn0" href="${util:property('shiro.registUrl')}">注册</a>
           	</c:if>
        </div>
        <div class="right pos0">
            	服务热线：<span class="blueT">${util:property('hotline')}</span>
        </div>
        <c:if test="${not empty CURRENT_USER_SESSION_INFO}">
	        <div class="right pos0">
		        <a href="${util:property('shiro.successUrl')}"><span class="ico_InLogin1 left">${CURRENT_USER_SESSION_INFO}</span></a>
		       	<a href="${util:property('shiro.logoutUrl')}"><span class="ico_OutLogin1 left">退出</span></a>
		    </div>
	    </c:if>
    </div>
</div>