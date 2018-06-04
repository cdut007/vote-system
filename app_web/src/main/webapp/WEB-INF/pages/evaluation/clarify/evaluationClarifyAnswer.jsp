<%@page pageEncoding="utf-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<c:set value="${evaluationClarifyService.createEvaluationClarifyQuery().evaluationClarifyId(processBusinessKey).singleResult()}" var="evaluationClarify" />
<c:set value="${tenderItemService.createTenderItemQuery().tenderItemId(evaluationClarify.tenderItemId).singleResult()}" var="tenderItem" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" easyui="true" uedit="true" plupload="true"/>
<script type="text/javascript">
	$(function() {
		var ue = UE.getEditor('modifyContent', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold',
					'italic', 'underline', '|', 'forecolor', 'backcolor',
					'selectall', 'cleardoc', '|', 'customstyle', 'paragraph',
					'fontfamily', 'fontsize', '|', 'justifyleft',
					'justifycenter', 'justifyright', 'justifyjustify', '|',
					'inserttable', 'deletetable', 'insertparagraphbeforetable',
					'insertrow', 'deleterow', 'insertcol', 'deletecol',
					'mergecells', 'mergeright', 'mergedown', 'splittocells',
					'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		//ue.addListener("contentChange",function(){
		//	sealUtil.removeSeal(sealName);
		//});
		$("#sub").click(function() {
                var sealName="${CURRENT_USER_SESSION_INFO.organName}";
                if(!sealUtil.sealExists(sealName)){
                    sealUtil.addSealWithBKey("${evaluationClarify.id}",sealName,"data=string2sign","sealPos",600,-200);
                    if(sealUtil.sealExists(sealName)) {
                        $.messager.alert("系统提示","签章成功", "info", function() {
                            $("#clarifyForm").submit();
                        });
                    }else{
                        $.messager.alert("系统提示","签章失败！");
                    }
                }else if(sealUtil.sealExists(sealName)){
                    $("#clarifyForm").submit();
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
			澄清回复
		</div>
	</div>
	<form id="clarifyForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
		 <input type='hidden' name="taskId" value="${taskId}" /> 
		 <%--<form:hidden path="attachmentSsztId" id="attachmentSsztId"/> --%>
		 <input type="hidden" id="attachmentSsztId" value="${processBusinessKey}" />
		 
		<div class="block">
			<table class="mytableStyle">
				<tr>
					<th>项目名称</th>
					<td>${tenderItem.projectInstanceName}</td>
					<th>标段名称</th>
					<td>${tenderItem.projectItemName}</td>
				</tr>
				<tr>
					<th>投标单位</th>
					<td colspan="3" id="organBname">${tenderItem.organBName}</td>
				</tr>
				<%--<tr>
					<td><a id="addAttachment" class="button red">添加附件</a><i>可以上传.pdf .doc .docx</i></td>
					<td><table id="attachmentUpload"></table></td>
				</tr> --%>
				<tr>
					<td colspan="2">
					
					</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'澄清需求'" style="overflow: hidden">
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${evaluationClarify.question}</div>
				</div>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'澄清内容'" style="overflow: hidden">
				<textarea id="modifyContent" name="answer" class="easyui-validatebox" style="height:400px;" data-options="required:true"></textarea>
				<span id="sealPos"></span>
			</div>
			<div class="blank10"></div>
			<div>
				<a id="addAttachment" class="button red">添加附件</a><i>可以上传.pdf .doc .docx</i>
				<table id="attachmentUpload"></table>
			</div>
		</div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;position:fixed;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
			<%-- <input type="hidden" value="${token}" name="token" /> 
			<input type="hidden" value="${taskId}" name="taskId" /> 
			<input type="hidden" id="signatureData" name="signatureData"/> 
			<input type="hidden" id="sealName" name="sealName" value="${tenderItem.organBName}"/>  --%>
			<span style="float:right">
				<!-- <a class="button red" id='gz'>电子盖章</a> -->
				<a class="button red" id='sub'>签章并提交</a>
			</span>
		</div>
	</form>
	<script src="/resources/page/tender/evaluationClarifyForm.js" type="text/javascript"></script> 
	<%--<script src="/resources/page/notice/notice_form.js" type="text/javascript"></script>--%>
</body>
</html>