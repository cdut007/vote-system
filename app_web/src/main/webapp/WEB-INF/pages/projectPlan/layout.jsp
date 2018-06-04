<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目计划信息表表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
	<head>
		<%@include file="/common/link.jsp"%>
		<script type="text/javascript">
$(function() {
	$("#projectPlan-datagrid").datagrid(
					{
						singleSelect : true,
						rownumbers : true,
						fitColumns : true,
						striped : true,
						pagination : true,
						title : "招标项目计划",
						url : "${pageContext.request.contextPath}/projectPlan/list",
						idField : "id",
						toolbar : [
								{
									text : "添加",
									iconCls : "myicon-application_add",
									handler : function() {
										var id = new Date().getTime();
										$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
										$("#" + id).dialog(
														{
															width : 800,
															height : 600,
															closed : false,
															modal : true,
															loadingMessage : '正在加载...',
															title : "招标项目计划",
															href : "${pageContext.request.contextPath}/projectPlan/form",
															onClose : function() {
																$("#" + id).dialog("destroy");
															},
															buttons : [
																	{
																		text : "确认",
																		color : "red",
																		handler : function() {
																			$("#"+ id+ " form").submit();
																		}
																	},
																	{
																		text : "取消",
																		color : "red",
																		handler : function() {
																			$("#"+ id).dialog("close");
																		}
																	} ],
															onLoad : function() {
																validForm($('#' + id + ' form'),
																function(data) {
																	if (data.success) {
																		$('#' + id).dialog('close');
																		$('#projectPlan-datagrid').datagrid('reload');
																	} else {
																		$.messager.alert('系统提示',data.msg);
																	}
																});
															}
														});
									}
								},
								{
									text : "修改",
									iconCls : "myicon-application_edit",
									handler : function() {
										var rowData = $('#projectPlan-datagrid').datagrid('getSelected');
										if (rowData == null) {
											$.messager.alert('系统提示', '请选择一条数据！');
											return;
										}
										var id = new Date().getTime();
										$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
										$("#" + id).dialog(
														{
															width : 800,
															height : 600,
															closed : false,
															modal : true,
															loadingMessage : '正在加载...',
															title : "招标项目计划",
															href : "${pageContext.request.contextPath}/projectPlan/form?projectInstanceId="+ rowData['projectInstanceId'],
															onClose : function() {
																$("#" + id).dialog("destroy");
															},
															buttons : [
																	{
																		text : "确认",
																		iconCls : "myicon-accept",
																		handler : function() {
																			$("#"+ id+ " form").submit();
																		}
																	},
																	{
																		text : "重置",
																		iconCls : "myicon-accept",
																		handler : function() {
																			$("#"+ id).dialog("refresh");
																		}
																	},
																	{
																		text : "取消",
																		iconCls : "myicon-arrow_undo",
																		handler : function() {
																			$("#"+ id).dialog("close");
																		}
																	} ],
															onLoad : function() {
																validForm($('#' + id + ' form'),
																function(data) {
																	if (data.success) {
																		$('#' + id).dialog('close');
																		$('#projectPlan-datagrid').datagrid('reload');
																	} else {
																		$.messager.alert('系统提示',data.msg);
																	}
																});
															}
														});
									}
								},
								{
									text : "详情",
									iconCls : "myicon-application_form_magnify",
									handler : function() {
										var rowData = $('#projectPlan-datagrid').datagrid('getSelected');
										if (rowData == null) {
											$.messager.alert('系统提示', '请选择一条数据！');
											return;
										}
										var id = new Date().getTime();
										$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
										$("#" + id).dialog(
														{
															width : 800,
															height : 600,
															closed : false,
															modal : true,
															loadingMessage : '正在加载...',
															title : "招标项目计划",
															href : "${pageContext.request.contextPath}/projectPlan/form?projectInstanceId="+ rowData['projectInstanceId'],
															onClose : function() {
																$("#" + id).dialog("destroy");
															},
															buttons : [ {
																text : "关闭",
																iconCls : "myicon-arrow_undo",
																handler : function() {
																	$("#" + id).dialog("close");
																}
															} ],
															onLoad : function() {
																validForm($('#' + id + ' form'),
																function(data) {
																	if (data.success) {
																		$('#' + id).dialog('close');
																		$('#projectPlan-datagrid').datagrid('reload');
																	} else {
																		$.messager.alert('系统提示',data.msg);
																	}
																});
															}
														});
									}
								},
								{
									text : "删除",
									iconCls : "myicon-application_delete",
									handler : function() {
										var rowData = $('#projectPlan-datagrid').datagrid('getSelected');
										if (rowData == null) {
											$.messager.alert('系统提示', '请选择一条数据！');
											return;
										}
										$.messager.confirm('系统提示','确认删除吗?',
														function(ok) {
															if (ok) {
																$.ajax( {
																	type : 'post',
																	dataType : 'html',
																	data : {
																		projectPlan_id : rowData['id']
																	},
																	url : "${pageContext.request.contextPath}/projectPlan/del",
																	success : function(data) {
																		$('#projectPlan-datagrid').datagrid('reload');
																		$('#projectPlan-datagrid').datagrid('unselectAll');
																	},
																	error : function(e,s1,s2) {
																		$.messager.alert('系统提示','删除失败！');
																	}
																});
															}
														});
									}
								} ],
						columns : [ [ 
							{
							field : "zbxmbh",
							title : "招标项目编号",
							align : "left",
							width : 50
						}, {
							field : "zbxmmc",
							title : "招标项目名称",
							align : "left"
						}, {
							field : "bdbh00",
							title : "相关标段（包）编号",
							align : "left"/*,width:2000*/
						}, {
							field : "gzrwjh",
							title : "工作任务计划",
							align : "left",
							formatter : function(value) {
								if (value.length > 20) {
									return value.substr(0, 20) + "...";
								} else {
									return value;
								}
							}
						}, {
							field : "xmcyzz",
							title : "项目团队成员组成与职责分工",
							align : "left"/*,width:2000*/,
							formatter:function(value){
								if(value.length>20){
									return value.substr(0,20) +"...";
								}else{
									return value;
								}
							}
						}
						] ]
					});
});
</script>
	</head>
	<body>
		<jsp:include page="/common/top.jsp"/>
		<div class="block">
			<div class="right_top_div">
				当前位置: 招标项目计划管理 &gt; 招标项目计划列表
			</div>
			<div class="blank10"></div>
			<form:form id="projectPlanList" action="${pageContext.request.contextPath}/projectPlan/list"
				method="post" commandName="projectPlan">
				<table class="seachparam">
					<tr>
						<td></td>
					</tr>
				</table>
				<table id="projectPlan-datagrid">
				</table>
			</form:form>
		</div>
	</body>
</html>
