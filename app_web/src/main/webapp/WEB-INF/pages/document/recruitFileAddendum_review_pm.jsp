<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${recruitFileService.getRecruitFileAddendum(processBusinessKey)}" var="recruitFileAddendum" scope="request" />
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%-- <c:set value="${candidatePublicityService.getSignatureDataById(candidatePublicity.id)}" var="signatureData" scope="request" /> --%>
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
    OpenFile("${pageScope.basePath}/attachment/download/${recruitFileAddendum.pdfAttachment.fjid00}");
    //document.all.HWPostil1.ForceSignType=7;
}
	$(function() {
		
		$("#pass").click(function() {
			$("input[name=pass]").val("true");
			$("#recruitFileAddendumForm").submit();
		});
		$("#unpass").click(function() {
			if ($.trim($("#shyj").val()) == '') {
				ShowMessageOkCancel("请填写审核意见！");
				return;
			}
			if($("#shyj").val().length > 1000){
				ShowMessageOkCancel("最多输入1000个汉字(包含符号和空格)！");
				return;
			}
			$("input[name=pass]").val("false");
			$("#recruitFileAddendumForm").submit();
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
			招标文件补遗审核
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标文件补遗审核</h4>
			<form:form id="recruitFileAddendumForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="recruitFileAddendum">
				<form:hidden path="id" />
				<input type="hidden" name="DocumentID" value="${recruitFileAddendum.id}" />
				<input type="hidden" name="taskId" value="${taskId}" />
				<div class="blank10"></div>
				<div class="blank10"></div>
				
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
							<form:textarea path="shyj" cssStyle="width:99%;height:120px;" class="inputxt easyui-validatebox" data-options="validType:'length[0,1000]'"/>
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