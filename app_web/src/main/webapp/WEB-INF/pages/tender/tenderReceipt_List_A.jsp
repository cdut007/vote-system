<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<html>
<head>
<%@include file="/common/link.jsp"%>

<script type="text/javascript">

$(function() {
	
	$("#tenderReceipt_list_a").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		height : 400,
		fitColumns : true,
		pagination : true,
		title:"收到投标文件列表",
		url : "${pageContext.request.contextPath}/tenderReceipt_List_A",
		//queryParams : {ztmc00,organType},
		idField : "id",

		columns : [ [ {
				field : "organBName",
				title : "投标单位名称",
				width : 200
			}, {
				field : "tenderItem.projectInstanceName",
				title : "招标项目",
				width : 200
			},{
				field : "tenderItem.projectItemName",
				title : "标段(包)",
				width : 200
			},{
				field : "createTime",
				title : "投标时间",
				width : 200
			}, {
				field : "id",
				title : "操作",
				width : 200,
				align : 'center',
				formatter:function(value, row, index) {
						return '<a class="button red small" href="'+ctx+'/tenderReceipt_A?id='+row["id"]+'">发送回执</a>';
				}
			} ] ]
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
			投标回执管理
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<table id="tenderReceipt_list_a"></table>
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
