<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<%@page pageEncoding="utf-8"%>
<%@page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- 
Describe：添加或修改项目
Copyright: Copyright(c)2011
Company: 美宏博科技有限公司
author: zhangdingwang
--%>
<head>
<%@include file="/common/link.jsp"%>
<title>数据维护</title>
<script type="text/javascript">
	$(function() {
		$("#execute").click(function() {
			ajax({
				form : $("#sqlform"),
				success : function(data) {
					if(!data.success){
						alertMsg(data.msg);
					}else{
						$("#resultset").html(data.data);
					}
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="right_top_div">当前位置: 系统管理 &gt;数据维护</div>
	<form id="sqlform" action="${pageContext.request.contextPath}/tool/executeSQL" method="post">
		<table class="mytablerow" style="width:90%">
			<tr>
				<td>
					<a class="easyui-linkbutton" id="execute" data-options="plain:true,iconCls:'myicon-resultset_next'">执行</a> 
					<a class="easyui-linkbutton" data-options="plain:true,iconCls:'myicon-clear'" onclick="$('textarea').html('');">清空</a>
				</td>
			</tr>
			<tr>
				<td><textarea name="sql" style="width:100%;height:150px" name="sql" class="validate[required]"></textarea>
				</td>
			</tr>
			<tr>
				<td id="resultset" style="padding:0 0 0 0;"></td>
			</tr>
		</table>
	</form>
</body>