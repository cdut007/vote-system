<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%--专家个人详细评审结果确认 --%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标邀请书签章</title>
<sys:link ca="true" uedit="true" easyui="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
<!--该事件在AIP引擎初始化完毕之后触发-->
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
	HWPostil1_NotifyCtrlReady();
</SCRIPT>
<!--ready事件-->
<script type="text/javascript">
	
	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${qualificationInvitation.pdfAttachmentId}");
	}
	
		
	$(function() {
		
		var sealNum=0;
		
	    $("#sign").click(function(){
	    	if(AddSeal(0)=="-200"){
	            ShowMessage("请插入有效的USBKey！");
			}else{
	            sealNum=sealNum+1;
			};
		});
	
		$("#pass").click(function() {
			
			if (GetCurrUserID()==""||sealNum==0) {
				alert("请先盖章！");
				return false;
			}	
	        
	        var paramsArray = {"qualificationInvitationId":"${qualificationInvitation.id}"};
	        var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/qualificationInvitation/updateQualificationInvitation");
	        if ("OK" == returnValue) {
	            $("#workflowForm").submit();
	            ShowMessage("操作成功！");
	        } else {
	            ShowMessage("操作失败！");
	        }
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
			投标邀请书签章
		</div>
		
		<div class="usBox">
						
			<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
				<input type="hidden" name="taskId" value="${taskId}" /> 
			</form>
			
				
			<div class="usBox main" style="padding: 3px;height:560px;" id="">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			</div>
			
			<input type="button" class="button red" value="电子印章" id="sign"/>
			<input type="button" class="button red" value="提 交" id="pass" />
			
		</div>
		
	</div>
	
</body>
</html>
