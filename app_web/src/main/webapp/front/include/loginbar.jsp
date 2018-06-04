<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<c:choose>
	<c:when test="${empty CURRENT_USER_SESSION_INFO}">
		<div class="login_box">
			<a href="${util:property('sso.shiro.loginUrl')}"><span class="left">登录</span></a>
			<div class="left"></div>
			<a href="${util:property('shiro.registUrl')}"><span class="right">免费注册</span></a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="login_box_info">
			<a href="${util:property('shiro.successUrl')}" style="color:#fff;">
				<span class="ico_InLogin left"></span>
	            <span class="login_yes_info left">
	                <p class="text_over">${CURRENT_USER_SESSION_INFO}</p>
	                <p class="text_over">${CURRENT_USER_SESSION_INFO.organ}</p>
	            </span>
            </a>
            <a href="${util:property('shiro.logoutUrl')}"><span class="ico_OutLogin right"></span></a>
		</div>
	</c:otherwise>
</c:choose>