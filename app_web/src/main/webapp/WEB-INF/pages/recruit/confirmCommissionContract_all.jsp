<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="${commissionContractService.retrieveCommissionContractByProjectInstanceId(processBusinessKey)}" var="commissionContract" scope="request"/>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>

	<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<script type="text/javascript">
    var sealNum=0;
	$(function() {
		$("#passBtn").click(function(){
            var r = ShowMessageOkCancel("确认委托代理合同有效吗?");
			if(r==1){
				$("#qdhtForm").submit();
			}
		});
		//不通过按钮确认
		$("#noBtn").click(function(event) {
			var r = ShowMessageOkCancel("确认不同意委托代理合同吗?");
			if(r==1){
				$("#pass").val("false");
				$("#qdhtForm").submit();
			}
		});
	});
	
	 function HWPostil1_NotifyCtrlReady() {
	        document.all.HWPostil1.HideMenuItem(30);
	        OpenFile("${pageScope.basePath}/attachment/download/${commissionContract.attachment.fjid00}");
	        //document.all.HWPostil1.ForceSignType=7;
	 }
    function  HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue) {
        if(lActionType==3 && lType==3){
            sealNum--;
            sealNum = sealNum <=0 ?0:sealNum;
        }else if(lActionType==5 && lType==0){
            sealNum++;
        }
    }
	 
</script>
<style type="text/css">
h3 {
	text-align: left;
	border: 0;
}

#spanClose:hover {
	background-color: #eee;
	font-weight: bold;
	cursor: pointer;
}

form {
	margin: 0;
}

.user_write {
	font-weight: 500;
	text-decoration: underline;
	font-family: 楷体;
	font-size: 15px;
	font-style: italic;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			确认合同
		</div>
		<div class="blank10"></div>
		<%-- <div class="usBox main" id="ht_content">${commissionContract.htnr00}</div> --%>
		<div class="usBox main" style="padding: 3px;height:660px;" id="ht_content">
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			<div style="text-align:right;">
				<form:form id="qdhtForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm" modelAttribute="commissionContract">
					<input type='hidden' id="taskId" name='taskId' value="${taskId}" />
					<input type='hidden' id="pass" name='pass' value="true" />
					<input type="button" class='button red' id="noBtn" value="不通过"/>
					<input type="button" class='button red' id="passBtn" value="通过"/>
				</form:form>
			</div>
			<div class="blank10"></div>
		</div>
	</div>
	<%--<jsp:include page="/common/bottom.jsp"/>--%>
</body>
</html>