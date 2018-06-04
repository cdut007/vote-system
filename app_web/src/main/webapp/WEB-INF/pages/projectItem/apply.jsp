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
				正在报名的标段
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix">
						<table id="itemList-datagrid"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
<script type="text/javascript">
	$(function() {
		$("#itemList-datagrid").datagrid({
			title : "正在报名的标段",
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/projectItem/applyList",
			columns : [ [ {
				field : "projectInstance.zbxmbh",
				title : "招标项目编号",
				width : 100
			}, {
				field : "projectInstance.zbxmmc",
				title : "招标项目名称",
			}, {
				field : "projectInstance.project.organ.ztmc00",
				title : "招标人",
				width : 80
			}, {
				field : "bdbh00",
				title : "标段编号",
				width : 60
			}, {
				field : "bdmc00",
				title : "标段名称",
				width : 60
			}, {
				field : "projectInstance.zbfs00",
				title : "招标方式",
				width : 60
			}, {
				field : "projectInstance.zbzzxs",
				title : "招标组织形式",
				width : 100
			}, {
				field : "applyNum",
				title : "报名数量",
				width : 100
			} ] ]
		});
	});
</script>
</html>
