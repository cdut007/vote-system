<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<form:form id="exceptionEdit_form" class="exceptionform" method="post" action="${pageContext.request.contextPath}/evaluation/exceptionReportAdd" modelAttribute="exception">
	<form:hidden path="expertApplyId"/>
	<form:hidden path="projectItemId"/>
	<form:hidden path="projectInstanceId"/>
	<form:hidden path="projectId"/>
	<table>
		<tr>
			<td class="need"></td>
			<td style="width:120px;">项目名称:</td>
			<td>
					${exception.expertApply.projectInstance.project.xmmc00}
			</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td style="width:120px;">招标项目名称:</td>
			<td>${exception.expertApply.projectInstanceName}

			</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td style="width:120px;">相关标段（包）名称:</td>
			<td>${exception.projectItem.bdmc00}
			</td>
		</tr>

		<tr>
			<td class="need">*</td>
			<td style="width:120px;">报告名称:</td>
			<td>
				<form:input path="exceptionTitle" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
			</td>
		</tr>

		<tr>
			<td class="need">*</td>
			<td style="width:120px;">招标异常情况描述:</td>
			<td>
				<form:textarea path="exceptionContent" cssClass="inputxt easyui-validatebox"  data-options="required:true"/>
			</td>
		</tr>
	</table>
</form:form>

