<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- 
Describe:保证金退款
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<jsp:include page="/common/link.jsp" />
</head>

<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			保证金退款管理
			<code>&gt;</code>
			查看保证金退款凭证
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				查看保证金退款凭证
			</h4>
			<div class="blank10"></div>
			<table width="100%" style="table-layout:fixed;">
			<c:forEach items="${list}" var="attachment">
				<tr>
					<td><image src="${ctx}/jcebid/${attachment.path}" ></td>
				<tr>
			</tr>
			</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>

