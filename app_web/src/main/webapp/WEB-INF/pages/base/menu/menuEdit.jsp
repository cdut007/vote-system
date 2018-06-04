<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<form:form method="post" action="${pageContext.request.contextPath}/menu/saveOrUpdateMenu" commandName="menu">
	<form:hidden path="id" />
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">菜单名称：</td>
			<td>
				<form:input path="menuName" cssClass="inputxt easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">上级菜单：</td>
			<td>
				<form:input path="parentId" class="easyui-combotree inputxt" data-options="url:'${pageContext.request.contextPath}/menu/getMenuTree',required:true" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>菜单类型：</td>
			<td>
				<form:select path="menuType" cssClass="inputxt easyui-validatebox" data-options="required:true">
					<option value="">-请选择-</option>
					<form:options items="${util:dictionaryTree('MENU_TYPE',false)}" itemLabel="itemName" itemValue="itemCode" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>请求地址：</td>
			<td>
				<form:input path="url" cssClass="inputxt" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>排序号：</td>
			<td>
				<form:input path="orderno" cssClass="inputxt easyui-numberbox" data-options="required:true"/>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>删除状态：</td>
			<td>
				<form:select path="deleteMark" cssClass="inputxt easyui-validatebox" data-options="required:true">
					<form:options items="${util:dictionaryTree('DELETE_MARK',false)}" itemLabel="itemName" itemValue="itemCode" />
				</form:select>
			</td>
		</tr>
	</table>
</form:form>