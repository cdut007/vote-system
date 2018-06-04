<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" ca="true" jgrowl="true" plupload="true"/>
<script type='text/javascript' src='/resources/jquery-plugins/jquery.im.js'></script>
<script src="/resources/designer/json2.js" type="text/javascript"></script>
<c:set value="${bidFileService.loadBidFile(bidFileId)}" var="bidFile" />

	
<script type="text/javascript">



</script>

<style type="text/css">
.centerss {
 width: 1000px;
 margin: auto;
 text-align: center;
 line-height:40px;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
			<div class="blank10"></div>
			<table class="mytableStyle">
				<tr>
		
					<td>招标项目名称：</td>
					<td>${bidFile.projectInstanceName}</td>
					<td>标段名称：</td>
					<td>${bidFile.projectItemName}</td>
				</tr>
				<tr>
					<td>投标单位：</td>
					<td>${bidFile.organBName}</td>
					<td>投标报价：</td>
					<td>
						${bidFile.tbbjje}${bidFile.tbbjdw=='1'?'元':'万元'}
					</td>
		
				</tr>
			
				<tr>
					<td colspan='4'>
						<table id="attachmentUpload"></table>
					</td>
				</tr>
				
				
				<tr>
					<td>审核结果：</td>
					<td colspan='3' style="color:red; font-size:18px;">
						<c:if test="${bidFile.clarifyResult=='0'}">不同意澄清，此投标人不再参与后续评审</c:if>
						<c:if test="${bidFile.clarifyResult=='1'}">同意澄清，此投标人参与后续评审</c:if>
					</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="blank10"></div>
			<div class="block">
				<button class="button red" id="sign" >签字</button>
				<button class="button red" id="complete" >确认</button>
			</div>
			
			<form action="${pageContext.request.contextPath}/bidFile/updatePriceClarifyResult" id="form1">
					<input type="hidden" id="id" name="id" value="${bidFile.id}"></input>
					<input type="hidden" id="clarifyResult" name="clarifyResult" value="${bidFile.clarifyResult}"></input>
			</form>
			
	
			<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form2">
					<input type="hidden" name="taskId" value="${taskId}" /> 
					<input type="hidden" name="message" value="${message}" />
					<input type="hidden" id="attachmentSsztId" value="${bidFile.id}"></input>
					<input type="hidden" id="clarifyResult2" name="clarifyResult" value="${bidFile.clarifyResult}"></input>
					
			</form>
	</div>
		<div class="blank10"></div>
			<div class="blank10"></div>
				<div class="blank10"></div>
					<div class="blank10"></div>
						<div class="blank10"></div>
							<div class="blank10"></div>
								<div class="blank10"></div>
									<div class="blank10"></div>
	<div id="ht_end"></div>
	
	</div>
	<jsp:include page="/common/bottom.jsp"/>
	
<script type="text/javascript">

	$(function() {
		//SetValue_onclick();
		var sealName = "${CURRENT_USER_SESSION_INFO.userName}"; // 对申请表的签章
		var posX = 580;
		var posY = -250;

		if(!sealUtil.use_fake_seal){
			sealUtil.loadAllSealWithBKey("${processBusinessKey}:${bidFileId}_price_clarifi_sign}","data=string2sign","ht_end");
		}
		$("#complete").click(function() {
			if (!sealUtil.use_fake_seal && !sealUtil.sealExists(sealName)) {
				$.messager.alert("系统提示", "提交申请表之前请先加盖电子印章！", "warning");
				return;
			}
			$.messager.confirm("系统提示", "确认提交吗", function(ok) {
				if (ok) {
					if(!sealUtil.use_fake_seal){
						//*****如果印章位置有更新，那么更新印章位置*****************************
						sealUtil.checkAndUpdateSealPos(sealName,"${processBusinessKey}:${bidFileId}_price_clarifi_sign}",posX,posY);
						//******************************************
					}
					$("#form2").submit();
				}
			});
		});
		$("#sign").click(function() {
			if(!sealUtil.use_fake_seal){
				sealUtil.addSealWithBKey("${processBusinessKey}:${bidFileId}_price_clarifi_sign}",sealName,"data=string2sign","ht_end",posX,posY);
			}
		});
	});
</script>
<script>

$(function() {

	$("#attachmentUpload").datagrid({
		title:"附件列表",
		rownumbers:true,
		striped:true,
		collapsible:true,
		url:ctx+"/attachment/listAttachment",
		idField:"fjid00",
		queryParams:{"fjsszt":$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val()},
		height:200,
		columns:[[
		  {title:"附件名称",field:"fjmc00",width:300},
		  {title:"上传时间",field:"uploadTime",width:120},
		  {title:"附件大小",field:"length",width:80,align:"right",formatter:function(value){
			  return castSize(value);
		  }},
		  {title:"附件类型",field:"fjgslx",width:120},
		  {title:"操作",field:"opt",width:120,align:'center',formatter:function(value,rowData,rowIndex){
			  return "<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>";
		  }}
		]]
	});

});
</script>
</body>
</html>
