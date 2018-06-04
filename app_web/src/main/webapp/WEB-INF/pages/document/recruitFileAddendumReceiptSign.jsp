<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<jsp:include page="/common/link.jsp" />
<script>
function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${recruitFileAddendumReceipt.pdfAttachment.fjid00}");
    //document.all.HWPostil1.ForceSignType=7;
}
		var sealNum=0;
		$(function() {

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
				var r = ShowMessageOkCancel("确认提交吗?");
				if(r==1){
	                /* var m = new Map();
	                m.set("taskId","${taskId}");
	                m.set("id","${recruitFileAddendumReceipt.id}");
	                var returnValue = SaveDoc(m,"${pageScope.basePath}/recruitFile/updateRecruitFileAddendumReceiptStatus"); */
	                
	                var paramsArray = {"taskId":"${taskId}", "id":"${recruitFileAddendumReceipt.id}"};
	                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/recruitFile/updateRecruitFileAddendumReceiptStatus");
	                if ("OK" == returnValue) {
	                    ShowMessage("文件上传成功");
	                    window.location.href="/home";
	                } else {
	                	if("workflow/taskNotFound"==returnValue){
	                    	ShowMessage("任务不存在或已被处理");
	                		window.location.href="/home";
	                	}else{
	                		ShowMessage("文件上传失败");
	                	}
	                }
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
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标文件补遗回执确认
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标文件补遗回执确认</h4>
			<form:form id="" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="">
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
						<td colspan="2" style="padding:10px 0 18px 0;">
							<input type="hidden" name="pass" value="true" />
							<input type="button" class="button red" value="电子印章" id="sign" />
							<input type="button" class="button red" value="发送回执" id="pass" /> 
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>