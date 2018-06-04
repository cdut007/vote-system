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
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.plan {
	position: absolute;
	background-color: #fff;
	z-index: 1000;
	border: 2px #D40000 solid;
	left: 200px;
	top: 200px;
	width: 850px;
	height: 470px;
	display: none;
}

.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 100;
	-moz-opacity: 0.2;
	opacity: .20;
	filter: alpha(opacity = 20);
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				已归档项目
			</div>
			<div class="block">
				<div class="clearfix">
					<table id="projectList-datagrid"></table>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
<script type="text/javascript">
	$(function() {
		$("#projectList-datagrid").datagrid({
			title : "已归档项目",
			//sortName:"bdbh00",
			//sortOrder:"desc",
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/projectInstance/hasArchiveList",
			queryParams:{archiveStatus:"1"},
			columns : [ [
				/* {field : "organProjectCode",title : "招标项目编号",width : 100}, */
				{field : "bdbh00",title : "标段编号",width:100},
				{field : "projectInstanceName",title : "项目名称",width:170},
				{field : "bdmc00",title : "标段名称",width:140},
				{field : "organTName",title : "招标人",width : 160},
				{field : "createTime",title : "添加时间",width : 120},
				/* {field : "projectInstance.zbfs00",title : "招标方式",width : 60},
				{field : "projectInstance.zbzzxs",title : "招标组织形式",width : 100}, */
				/* {field : "projectInstance.lxsj00",title : "立项时间",width : 100}, */
				{field : "opt",title : "操作",width:80,formatter : function(value,rowData,rowIndex) {
					return "<a class='button red small' href=\""+ctx+"/projectInstance/archiveForm?look=true&id="+rowData["id"]+"\" target=\"_blank\">查看</a>";
				}} 
			] ]
		});
	});
</script>
</html>
