<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%-- 
Describe:中标通知查看
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<sys:link ca="true" uedit="true" easyui="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<script type="text/javascript">
function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${notify.pdfAttachmentId}");
    //document.all.HWPostil1.ForceSignType=7;
}
$(function(){
	
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
			招标/中标通知查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标/中标通知查看</h4>
			<form:form id="notifyForm" class="registerform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="notice">
				<input type='hidden' name="id" value="${notify.id}">
				<%--<input type='hidden' name="taskId" value="${taskId}">
				<input type='hidden' name="projectInstance.zbxmbh" value="${notice.projectInstance.zbxmbh}">
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" value="${signatureData.sealName}"/>
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" value="${signatureData.signatureData}"/>
				<form:hidden path="ggnrwb" id="ggnrwb"/>
				<input type="hidden" name="changeContent" value="${notice.changeContent}" /> --%>
				<table width="100%" class="mytableStyle" style="table-layout:fixed;">
					<tr>
						<th>招标项目名称：</th>
						<td colspan="3">${notify.projectName}</td>
					</tr>
					<tr>
						<th>标段名称：</th>
						<td colspan="3">${notify.projectItemName}</td>
					</tr>
					<tr>
						<th>中标机构：</th>
						<td colspan="3">${notify.organName}</td>
					</tr>					
					<tr>
						<th>通知标题：</th>
						<td colspan="3">${notify.title}</td>
					</tr>
					<tr>
						<th style="width:15%;">通知类型：</th>
						<td colspan="3">${notify.notifyType==0?"中标通知":"未中标通知"}</td>	
					</tr>
					<tr>
						<th>通知状态：</th>
						<td colspan="3">${notify.status==0?"草稿":"已提交"}</td>
					</tr>					
					<tr>
						<th style="vertical-align:middle">通知内容:</th>
						<td colspan='3'>
							<%-- <span id="ggnr"></span>
							<div id="notifyContent" style="border:1px solid #ddd;padding:50px;">${notify.content}</div>
							<span id="sealPos"></span> --%>
							
							<div class="usBox main" style="padding: 3px;height:660px;" id="">
								<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
								<script src="/resources/aip/LoadAip.js"></script>
								<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
							</div>
						</td>
					</tr>
				</table>
				<table id="attachmentUpload"></table>
				<input type="hidden" id="attachmentSsztId" value="${notify.id}"/>
				<input type="hidden" id="view" value="1"/>
			</form:form>
		</div>
		<div class="blank10"></div>
		<a class="button orange" onclick="history.go(-1)">返回</a>
	</div>
	<script src="/resources/page/notice/notifyFile.js" type="text/javascript"></script>
</body>
</html>