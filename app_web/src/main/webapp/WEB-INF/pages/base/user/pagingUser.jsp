<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/page/base/user/pagingUser.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业管理
			<code>&gt;</code>
			人员管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<!-- <a class="button red" onclick="addUser();">添加人员</a> 
			<a class="button red" onclick="editUser();">编辑人员</a> 
			<a class="button red" onclick="removeUser();">删除人员</a> 
			<div class="blank10"></div> -->
			<div class="clearfix" style="height:600px">
				<table id="user-datagrid"></table>
				<div class="blank10"></div>
				<%-- <input type="button" class="button orange" value="添加" onclick="window.location='${pageContext.request.contextPath}/user/userEdit'" /> --%>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
