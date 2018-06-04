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
			url : "${pageContext.request.contextPath}/invitationFile/pagingAllTenderData",
			queryParams:{},
			cache : true,
			columns : [ [ {
				field : "id",
				checkbox : true
			}, {
				field : "ztmc00",
				title : "主体名称",
				width: 100
			},{
				field : "region",
				title : "区域",
				width : 80
			},{
				field : "industry",
				title : "行业",
				width : 80
			},{
				field : "address",
				title : "联系地址",
				width : 80
			}   ] ]
		});
	});
	
</script>
	<div class="tableTitle2">查询条件</div>
	<form  class="registerform">
		<table class="mytableStyle">
			<tr>
				<td>主体名称</td><td><input type="text" name="ztmc00" id="ztmc00" value="${ztmc00}" class="inputxt"/></td>
				<td>
					<input type='button' value="查询" class="button small red" onclick="javascript:$('#expertUser-datagrid').datagrid('load',{'ztmc00':$('#ztmc00').val()});">
					<input type='reset' value="重置" class="button small red">
				</td>
			</tr>
		</table>
	</form>
	<div class="blank10"></div>
	<table id="expertUser-datagrid"></table>
