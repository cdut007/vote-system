<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<c:set var="projectInstance" value="${projectInstanceService.createProjectInstanceQuery().projectInstanceId(processBusinessKey).singleResult()}" />
<c:set var="projectItemList" value="${projectItemService.createProjectItemQuery().projectInstanceId(processBusinessKey).list()}" />
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 招标文件基本信息
author: ZORO
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>确认招标结果</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#pass").click(function() {
			$.messager.confirm("系统提示", "确认通过吗?", function(ok) {
				if (ok) {
					$("#workFlowForm").attr("action", ctx + "/workflow/completeForm?isComplete=true").submit();
				}
			});
		});
		$("#nopass").click(function() {
			var id = new Date().getTime();
			$("body").append("<div style='padding:10px' id='" + id + "'></div>");
			$("#" + id).dialog({
				width : 600,
				height : 400,
				closed : false,
				modal : true,
				title : "不通过原因",
				content : "<form action=\"" + ctx + "/workflow/completeForm?taskId=" + $(":input[name='taskId']").val() + "&isComplete=false\" method=\"post\"><textarea name=\"reason\" class=\"easyui-validatebox\" data-options=\"required:true\" style=\"width:560px;height:280px;\"></textarea></form>",
				onClose : function() {
					$("#" + id).dialog("destroy");
				},
				buttons : [ {
					text : "确认",
					color : "red",
					handler : function() {
						if ($("#" + id + " form").form("validate")) {
							$.messager.confirm("系统提示", "确认提交吗?", function(ok) {
								if (ok) {
									$("#" + id + " form").submit();
								}
							});
						}
					}
				}, {
					text : "取消",
					color : "red",
					handler : function() {
						$("#" + id).dialog("close");
					}
				} ]
			});
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
			招标文件信息
		</div>
		<div class="usBox">
			<form id="workFlowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
				<div class="clearfix">
					<h1 align="center">${projectInstance.zbxmmc}</h1>
					<c:forEach items="${projectItemList}" var="projectItem">
						<h4 class="tableTitle">${projectItem.bdmc00}</h4>
						<table class="mytableStyle" style="width:100%;background-color:#fff;">
							<thead>
								<tr>
									<th style="width:20px;">排名</th>
									<th style="width:365px;">投标单位</th>
									<th style="width:123px;">最终得分</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${evaluationReportService.retrieveTenderItemTop3(projectItem.id)}" var="tenderItem" varStatus="status">
									<tr>
										<td>${status.count}</td>
										<td>${tenderItem.organBName}</td>
										<td>${tenderItem.pjf000}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="blank10"></div>
					</c:forEach>
				</div>
				<div class="blank10"></div>
				<input type="hidden" value="${taskId}" name="taskId" /> 
				<a id="pass" class="red button">通过</a> 
				<a id="nopass" class="red button">不通过</a>
			</form>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>