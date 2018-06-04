<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Describe:投标文件上传查询
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

	$("#bidList-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		//fitColumns : true,
		pagination : true,
		title:"投标文件上传时间",
		url : ctx+"/bidFile/listBidFileUploadInfo",
		idField : "id",
		columns : [[
		   {field:"projectInstanceName",title:"招标项目",align:"left",width:300,formatter:function(value,row,index){return row[0];}},	
		   {field:"projectItemName",title:"标段",align:"left",width:250,formatter:function(value,row,index){return row[1];}},
           {field:"organBName",title:"投标机构",align:"left",width:250,formatter:function(value,row,index){return row[2];}},
           {field:"tbsj00",title:"投标文件上传时间",align:"center",width:180,formatter:function(value,row,index){return row[3];}}
           ]]
	});
});


	function queryBidList(){
		var projectName=getFormValue("projectName");
		var itemName=getFormValue("itemName");
		
		var queryParams={
				projectName:projectName,
				itemName:itemName
		};
		$('#bidList-datagrid').datagrid({
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
			投标文件上传信息
			<!--<code>&gt;</code>
			未中标通知管理-->
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<table style="width:100%;">
			    <tr>
					<td>项目名称：</td>
					<td> 
						<input id="projectName" class="inputxt" />
					</td>
					<td>标段名称：</td>
					<td>
						<input id="itemName" class="inputxt" />
					</td>
					<td style="text-align:right;"><a class="button red" onclick="queryBidList();">查 询</a></td>
				</tr>
				<%--<tr>
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
				</tr> --%>
			</table>
		</div>
		<div class="clearfix">
			<div class="blank10"></div>
			<table id="bidList-datagrid"></table>
		</div>
	</div>
</body>
</body>
</html>
