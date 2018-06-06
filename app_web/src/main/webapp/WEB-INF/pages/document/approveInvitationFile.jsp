<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标邀请文件信息</title>
<sys:link easyui="true" jgrowl="true" datepicker="true"/>
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
</style>

<script>


</script>

</head>
<c:set value="${invitationFileService.loadInvitationFile(processBusinessKey)}" var="invitationFile" scope="request"></c:set>
<c:set value="${invitationFileService.pagingInvitationFileTenderData(processBusinessKey)}" var="tenderlist" scope="request"></c:set>

<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">项目管理</a>
			<code>&gt;</code>
			投标邀请审核
		</div>
	</div>
	<div class="block">
		<form id="invitation_Form" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
			
			<div class="blank10"></div>
			<input type="hidden" name="token" value="${token}" />
			<input type="hidden" name="pass" id="pass" value="true" />
			<input type="hidden" name="taskId" value="${taskId}"></input>
			<div class="easyui-panel" data-options="title:'项目概况',collapsible:true">
				<table style="width:98%;table-layout:fixed;margin:0 auto;">
					<tbody>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标编号</td>
							<td>${invitationFile.projectInstance.zbxmbh}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标项目名称</td>
							<td>${invitationFile.projectInstance.zbxmmc}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标人</td>
							<td>${invitationFile.projectInstance.project.organ.ztmc00}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">审核意见</td>
							<td>
								<textarea style=" width:350px;height:40px;" name="nopassReason"  id="nopassReason">${invitationFile.nopassReason}</textarea>
							</td>
						</tr>
					
							
				
					</tbody>
				</table>
			</div>
			
		   <div id="tender_tabs" class="easyui-tabs" data-options="fit:true,border:false" style="height:550px;">
					<c:forEach items="${tenderlist}" var="tender">
					<div data-options="title:'${tender.ztmc00}'">
						<div style="padding:50px;border:1px solid #ddd">${invitationFile.invitationContent.replace("XXXXXXXXXX", tender.ztmc00)}</div>
					</div>
				</c:forEach>
			</div>
		  
		
		
			<div class="blank10"></div>
					<input id='reject' type="button" class="button red" value="拒绝" />
					<input id='complete' type="button" class="button red" value="同意" />
					<a class="button orange" onclick="history.go(-1)">返回</a>
		</form>
	</div>
	<script>
	
		$("#complete").click(function(){	
			
			$("#invitation_Form").submit();
			
		});
		
		$("#reject").click(function(){	
			
			if ($.trim($("#nopassReason").val()) == '') {
				$.messager.alert("提示信息", "请填写审核意见！");
				return;
			}
			
			
			$("#pass").val("false");
			$("#invitation_Form").submit();
			
		});
	
	</script>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>