<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<c:set value="${preQualificationNoticeService.loadNoticeData(processBusinessKey)}" var="notice" scope="request" />
<%-- <c:set value="${noticeService.getSignatureDataById(processBusinessKey)}" var="signatureData" scope="request" /> --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>
<jsp:include page="/common/link.jsp" />
<script>
	$(function() {
		var posX = 180;
		var posY = -180;
		var sealName="${CURRENT_USER_SESSION_INFO.organName}";
		$("#sign").click(function(){
			//gaiZhang($("#sealName").val());
			//addSeal(sealName);
			var sealCount=sealUtil.sealCount();
			if(sealCount == 1){
				posX = 360;
			}else if(sealCount==2){
				posX = 540;
			}
			sealUtil.addSealWithBKey("${notice.id}",sealName,"data=string2sign","sealPos",posX,posY);
			//$("#SigndataStrSignData").val(signData);
		});
		sealUtil.loadAllSealWithBKey("${notice.id}","data=string2sign","sealPos");
		
		$("#pass").click(function() {
			/* if(!sealUtil.sealExists(sealName)){
				$.messager.alert('系统提示',"请先盖章！");
				return;
			} */
			$("input[name=pass]").val("true");
			//*****如果印章位置有更新，那么更新印章位置*****************************
			sealUtil.checkAndUpdateSealPos(sealName,"${notice.id}",posX,posY);
			//******************************************
			$("#publicityForm").submit();
		});
		$("#unpass").click(function() {
			if ($.trim($("#shyj").val()) == '') {
				$.messager.alert("提示信息", "请填写审核意见！");
				return;
			}
			/* if(!sealUtil.sealExists(sealName)){
				$.messager.alert('系统提示',"请先盖章！");
				return;
			} */
			$("input[name=pass]").val("false");
			$("#publicityForm").submit();
		});
	
	
	});
	
	/*$(function(){
		var SigndataStrSignData = '${signatureData.signatureData}';
		var sealName='${signatureData.sealName}';
		if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
			document.all.DWebSignSeal.ShowSeal(sealName, 1);
		} else {
			document.all.DWebSignSeal.SetStoreData(SigndataStrSignData); 
			document.all.DWebSignSeal.ShowWebSeals();
			document.all.DWebSignSeal.SetMenuItem(sealName,12);
			document.all.DWebSignSeal.LockSealPosition(sealName);
		}
	});*/
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			资格预审结果公告审核
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>资格预审结果公告审核</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="notice">
			<%-- 	<form:hidden path="id" />
				<form:hidden path="projectInstanceId" />
				<form:hidden path="publishDate" />
				<form:hidden path="deadline" />
				<form:hidden path="contacts" />
				<form:hidden path="phone" />
				<form:hidden path="email" />
				<form:hidden path="noticeContent" id="noticeContent"/> --%>
				
				<input type="hidden" name="DocumentID" value="${notice.id}" />
				<input type="hidden" name="taskId" value="${taskId}" />
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" />
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" />
				<div class="blank10"></div>
				<table class='mytableStyle'>
					<col style="width:100px" />
					<col />
					<col style="width:100px" />
					<col />
					<tr>
						<td width="120px">招标项目名称</td>
						<td>${notice.projectInstance}</td>
					</tr>
					<tr>
						<td width="120px">标段</td>
					
						<td>${notice.projectItemNames}</td>
					
					</tr>
				</table>
				<div class="blank10"></div>
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<span id="noticeCont"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${notice.noticeContent}</div>
					<span id="sealPos"></span>
				</div>
				<div class="blank10"></div>
				<table style="table-layout:fixed;width:100%">
					<tr>
						<td style="width:100px;">审核意见:</td>
						<td>
							<%-- <form:textarea path="reviewComment" cssStyle="width:99%;height:120px;" /> --%>
							<textarea id="shyj" name="shyj" style="width:99%;height:120px;" class="inputxt easyui-validatebox" data-options="validType:'length[0,1000]'"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding:10px 0 18px 0;">
							<input type="hidden" name="pass" value="true" /> 
							<!-- <input type="button" class="button red" value="电子印章" id="sign" /> -->
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