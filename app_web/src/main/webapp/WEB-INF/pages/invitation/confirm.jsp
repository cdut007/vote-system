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
<title>投标邀请确认</title>
<c:set value="${tenderItemService.loadTenderItem(processBusinessKey)}" var="tenderItem" scope="request" />
<c:set value="${tenderItem.projectItem}" var="projectItem" scope="request" />
<c:set value="${tenderItem.projectInstance}" var="projectInstance" scope="request" />
<c:set value="${recruitFileService.loadRecruitFileForInvitation(processBusinessKey)}" var="recruitFile" scope="request" />
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

		$("#pass").click(function() {
			$("input[name=accept]").val("true");
			$("#bidinvitationform").submit();
		});
		$("#unpass").click(function() {
			if ($.trim($("#comment").val()) == '') {
				alert("请填写拒绝意见！");
				return;
			}
		
			$("input[name=accept]").val("false");
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
			投标邀请确认
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>投标邀请确认</h4>
			<form id="bidinvitationform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' >
			
				
				<input type="hidden" name="accept"/>
				<input type="hidden" name="taskId" value="${taskId}" />
				<div class="blank10"></div>
				<table class='mytableStyle'>
					
					<tr>
						<td width="120px">招标项目名称</td>
						<td>${projectInstance}</td>
					</tr>
					<tr>
						<td width="120px">标段</td>					
						<td>${projectItem}</td>				
					</tr>
					<tr>
						<td width="120px">投标资格</td>					
						<td>${recruitFile.invitation.bidQualification}</td>				
					</tr>
					<tr>
						<td width="120px">回复截止时间</td>					
						<td>${recruitFile.invitation.inviteEndTime}</td>				
					</tr>
					<tr>
						<td width="120px">招标文件获取方法</td>					
						<td>${recruitFile.tenderNoticeData.bidFileObtainWay}</td>				
					</tr>
					<tr>
						<td>招标文件获取时间</td>
						<td>
								${recruitFile.tenderNoticeData.applyDateBegin}
									至
								${recruitFile.tenderNoticeData.applyDateEnd}
						</td>
					</tr>
					<tr>
						<td>投标文件递交截止时间</td>
						<td>
							${recruitFile.tenderNoticeData.bidDeadline}
						</td>
					</tr>
					<tr>
						<td>投标文件递交方法</td>
						<td>
							${recruitFile.tenderNoticeData.bidSendForm}
						</td>
					</tr>
					
					
				</table>
				<div class="blank10"></div>
				
				<div class="usBox main" style="padding: 3px;height:560px;" id="">
					<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
					<script src="/resources/aip/LoadAip.js"></script>
					<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				</div>
				
				<div class="blank10"></div>
				<table style="table-layout:fixed;width:100%">
					<tr>
						<td style="width:100px;">意见:</td>
						<td>
							<%-- <form:textarea path="reviewComment" cssStyle="width:99%;height:120px;" /> --%>
							<textarea id="comment" name="comment" style="width:99%;height:120px;"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding:10px 0 18px 0;">
							<input type="hidden" name="pass" value="true" /> 
							<input type="button" class="button red" value="接受" id="pass" /> 
							<input type="button" class="button red" value="拒绝" id="unpass" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>