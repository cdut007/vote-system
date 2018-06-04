<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set var="projectInstance" value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(projectItem.projectInstanceId).singleResult()}"></c:set>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标项目管理
			<code>&gt;</code>
			标段管理
			<code>&gt;</code>
			添加标段
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				<c:choose>
					<c:when test="${projectItem.id==null}">新增</c:when>
					<c:otherwise>修改</c:otherwise>
				</c:choose>
				标段（包）
			</h4>
			<form:form id="projectItem_form" class="registerform" method="post" action="${pageContext.request.contextPath}/projectItem/indSaveOrUpdateProjectItem" modelAttribute="projectItem">
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id" />
				<form:hidden path="bdbh00" />
				<form:hidden path="projectInstanceId" />
				<table>
					<tr>
						<td class="need">*</td>
						<td style="width:120px;">标段（包）名称：</td>
						<td><form:input path="bdmc00" cssClass="inputxt easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="width:120px;">标段编号：</td>
						<td><form:input path="organProjectItemCode" cssClass="inputxt easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>标段分类代码：</td>
						<td>${util:dictionary('PROJECT_ITEM_TYPE',projectInstance.tenderProjectClassifyCode)} <%-- <form:select path="bdfldm" datatype='s1-20' nullmsg="请输入标段分类代码！" cssClass="inputxt">
					<form:options items="${util:dictionaryTree('PROJECT_ITEM_TYPE',false)}" itemValue="itemCode" itemLabel="itemName" />
				</form:select> --%>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>标段（包）内容:</td>
						<td><form:textarea path="bdnr00" cssClass="easyui-validatebox" data-options="required:true" style="width:400px;height:120px;" /></td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>交货期/工期/服务期</td>
						<td><sys:number name="deliveryTimeLimit" value="${projectItem.deliveryTimeLimit}" />天</td>
					</tr>
					<tr>
						<td class="need"></td>
						<td>标段合同估算价：</td>
						<td><form:input path="bdhtgj" cssClass="inputxt easyui-numberbox" datatype="n" nullmsg="请输入标段合同估算价！" /></td>
					</tr>
					<tr>
						<td></td>
						<td>标段合同估算价单位：</td>
						<td><form:select path="bdgjdw">
								<form:options items="${util:dictionaryTree('JEDWDM',false)}" itemValue="itemCode" itemLabel="itemName" />
							</form:select></td>
					</tr>
					<tr>
						<td></td>
						<td>标段合同估算价币种：</td>
						<td><form:select path="bdgjdm">
								<form:options items="${util:dictionaryTree('CURRENCY',false)}" itemValue="itemCode" itemLabel="itemName" />
							</form:select></td>
					</tr>
					<tr>
						<td></td>
						<td>标书售价（元）：</td>
						<td><form:input path="price" cssClass="inputxt easyui-numberbox" data-options="required:true" /></td>
					</tr>
				</table>
				<div class="blank10"></div>
				<input type="submit" class="button red" value="保存" />
				<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
			</form:form>
		</div>
	</div>
</body>
</html>