<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>

<html>
<head>
<%@include file="/common/link.jsp"%>
	<script type="text/javascript" src="/resources/page/guardian/listGuardian.js"></script>
</head>
<body>
	<div class="block">
		<div class="usBox">
			<div class="blank10"></div>
			<div class="clearfix" style="height:420px;">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="width:320,region:'west'">
						<table id="department-treegrid">
						</table>
					</div>
					<div data-options="region:'center'">
						<table id="userList"></table>
					</div>
				</div>
			</div>
		</div>
		<c:forEach items="${userIdList}" var="ite" varStatus="st">
			<input id="guardianIdAtPop_${st.index}" name="guardianIdAtPop_${st.index}" value="${ite}" type="text"/>
		</c:forEach>
	</div>
	<div class="blank10"></div>
</body>
</html>
