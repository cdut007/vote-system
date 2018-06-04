<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<form:form id="signEdit_form" class="signform" method="post" action="${pageContext.request.contextPath}/sign/createOrUpdateSign" modelAttribute="sign">
	<form:hidden path="id"/>
	<table>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">签到人姓名:</td>
			<td>
				<form:input path="userName" cssClass="inputxt easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">身份证号:</td>
			<td>
				<form:input path="userNumber" cssClass="inputxt easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
				<tr>
			<td class="need">*</td>
			<td style="width:100px;">单位名称:</td>
			<td>
				<form:input path="unitName" cssClass="inputxt easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">联系方式:</td>
			<td>
				<form:input path="phoneNumber" cssClass="inputxt easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
	</table>
</form:form>

