<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%--专家个人详细评审结果确认 --%>

<c:set value="${tenderItemScoreService.listTenderItemPriceScore(processBusinessKey,projectItemId)}" var="resultMap" />
<c:set value="${resultMap.bidFiles}" var="bidFiles" />


<jsp:useBean id="list2" class="java.util.ArrayList"></jsp:useBean>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标人报价确认</title>
<sys:link ca="true" uedit="true" easyui="true"/>
<style type="text/css">
.bold_red {
	font-weight: bold;
	color: red;
}
</style>
<!--ready事件-->
<script type="text/javascript">
	
	function startBidPriceClarify(id){
		$.ajax({
			url:ctx+"/bidFile/startBidFilePriceClarifyWorkFlow",
			type:"post",
			data:{expertApplyId:"${processBusinessKey}",projectItemId:"${projectItemId}", bidFileId:id},
			dataType:"json",
			success:function(data){
				$.messager.alert("系统提示",data.msg);
			}
		});
	}
	$(function() {
		$("#complete").click(function() {
			$.messager.progress({
				title : "系统提示",
				msg : "正在提交数据"
			});
			
			$.ajax({
				url:ctx+"/bidFile/validBidFilePriceClarifyWorkFlow",
				type:"post",
				data:{expertApplyId:"${processBusinessKey}",projectItemId:"${projectItemId}"},
				dataType:"json",
				success:function(data){
					if(data.success){						
						$("#workflowForm").submit();
					}else{			
						$.messager.progress("close");
						if(data.msg){
							$.messager.alert("系统提示",data.msg);
						}else{
							$.messager.alert("系统提示","当前还有投标人的报价澄清未完成");
						}
					}
				
				}
			});
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
			详细评审
		</div>
				<table class="mytableStyle">
				<div class="blank10"></div>
	
					<c:forEach items="${bidFiles}" var="bidFile" varStatus="bidFileStatus">
					
							<c:if test="${bidFileStatus.index==0}">
								<tr>
									<td>招标项目：</td>
									<td>标段名称：</td>
									<td>投标单位：</td>
									<td>投标报价：</td>
									<td>操作：</td>
								</tr>
							</c:if>
							<tr>
								<td>${bidFile.projectInstanceName}</td>
								
								<td>${bidFile.projectItemName}</td>
								<td>${bidFile.organBName}</td>
								<td>${bidFile.tbbjje}(${bidFile.tbbjdw=='2'?'万元':'元'})</td>
								<td><button onclick="startBidPriceClarify('${bidFile.id}');">报价澄清</button></td>
							</tr>
					</c:forEach>
					</table>
			<div class="blank10"></div>
		
	</div>
	
	
	<div class="block">
			
		<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:998;border: #ccc 1px solid;">
			<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
				<input type="hidden" name="taskId" value="${taskId}" /> 
				<a class="button red" id="complete">下一步</a>
			</form>
		</div>
	
			<div id="ht_end"></div>
		</div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
</body>
</html>
