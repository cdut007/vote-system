<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%-- <html>

Describe：添加或修改项目
Copyright: Copyright(c)2011
Company: 美宏博科技有限公司
author: zhangdingwang

<head>
<%@include file="/common/link.jsp"%>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			系统管理
			<code>&gt;</code>
			菜单维护
			<code>&gt;</code>
			添加菜单
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix"> --%>
				<form:form  action="${pageContext.request.contextPath}/department/saveOrUpdateDepartment" method="post" modelAttribute="department">
					<form:hidden path="id" />
					<table>
						<tr>
							<th>部门名称：</th>
							<td><form:input path="departmentName" cssClass="inputxt"/></td>
						</tr>
						<tr>
							<th>上级部门：</th>
							<td><form:input path="parentId" cssClass="inputxt easyui-combotree" data-options="url:'${pageContext.request.contextPath}/department/getDepartmentTree'" /></td>
						</tr>
						<tr>
							<th>部门描述：</th>
							<td><form:textarea path="description" /></td>
						</tr>
					</table>
					<%-- <div class="blank10"></div>
					<input type="submit" class="button red" value="保存" />
					<input type="button" class="button red" value="返回" onclick="window.location='${pageContext.request.contextPath}/department/listDepartment'" /> --%>
				</form:form>
			<%-- </div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html> --%>
