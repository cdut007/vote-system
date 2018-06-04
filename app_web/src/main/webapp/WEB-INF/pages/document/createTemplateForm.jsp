<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form action="${pageContext.request.contextPath}/document/createTemplate" commandName="template">
	<table>
		<tr>
			<td class="need">*</td>
			<td>模板名称：</td>
			<td>
				<form:input path="name" cssClass='inputxt easyui-validatebox' data-options="required:true" />
			</td>
			<td>
				<div class="Validform_checktip"></div>
			</td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>模板描述：</td>
			<td>
				<form:textarea path="description" cssClass="easyui-validatebox" data-options="required:true" />
			</td>
			<td>
				<div class="Validform_checktip"></div>
			</td>
		</tr>
	</table>
</form:form>
