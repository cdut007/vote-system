<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:主体资质信息表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
</head>
<body>
<div class='block'>
	<div class="right_top_div">当前位置: 资质管理 &gt; 资质信息列表</div>
	<div class="tableTitle"><span>主体资质</span></div>
	<table class="mytableStyle">
		<thead>
			<tr>
				<th width="20px"></th>
				<th width="20px"><input type="checkbox" /></th>
				<th>主体代码</th>
				<th>资质序列、行业和专业类别</th>
				<th>资质等级</th>
				<th>资质证书编号</th>
				<th>信息申报责任人</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.rows}" var="t_organ_zz_item" varStatus="status">
				<tr>
					<th>${(page.page-1)*page.pageSize+status.count}</th>
					<td><input name="t_organ_zz_id" type="checkbox" value="${t_organ_zz_item.id }" /></td>
					<td>${t_organ_zz_item.ztdm00}</td>
					<td>${t_organ_zz_item.zzxl00}</td>
					<td>${util:dictionary('ZZDJDM',t_organ_zz_item.zzdj00)}</td>
					<td>${t_organ_zz_item.zzzsbh}</td>
					<td>${t_organ_zz_item.xxsbr0}</td>
				</tr>
			</c:forEach>
			<c:forEach begin="${fn:length(page.rows)+1}" end="${page.pageSize}" varStatus="status">
				<tr>
					<th>${fn:length(page.rows)+(page.page-1)*page.pageSize+status.count}</th>
					<td><input type="checkbox" disabled="disabled" /></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style='padding-top:2px;'>
			<div id="operation">
				<a class="easyui-linkbutton"  onclick="javascript:window.location.href='${pageContext.request.contextPath}/t_organ_zz/addOrMod'">新增</a>
				<a class="easyui-linkbutton"  onclick="edit();">修改</a>
				<a class="easyui-linkbutton"  onclick="del();">删除</a>
			</div>
		</div>
</div>
</body>
</html>
