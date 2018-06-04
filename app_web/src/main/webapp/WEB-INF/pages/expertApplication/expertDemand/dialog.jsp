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
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
		$("#expertDemand-datagrid").datagrid({
			title : "待抽取项目列表",
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			cache : false,
			toolbar:[{text:"添加",iconCls:"myicon-application_add",
						handler:function(){
							var id=new Date().getTime(); 
						    $("#demand-container").append("<div style='padding:10px' id='"+id+"'></div>");
						    $("#"+id).dialog({
									width : 1000,
									height : 550,
									closed : false,
									modal : true,
									cache : false,
									loadingMessage : "正在加载...",
									title : "添加抽取要求",
									href : "${pageContext.request.contextPath}/expertDemand/addOrMod?cqsqzj=${expertDemand.cqsqzj}",
									onClose : function() {
										$("#" + id).dialog("destroy");
									},
									buttons : [
											{
												text : "确认",
												color : "red",
												handler : function() {
													$("#" + id +" form").submit();
													$.ajax({
														url:"${pageContext.request.contextPath}/expertDemand/saveOrUpdate",
														type:"post",
														data:$("#" + id +" form").serialize(),
														success:function(data){
															$("#"+ id).dialog("close");
															$("#expertDemand-datagrid").datagrid("reload");
															$("#expertDemand-datagrid").datagrid("unselectAll");
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
											} ],
										onLoad : function() {
											validForm($("#"+ id+ " form"),
													function(data) {
														if (data.success) {
															$("#"+ id).dialog("close");
															$("#expertDemand-datagrid").datagrid("reload");
														} else {
															$.messager.alert("系统提示",data.msg);
														}
													});
										}
								});
							}
						},
						{text:"修改",iconCls:"myicon-application_add",
							handler:function(){
								var rowData = $("#expertDemand-datagrid").datagrid("getSelected");
								if (rowData == null) {
									$.messager.alert("系统提示","请选择一条数据！");
									return;
								}
								var id=new Date().getTime(); 
							    $("#demand-container").append("<div style='padding:10px' id='"+id+"'></div>");
							    $("#"+id).dialog({
										width : 1000,
										height : 550,
										closed : false,
										modal : true,
										cache : false,
										loadingMessage : "正在加载...",
										title : "修改抽取要求",
										href : "${pageContext.request.contextPath}/expertDemand/addOrMod?id="+ rowData["id"],
										onClose : function() {
											$("#" + id).dialog("destroy");
										},
										buttons : [
												{
													text : "确认",
													color : "red",
													handler : function() {
														$("#" + id +" form").submit();
														$.ajax({
															url:"${pageContext.request.contextPath}/expertDemand/saveOrUpdate",
															type:"post",
															data:$("#" + id +" form").serialize(),
															success:function(data){
																$("#"+ id).dialog("close");
																$("#expertDemand-datagrid").datagrid("reload");
																$("#expertDemand-datagrid").datagrid("unselectAll");
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
												} ],
											onLoad : function() {
												validForm($("#"+ id+ " form"),
														function(data) {
															if (data.success) {
																$("#"+ id).dialog("close");
																$("#expertDemand-datagrid").datagrid("reload");
															} else {
																$.messager.alert("系统提示",data.msg);
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
								var rowData = $("#expertDemand-datagrid").datagrid("getSelected");
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
											url : "${pageContext.request.contextPath}/expertDemand/del",
											success : function(data) {
												$("#expertDemand-datagrid").datagrid("reload");
												$("#expertDemand-datagrid").datagrid("unselectAll");
											},
											error : function(e,s1,s2) {
												$.messager.alert("系统提示","删除失败！");
											}
										});
									}
								});
							}
					} ],
			url : "${pageContext.request.contextPath}/expertDemand/list?cqsqzj=${expertDemand.cqsqzj}",
			columns : [ [ {
				field : "ck",
				title : "",
				checkbox : true
			},{
				field : "_zjlb00_",
				title : "专家类别",
				width : 100
			}, {
				field : "cqrs00",
				title : "抽取人数"
			}, {
				field : "_ssk000_",
				title : "所属库",
				width : 60
			}, {
				field : "pspm00",
				title : "评审品目",
				width : 60
			}] ]
		});
	});
	
</script>
<div style="padding:5px">
	<div id="ur_here">
		当前位置: <a href="${util:property('frontEnd')}">首页</a>
		<code>&gt;</code>
		抽取需求
	</div>
	<table id="expertDemand-datagrid" ></table>
	<div id="demand-container"></div>
</div>	