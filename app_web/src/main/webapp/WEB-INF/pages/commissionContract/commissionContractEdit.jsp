<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<sys:link easyui="true" jgrowl="true" uedit="true" datepicker="true" plupload="true" ztree="true"/>
<script type="text/javascript" src="/resources/page/contract/contractEdit.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			合同管理
			<code>&gt;</code>
			${empty commissionContract.id?"添加":"编辑"}代理合同
		</div>
	</div>
	<div class="block">
		<form:form id="commissionContractForm" method="post" action="${pageContext.request.contextPath}/commissionContract/creatCommissionContract" modelAttribute="commissionContract">
			<form:hidden path="id" />
			<table style="width:100%;">
				<col style="width:80px;" />
				<col />
				<col style="width:80px;" />
				<col />
				<tbody>
					<tr>
						<td>合同名称</td>
						<td colspan="3">
							<form:input path="htmc00" cssClass="inputxt easyui-validatebox" style="width:80%" data-options="required:false"/>&nbsp;&nbsp;<a id="pickfile" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">导入合同文件</a>
						</td>
					</tr>
					<!--  <tr>
						<td>创建人</td>
						<td>
							<form:input path="htcjr0" cssClass="inputxt" />
						</td>
					</tr>	-->

					<tr>
						<th><nobr>合同内容&nbsp;&nbsp;</nobr></th>
						<td colspan="3">
							<form:textarea path="htnr00" style="height:400px;"/>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="blank10"></div>
			<a class="button red" id="saveBtn"> 保存</a>
			<a class="button red" href="${pageContext.request.contextPath}/commissionContract/list">返回</a>
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
