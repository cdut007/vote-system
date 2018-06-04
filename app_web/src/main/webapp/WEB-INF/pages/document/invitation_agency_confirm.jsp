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
<sys:link ca="true" easyui="true" jgrowl="true" datepicker="true"/>
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
<c:set value="${invitationFileService.loadInvitationFileTender(processBusinessKey)}" var="invitationTenderFile" scope="request"></c:set>
<script type="text/javascript">
    $(function() {
        //验证电子印章
        sealUtil.loadAllSealWithBKey("${invitationTenderFile.invitationId}"+":"+"${invitationTenderFile.organId}","data=string2sign","sealPos1");
    });
</script>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">项目管理</a>
			<code>&gt;</code>
			投标邀请确认
		</div>
	</div>
	<div class="block">
		<form id="invitation_Form" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
			
			<div class="blank10"></div>
			<input type="hidden" name="token" value="${token}" />
			<input type="hidden" name="pass" id="pass" value="true" />
			<input type="hidden" name="taskId" value="${taskId}"></input>
			<input type="hidden" name="sign_id" id="sign_id" value=""></input>
			<div class="easyui-panel" data-options="title:'投标邀请回执确认',collapsible:true">
				<table style="width:98%;table-layout:fixed;margin:0 auto;">
					<tbody>
					
				<table>
							<tr>
									<td class="need"></td>
									<td>投标邀请回执内容</td>
									<td>
										<div id="invitationContentShow" style="padding:50px;border:1px solid #ddd">${invitationTenderFile.receiptContent}</div>
										<div id="sealPos1"></div>
									</td>
								</tr>
				</table>
				
					</tbody>
				</table>
			</div>
		
					<div class="blank10"></div>
					<input id='complete' type="button" class="button red" value="确定" />
					<a class="button orange" onclick="history.go(-1)">返回</a>
		</form>
	</div>
	<script>
	
	$("#complete").click(function(){
		$.messager.alert("系统提示","确认邀请","info",function(){
	
			$("#invitation_Form").submit();
			
		});
	});
	
	</script>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>