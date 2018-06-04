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
	
	$("#organBCertificate_list").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		height : 400,
		pagination : true,
		title:"投标单位执业人员列表",
		url : "${pageContext.request.contextPath}/organ/organBCertificateViewData",
		queryParams : {organId:organId},
		idField : "id",
		columns : [ [
			{field:"userName",title:"姓名",width:100}, 
			{field:"certificateCode",title:"证书编号",width:200}, 
			{field:"certificateName",title:"证书名称",width:200},
			{field:"certificateKind",title:"证书类别",width:100},
			{field:"certificateAward",title:"发证机关",width:200},
			{field:"certificateType",title:"证书状态",width:100}
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
			投标单位职业人员信息
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<div class="blank10"></div>
				<table id="organBCertificate_list"></table>
				<div class="blank10"></div>
				<input type="button" class="button red" onclick="javascript:window.close()" value="关 闭" />
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
