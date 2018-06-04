<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:代理机构查询中标通知
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<html>
<head>
<style type="text/css">
</style>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function() {

	$("#bidNotify-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		//fitColumns : true,
		pagination : true,
		title:"中标通知",
		url : ctx+"/bidNotify/list",
		idField : "id",
		toolbar:[
			{
				text : "新建中标通知",
				iconCls : "myicon-application_add",
				handler : function() {
					window.location.href=ctx+"/bidNotify/add";				
				}
			},
			{
				text : "新建未中标通知",
				iconCls : "myicon-application_add",
				handler : function() {
					window.location.href=ctx+"/bidNotify/addNoPass";				
				}	
			}	
		],
		columns : [[
		   {field:"projectName",title:"招标项目",align:"left",width:150},	
		   {field:"projectItemName",title:"标段",align:"left",width:120},
           {field:"title",title:"通知标题",align:"left",width:150},
           {field:"notifyType",title:"通知类型",align:"center",width:65,formatter:function(value,row,index){
        	   if(value=="0") return "中标通知";
        	   else if(value=="1") return "未中标通知";
           }},
           {field:"status",title:"状态",align:"center",width:60,formatter:function(value,row,index){
        	   if(value=="0") return "草稿";
        	   else if(value=="1") return "已提交";
           }},
           {field:"createTime",title:"发布时间",align:"center",width:120},
           {field:"opt",title:"操作",align:"left",width:380,formatter : function(value,row,index) {
        	   var returnValue="<a class='button red small' href=\""+ctx+"/bidNotify/view?id="+row["id"]+"\">查看</a>";
        	   if(row["status"]==0){
	        	   returnValue+="<a class='button red small' href=\""+ctx+"/bidNotify/edit?id="+row["id"]+"\">编辑</a>";
	        	   //returnValue+="<a class='button red small' href=\""+ctx+"/bidNotify/delete?id="+row["id"]+"\">删除</a>";
	        	   returnValue+="<a class='button red small' href='#' onclick='doDelete(\""+row["id"]+"\")' >删除</a>";
	        	   returnValue+="<a class='button red small' href=\""+ctx+"/bidNotify/review?id="+row["id"]+"\">提交</a>";//submit
        	   }
        	   return returnValue;
		}}]]
		           
	});
});

function doDelete(id){
	$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
		if (ok) {
			var url=ctx+"/bidNotify/delete?id="+id;		
			location.href=url;
		}
	});
}
	

	
	function queryBidNotify(){
		var title=getFormValue("title");
		var beginDate=getFormValue("beginDate");
		var endDate=getFormValue("endDate");
		var notifyType=getFormValue("notifyType");
		var status=getFormValue("status");
		
		var queryParams={
				title:title,
				notifyType:notifyType,
				beginDate:beginDate,
				endDate:endDate,
				status:status
		};
		$('#bidNotify-datagrid').datagrid({
			pageNumber:1,
			queryParams:queryParams
		});		
	}
	
	function getFormValue(frmName){
		var frm=document.getElementById(frmName);
		if(frm==undefined) return "";
		return frm.value;
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
			中标通知管理
			<!--<code>&gt;</code>
			未中标通知管理-->
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<table style="width:100%;">
			    <tr>
					<td>通知标题：</td>
					<td> 
						<input id="title" class="inputxt" />
					</td>
					<td>通知类型：</td>
					<td>
						<select id="notifyType">
							<option value="">---==请选择==---</option>
							<option value="0">中标通知</option>
							<option value="1">未中标通知</option>
						</select>
					</td>
					<td style="text-align:right;"><a class="button red" onclick="queryBidNotify();">查 询</a></td>
				</tr>
				<tr>
					<td>发布时间从：</td>
					<td>
						<input type="text" id="beginDate" name="ggfbsjMin" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					</td>
					<td>到：</td>
					<td>
						<input type="text" id="endDate" name="ggfbsjMax" class="inputxt Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					</td>
					<td>通知状态：</td>
					<td>
						<select id=status>
							<option value="">---==请选择==---</option>
							<option value="0">草稿</option>
							<option value="1">已提交</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<div class="clearfix">
			<div class="blank10"></div>
			<table id="bidNotify-datagrid"></table>
		</div>
	</div>
</body>
</body>
</html>
