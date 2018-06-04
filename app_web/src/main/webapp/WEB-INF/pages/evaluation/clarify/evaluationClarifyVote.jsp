<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<c:set value="${evaluationClarifyService.createEvaluationClarifyQuery().evaluationClarifyId(processBusinessKey).singleResult()}" var="evaluationClarify" />
<c:set value="${tenderItemService.createTenderItemQuery().tenderItemId(evaluationClarify.tenderItemId).singleResult()}" var="tenderItem" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建澄清文件</title>
<sys:link jgrowl="true" easyui="true" />
<script type="text/javascript">
	$(function() {
		$("#agree").click(function() {
			$(":input[name='agree']").val("1");
			$("#clarifyForm").submit();
		});
		$("#disagree").click(function() {
			$(":input[name='agree']").val("0");
			$("#clarifyForm").submit();
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			发起澄清
		</div>
	</div>
	<form id="clarifyForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
		<input type='hidden' name="agree" value="1" /> <input type='hidden' name="taskId" value="${taskId}" /> <input type='hidden' name="token" value="${token}" />
		<div class="block">
			<table class="mytableStyle">
				<tr>
					<th>项目名称</th>
					<td>${tenderItem.projectInstanceName}</td>
					<th>标段名称</th>
					<td>${tenderItem.projectItemName}</td>
				</tr>
				<tr>
					<th>投标单位</th>
					<td colspan="3">${tenderItem.organBName}</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'澄清需求'" style="overflow: hidden">
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="receiptContentContainer">${evaluationClarify.question}</div>
				</div>
			</div>
		</div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;position:fixed;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
			<span style="float:right"> <a class="button red" id='agree'>同意发起澄清</a> <a class="button red" id='disagree'>不同意发起澄清</a>
			</span>
		</div>
	</form>
</body>
</html>
