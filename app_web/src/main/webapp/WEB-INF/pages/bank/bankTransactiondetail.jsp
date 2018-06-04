<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<sys:link easyui="true" jgrowl="true"/>
<script type="text/javascript">
$(function(){
	$("#bank-datagrid").datagrid({
		title:"交易明细详情",
		url:ctx+"/banks/transactiondetail?t="+new Date(),
		idField:"certNo",
		striped:true,
		pagination:true,
		rownumbers:true,
		toolbar:"#toolbar",
		columns:[[
			{title:"流水号",field:"certNo",width:200},
			{title:"我方账号",field:"ownerAccountNo",width:200},
			{title:"对方账号",field:"oppAccountNo",width:200},
			/* {title:"收款账号",field:"toAccount",width:200}, */
			{title:"交易单位",field:"oppOrganName",width:200},
			/* {title:"付款单位名称",field:"toOrganName",width:100}, */
			{title:"交易金额",field:"amount",width:100},
			{title:"时间",field:"createTime",width:150},
			{title:"支付类型",field:"transactionType",width:150},
			{title:"备注",field:"remarks",width:200}
		]]
		
	});
	
	$("#sousuo").click(function(){
			var start = $('#startDate').datebox('getValue').replace(/[^\d]/g,"");
			var end = $('#endDate').datebox('getValue').replace(/[^\d]/g,"");
			var transactionType=$('#transactionType').val();
			$("#bank-datagrid").datagrid("reload",{"startDate":start,"endDate":end,"transactionType":transactionType});
		});
});
</script>
</head>
  <body>
  <jsp:include page="/common/top.jsp"/>
  <div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				企业账户管理
				<code>&gt;</code>
				交易明细查询
		</div>
	</div>
	<div class="block ">
	<%-- <table class="easyui-datagrid"  data-options="title:'交易明细详情',striped:true" style="width:800px;height:auto">
		<thead>
			<tr>
				<th>付款账号</th>
				<th>收款账号</th>
				<th>银行流水号</th>
				<th>收款单位名称</th>
				<th>付款单位名称</th>
				<th>金额</th>
				<th>时间</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
				<%=session.getAttribute("bankTransactiondetail") %>
			<c:forEach items="${bankTransactiondetail}" var="b">
				<tr>
					<td>${b.fromAccount}</td>
					<td>${b.toAccount}</td>
					<td>${b.serialNumber}</td>
					<td>${b.fromOrganOName}</td>
					<td>${b.toOrganOName}</td>
					<td>${b.amount}</td>
					<td>${b.createTime}</td>
					<td>${b.remarks}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table> --%>
	<div id="toolbar">
		<table>
			<tr>
				<td>开始时间：<input id='startDate' class='easyui-datebox' style='width:120px'/></td>
				<td>结束时间：<input id='endDate' class='easyui-datebox' style='width:120px'/></td>
				<td>
					类型：<select id='transactionType' style="width:80px">
						 	<option value="">--所有--</option>
						 	<option value="B">招标文件</option>
						 	<option value="C">保证金</option>
						 </select>
				</td>
			</tr>
		</table>
		<table  style="width:100%;">
			<tr>
				<td>
					<a id='sousuo' class='easyui-linkbutton' iconCls='icon-search' style="float:right">搜索</a>
				</td>
			</tr>
		</table>
	</div>
	<table id="bank-datagrid"></table>
		<!-- <input type="hidden" id="projectInstanceId" name="projectInstanceId"/>
		<input type="hidden" id="projectItemId" name="projectItemId"/> -->
	</div>
	<div class="blank10"></div>
	<%-- <jsp:include page="/common/bottom.jsp"/> --%>
    
  </body>
</html>
