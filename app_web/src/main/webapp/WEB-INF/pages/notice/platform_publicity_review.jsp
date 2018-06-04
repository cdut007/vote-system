<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${candidatePublicityService.getCandidatePublicity(processBusinessKey)}" var="candidatePublicity" scope="request" />
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
    OpenFile("${pageScope.basePath}/attachment/download/${candidatePublicity.pdfAttachment.fjid00}");
    //document.all.HWPostil1.ForceSignType=7;
}
	$(function() {
		//var sealName="${CURRENT_USER_SESSION_INFO.organName}";
		//var sealName="${CURRENT_USER_SESSION_INFO.getOrgan().ztmc00}";
		//var posX = 540;
		//var posY = -180;
		//$("#sign").click(function(){
			//gaiZhang($("#sealName").val());
			//addSeal(sealName);

			//sealUtil.addSealWithBKey("${candidatePublicity.id}",sealName,"data=string2sign","sealPos",posX,posY);
			//$("#SigndataStrSignData").val(signData);
		//});
		//sealUtil.loadAllSealWithBKey("${candidatePublicity.id}","data=string2sign","sealPos");
		
		$("#pass").click(function() {
			/* if(!sealUtil.sealExists(sealName)){
				$.messager.alert('系统提示',"请先盖章！");
				return;
			} */
			$("input[name=pass]").val("true");
			//*****如果印章位置有更新，那么更新印章位置*****************************
			//sealUtil.checkAndUpdateSealPos(sealName,"${candidatePublicity.id}",posX,posY);
			//******************************************
			$("#publicityForm").submit();
		});
		$("#unpass").click(function() {
			if ($.trim($("#shyj").val()) == '') {
				ShowMessageOkCancel("请填写审核意见！");
				return;
			}
			if($("#shyj").val().length > 1000){
				ShowMessageOkCancel("最多输入1000个汉字(包含符合和空格)！");
				return;
			}
			/* if(!sealUtil.sealExists(sealName)){
				$.messager.alert('系统提示',"请先盖章！");
				return;
			} */
			$("input[name=pass]").val("false");
			$("#publicityForm").submit();
		});
		
		var editor = UE.getEditor('gsnr', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		$("#projectInstanceId").change(function() {
			$.ajax({
				type : "post",
				cache : false,
				url : ctx + "/notice/findProjectItemList",
				async : false,
				data : "projectInstanceId=" + $(this).val(),
				dataType : "json",
				success : function(data) {
					var radioHtml = "";
					for (var i = 0; i < data.length; i++) {
						radioHtml += "<input id=\""+data[i].id+"\" type='radio' name='projectItemId' value='"+data[i].id+"'/><label for=\""+data[i].id+"\">" + data[i].bdmc00 + "</label>";
					}
					$("#bdjh").html(radioHtml);
				},
			});
		});
		$(document).on("change", "#bdjh :input", function() {
			var projectInstanceId = $("#projectInstanceId").val();
			var projectInstanceName = $("#projectInstanceId").children("option[value='" + projectInstanceId + "']").html();
			var projectItemName = $(":input[name='" + $(this).attr("name") + "']:checked").next().text();
			$(":input[name='publicityTitle']").val(projectInstanceName + "(" + projectItemName + ")中标候选人公示");
			loadDefaultCandidatePublicity();
		});
		$(".Wdate").focus(function() {
			WdatePicker({
				dateFmt : 'yyyy-MM-dd HH:mm:ss',
				onpicked : loadDefaultCandidatePublicity
			});
		});
		$(":input").filter(function() {
			return !$(this).hasClass("Wdate") && $(this).attr("type") == "text";
		}).blur(function() {
			loadDefaultCandidatePublicity();
		});
		function loadDefaultCandidatePublicity() {
			$.ajax({
				url : ctx + "/candidatePublicity/defaultCandidatePublicity",
				type : "post",
				data : $("#publicityForm").serialize(),
				dataType : "html",
				success : function(data) {
					editor.setContent(data);
				}
			});
		}
	});
	function formSubmit(submitType) {
		//保存草稿
		if (1 == submitType) {
			$("#publicityForm").attr("action", "${pageContext.request.contextPath}/candidatePublicity/saveOrUpdatePublicity");
			//提交审核
		} else if (2 == submitType) {
			$("#publicityForm").attr("action", "${pageContext.request.contextPath}/candidatePublicity/reviewPublicity");
		}
		$("#publicityForm").submit();
	}
	
	/* $(function(){
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
	}); */
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			中标候选人公示审核
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>中标候选人公示审核</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="candidatePublicity">
				<form:hidden path="id" />
				<form:hidden path="projectInstanceId" />
				<%-- <form:hidden path="projectItemId" /> --%>
				<form:hidden path="gskssj" />
				<form:hidden path="gsjssj" />
				<form:hidden path="contacts" />
				<form:hidden path="phone" />
				<form:hidden path="email" />
				<input type="hidden" name="taskId" value="${taskId}" />
				<!-- <input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" />
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" /> -->
				<form:hidden path="gsnr" id="gsnr"/>
				<div class="blank10"></div>
				<table class='mytableStyle'>
					<col style="width:100px" />
					<col />
					<col style="width:100px" />
					<col />
					<tr>
						<th width="120px">招标项目名称</th>
						<td colspan="3">${candidatePublicity.projectInstance}</td>
					</tr>
					<tr>
						<th width="120px">标段</th>
							<td>
								<c:forEach items="${candidatePublicity.projectItemList}" var="item">
									<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
								</c:forEach>
							</td>
						<th>公示类型：</th>
						<td>${util:dictionary('GSLXDM',candidatePublicity.gslx)}</td>
					</tr>
				</table>
				<div class="blank10"></div>
				
				<%-- <div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<span id="gsnrss"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${candidatePublicity.gsnr}</div>
					<span id="sealPos"></span>
				</div> --%>
				<div class="usBox main" style="padding: 3px;height:660px;">
					<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
					<script src="/resources/aip/LoadAip.js"></script>
					<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
				</div>
				
				<div class="blank10"></div>
				<table style="table-layout:fixed;width:100%">
					<tr>
						<th style="width:100px;">推送公共服务平台:</th>
						<td>
							<div><label for="connectPublicService-true">是</label><input type="radio" id="connectPublicService-true" name="connectPublicService" value="true" checked="checked"/></div>
							<div><label for="connectPublicService-false">否</label><input type="radio" id="connectPublicService-false" name="connectPublicService" value="false"/></div>
						</td>
					</tr>
					<tr>
						<td style="width:100px;">审核意见:</td>
						<td>
							<form:textarea path="shyj" cssStyle="width:99%;height:120px;" class="inputxt easyui-validatebox" data-options="validType:'length[0,1000]'"/>
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