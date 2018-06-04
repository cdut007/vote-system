<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:投标机构查询中标通知
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
		url : ctx+"/bidNotify/listT?status=1",
		idField : "id",
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
        	   return returnValue;
		}}]]
		           
	});
});
	
	
	function queryBidNotify(){
		var title=getFormValue("title");
		var beginDate=getFormValue("beginDate");
		var endDate=getFormValue("endDate");
		var notifyType=getFormValue("notifyType");
		
		var queryParams={
				title:title,
				notifyType:notifyType,
				beginDate:beginDate,
				endDate:endDate,
				status:1
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
			<%--<code>&gt;</code>
			招标/资格预审公告管理 --%>
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
