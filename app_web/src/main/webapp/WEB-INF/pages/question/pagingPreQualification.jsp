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
	$("#preQualification-datagrid").datagrid({
		title:"资格预审结果公示列表",
		url:ctx+"/question/pagingPreQualificationData",
		pagination:true,
		rownumbers:true,
		singleSelect:true,
		striped:true,
		height:450,
		idField:"id",
		method:"post",
		columns:[[
			{field : 'projectInstanceName',title : "招标项目",width:250},
			{field : 'projectItemNames',title : "标段",width:150},
			{field : 'ggzt',title : "公告状态",width:100},
			{field : 'publishDate',title : "公告发布时间",width:100},
			{field : 'deadline',title : "公告结束时间",width:100},
			
			/* {field : 'id',title : "操作",width:100,formatter:function(value,rowData,rowIndex){
				return "<a class=\"button red small\" href=\""+ctx+"/bidOpen/bidOpenManager?expertApplyId="+value+"\" target='_blank'>进入</a>";
			}} */
		]],
		toolbar:[{
			text : "添加资格预审结果质疑",
			iconCls : "myicon-application_add",
			handler : function() {
				var row=$("#preQualification-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示", "请先选择标段");
					return;
				}
				
				/*****************************************************************
				 *	判断资格预审结果公示是否已经结束
				 **********************/
				$.ajax({
					url:ctx+"/question/preQualificationEnd",
					type:"post",
					data:{preQualificationNoticeId:row.id},
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
								href : ctx + "/question/preQualificationQuestionEdit",
								queryParams:{preQualificationNoticeId:row.id},
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
							$.messager.alert("系统提示","资格预审结果公示已结束，不能发起质疑！","error");
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
				资格预审结果公示列表
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix">
						<table id="preQualification-datagrid" class="easyui-datagird"></table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>