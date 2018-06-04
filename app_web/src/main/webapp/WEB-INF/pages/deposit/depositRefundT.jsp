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

	$("#deposit-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		//fitColumns : true,
		pagination : true,
		title:"",
		url : ctx+"/deposit/listDepositReturnT",
		idField : "id",
		columns : [[
		   {field:"projectName",title:"招标项目",align:"left",width:150},	
		   {field:"projectItemName",title:"标段",align:"left",width:100},
           {field:"organName",title:"投标机构",align:"left",width:150},
           {field:"returnMoney",title:"退还金额",align:"center",width:80},
           {field:"createTime",title:"退还时间",align:"center",width:120},           
           {field:"attachmentId",title:"退还凭证",align:"center",width:280,formatter:function(value,row,index){
        	   var url=ctx+"/deposit/viewDepositReceipt?id="+row["id"];
        	   return "<a href='"+url+"'>查看凭证</a>";
           }}
        ]]/*,
		toolbar:[
			{
				text : "新建保证金退款",
				iconCls : "myicon-application_add",
				handler : function() {
					window.location.href=ctx+"/deposit/addDepositRefund";				
				}
			}
		],*/
	});
});


	function queryDepositFund(){
		var projectName=getFormValue("projectName");
		var itemName=getFormValue("itemName");
		
		var queryParams={
				projectName:projectName,
				itemName:itemName
		};
		$('#deposit-datagrid').datagrid({
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
			保证金退还查询
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
					<td style="text-align:right;"><a class="button red" onclick="queryDepositFund();">查 询</a></td>
				</tr>
			</table>
		</div>
		<div class="clearfix">
			<div class="blank10"></div>
			<table id="deposit-datagrid"></table>
		</div>
	</div>
</body>
</html>
