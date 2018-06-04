<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<div class="usBox">
	<h4 style='border-bottom: #666 1px solid;'>
		<c:choose>
			<c:when test="${projectItem.id==null}">新增</c:when>
			<c:otherwise>修改</c:otherwise>
		</c:choose>
		标段（包）
	</h4>
	<form:form id="projectItem_form" class="registerform" method="post" action="${pageContext.request.contextPath}/projectItem/saveOrUpdate" modelAttribute="projectItem">
		<table width="100%" style="table-layout:fixed;">
			<tr>
				<td class="need">*</td>
				<td>标段（包）名称：</td>
				<td><form:input path="bdmc00" class="inputxt" datatype='s1-100' nullmsg="请输入标段名称！" errormsg="请输入中文名称！" /> <form:hidden path="id" /> <form:hidden path="bdbh00" /> <form:hidden path="tjsj00" /> <form:hidden path="projectInstance.id" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td class="need">*</td>
				<td>标段分类代码：</td>
				<td><form:input path="bdfldm" datatype='s1-20' nullmsg="请输入标段分类代码！" class="inputxt" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>标段（包）内容:</td>
				<td colspan='5'><form:textarea path="bdnr00" datatype="*" nullmsg="请输入标段（包）内容" style="width:682px;height:120px;" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td class="need">*</td>
				<td>标段合同估算价：</td>
				<td><form:input path="bdhtgj" class="inputxt" datatype="n.n" nullmsg="请输入标段合同估算价！" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td></td>
				<td>标段合同估算价币种：</td>
				<td><form:select path="bdgjdm">
						<option value="">--请选择--</option>
						<form:options items="${BZDM00}"  itemValue="itemCode" itemLabel="itemName"/>
					</form:select></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>标段合同估算价单位：</td>
				<td><form:select path="bdgjdw">
						<option value="">--请选择--</option>
						<form:options items="${util:dictionaryTree('JEDWDM',false)}"  itemValue="itemCode" itemLabel="itemName"/>
					</form:select></td>
				<td></td>
			</tr>
		</table>
		<div class="blank10"></div>
		<input type="submit" class="button red" value="保存" />
		<input type="button" class="button red" onclick="$(this).parents('.usBox:first').remove();<c:if test="${projectItem.id!=null}">$('#${projectItem.id}').show();</c:if>" value="取消" />
	</form:form>
</div>