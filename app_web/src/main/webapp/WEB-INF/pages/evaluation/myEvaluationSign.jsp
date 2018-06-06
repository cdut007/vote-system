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
<c:set value="${tenderItemScoreService.listMyTenderItemScore2Pdf(processBusinessKey,projectItemId,'','','')}" var="attachmentId" />

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
		HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<title>详细评审确认</title>
<sys:link ca="true" uedit="true" easyui="true"/>
<!--ready事件-->
<script type="text/javascript">
	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${attachmentId}");
	}

    var sealNum=0;
	$(function(){
	    $("#sign").click(function(){
	    	if(AddSeal(0)=="-200"){
	            ShowMessage("请插入有效的USBKey！");
			}
		});
	
		$("#pass").click(function() {
            if (sealNum<=0) {
                alert("请先盖章！");
                sealNum=0;
                return false;
            }
	        
	        var paramsArray = {"expertApplyId":"${processBusinessKey}","projectItemId":"${projectItemId}"};
	        var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/evaluation/expertDetailReviewSign");
	        if ("OK" == returnValue) {
	            $("#workflowForm").submit();
	            ShowMessage("操作成功！");
	        } else {
	            ShowMessage("操作失败！");
	        }
		}); 
	});

    function  HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue) {
        if(lActionType==3 && lType==3){
            sealNum--;
            sealNum = sealNum <=0 ?0:sealNum;
        }else if(lActionType==5 && lType==0){
            sealNum++;
        }
    }
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				评标结果签章
			</div>
	</div>
	
	<div class="block">
	
			<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
					<input type="hidden" id="DocumentID" name="DocumentID" value="${processBusinessKey}:${projectItemId}:${CURRENT_USER_SESSION_INFO}"/> 
					<input type="hidden" id="content" name="content" value="${content}" /> 
					<input type="hidden" name="taskId" value="${taskId}" /> 
					<input type="hidden" name="back" value="false" />
			</form>
			
		<form:form modelAttribute="">
			
			<div class="usBox main" style="padding: 3px;height:560px;" id="">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			</div>
			
			<input type="button" class="button red" value="电子印章" id="sign"/>
			<input type="button" class="button red" value="提 交" id="pass" />
		</form:form>
	</div>
</body>
</html>