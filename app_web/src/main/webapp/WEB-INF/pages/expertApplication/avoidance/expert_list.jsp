<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%-- 
Describe:回避专家设置--专家查询dialog
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<script type="text/javascript">
$(function(){
		$("#avoidanceExpert-datagrid").datagrid({
			title : "专家列表",
			height : 380,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/avoidanceExpert/expertList?hbxmzj=${avoidanceExpert.hbxmzj}",
			cache : false,
			columns : [ [ {
				field : "ck",
				title : "",
				checkbox : true
			},{
				field : "id",
				title : "专家编号",
				width : 80
			}, {
				field : "userName",
				title : "专家姓名",
				width: 100
			} ] ]
		});
	});
	
</script>
	<div class="tableTitle2">查询条件</div>
	<form action="${pageContext.request.contextPath}/avoidanceExpert/expertList?hbxmzj=${avoidanceExpert.hbxmzj}" class="registerform">
		<table class="mytableStyle">
			<tr>
				<td>专家编号</td><td><input type="text" name="hbzjzj" id="hbzjzj" value="${avoidanceExpert.hbzjzj}" class="inputxt"/></td>
				<td>专家姓名</td><td><input type="text" name="hbzjmc" id="hbzjmc" value="${avoidanceExpert.hbzjmc}" class="inputxt"/></td>
				<td>
					<input type='button' value="查询" class="button small red" onclick="javascript:$('#avoidanceExpert-datagrid').datagrid('load',{'hbzjzj':$('#hbzjzj').val(),'hbzjmc':$('#hbzjmc').val()});">
					<input type='reset' value="重置" class="button small red">
				</td>
			</tr>
		</table>
	</form>
	<div class="blank10"></div>
	<table id="avoidanceExpert-datagrid"></table>
