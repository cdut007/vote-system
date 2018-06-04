<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form method="post">
	<table>
		<tr>
			<th style="text-align: right;">招标项目名称：</th><th>${tender.projectInstanceName}<input type="hidden" name="tenderId" value="${tender.id }"/></th>
		</tr>
		<tr>
			<td style="text-align: right;">负责人姓名：</td><td><input type="text" name="tkfzrName" value="${tender.tkfzrName}" class="inputxt easyui-validatebox"  data-options="required:true" /></td>
		</tr>
		<tr>
			<td style="text-align: right;">负责人电话：</td><td><input type="text" name="tkfzrPhone" value="${tender.tkfzrPhone}" class="inputxt easyui-validatebox"  data-options="required:true,validType:['length[7,13]']
			" /></td>
		</tr>
		<tr>
			<td style="text-align: right;">踏勘人数：</td><td><input type="text" name="tkrs" value="${tender.tkrs}" class="inputxt easyui-numberbox"  data-options="required:true,min:1" /></td>
		</tr>
		<c:forEach items="${tenderItemList}" var="item" varStatus="status">
		<tr>
		<td style="text-align: right;">标段名称：</td><td><input type="checkbox" name="itemId" value="${item.id }" <c:if test="${item.isReconnaissance==1 }">checked</c:if> class="easyui-validatebox"  data-options="required:true" />${item.projectItem.bdmc00}</td>
		</tr>
		</c:forEach>
	</table>
</form>
