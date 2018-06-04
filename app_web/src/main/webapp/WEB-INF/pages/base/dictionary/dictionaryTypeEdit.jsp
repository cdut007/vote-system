<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form:form action="${pageContext.request.contextPath}/dictionary/createOrUpdateDictionaryType" method="post" modelAttribute="dictionaryType">
	<form:hidden path="typeCode" />
	<table>
		<tr>
			<th>字典类型名称:</th>
			<td><form:input path="typeName" cssClass="inputxt easyui-validatebox" data-options="required:true" cssStyle="width: 200px" /></td>
		</tr>
		<tr>
			<th>字典类型编码:</th>
			<td><form:input path="newTypeCode" cssClass="inputxt easyui-validatebox" data-options="required:true" cssStyle="width: 200px" /></td>
		</tr>
	</table>
</form:form>
