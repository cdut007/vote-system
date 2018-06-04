<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目计划信息表表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<form action="${pageContext.request.contextPath}/projectPlan/saveOrUpdate" method="post">
	<input type='hidden' name="id" value="${projectPlan.id}" /> 
	<input type='hidden' name="projectInstanceId" value="${empty projectPlan.projectInstanceId?projectInstanceId:projectPlan.projectInstanceId}" />
	<table class="mytablerow" style="width:100%;">
		<tr>
			<th><h1>工作任务计划:</h1></th>
		</tr>
		<tr>
			<td>
				<textarea name="gzrwjh" class="easyui-validatebox" data-options="required:true" style="width:99%;height:160px;">${projectPlan.gzrwjh}</textarea>
			</td>
		</tr>
		<tr>
			<th><h1>项目团队成员组成与职责分工:</h1></th>
		</tr>
		<tr>
			<td>
				<textarea name="xmcyzz" class="easyui-validatebox" data-options="required:true" style="width:99%;height:160px;">${projectPlan.xmcyzz}</textarea>
			</td>
		</tr>
	</table>
</form>
