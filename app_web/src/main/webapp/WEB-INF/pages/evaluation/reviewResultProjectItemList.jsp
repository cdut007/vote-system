<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set value="${qualificationResultDetailService.listReviewQualificationResultDetailList2pdf(processBusinessKey,projectItemId,reviewType,'','','')}" var="attachmentId" />
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<head>
<sys:link title="初步评审签章" easyui="true" webedit="true" jgrowl="true" spectrum="true" />
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
</SCRIPT>
	
	
	<script>
		function HWPostil1_NotifyCtrlReady() {
		    document.all.HWPostil1.HideMenuItem(30);
		    OpenFile("${pageScope.basePath}/attachment/download/${attachmentId}");
		}
		
		$(function(){
			$("#pass").click(function() {
	        	$("#workflowForm").submit();
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
			发起专家初评合议
		</div>
	</div>
<div class="block">

		<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm">
			<div class="usBox main" style="padding: 3px;height:560px;" id="">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			</div>
			
			<input type="hidden" name="taskId" value="${taskId}" />
			<input type="button" class="button red" value="提交合议结果" id="pass" />
		</form>
		
</div>
</body>