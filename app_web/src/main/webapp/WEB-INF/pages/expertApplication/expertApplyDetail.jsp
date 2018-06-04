<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>抽取专家申请信息</title>
<sys:link easyui="true" jgrowl="true" datepicker="true" />
<script type="text/javascript">
$(function(){
	$("#expert-datagrid").datagrid({
		title : "专家组成员",
		height : 380,
		rownumbers : true,
		singleSelect : false,
		fitColumns : true,
		idField : "id",
		animate : false,
		url : ctx+"/expertGroup/pagingGroupExpertData",
		queryParams : {
			id : $("#expertGroupId").val()
		},
		cache : false,
		toolbar : [ {
			text : "添加",
			iconCls : "myicon-application_add",
			handler : function() {
				var id = new Date().getTime();
				var dialog=$("<div/>").css("padding",10).appendTo($("body")).dialog({
					width : 800,
					height : 550,
					closed : false,
					modal : true,
					loadingMessage : "正在加载...",
					title : "添加评标组成员",
					href : ctx+"/expertGroup/pagingExpert",
					queryParams : {
						id : $("#expertGroupId").val()
					},
					onClose : function() {
						dialog.dialog("destroy");
					},
					buttons : [ {
						text : "确认",
						color : "red",
						handler : function() {
							var selectedRows = $("#expertUser-datagrid").datagrid("getSelections");
							$.ajax({
								url : ctx+"/expertGroup/saveExperts",
								type : "post",
								data : {
									expertId : $(selectedRows).map(function(){
										return this["id"];
									}).get().join(","),
									groupId : $("#expertGroupId").val()
								},
								success : function(data) {
									$("#" + id).dialog("close");
									$("#expert-datagrid").datagrid("reload");
									$("#expert-datagrid").datagrid("unselectAll");
								}
							});
						}
					}, {
						text : "取消",
						color : "red",
						handler : function() {
							dialog.dialog("destroy");
						}
					} ]
				});
			}
		}, {
			text : "删除",
			iconCls : "myicon-application_delete",
			handler : function() {
				var rowData = $("#expert-datagrid").datagrid("getChecked");
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
							}).get().join("&") + "&groupId="+$("#expertGroupId").val(),
							url :ctx+ "/expertGroup/delExperts",
							success : function(data) {
								$("#expert-datagrid").datagrid("reload");
								$("#expert-datagrid").datagrid("unselectAll");
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
			field : "id",
			title : "",
			checkbox : true
		}, {
			field : "userName",
			title : "专家姓名",
			width : 80
		},{
			field : "gender",
			title : "性别",
			width : 60
		},{
			field : "identityNo",
			title : "身份证号"
		},
		{
			field : "phone",
			title : "联系方式"
		}] ]
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
			专家抽取申请信息
		</div>
	</div>
	<div class="block">
		<form:form class="registerform" method="post" modelAttribute="expertApply">
			<input type="hidden" name="token" value="${token}" />
			<form:hidden path='id' />
			<form:hidden id="expertGroupId" path='expertGroup.id' />
			<form:hidden path='projectInstanceId' />
			<form:hidden path='juryExpertNum' />
			<form:hidden path='juryTUserNum' />
			<form:hidden path='bidOpenDate' />
			<form:hidden path='bidOpenPlace' />
			<form:hidden path='juryTUserNum' />
			<div class="easyui-panel" data-options="title:'招标项目信息'">
				<table class="mytableStyle" style="table-layout:fixed;margin:0 auto;border:none;">
					<col style="width:120px;" />
					<col />
					<col style="width:120px;" />
					<col />
					<tr>
						<th width="120px">项目编号：</th>
						<td colspan="3">${expertApply.projectInstance.zbxmbh}</td>
					<tr>
					<tr>
						<th width="120px">项目名称：</th>
						<td colspan="3">${expertApply.projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">招标单位：</th>
						<td colspan="3">${expertApply.projectInstance.organTName}</td>
					</tr>
					<tr>
						<th width="120px">代理机构：</th>
						<td colspan="3">${expertApply.projectInstance.organAName}</td>
					</tr>
					<tr>
						<th>招标方式：</th>
						<td>${util:dictionary('ZBFS00',expertApply.projectInstance.zbfs00)}</td>
						<th width="120px">招标组织形式：</th>
						<td>${util:dictionary('ZBZZXS',expertApply.projectInstance.zbzzxs)}</td>
					</tr>
					<tr>
						<th>标段：</th>
						<td colspan="3">
							<c:forEach items="${expertApply.projectItemList}" var="item">
								<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>开标时间：</th>
						<td><fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th width="120px">开标地点：</th>
						<td>${expertApply.bidOpenPlace}</td>
					</tr>
					<tr>
						<th>评标委员会组建：</th>
						<td colspan="3">评标委员会构成： ${expertApply.juryTUserNum+expertApply.juryExpertNum}人，其中招标人代表 ${expertApply.juryTUserNum}人，专家${expertApply.juryExpertNum}人。</td>
					</tr>
					<tr>
						<th style="width:100px;">评标时间：</th>
						<td><fmt:formatDate value="${expertApply.evaluateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th style="width:100px;">评标地点：</th>
						<td>${expertApply.evaluatePlace}</td>
					</tr>
					<tr>
						<th style="width:100px;">评标用时：</th>
						<td>${util:dictionary('PBSJDM',expertApply.dayNumber)}</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>所属库：</th>
						<td>${util:dictionary('SSK000',expertApply.expertDatabase)}</td>
						<th>专家所在区域：</th>
						<td>${util:dictionaryPath('REGION',expertApply.expertRegion)}</td>
					</tr>
					<tr>
						<th>备注说明：</th>
						<td colspan='3'>${expertApply.beizhu}</td>
					</tr>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'抽取需求'">
				<table class="mytableStyle">
					<thead>
						<tr>
							<th>序号</th>
							<th>专业</th>
							<th>人数</th>
							<th>报到时间</th>
							<th>报到地点</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${expertDemandList}" var="expertDemand" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td>${expertDemand.specialtyFirstTypeName}-${expertDemand.specialtySecondTypeName}-${expertDemand.specialtyThirdTypeName}</td>
								<td>${expertDemand.expertCount}</td>
								<td>${expertDemand.expertCheckInTime}</td>
								<td>${expertDemand.expertCheckInAddress}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'回避单位'">
				<table class="mytableStyle">
					<thead>
						<tr>
							<th>序号</th>
							<th>回避单位代码</th>
							<th>回避单位名称</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${avoidanceOrganList}" var="avoidanceOrgan" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td>${avoidanceOrgan.organCode}</td>
								<td>${avoidanceOrgan.organName}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			<div id="expert-datagrid"></div>
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
