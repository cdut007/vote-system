<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:if test="${!(fn:length(list) > 0)}">暂无报名！</c:if>
<c:if test="${fn:length(list) > 0}">
<table class='queryTable'>
	<c:forEach items="${list}" var="tender" varStatus="status">
	<tr>
		<th style="text-align: right;">踏勘单位名称：</th><th>${tender.organName }</th>
	</tr>
	<tr>
		<th style="text-align: right;">负责人姓名：</th><th>${tender.tkfzrName }</th>
	</tr>
	<tr>
		<th style="text-align: right;">负责人电话：</th><th>${tender.tkfzrPhone }</th>
	</tr>
	<tr>
		<th style="text-align: right;">人数：</th><th>${tender.tkrs }</th>
	</tr>
	<tr>
		<td style="text-align: right;">踏勘标段名称：</td><td>
		<c:forEach items="${tender.tenderItemList}" var="item" varStatus="status">
			${item.projectItem.bdmc00}<c:if test="${!status.last }">,</c:if>
		</c:forEach>
		</td>
	</tr>
	</c:forEach>
</table>
</c:if>			