<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<c:set value="${tenderService.getTender(processBusinessKey)}" var="tender"></c:set>
<c:set value="${tender.tenderItemList}" var="tenderItemList"></c:set>
<html>
	<head>
		<jsp:include page="/common/link.jsp" />
		<script type="text/javascript">
			$(function(){
				$("#fanhui").click(function(){
					window.location=ctx+"/home";
				});
			});
		</script>
	</head>
	<body>
		<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			撤销投标确认
		</div>
		<div class="blank10"></div>
		<table class='mytableStyle' style="width:100%;">
			<tr>
				<th>投标项目</th>
				<td>${tender.projectInstanceName }</td>
			</tr>
			<tr>
				<th style="width:200px;">投标单位</th>
				<td>${tender.organName}</td>
			</tr>
			<tr>
				<th style="width:200px;">授权人</th>
				<td>${tender.applyUserName}</td>
			</tr>
		</table>
		<div class="blank10"></div>
		<table class='mytableStyle' style="width:100%;">
			<thead>
				<tr>
					<th>标段名称</th>
					<th>投标文件</th>
					<th>投标保证金</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${tenderItemList }" var="tenderItem">
					<tr>
						<td>
							${tenderItem.projectItemName}
						</td>
						<td><c:if test="${empty tenderItemService.findBidFileAttachment(tenderItem.id)}" var="notUpload">未上传</c:if><c:if test="${!notUpload}">已上传</c:if></td>
						<td><c:if test="${empty tenderItemService.findDepositEvidenceAttachment(tenderItem.id)}" var="notSend">未提交</c:if><c:if test="${!notSend}">已提交</c:if></td>
					</tr>		
				</c:forEach>
			</tbody>
		</table>
		<div class="blank10"></div>
		<form method="post" action="${pageContext.request.contextPath}/workflow/completeForm" >
			<input name="taskId" value="${taskId}" type="hidden"/>
			<input name="token" value="${token}" type="hidden"/>
			<input type="submit"  class="button red" value="确认"  id="fanhui">
		</form>
	</div>
	</body>
</html>