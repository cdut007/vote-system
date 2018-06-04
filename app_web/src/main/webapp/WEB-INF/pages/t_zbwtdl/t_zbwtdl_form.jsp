<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标委托代理表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<form:form id="t_zbwtdl_form_id" action="${pageContext.request.contextPath}/t_zbwtdl/saveOrUpdate" method="post" commandName="t_zbwtdl">
	<form:hidden path="id"/>
	<table class="mytablerow" style="width:600px;">
		<tr>
			<th width="90px">招标项目编号</th><td><form:input path="zbxmbh" cssClass="validate[maxSize[10]]"/></td>
			<th width="90px">招标代理机构代码</th><td><form:input path="dljgdm" cssClass="validate[maxSize[4]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标代理机构名称</th><td><form:input path="dljgmc" cssClass="validate[maxSize[50]]"/></td>
			<th width="90px">招标代理资格分类代码</th><td><form:input path="dlzgfl" cssClass="validate[maxSize[3]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标代理资格分级代码</th><td><form:input path="dlzgfj" cssClass="validate[maxSize[3]]"/></td>
			<th width="90px">招标代理内容与范围</th><td><form:input path="dlnrfw" cssClass="validate[maxSize[1000]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标代理权限</th><td><form:input path="zbdlqx" cssClass="validate[maxSize[250]]"/></td>
			<th width="90px">招标代理机构项目负责人信息</th><td><form:input path="dlfzr0" cssClass="validate[maxSize[150]]"/></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	$("#t_zbwtdl_form_id").validationEngine({showOneMessage : true,promptPosition : "bottomLeft"});
});
</script>
