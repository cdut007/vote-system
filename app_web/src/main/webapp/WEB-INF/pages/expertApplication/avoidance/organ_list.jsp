<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:回避单位设置--单位查询dialog
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
		$("#avoidanceOrgan-datagrid").datagrid({
			title : "单位列表",
			height : 380,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/avoidanceOrgan/organList?hbxmzj=${avoidanceOrgan.hbxmzj}",
			cache : false,
			columns : [ [ {
				field : "ck",
				title : "",
				checkbox : true
			},{
				field : "ztbh00",
				title : "单位编号",
				width : 80
			}, {
				field : "ztmc00",
				title : "单位名称",
				width: 100
			} ] ]
		});
	});

</script>
	<div class="tableTitle2">查询条件</div>
	<form action="" class="registerform">
		<table class="mytableStyle">
			<tr>
				<td>单位编号</td><td><input type="text" name="hbdwbh" id="hbdwbh" value="${avoidanceOrgan.hbdwbh}" class="inputxt"/></td>
				<td>单位名称</td><td><input type="text" name="hbdwmc" id="hbdwmc" value="${avoidanceOrgan.hbdwmc}" class="inputxt"/></td>
				<td>
					<input type='button' value="查询" onclick="javascript:$('#avoidanceOrgan-datagrid').datagrid('load',{'hbdwbh':$('#hbdwbh').val(),'hbdwmc':$('#hbdwmc').val()});" class="button small red">
					<input type='reset' value="重置" class="button small red">
				</td>
			</tr>
		</table>
	</form>
	<div class="blank10"></div>
	<table id="avoidanceOrgan-datagrid"></table>
