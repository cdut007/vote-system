<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<script type="text/javascript"
	src="/resources/fusionCharts/FusionCharts.js"></script>
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
<script>
	function bindFormEvent() {
		$("#zbplanBox").find(".registerform").Validform(
				{
					ajaxPost : true,
					callback : function(data) {
						if (data.success) {
							//window.location.href = "${pageContext.request.contextPath}/node_6/biz_list";
							alert(data.msg);
						}
					},
					tiptype : function(msg, o, cssctl) {
						if (!o.obj.is("form")) {
							var objtip = o.obj.parents("td").next().find(
									".Validform_checktip");
							cssctl(objtip, o.type);
							objtip.text(msg);
							var infoObj = o.obj.parents("td").next().find(
									".infostyle");
							if (o.type == 2) {
								infoObj.fadeOut(200);
							} else {
								if (infoObj.is(":visible")) {
									return;
								}
								var left = o.obj.offset().left, top = o.obj
										.offset().top;
								infoObj.css({
									left : left + 170,
									top : top - 45
								}).show().animate({
									top : top - 35
								}, 200);
							}
						}
					}
				});
	}

	function zb_plan(zbxmid) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='"+id+"'></div>");
		$('#' + id).dialog({
							width : 800,
							height : 600,
							title : "招标计划",
							loadingMessage : '正在加载...',
							modal : true,
							href : "${pageContext.request.contextPath}/projectPlan/form?projectInstanceId="
									+ zbxmid,
							onClose : function() {
								$('#' + id).dialog("destroy");
							},

							onLoad : function() {
								validForm($('#' + id + ' form'),
										function(data) {
											$.messager.alert('系统提示', data.msg);
										});
							},
							
							buttons:[{text : "确认",color : "red",handler : function(){
								$("#"+id+" form").ajaxSubmit({
								dataType:"json",
								beforeSend:function(){
									return $('#'+id+" form").form("validate");
								},
								success:function(data){
									$.jGrowl(data.msg);
									$("#"+id).dialog("close");
								}
							});}},
							{text : "关闭",color : "red",handler : function() {$("#"+id).dialog("close");}}]
							
							/* buttons : [ {
								text : "确认",
								color : "red",
								handler : function() {
									$("#" + id + " form").submit();
								}
							}, {
								text : "关闭",
								color : "red",
								handler : function() {
									$("#" + id).dialog("close");
								}
							} ] */
						});
	}
</script>

</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			代理项目管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<table style="width: 100%;">
				<tr>
					<td style="text-align: center"><div id="projectInstancePie"></div></td>
					<td style="text-align: center"><div id="projectInstancePie1"></div></td>
				</tr>
				<tr>
					<td style="text-align: center"><div id="projectInstancePie3"></div></td>
					<td style="text-align: center"><div id="projectInstancePie4"></div></td>
				</tr>
			</table>
			<div class="blank10"></div>
			<table id="projectList-datagrid"></table>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#projectList-datagrid")
				.datagrid(
						{
							title : "招标项目列表",
							height : 400,
							singleSelect : true,
							rownumbers : true,
							pagination : true,
							fitColumns : true,
							idField : "id",
							striped : true,
							animate : false,
							url : "${pageContext.request.contextPath}/projectInstance/agencylist",
							toolbar : [
										{
											text : "添加",
											iconCls : "myicon-application_add",
											handler : function() {
												window.location.href="/projectInstance/view_create_project_instance?createByAgency=true"
											}
										},{
											text : "编辑",
											iconCls : "myicon-application_edit",
											handler : function() {
												var rows = $('#projectList-datagrid').datagrid('getSelections');
												if(rows.length==0){
													$.messager.alert('提示',"请选择要编辑的招标项目！",'info');
													return;
												}
												var row=rows[0];
												window.location.href="/projectInstance/view_create_project_instance?createByAgency=true&id="+row.id;
											}
										}
										],
							columns : [ [
									{
										field : "zbxmbh",
										title : "招标项目编号",
										width : 100
									},
									{
										field : "zbxmmc",
										title : "招标项目名称",
										width : 100,
									},
									{
										field : "organTName",
										title : "招标人",
										width : 60
									},
									{
										field : "zbfs00",
										title : "招标方式",
										width : 60
									},
									{
										field : "zbzzxs",
										title : "招标组织形式",
										width : 100
									},
									{
										field : "lxsj00",
										title : "立项时间",
										width : 100
									},
									{
										field : "id",
										title : "操作",
										formatter : function(value, rowData,
												rowIndex) {

											var links = "";
											var zbjh = "<a class='button red small' href=\"javascript:zb_plan('"
													+ value + "')\">招标计划</a>";
											var bdgl="";
											//先禁用标段管理，标段管理需要和完成招标具体工作里面的标段管理保持一致
											//var bdgl = "<a class='button red small'  href=\"${pageContext.request.contextPath}/projectItem/indProjectItemLayout?projectInstanceId="
													//+ value + "\">标段管理</a>";

											if (rowData.dlrzj0 == ""
													|| rowData.dlrzj0 == "null"
													|| !rowData.dlrzj0) {
												zbjh = "<a class='button small' disabled=\"true\" >招标计划</a>";
												//bdgl = "<a class='button small' disabled=\"true\" >标段管理</a>";
											}

											return links + zbjh + bdgl 
												+ "<a class='button red small' href=\"${pageContext.request.contextPath}/commissionContract/addOrMod?projectInstanceId=" + value + "\">代理合同</a>"
												+ "<a class='button red small' href=\"${pageContext.request.contextPath}/projectInstance/projectInstanceDetail2?projectInstanceId="	+ value + "\">查看详情</a>";
										}
									} ] ]
						});		
		/* var width = "480";
		var column3D1 = new FusionCharts("/resources/fusionCharts/Pie3D.swf",
				"projectInstancePieId", width, "280", "0", "1");
		column3D1.setJSONUrl(ctx
				+ "/report?caption="
				+ encodeURI(encodeURIComponent("项目分类统计饼图") + "&year="
						+ new Date().getFullYear() + "&organRoleFlag=A"));
		column3D1.render("projectInstancePie");

		var column3D2 = new FusionCharts("/resources/fusionCharts/Pie3D.swf",
				"projectInstancePie1Id", width, "280", "0", "1");
		column3D2.setJSONUrl(ctx + "/report2?caption="
				+ encodeURI(encodeURIComponent("部门项目统计饼图")) + "&year="
				+ new Date().getFullYear() + "&organRoleFlag=A");
		column3D2.render("projectInstancePie1");

		var column3D3 = new FusionCharts(
				"/resources/fusionCharts/Column3D.swf",
				"projectInstancePie3Id", width, "280", "0", "1");
		column3D3.setJSONUrl(ctx + "/report?caption="
				+ encodeURI(encodeURIComponent("项目分类统计柱状图")) + "&year="
				+ new Date().getFullYear() + "&organRoleFlag=A");
		column3D3.render("projectInstancePie3");

		var column3D3 = new FusionCharts(
				"/resources/fusionCharts/Column3D.swf",
				"projectInstancePie4Id", width, "280", "0", "1");
		column3D3.setJSONUrl(ctx + "/report3?caption="
				+ encodeURI(encodeURI("月份项目分统计柱状图")) + "&year="
				+ new Date().getFullYear() + "&organRoleFlag=A");
		column3D3.render("projectInstancePie4"); */
	});

	function takanlist(projectInstanceId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id)
				.dialog(
						{
							width : 600,
							height : 400,
							closed : false,
							modal : true,
							loadingMessage : '正在加载...',
							title : "勘探查看",
							href : "${pageContext.request.contextPath}/projectInstance/takanlist?projectInstanceId="
									+ projectInstanceId,
							onClose : function() {
								$("#" + id).dialog("destroy");
							}
						});
	}
</script>
</html>
