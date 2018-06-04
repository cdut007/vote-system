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
		title:"正在开标项目标段",
		url:ctx+"/bidOpen/pagingBidOpeningData",
		pagination:true,
		rownumbers:true,
		singleSelect:true,
		striped:true,
		height:450,
		idField:"id",
		method:"post",
		columns:[[
			{field : 'projectInstance.zbxmmc',title : "项目名称",width:200,formatter:function(value,row,index){return row[0];}},
			{field : 'projectItem.bdmc00',title : "标段名称",width:200,formatter:function(value,row,index){return row[1];}},
			{field : 'bidOpenDate',title : "开标时间",width:150,formatter:function(value,row,index){return row[2];}},
			{field : 'projectItem.organTName',title : "业主单位",align:"left",width:200,formatter:function(value,row,index){return row[3];}},
			{field : 'openStatus',hidden:true,title : "开标状态",align:"left",width:100,formatter:function(value,row,index){return row[4]=="1"?"正常开标":row[4]=="-1"?"开标失败":"待开标";}},
			{field : 'closeReason',hidden:true,title : "开标异常",align:"left",width:150,formatter:function(value,row,index){return row[5];}},			
			{field : 'operate',hidden:true,title : "操作",align:"left",width:150,formatter:function(value,row,index){
				var expertApplyId=row[6];
				var openStatus=row[4];
				//if(rowData.expertApplyId && rowData.openStatus=="正常开标"){
				if(expertApplyId!=""&&openStatus=="1"){
					return "<a class=\"button red small\" href=\""+ctx+"/bidOpen/bidOpenManager?expertApplyId="+expertApplyId+"\" target='_blank'>进入</a>";//rowData.
				}
			}}
		]],
		toolbar:[{
			text : "添加开标质疑",
			iconCls : "myicon-application_add",
			handler : function() {
				var row=$("#bidOpening-datagrid").datagrid("getSelected");
				
				if(row==null){
					$.messager.alert("系统提示", "请先选择标段");
					return;
				}
				
				/*****************************************************************
				 *	判断开标是否已经结束
				 **********************/
				$.ajax({
					url:ctx+"/question/havaCandidatePublicity",
					type:"post",
					data:{expertApplyId:row[6]},
					dataType:"json",
					success:function(data){
						if(data.success){							
							var id = new Date().getTime();				
							$("body").append("<div style='padding:10px' id='" + id + "'></div>");
							$("#" + id).dialog({
								width : 600,
								height : 500,
								closed : false,
								modal : true,
								loadingMessage : '正在加载...',
								title : "需要澄清的问题",
								href : ctx + "/question/bidOpeningQuestionEdit",
								queryParams:{expertApplyId:row[6]},
								onClose : function() {
									$("#" + id).dialog("destroy");
								},
								buttons : [ {
									text : "确认",
									color : "red",
									handler : function() {
										$("#" + id + " form").ajaxSubmit({
											dataType:"json",
											beforeSend:function(){
												return $("#" + id + " form").form("validate");
											},
											success:function(data){
												if(data.success){
													$("#projectitem-datagrid").datagrid("reload");
													$("#" + id).dialog("close");
												}
												$.jGrowl(data.msg)
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
							
						}else{
							$.messager.alert("系统提示","评标已结束，不能发起质疑！","error");
							return false;
						}
					}
				});
			}
		}]
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		
		<div class="AreaR ">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				<code>&gt;</code>
				开标管理
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix">
						<table id="bidOpening-datagrid" class="easyui-datagird"></table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>