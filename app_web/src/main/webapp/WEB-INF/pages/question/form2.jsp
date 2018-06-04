<%@page pageEncoding="utf-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" easyui="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	
<script type="text/javascript">
$(function(){
	//var sealName = "${CURRENT_USER_SESSION_INFO.organName}";
	//var sealCount=sealUtil.sealCount();
	// 验证电子印章
	//function seal(sealName) {
		//var signData = sealUtil.addSealWithBKeyNoSave(sealName,"data=string2sign","sealPosition",300,-100);
		//$("#signatureData").val(signData);
	//}
	$("#sign").click(function(){
		$("#receiptContent").val($("#receiptContentContainer").html());
		
		//seal(sealName);
		//if($("#signatureData").val()!=""){
			
			$("#clarifyForm").ajaxSubmit({
				dataType:"json",
				success:function(data){
					//$.messager.alert("系统提示",data.msg);
					//window.location.href=ctx+"/home";
					window.location.href=ctx+"/question/receipt_confirm_form?id="+data.data;
				}
			});
			
		//}else{
		//	$.messager.alert("系统提示","signData 为空，签章失败");
		//}
	});
	//sealUtil.loadAllSealWithBKey("${recruitFile.id}","data=string2sign","sealPosition2");
});


function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${recruitFile.pdfAttachment.fjid00}");
    //document.all.HWPostil1.ForceSignType=7;
}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			澄清文件确认
		</div>
	</div>
	<form:form action="${pageContext.request.contextPath}/question/setQrReconnaissance" method="post" modelAttribute="recruitFile">
		<div class="block">
			<div style="width:100%;background:#f1f1f1;border:1px solid #ddd;height:660px;">
				<%-- <div style="background:#fff;width:750px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;font-size:12px">${recruitFile.modifyContent}</div>
				<span id="sealPosition2"></span> --%>
				
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				
			</div>
			<div class="blank10"></div>
			<div style="width:100%;background:#f1f1f1;border:1px solid #ddd;display:none">
				<div style="background:#fff;width:750px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="receiptContentContainer">
					<c:choose >
						<c:when test="${empty receipt.id}">
							<jsp:include page="defaultReceipt.jsp"/>
						</c:when>
						<c:otherwise>
							${receipt.receiptContent}
						</c:otherwise>
					</c:choose>
				</div>
				<span id="modifyContentSealPostion"></span>
			</div>
		</div>
		
	</form:form>
	<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
		<form:form id="clarifyForm" action="${pageContext.request.contextPath}/question/setQrReconnaissance" method="post" modelAttribute="receipt">
			<input type="hidden" id="DocumentID" name="DocumentID" value="${recruitFile.id}-${CURRENT_USER_SESSION_INFO.organId}"/>
			<form:hidden id="receiptContent" path="receiptContent"/>
			<form:hidden id="receiptId" value="${receipt.id}" path="id"/>
			<input type="hidden" value="${recruitFile.id}" name="objectId"/>
			<input type="hidden" name="signatureData" id="signatureData" value=""/>
			<input type='hidden' name="sealName" value="${CURRENT_USER_SESSION_INFO.userName}" />
			<input type='hidden' name="posX" value="300"/>
			<input type='hidden' name="posY" value="-100"/>

			<span style="float:right"> 
				<c:if test="${empty sealSignData}"><a class="button red" id='sign'>发送回执</a></c:if>
				<a class="button red" onclick="window.close()">关闭</a>
			</span>
		</form:form>
	</div>
</body>
</html>