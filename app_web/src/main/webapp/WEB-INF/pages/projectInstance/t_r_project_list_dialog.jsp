<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%--  
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">

function selectRProject(){
	if(event.srcElement.tagName=="TD"){
       objrow=event.srcElement.parentNode;
	   objrad=objrow.cells[0].childNodes[0];//若嵌套结构有变化此处需要调整
	  objrad.checked=true;
    }
}

</script>
</head>
<body>
	<form:form id="projectInstance_list" action="${pageContext.request.contextPath}/projectInstance/list_dialog" method="post" commandName="projectInstance">
		
		<div class="mytable-border" style='width:99%'>
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th width="150px">招标项目编号</th>
						<th width="200px">招标项目名称</th>
						<th>招标人</th>
						<th>代理机构</th>
						<th>招标方式</th>
						<th>组织形式</th>
						<th>立项时间</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="projectInstance_item" varStatus="status">
					<tr onclick="selectRProject()">
						<td><input name="selValue" type="radio" value="${projectInstance_item.zbxmbh}@${projectInstance_item.zbxmmc}" /></td>
						<td>${projectInstance_item.zbxmbh}</td>
						<td>${projectInstance_item.zbxmmc}</td>
						<td>${projectInstance_item.zbr000}</td>
						<td>${projectInstance_item.dljgmc}</td>
						<td>${util:dictionary('ZBFS00',projectInstance_item.zbfs00)}</td>
						<td>${util:dictionary('ZBZZXS',projectInstance_item.zbzzxs)}</td>
						<td><fmt:formatDate value="${projectInstance_item.lxsj00}" type="both" dateStyle="default" timeStyle="default"/></td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(page.rows)+1}" end="6" varStatus="status">
					<tr>
						<td><input type="radio" disabled="disabled"/></td>
						<td></td>
						<td></td>
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
