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

function rewards_and_punishment_check(rewardsAndPunishmentId){
	window.location='${pageContext.request.contextPath}/organ/organBRewardsAndPunishmentCheck?rewardsAndPunishmentId='+rewardsAndPunishmentId+"&organId="+"${organId}";
}
function rewards_and_punishment_delete(rewardsAndPunishmentId){
	
	$.ajax({
		url:ctx+"/organ/organBRewardsAndPunishmentDelete",
		type:"post",
		data:{"rewardsAndPunishmentId":rewardsAndPunishmentId},
		dataType:"json",
		success:function(result){
			if(result.success){
				$.messager.alert("系统提示","删除成功！","info",function(){
					$("#organBRewardsAndPunishment_list").datagrid("reload");
				});
			}else{
				$.messager.alert("系统提示","删除失败！","error");
			}
		},
		/* error:function(){
			$.messager.alert("系统提示","连接服务器失败！请重试！");
		} */
	});
}

$(function() {
	var organId = "${organId}";
	
	$("#organBRewardsAndPunishment_list").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		fitColumns : true,
		height : 400,
		pagination : true,
		title:"投标单位奖惩信息",
		url : "${pageContext.request.contextPath}/organ/organBRewardsAndPunishmentViewData",
		queryParams : {organId:organId},
		idField : "id",
		columns : [[
			{field:"organName",title:"投标单位",width:200},
			{field:"conferDate",title:"奖励/惩罚日期",width:200}, 
			{field:"conferKind",title:"类型",width:200}, 
			{field:"conferName",title:"奖励/惩罚名称",width:200}, 
			{field:"conferOrganization",title:"奖励/惩罚颁发单位",width:200},
			{field:"id",title:"操作",align:"center",formatter:function(value,row,index){
				return 	"<a class='button red small' onclick='rewards_and_punishment_check(\""+row.id+"\")'>查看</a>"+
						"<a class='button red small' onclick='rewards_and_punishment_delete(\""+row.id+"\")'>删除</a>";
			}}]],
		toolbar:[{
			text : "添加",
			iconCls : "myicon-application_add",	
			handler : function() {
				window.location.href=ctx+"/organ/addOrEditOrganBRewardsAndPunishment?organId="+organId;
			}
		},{
			text : "编辑",
			iconCls : "myicon-application_add",
			handler : function() {
				var row=$("#organBRewardsAndPunishment_list").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择一条记录!");
					return;
				}
				window.location.href=ctx+"/organ/addOrEditOrganBRewardsAndPunishment?rewardsAndPunishmentId="+row.id+"&organId="+organId;
			}
		}]
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
			投标单位奖惩信息
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<div class="blank10"></div>
				<table id="organBRewardsAndPunishment_list"></table>
				<div class="blank10"></div>
				<input type="button" class="button red" onclick="javascript:window.close()" value="关 闭" />
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
