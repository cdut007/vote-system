<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function() {
	$("#bidOpening-datagrid").datagrid({
		title:"开标项目管理",
		url:ctx+"/bidOpen/pagingBidOpeningData",
		pagination:true,
		rownumbers:true,
		striped:true,
		singleSelect : true,
		height:400,
		idField:"id",
		method:"post",
		columns:[[
			{field : 'projectInstance.zbxmmc',title : "项目名称",width:150,formatter:function(value,row,index){return row[0];}},
			{field : 'projectItem.bdmc00',title : "标段名称",width:150,formatter:function(value,row,index){return row[1];}},
			{field : 'bidOpenDate',title : "开标时间",width:80,formatter:function(value,row,index){return row[2];}},
			{field : 'projectItem.organTName',title : "业主单位",align:"left",width:150,formatter:function(value,row,index){return row[3];}},
			{field : 'openStatus',title : "开标状态",align:"left",width:60,formatter:function(value,row,index){return row[4]=="1"?"正常开标":row[4]=="-1"?"开标失败":"待开标";}},
			{field : 'closeReason',title : "开标异常",align:"left",width:150,formatter:function(value,row,index){return row[5];}},			
			{field : 'operate',title : "操作",align:"left",width:150,formatter:function(value,row,index){
				var expertApplyId=row[6];
				var openStatus=row[4];
				//if(rowData.expertApplyId && rowData.openStatus=="正常开标"){
				if(expertApplyId!=""&&openStatus=="1"){
					return "<a class=\"button red small\" href=\""+ctx+"/bidOpen/bidOpenManager?expertApplyId="+expertApplyId+"\" target='_blank'>进入</a>";//rowData.
				}
			}}
		]]
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<code>&gt;</code>
			开标管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<table id="bidOpening-datagrid"></table>
		</div>
	</div>
</body>
</html>