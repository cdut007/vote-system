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
<sys:link ca="true" easyui="true" uedit="true" />
<script type="text/javascript">
	$(function() {
        //验证电子印章
        sealUtil.loadAllSealWithBKey("${evaluationClarify.id}","data=string2sign","sealPos");

        $("#sub").click(function() {
			$("#clarifyForm").submit();
		});
		
		$("#attachment").datagrid({
			title:"附件列表",
			rownumbers:true,
			striped:true,
			url:ctx+"/attachment/listAttachment",
			idField:"fjid00",
			queryParams:{"fjsszt":$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val()},
			height:150,
			columns:[[
			  {title:"附件名称",field:"fjmc00",width:200},
			  {title:"上传时间",field:"uploadTime",width:100},
			  {title:"附件大小",field:"length",width:100,align:"right",formatter:function(value){
				  return castSize(value);
			  }},
			  {title:"附件类型",field:"fjgslx",width:100},
			  {title:"操作",field:"opt",width:100,align:'center',formatter:function(value,rowData,index){
				  return "<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>";
			  }}
			]]
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
			澄清结果确认
		</div>
	</div>
	<form id="clarifyForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
		<input type="hidden" id="attachmentSsztId" value="${processBusinessKey}"/>
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
					<td colspan="3">${tenderItem.organBName}</td>
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
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${evaluationClarify.answer}</div>
					<span id="sealPos"></span>
				</div>
			</div>
			<div class="blank10"></div>
			<div>
				<table id="attachment"></table>
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
			<input type="hidden" value="${token}" name="token" /> 
			<input type="hidden" value="${taskId}" name="taskId" /> 
			<span style="float:right"> 
				<a class="button red" id='sub'>确认</a>
			</span>
		</div>
	</form>
</body>
</html>