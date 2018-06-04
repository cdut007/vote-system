<%@page pageEncoding="utf-8" import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${recruitFileService.findRecruitFile(projectItemId)}" var="recruitFile"></c:set>
<c:set value="${recruitFile.evaluationMethodInstance.evaluationMethod.uniqueMethodId}" var="uniqueMethodId" scope="request"></c:set>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>交通技术评分人数抽取</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.contentBox {
	position: fixed;
	bottom: 67px;
	height: 500px;
	left: 10%;
	width: 70%;
	min-width: 800px;
	z-index: 1000;
	opacity: 1;
	border-radius: 5px;
	background-color: #fafafa;
}
p {
	text-indent: 2em
}
</style>
<script type="text/javascript">

function submitJtTenderNumber(){
	$.messager.progress({
		title : "系统提示",
		msg : "正在提交数据"
	});
	
	var jtTechMethodTenderNum = $("#jtTechMethodTenderNum").val();
	if(jtTechMethodTenderNum=="" || jtTechMethodTenderNum==null){
		$.messager.progress("close");
		$.messager.alert("系统提示","请输入抽取人数");
		
	}else if(jtTechMethodTenderNum<3 || jtTechMethodTenderNum>5){
		$.messager.progress("close");
		$.messager.alert("系统提示","抽取人数范围为3-5");
	}else{
		$.ajax({
			url:ctx+"/recruitFileData/saveBidderNumOfJTTech",
			type:"post",
			data:{id:"${recruitFile.id}",jtTechMethodTenderNum:$("#jtTechMethodTenderNum").val()},
			dataType:"json",
			success:function(data){
				if(data.success){						
					$("#workflowForm").submit();
				}else{			
					$.messager.progress("close");
					if(data.msg){
						$.messager.alert("系统提示",data.msg);
					}
				}
			
			}
		});
	}
}
	$(function() {
		
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
			交通技术评分人数抽取
		</div>
	</div>
		<div class="block">
			<table class="mytableStyle">
				<tr>		
					<td>招标项目名称：</td>
					<td>${recruitFile.projectInstanceName}</td>
					<td>标段名称：</td>
					<td>${recruitFile.projectItemName}</td>
				</tr>
				<tr>		
					<td>抽取人数：</td>
					<td colspan="3">
					<input type="number" name="jtTechMethodTenderNum" id="jtTechMethodTenderNum" value="${recruitFile.jtTechMethodTenderNum}"></input>
					
					</td>
				
				</tr>
						
			</table>
			<div class="blank10"></div>
			<div class="blank10"></div>
	
		</div>
		<div class="block">
				<button class="button red" onclick="submitJtTenderNumber();">抽取</button>
			</div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<form action="${pageContext.request.contextPath}/workflow/completeForm" id="workflowForm">
				<input type="hidden" name="taskId" value="${taskId}" /> 
				<input type="hidden" name="message" value="${message}" />
		</form>
</body>
</html>
