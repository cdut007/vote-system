<%@page pageEncoding="utf-8"%>
<%@page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form action="${pageContext.request.contextPath}/tool/createOrAlter" method="post" modelAttribute="entityTemplate">
	<form:hidden path="tableName" />
	<form:hidden path="comment" />
	<c:forEach items="${entityTemplate.fieldWithMappingList}" var="item" varStatus="status">
		<form:hidden path="fieldWithMappingList[${status.index}].fieldName" />
		<form:hidden path="fieldWithMappingList[${status.index}].columnName" />
		<form:hidden path="fieldWithMappingList[${status.index}].fieldType" />
		<form:hidden path="fieldWithMappingList[${status.index}].notNull" />
		<form:hidden path="fieldWithMappingList[${status.index}].primary" />
	</c:forEach>
	<table id="tableform" class="mytableStyle" style="width:100%;">
		<tbody>
			<tr>
				<td>表名</td>
				<td>
					<h1>${entityTemplate.tableName}</h1>
				</td>
			</tr>
			<tr>
				<td>实体类包名</td>
				<td>
					<form:input cssClass="inputxt" path="packageName" />
				</td>
			</tr>
			<tr>
				<td>表单页大小</td>
				<td>
					<input class="inputxt" name="width" style="width:60px;background:#efefef"/>*<input class="inputxt" name="height" style="width:60px;background:#efefef"/>
				</td>
			</tr>
			<tr>
				<td>生成类型</td>
				<td style="text-align: left">
					<p>
						<a id="exportPOJO" class="button orange small">实体类</a>
					</p>
					<p>
						<a id="exportCONTROLLER" class="button orange small">控制器类</a>
					</p>
					<p>
						<a id="exportLIST" class="button orange small">列表页面</a>
					</p>
					<p>
						<a id="exportFORM" class="button orange small">表单页面</a>
					</p>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>