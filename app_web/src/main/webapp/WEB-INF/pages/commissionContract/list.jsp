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
<script type="text/javascript">
	$(function() {
		$("#contractList").datagrid({
			title : "合同管理",
			height : 400,
			remoteSort:true,
			sortName:"htcjsj",
			sortOrder:"desc",
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			idField : "id",
			striped : true,
			animate : false,
			url : ctx + "/commissionContract/listData",
			/* toolbar:[
				{
					iconCls:"icon-add",text:"新增代理合同",handler:function(){
					window.location.href=ctx+"/commissionContract/commissionContractEdit";
					return;
				}
			}
			], */
			columns : [ [
			    {field : "htmc00",title:"合同名称",width:120},
			    {field : "createUserName",title : "创建人",width : 75},
			    {field : "organTName",title : "甲方",width : 140},
			    {field : "organAName",title : "乙方",width : 140},
				{field : "htcjsj",title : "创建时间",width : 120,sortable:true,order:"desc"},
				{field : "opt",title : "操作",width:80,formatter : function(value,rowData,rowIndex) {
					return "<a class='button red small' href=\""+ctx+"/commissionContract/addOrMod?id=" + rowData["id"] + "\" target=\"_blank\">预览</a>";
				}}
			] ],
			loadFilter: function(data){
				//console.log(data);
				data.total = data.totalElements;
				data.row = data.size;
				data.rows = data.content;
				return data;
			}
		});
	});
</script>
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
				合同管理
			</div>
			<div class="block">
				<table id="contractList"></table>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
