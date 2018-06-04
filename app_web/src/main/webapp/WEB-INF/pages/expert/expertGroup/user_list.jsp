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
		$("#expertUser-datagrid").datagrid({
			title : "人员列表",
			height : 380,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/expertGroup/userList",
			queryParams:{id:"${expertGroup.id}"},
			cache : true,
			columns : [ [ {
				field : "id",
				checkbox : true
			}, {
				field : "userName",
				title : "专家姓名",
				width: 100
			},{
				field : "gender",
				title : "性别",
				width : 80
			} ] ]
		});
	});
	
</script>
	<div class="tableTitle2">查询条件</div>
	<form  class="registerform">
		<table class="mytableStyle">
			<tr>
				<td>专家编号</td><td><input type="text" name="hbzjzj" id="hbzjzj" value="${hbzjzj}" class="inputxt"/></td>
				<td>专家姓名</td><td><input type="text" name="hbzjmc" id="hbzjmc" value="${hbzjmc}" class="inputxt"/></td>
				<td>
					<input type='button' value="查询" class="button small red" onclick="javascript:$('#expertUser-datagrid').datagrid('load',{'hbzjzj':$('#hbzjzj').val(),'hbzjmc':$('#hbzjmc').val()});">
					<input type='reset' value="重置" class="button small red">
				</td>
			</tr>
		</table>
	</form>
	<div class="blank10"></div>
	<table id="expertUser-datagrid"></table>
