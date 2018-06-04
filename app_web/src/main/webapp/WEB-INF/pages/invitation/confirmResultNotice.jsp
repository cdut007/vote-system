<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>确认资格预审结果</title>
<c:set value="${invitationFileService.findInvitationPdfAttachmentId(processBusinessKey)}" var="invitationAttachmentId" scope="request" />
<sys:link ca="true" uedit="true" easyui="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
	HWPostil1_NotifyCtrlReady();
</SCRIPT>
<jsp:include page="/common/link.jsp" />
<script>
	
	
	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${invitationAttachmentId}");
	}


	$(function() {

		$("#confirm").click(function() {
			$("#bidinvitationform").submit();
		});
	
	});
	

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			确认资格预审结果
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<form id="bidinvitationform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' >
				
				<input type="hidden" name="taskId" value="${taskId}" />
				
				<div class="usBox main" style="padding: 3px;height:560px;" id="">
					<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
					<script src="/resources/aip/LoadAip.js"></script>
					<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				</div>
				
				<div class="blank10"></div>
				<input type="button" class="button red" value="确认" id="confirm" /> 
				
			</form>
		</div>
	</div>
</body>
</html>