<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>

<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
		$("#avoidanceExpert").datagrid({
			title : "回避专家列表",
			height : 260,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			pageSize : 5,
			pageList:[5],
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			cache : false,
			toolbar:[{text:"添加",iconCls:"myicon-application_add",
						handler:function(){
							var id=new Date().getTime(); 
						    $("#avoidance-container").append("<div style='padding:10px' id='"+id+"'></div>");
						    $("#"+id).dialog({
									width : 800,
									height : 550,
									closed : false,
									modal : true,
									loadingMessage : "正在加载...",
									title : "添加回避专家",
									href : "${pageContext.request.contextPath}/avoidanceExpert/dialog?hbxmzj=${expertApplication.projectInstance}",
									onClose : function() {
										$("#" + id).dialog("destroy");
									},
									buttons : [
											{
												text : "确认",
												color : "red",
												handler : function() {
													var selectedRows = $("#avoidanceExpert-datagrid").datagrid("getSelections");
													var idStr ="";
													var xmingStr ="";
													for(var i=0;i<selectedRows.length;i++){
														idStr +=selectedRows[i].id+",";
														xmingStr +=selectedRows[i].userName+",";
													}
													$.ajax({
														url:"${pageContext.request.contextPath}/avoidanceExpert/save?hbxmzj=${expertApplication.projectInstanceId}",
														type:"post",
														data:{hbzjzj:idStr,hbzjmc:xmingStr},
														success:function(data){
															$("#"+ id).dialog("close");
															$("#avoidanceExpert").datagrid("reload");
															$("#avoidanceExpert").datagrid("unselectAll");
														}
													});
												}
											},
											{
												text : "取消",
												color : "red",
												handler : function() {
													$("#"+ id).dialog("close");
												}
											} ]
								});
							}
						},
						{
							text : "删除",
							iconCls : "myicon-application_delete",
							handler : function() {
								var rowData = $("#avoidanceExpert").datagrid("getSelected");
								if (rowData == null) {
									$.messager.alert("系统提示","请选择一条数据！");
									return;
								}
								$.messager.confirm("系统提示","确认删除吗?",function(ok) {
									if (ok) {
										$.ajax({
											type : "post",
											dataType : "html",
											data : {
												id : rowData["id"]
											},
											url : "${pageContext.request.contextPath}/avoidanceExpert/del",
											success : function(data) {
												$("#avoidanceExpert").datagrid("reload");
												$("#avoidanceExpert").datagrid("unselectAll");
											},
											error : function(e,s1,s2) {
												$.messager.alert("系统提示","删除失败！");
											}
										});
									}
								});
							}
					} ],
			url : "${pageContext.request.contextPath}/avoidanceExpert/avoidanceExpertList?hbxmzj=${expertApplication.projectInstanceId}",
			columns : [ [ {
				field : "ck",
				title : "",
				checkbox : true
			},{
				field : "hbzjzj",
				title : "回避专家主键",
				width : 100
			}, {
				field : "hbzjmc",
				title : "回避专家姓名",
				width : 100
			} ] ]
		});

		$("#avoidanceOrgan").datagrid({
			title : "回避单位列表",
			height : 260,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			pageSize : 5,
			pageList:[5],
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			cache : false,
			toolbar:[{text:"添加",iconCls:"myicon-application_add",
						handler:function(){
							var id=new Date().getTime(); 
						    $("#avoidance-container").append("<div style='padding:10px' id='"+id+"'></div>");
						    $("#"+id).dialog({
									width : 800,
									height : 550,
									closed : false,
									modal : true,
									loadingMessage : "正在加载...",
									title : "添加回避单位",
									href : "${pageContext.request.contextPath}/avoidanceOrgan/dialog?hbxmzj=${expertApplication.projectInstanceId}",
									onClose : function() {
										$("#" + id).dialog("destroy");
									},
									buttons : [
											{
												text : "确认",
												color : "red",
												handler : function() {
													var selectedRows = $("#avoidanceOrgan-datagrid").datagrid("getSelections");
													var idStr ="";
													var dwmcStr ="";
													for(var i=0;i<selectedRows.length;i++){
														idStr +=selectedRows[i].id+",";
														dwmcStr +=selectedRows[i].ztmc00+",";
													}
													$.ajax({
														url:"${pageContext.request.contextPath}/avoidanceOrgan/save?hbxmzj=${expertApplication.projectInstanceId}",
														type:"post",
														data:{hbdwzj:idStr,hbdwmc:dwmcStr},
														success:function(data){
															$("#"+ id).dialog("close");
															$("#avoidanceOrgan").datagrid("reload");
															$("#avoidanceOrgan").datagrid("unselectAll");
														}
													});
												}
											},
											{
												text : "取消",
												color : "red",
												handler : function() {
													$("#"+ id).dialog("close");
												}
											} ]
								});
							}
						},
						{
							text : "删除",
							iconCls : "myicon-application_delete",
							handler : function() {
								var rowData = $("#avoidanceOrgan").datagrid("getSelected");
								if (rowData == null) {
									$.messager.alert("系统提示","请选择一条数据！");
									return;
								}
								$.messager.confirm("系统提示","确认删除吗?",function(ok) {
									if (ok) {
										$.ajax({
											type : "post",
											dataType : "html",
											data : {
												id : rowData["id"]
											},
											url : "${pageContext.request.contextPath}/avoidanceOrgan/del",
											success : function(data) {
												$("#avoidanceOrgan").datagrid("reload");
												$("#avoidanceOrgan").datagrid("unselectAll");
											},
											error : function(e,s1,s2) {
												$.messager.alert("系统提示","删除失败！");
											}
										});
									}
								});
							}
					} ],
			url : "${pageContext.request.contextPath}/avoidanceOrgan/avoidanceOrganList?hbxmzj=${expertApplication.projectInstanceId}",
			columns : [ [ {
				field : "ck",
				title : "",
				checkbox : true
			},{
				field : "hbdwbh",
				title : "回避单位编号",
				width : 100
			}, {
				field : "hbdwmc",
				title : "回避单位名称",
				width : 100
			} ] ]
		});
	});
</script>
<div style="padding:5px;">
	<table id="avoidanceExpert"></table>
	<div class="blank10"></div>
	<table id="avoidanceOrgan"></table>
	<div id="avoidance-container"></div>
</div>
