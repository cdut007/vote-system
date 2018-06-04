<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:专家组列表
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>专家组信息</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
</style>
<script type="text/javascript">
	$(function() {
		$("#expertGroupUser-datagrid").datagrid({
			title : "专家组成员",
			height : 380,
			rownumbers : true,
			singleSelect : false,
			fitColumns : true,
			idField : "id",
			animate : false,
			url : "${pageContext.request.contextPath}/expertGroup/expertList",
			queryParams : {
				id : "${expertGroup.id}"
			},
			cache : false,
			toolbar : [ {
				text : "添加",
				iconCls : "myicon-application_add",
				handler : function() {
					var id = new Date().getTime();
					$("#container").append("<div style='padding:10px' id='"+id+"'></div>");
					$("#" + id).dialog({
						width : 800,
						height : 550,
						closed : false,
						modal : true,
						loadingMessage : "正在加载...",
						title : "添加评标组成员",
						href : "${pageContext.request.contextPath}/expertGroup/dialog",
						queryParams : {
							id : "${expertGroup.id}"
						},
						onClose : function() {
							$("#" + id).dialog("destroy");
						},
						buttons : [ {
							text : "确认",
							color : "red",
							handler : function() {
								var selectedRows = $("#expertUser-datagrid").datagrid("getSelections");
								var idStr = "";
								for (var i = 0; i < selectedRows.length; i++) {
									idStr += selectedRows[i].id + ",";
								}
								$.ajax({
									url : "${pageContext.request.contextPath}/expertGroup/saveExperts",
									type : "post",
									data : {
										expertId : idStr,
										groupId : "${expertGroup.id}"
									},
									success : function(data) {
										$("#" + id).dialog("close");
										$("#expertGroupUser-datagrid").datagrid("reload");
										$("#expertGroupUser-datagrid").datagrid("unselectAll");
									}
								});
							}
						}, {
							text : "取消",
							color : "red",
							handler : function() {
								$("#" + id).dialog("close");
							}
						} ]
					});
				}
			}, {
				text : "删除",
				iconCls : "myicon-application_delete",
				handler : function() {
					var rowData = $("#expertGroupUser-datagrid").datagrid("getChecked");
					if (rowData.length == 0) {
						$.messager.alert("系统提示", "请选择一条数据！");
						return;
					}
					$.messager.confirm("系统提示", "确认删除吗?", function(ok) {
						if (ok) {
							$.ajax({
								type : "post",
								dataType : "html",
								data : $(rowData).map(function() {
									return "expertId=" + this["id"];
								}).get().join("&") + "&groupId=${expertGroup.id}",
								url : "${pageContext.request.contextPath}/expertGroup/delExperts",
								success : function(data) {
									$("#expertGroupUser-datagrid").datagrid("reload");
									$("#expertGroupUser-datagrid").datagrid("unselectAll");
								},
								error : function(e, s1, s2) {
									$.messager.alert("系统提示", "删除失败！");
								}
							});
						}
					});
				}
			} ],
			columns : [ [ {
				field : "ck",
				title : "",
				checkbox : true
			}, {
				field : "id",
				title : "专家编号",
				width : 80
			}, {
				field : "userName",
				title : "专家姓名",
				width : 100
			} ] ]
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			专家组信息
		</div>
		<div class="tableTitle">
			<span>专家组信息</span>
		</div>
		<form class="registerform">
			<table class="mytableStyle">
				<tr>
					<th width="120px">招标项目编号：</th>
					<td>${projectInstance.zbxmbh}</td>
					<th width="120px">招标项目名称：</th>
					<td>${projectInstance.zbxmmc}</td>
				</tr>
				<tr>
					<th>专家申请编号：</th>
					<td>${expertGroup.expertApplyId}</td>
					<th>专家组名称：</th>
					<td>${expertGroup.zjzmc0}</td>
				</tr>
				<tr>
					<th>专家组组长：</th>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td colspan='3'>${expertGroup.beizhu}</td>
				</tr>
			</table>
		</form>
		<div class="blank10"></div>
		<table id="expertGroupUser-datagrid"></table>
		<div id="container"></div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
</body>
</html>