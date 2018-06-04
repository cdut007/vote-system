<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${recruitFileService.getRecruitFileAddendum(processBusinessKey)}" var="recruitFileAddendum" scope="request" />
<c:set value="${recruitFileService.getOrganBName()}" var="organBName" scope="request" />
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
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
			
			$("#receipt").click(function() {
				//$("#content").val($("#contentHTML").html());
				//$("#recruitFileAddendumReceiptForm").AjaxSubmit();
				
				$.ajax({
					url:ctx+"/recruitFile/saveRecruitFileAddendumReceipt",
					type:"post",
					data:{id:"${recruitFileAddendum.id}",content:$("#contentHTML").html()},
					dataType:"json",
					success:function(data){
						window.location.href=ctx+"/recruitFile/saveRecruitFileAddendumReceiptSign?id="+data.data+"&taskId="+$("#taskId").val();
					}
				});
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
			招标文件补遗详细
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标文件补遗详细</h4>
			<form:form id="recruitFileAddendumReceiptForm" method="post" action='' modelAttribute="">
				<input type="hidden" name="taskId" value="${taskId}" id="taskId"/>
				<input type="hidden" name="content" id="content" />
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
							<div id="contentHTML" style="padding:50px;border:1px solid #ddd;">
							<jsp:include page="defaultAddendumReceipt.jsp" /></div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding:10px 0 18px 0;">
							<input type="button" class="button red" value="发送回执" id="receipt" /> 
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>