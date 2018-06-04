<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form:form  action="${pageContext.request.contextPath}/department/saveOrUpdateDepartment" method="post" modelAttribute="department">
	<form:hidden path="id" />
	<table>
		<tr>
			<th>部门名称：</th>
			<td><form:input path="departmentName" cssClass="inputxt easyui-validatebox" data-options="required:true" /></td>
		</tr>
		<tr>
			<th>上级部门：</th>
			<td><form:input path="parentId" cssClass="inputxt easyui-combotree" data-options="required:true,url:'${pageContext.request.contextPath}/department/getDepartmentTree'" /></td>
		</tr>
		<tr>
			<th>部门描述：</th>
			<td><form:textarea path="description" /></td>
		</tr>
	</table>
</form:form>