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
<%--<script type="text/javascript" src="/resources/fusionCharts/FusionCharts.js"></script> --%>
<jsp:include page="/common/link.jsp" />
<script>
$(document).ready(function(){
	var msg = "${msg}";
	if(msg==null || msg==""){

	}else{
		$.messager.alert("系统提示",msg);
	}
});
		
	$(function(){
		
		$("#projectList-datagrid").datagrid({
			title:"招标项目列表",
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			//fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : ctx+"/projectInstance/tendereelist",
			toolbar : [
						{
							text : "添加",
							iconCls : "myicon-application_add",
							handler : function() {
								window.location.href="/projectInstance/view_create_project_instance?createByAgency=false"
							}
						},
						{
							text : "编辑",
							iconCls : "myicon-application_edit",
							handler : function() {
								var rows = $('#projectList-datagrid').datagrid('getSelections');
								if(rows.length==0){
									$.messager.alert('提示',"请选择要编辑的招标项目！",'info');
									return;
								}
								var row=rows[0];//alert(row.id+",dlrzj0="+row.dlrzj0);
								/* console.log(row);
								var dlrzj0=row[8];
								//if(row.dlrzj0!=""&&row.dlrzj0!=null){
								if(dlrzj0!=""&&dlrzj0!=null){
									$.messager.alert('提示',"该招标项目已经签订了代理合同，不能编辑！",'info');
									return;
								} */
								window.location.href="/projectInstance/view_create_project_instance?createByAgency=false&id="+row[0];//row.id
							}
						},
						{
							text : "删除",
							iconCls : "myicon-application_delete",
							handler : function() {
								var rows = $('#projectList-datagrid').datagrid('getSelections');
								if(rows.length==0){
									$.messager.alert('提示',"请选择要删除的招标项目！",'info');
									return;
								}
								var row=rows[0];//alert(row.id+",dlrzj0="+row.dlrzj0);
								var dlrzj0=row[8];
								//if(row.dlrzj0!=""&&row.dlrzj0!=null){
								if(dlrzj0!=""&&dlrzj0!=null){
									$.messager.alert('提示',"该招标项目已经签订了代理合同，不能删除！",'info');
									return;
								}		
								
								$.messager.confirm("系统提示","确认删除吗?",function(ok){
									if(ok){
										var url="/projectInstance/delete?id="+row[0];//row.id
										$.post(url,function(data){
											var result=eval("("+data+")");
											$.messager.alert("系统提示",result.msg);
											window.location="${pageContext.request.contextPath}/projectInstance/tendereelayout";
										});
									}
								});	
							}
						},
						{
							text : "查看",
							iconCls : "myicon-application_view_icons",
							handler : function() {
								var rows = $('#projectList-datagrid').datagrid('getSelections');
								if(rows.length==0){
									$.messager.alert('提示',"请选择招标项目！",'info');
									return;
								}
								var row=rows[0];
								window.location.href="/projectInstance/viewProjectInstance?id="+row[0];//row.id
							}
						}
						],
			columns : [ [ 
				{field : "id",title : "招标项目编号",width :100,hidden:true,formatter:function(value,row,index){return row[0];}},
				{field : "zbxmbh",title : "招标项目编号",width :100,hidden:true}, 
				{field : "zbxmmc",title : "招标项目名称",width:160,formatter:function(value,row,index){return row[2];}},
				{field : "organTName",title : "招标人",width : 60,hidden:true},
				{field : "organAName",title : "代理机构",width : 160,formatter:function(value,row,index){return row[3];}},
				{field : "zbfs00",title : "招标方式",width : 80,formatter:function(value,row,index){return row[4]=="1"?"公开招标":row[4]=="2"?"邀请招标":"其他";}}, 
				{field : "zbzzxs",title : "招标组织形式",width : 100,formatter:function(value,row,index){return row[5]=="1"?"自行招标":row[5]=="2"?"委托招标":"其他";}}, 
				{field : "lxsj00",title : "立项时间",width : 120,formatter:function(value,row,index){return row[6];}}, 
				{field : "delegationWay",title : "委托方式",width : 90,formatter:function(value,row,index){return row[7]=="0"?"自主选择":"随机选择";}}, 
				{field : "operate",title : "操作",width:220,formatter : function(value,row,index) {value=row[0];
					return "<a class='button red small' href=\"javascript:zb_plan('"+value+"')\">招标计划</a><a class='button red small' href=\"${pageContext.request.contextPath}/commissionContract/addOrMod?projectInstanceId="+value+"\">代理合同</a>"
					+ "<a class='button red small' href=\"${pageContext.request.contextPath}/contract/contractPerformanceList?projectInstanceId=" + value + "\">合同履约</a>";
				}} 
			] ]
		});
		/* var width="480";
		var column3D1= new FusionCharts( "/resources/fusionCharts/Pie3D.swf", "projectInstancePieId", width, "280", "0", "1" );
		column3D1.setJSONUrl(ctx+"/report?caption="+encodeURI(encodeURIComponent("项目分类统计饼图"))+"&year="+new Date().getFullYear()+"&organRoleFlag=T");
		column3D1.render("projectInstancePie");
		 	 
		var column3D2 = new FusionCharts( "/resources/fusionCharts/Pie3D.swf", "projectInstancePie1Id", width, "280", "0", "1" );
		column3D2.setJSONUrl(ctx+"/report2?caption="+encodeURI(encodeURIComponent("部门项目统计饼图"))+"&year="+new Date().getFullYear()+"&organRoleFlag=T");
		column3D2.render("projectInstancePie1");
		
		var column3D3 = new FusionCharts( "/resources/fusionCharts/Column3D.swf", "projectInstancePie3Id", width, "280", "0", "1" );
		column3D3.setJSONUrl(ctx+"/report?caption="+encodeURI(encodeURIComponent("项目分类统计柱状图"))+"&year="+new Date().getFullYear()+"&organRoleFlag=T");
		column3D3.render("projectInstancePie3");
		
		var column3D3 = new FusionCharts( "/resources/fusionCharts/Column3D.swf", "projectInstancePie4Id", width, "280", "0", "1" );
		column3D3.setJSONUrl(ctx+"/report3?caption="+encodeURI(encodeURI("月份项目分统计柱状图"))+"&year="+new Date().getFullYear()+"&organRoleFlag=T");
		column3D3.render("projectInstancePie4"); */
	});
	
	function takanlist(projectInstanceId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "勘探查看",
			href : "${pageContext.request.contextPath}/projectInstance/takanlist?projectInstanceId="+projectInstanceId,
			onClose : function() {
				$("#" + id).dialog("destroy");
			}
		});
	}
	function zb_plan(zbxmid){
		var id=new Date().getTime(); 
		$("body").append("<div style='padding:10px' id='"+id+"'></div>");
		$('#'+id).dialog({
			width:800,
			height:500,
			title:"招标计划",
			loadingMessage:'正在加载...',
			modal:true,
			href:ctx+"/projectPlan/form?projectInstanceId="+zbxmid,
			onClose:function(){
				$('#'+id).dialog("destroy");
			},
			buttons:[{text : "确认",color : "red",handler : function(){$("#"+id+" form").ajaxSubmit({
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
		});
	}
 
</script>

</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标项目管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<!-- <table style="width:100%;">
				<tr>
					<td style="text-align: center"><div id="projectInstancePie"></div></td>
					<td style="text-align: center"><div id="projectInstancePie1"></div></td>
				</tr>
				<tr>
					<td style="text-align: center"><div id="projectInstancePie3"></div></td>
					<td style="text-align: center"><div id="projectInstancePie4"></div></td>
				</tr>
			</table> -->
			<div class="blank10"></div>
			<table id="projectList-datagrid"></table>
		</div>
	</div>
</body>
</html>
