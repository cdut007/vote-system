<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${recruitFileService.getRecruitFileAddendum(processBusinessKey)}" var="recruitFileAddendum" scope="request" />
<c:catch var="exception">
	<c:set value="${tenderUserId}" var="tenderUserId"></c:set>
	<c:set value="${recruitFileService.getRecruitFileAddendumReceipt(tenderUserId,processBusinessKey)}" var="recruitFileAddendumReceipt"></c:set>
</c:catch>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<jsp:include page="/common/link.jsp" />
<script>
function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${recruitFileAddendumReceipt.pdfAttachment.fjid00}");
}
		
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标文件补遗回执
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标文件补遗回执查看</h4>
			<form:form id="" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' >
				<input type="hidden" name="taskId" value="${taskId}" id="taskId"/>
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
						<td colspan="2" style="padding:10px 0 18px 0;">
							<input type="submit" class="button red" value="确 定" /> 
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>