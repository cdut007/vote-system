<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">
	function selectProject() {
		if (event.srcElement.tagName == "TD") {
			objrow = event.srcElement.parentNode;
			objrad = objrow.cells[0].childNodes[0];//若嵌套结构有变化此处需要调整
			objrad.checked = true;
		}
	}
</script>
</head>
<body>
	<form:form id="project_list" action="${pageContext.request.contextPath}/project/list_dialog" method="post" commandName="project">
		<div class="mytable-border" style="width:99%">
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th width="130px">项目编号</th>
						<th width="150px">项目名称</th>
						<th>行业类型</th>
						<th>项目规模</th>
						<th>联系人</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.rows}" var="project_item" varStatus="status">
						<tr onclick="selectProject()">
							<td><input name="selValue" type="radio" value="${project_item.id}@${project_item.xmmc00}" /></td>
							<td>${project_item.xmbh00}</td>
							<td>${project_item.xmmc00}</td>
							<td>${project_item.xmhylx}</td>
							<td>${project_item.xmgm00}</td>
							<td>${project_item.lxr000}</td>
						</tr>
					</c:forEach>
					<c:forEach begin="${fn:length(page.rows)+1}" end="6" varStatus="status">
						<tr>
							<td><input type="radio" disabled="disabled" /></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</form:form>
</body>
</html>
