<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>

<script type="text/javascript">

$(function() {
	var organId = "${organId}";
	
	$("#organBCredit_list").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		fitColumns : true,
		height : 400,
		pagination : true,
		title:"投标单位信用评价信息",
		url : "${pageContext.request.contextPath}/organ/organBCreditViewData",
		queryParams : {organId:organId},
		idField : "id",
		columns : [ [
			{field:"credit",title:"评价日期",width:200}, 
			{field:"credit",title:"评价等级开始日期",width:200}, 
			{field:"credit",title:"评价等级截止日期",width:200}, 
			{field:"credit",title:"信用评价等级",width:200},
			{field:"credit",title:"评价机关",width:200}
			] ]
		});
});

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标单位信用评价信息
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<div class="blank10"></div>
				<table id="organBCredit_list"></table>
				<div class="blank10"></div>
				<a class="button red" onclick="history.go(-1)">返回</a>
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
