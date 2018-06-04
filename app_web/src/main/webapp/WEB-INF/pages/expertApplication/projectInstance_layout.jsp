<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>抽取专家申请信息</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">	
</style>
<script>
	$(function(){
		/*****
		 * 需要抽取专家的标段
		 */
		$("#projectitemgroupneedexpert-datagrid").datagrid({
			title:"待抽取专家列表",
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			height:300,
			url : ctx+"/projectItem/listProjectItemGroupNeedExpertData",
			idField:"projectItemId",
			columns : [ [ 
			    {field : "projectInstanceNumber",title : "项目编号",align : "left"/*,width:1*/,hidden:true}, 
	 		    {field : "projectInstanceName",title : "项目名称",align : "left"/*,width:1*/}, 
	 		    {field : "projectItemNumber",title : "标段编号",align : "left"/*,width:1*/}, 
	 		    {field : "projectItemName",title : "标段名称",align : "left"/*,width:1*/}, 
	 		    {field : "bidOpenDate",title : "开标时间",align : "left"/*,width:1*/}, 
	 		    {field : "bidOpenPlace",title : "开标地点",align : "left"/*,width:1*/}, 
	 			{title : "操作",field : "projectItemId",formatter : function(value, rowData) {
	 				var param=$("<form/>").append($("<input/>").attr("name","bidOpenPlace").val(rowData["bidOpenPlace"])).serialize()+"&projectInstanceId="+rowData.projectInstanceId+"&bidOpenDate="+rowData["bidOpenDate"]+"&"+$(value.split(",")).map(function(){return "projectItemId="+this;}).get().join("&");
	 				return "<a class='small button red' href='${pageContext.request.contextPath}/expertApplication/expertApplyForm?"+param+"'>抽取申请</a>";
	 			}} 
	 		] ]
		});
	});
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			抽取专家申请信息
		</div>
	</div>
	<div class="block">
		<div class="usBox">
		<table id="projectitemgroupneedexpert-datagrid" ></table>
		</div>
	</div>
</body>
</html>
