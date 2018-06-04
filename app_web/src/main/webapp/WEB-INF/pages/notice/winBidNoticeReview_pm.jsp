<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${winBidNoticeService.getWinBidNotice(processBusinessKey)}" var="winBidNotice" scope="request" />
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%-- <c:set value="${winBidNoticeService.getSignatureDataById(processBusinessKey)}" var="signatureData" scope="request" /> --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<jsp:include page="/common/link.jsp" />
<script>
function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${winBidNotice.pdfAttachment.fjid00}");
    //document.all.HWPostil1.ForceSignType=7;
}
	$(function() {
		
		
		$("#pass").click(function() {
			$("input[name=pass]").val("true");
			$("#publicityForm").submit();
		});
		
		$("#unpass").click(function() {
			if ($.trim($("#shyj").val()) == '') {
				ShowMessageOkCancel("请填写审核意见！");
				return;
			}
			
			$("input[name=pass]").val("false");
			$("#publicityForm").submit();
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
			中标公告审核
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>中标公告审核</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="winBidNotice">
				<form:hidden path="id" />
				<form:hidden path="projectInstanceId" />
				<%-- <form:hidden path="projectItemId" /> --%>
				<form:hidden path="publishDate" />
				<form:hidden path="deadline" />
				<form:hidden path="contacts" />
				<form:hidden path="phone" />
				<form:hidden path="email" />
				<input type="hidden" name="DocumentID" value="${winBidNotice.id}" />
				<input type="hidden" name="taskId" value="${taskId}" />
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" />
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" />
				<form:hidden path="noticeContent" id="noticeContent"/>
				<div class="blank10"></div>
				<table class='mytableStyle'>
					<col style="width:100px" />
					<col />
					<col style="width:100px" />
					<col />
					<tr>
						<th width="120px">招标项目名称</th>
						<td>${winBidNotice.projectInstance}</td>
					</tr>
					<tr>
						<th width="120px">标段</th>
						<td>
							<c:forEach items="${winBidNotice.projectItemList}" var="item">
								<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
				</table>
				<div class="blank10"></div>
				
				<%-- <div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<span id="noticeCont"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${winBidNotice.noticeContent}</div>
					<span id="sealPos"></span>
				</div> --%>
				<div class="usBox main" style="padding: 3px;height:660px;">
					<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
					<script src="/resources/aip/LoadAip.js"></script>
					<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				</div>
				
				<div class="blank10"></div>
				<table style="table-layout:fixed;width:100%">
					<tr>
						<td style="width:100px;">审核意见:</td>
						<td>
							<%-- <form:textarea path="reviewComment" cssStyle="width:99%;height:120px;" /> --%>
							<textarea id="shyj" name="shyj" style="width:99%;height:120px;" class="inputxt easyui-validatebox" data-options="validType:'length[0,1000]'"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding:10px 0 18px 0;">
							<input type="hidden" name="pass" value="true" /> 
							<input type="button" class="button red" value="通过" id="pass" /> 
							<input type="button" class="button red" value="不通过" id="unpass" />
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>