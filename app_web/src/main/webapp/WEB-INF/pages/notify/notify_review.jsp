<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%-- 
Describe:电子签章
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true" />
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
        HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
	</SCRIPT>
<script type="text/javascript">

function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${notify.pdfAttachmentId}");
    //document.all.HWPostil1.ForceSignType=7;
}
	var sealNum = 0;
	$(function() {
		$("#sign").click(function(){
			if(AddSeal(0)=="-200"){
	            ShowMessage("请插入有效的USBKey！");
			}
		});

		
		$("#pass").click(function() {//alert("pass");
            if (sealNum<=0) {
                alert("请先盖章！");
                sealNum=0;
                return false;
            }
            var r = ShowMessageOkCancel("确认提交吗?");
			if(r==1){
                var paramsArray = {"DocumentID":"${notify.id}","id":"${notify.id}","projectInstance.zbxmbh":"${projectInstance.zbxmbh}","pass":"true","winOrNot":"win"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/bidNotify/sign");
                if ("OK" == returnValue) {
                    ShowMessage("提交成功！");
                    window.location.href="/bidNotify/layout";
                } else {
                	ShowMessage("提交失败！");
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
			招标/中标通知签章
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标/中标通知签章</h4>
			<form:form id="noticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/bidNotify/sign' modelAttribute="notify"><%--workflow/completeForm --%>
				<input type='hidden' name="DocumentID" value="${notify.id}">
				<input type='hidden' name="id" value="${notify.id}">
				<%--<input type='hidden' name="taskId" value="${taskId}">
				<form:hidden path="attachmentSsztId" id="attachmentSsztId"/> --%>
				<input type='hidden' name="projectInstance.zbxmbh" value="${projectInstance.zbxmbh}">
				<input type="hidden" id='signData' name="signData" />
				<%-- <input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" value="${signatureData.sealName}"/>
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" value="${signatureData.signatureData}"/> --%>
				<form:hidden path="content" id="content" />
				<table width="100%" class="mytableStyle" style="table-layout:fixed;">
					<tr>
						<th>招标项目名称：</th>
						<td colspan="3">${notify.projectName}</td>
					</tr>
					<tr>
						<th>标段（包）编号集合：</th>
						<td colspan="3">${notify.projectItemName}</td>
					</tr>
					<tr>
						<th>中标机构：</th>
						<td colspan="3">${notify.organName}</td>
					</tr>						
					<tr>
						<th>通知标题：</th>
						<td colspan="3">${notify.title}</td>
					</tr>
					<tr>
						<th style="vertical-align:middle">公告内容:</th>
						<td colspan='3'>
							<%-- <span id="ggnr"></span>
							<div id="noticeContent" style="border:1px solid #ddd;padding:50px;">${notify.content}</div>
							<span id="sealPos"></span> --%>
							
							<div class="usBox main" style="padding: 3px;height:660px;" id="">
								<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
								<script src="/resources/aip/LoadAip.js"></script>
								<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
							</div>
						</td>

					</tr>
					<%--<tr>
						<th style="vertical-align:middle">审核意见:</th>
						<td colspan='3'><textarea id="shyj" name="shyj" style="width:99%;height:120px;"></textarea></td>
					</tr> --%>
				</table>
				<div class="blank10"></div>
				<input type="hidden" name="signSha256"/>
				<input type="hidden" name="pass" value="true" />
				<input type="button" class="button red" value="电子印章" id="sign"/>
				<!-- <input type="button" class="button red" value="通过" id="pass" />
				<input type="button" class="button red" value="不通过" id="unpass" /> -->
				<input type="button" class="button red" value="提交" id="pass" />
				<input type="button" class="button red" value="返回" onclick="javascript:window.location.href='${pageContext.request.contextPath}/bidNotify/layout'" /><!-- history.go(-1) -->
			</form:form>
		</div>
	</div>
</body>
</html>