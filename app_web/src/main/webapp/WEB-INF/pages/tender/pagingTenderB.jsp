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
<script>
	$(function(){
		$("#tenderApplicationTable-datagrid").datagrid({
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			title : "投标报名申请",
			url : ctx+"/tenderApply/pagingTenderData/${organType}",
			idField : "id",
			columns : [ [ 
				{field : "projectInstanceName",title:"招标项目",width:100},
				{field:"organAName",title:"代理机构",width:100},
				{field : "organ",title : "投标单位",align : "left",width:36,hidden:true},
				{field : "createDate",title : "创建时间",align : "left",width:100}, 
				{field : "applyDate",title : "申请提交时间",align : "left",width:100}, 
				{field : "applyUserName",title : "报名申请人",align : "left",width:80}, 
				{field : "reviewStatus",title : "报名审核结果",align : "left",width:80}, 
				{field : "id",title : "操作",align : "left",width:80,formatter:function(value,rowData){
						return "<a class='button red small' href=\""+ctx+"/tenderApply/tenderApplyForm?id="+value+"\" target=\"_blank\">查看</a>";
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
			投标报名申请列表
		</div>
	</div>
	<div class="block">
		<table id="tenderApplicationTable-datagrid"></table>
	</div>
</body>
</html>