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
	var organId = "${organId}" ;
	
	$("#organBAptitude_list").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		height : 400,
		pagination : true,
		title:"投标单位资质列表",
		url : "${pageContext.request.contextPath}/organ/organBAptitudeViewData",
		queryParams : {organId:organId},
		idField : "id",
		columns : [ [
			{field:"organ.ztmc00",title:"单位名称",width:200,hidden:true}, 
			{field:"zzxl00",title:"资质序列",width:200,hidden:true}, 
			{field:"zzdj00",title:"资质等级",width:100},
			{field:"zzzsbh",title:"资质证书编号",width:100},
			{field:"zzname",title:"资质名称",width:150},
			{field:"startTime",title:"资质起始时间",width:150},
			{field:"endTime",title:"资质失效时间",width:100},
			{field:"zzsequence",title:"资质分类",width:100},
			{field:"zzindustry",title:"行业类别",width:120},
			{field:"zzprofessional",title:"专业类别",width:120} 
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
			投标单位资质查看
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<div class="blank10"></div>
				<table id="organBAptitude_list"></table>
				<div class="blank10"></div>
				<input type="button" class="button red" onclick="javascript:window.close()" value="关 闭" />
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
