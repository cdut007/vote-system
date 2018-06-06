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
<title>专家抽取申请表</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function(){
	$("#expertList-datagrid").datagrid({
		title:"专家抽取申请",
		url:ctx+"/expertApplication/pagingExpertListByAData",
		columns:[[
			{field:"id",checkbox:true},
			{field:"projectInstanceName",title:"项目名称",width:230,sortable:true},
			{field:"organTName",title:"招标人",width:180,sortable:true},
			{field:"organAName",title:"代理机构",width:170,sortable:true},
			{field:"bidOpenDate",title:"开标时间",width:120,sortable:true},
			{field:"opt",title:"操作",formatter:function(value,rowData,rowIndex){
				return "<a class='button red small' href=\""+ctx+"/expertApplication/expertListDetail?expertApplyId="+rowData["id"]+"\">查看</a>";
			}}
		]]
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<!--center start  -->
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				系统管理
				<code>&gt;</code>
				专家抽取申请
			</div>
			<div class="blank10"></div>
			<table id="expertList-datagrid"></table>
			<div class="blank10"></div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>