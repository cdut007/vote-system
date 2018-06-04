<%@page pageEncoding="utf-8" import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${recruitFileService.checkDetailMsgOfTender(processBusinessKey)}" var="tenderItem" scope="request"/>
<c:set value="${tenderItem.projectItem}" var="projectItem" scope="request" />
<c:set value="${tenderItem.projectInstance}" var="projectInstance" scope="request" />
<c:set value="${recruitFileService.loadRecruitFileForInvitation(processBusinessKey)}" var="recruitFile" scope="request" />
<c:set value="${recruitFileService.passQualificationOrNot(processBusinessKey)}" var="booooo" scope="request" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>编辑投标邀请书/预审结果通知书</title>
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
	$(function() {
		
		var ue1 = UE.getEditor('invitationContent', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		
	});
</script>
<style type="text/css">
.chatMsg {
	line-height: 20px;
	display: inline-block;
	word-wrap: break-word;
	word-break: break-all;
	text-align: left;
}
.chatMsgBox {
	width: 96%;
	font-family: Tahoma, Verdana, '微软雅黑';
	background-color: #fff;
	border: 1px solid #ccc;
	opacity: 1;
	border-radius: 5px;
	padding: 5px;
}

#displayContent {
	width: 100%;
	height: 450px;
	overflow-y: auto;
	overflow-x: hidden;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			编辑投标邀请书/预审结果通知书
		</div>
	</div>
	<form action="${pageContext.request.contextPath}/qualificationInvitation/sendQualificationInvitation" onsubmit="return confirm('确定提交吗？');" method="post">
		<div class="block">
			<textarea id="invitationContent" name="invitationContent" style="width:100%;height:400px;overflow-y:visible">
				
				<c:if test="${booooo }">
					<jsp:include page="defaultTenderInvitation.jsp" />
				</c:if>
				<c:if test="${!booooo }">
					<jsp:include page="defaultTenderResultNotice.jsp" />
				</c:if>
				
			</textarea>
			
			<div class="blank10"></div>
			<div class="blank10"></div>
			<input type="hidden" name="tenderItemId" value="${tenderItem.id}"/>
			<input type="hidden" name="projectItemId" value="${tenderItem.projectItemId}"/>
			<input type="hidden" name="organBId" value="${tenderItem.organId}"/>
			<input type="hidden" name="taskId" value="${taskId}" />
			<span style="float:right" ><input type='submit' class="button red" id='sub' value="提交" /></span>
		</div>
		
		<%-- <div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;/* position:fixed; */bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
			<input type="hidden" name="taskId" value="${taskId}" />
			<input type="hidden" name="projectItemId" value="${projectItemId}"/>
			<input type="hidden" name="expertApplyId" value="${processBusinessKey}" />
			<span style="float:right"> 
				<input type='submit' class="button red" id='sub' value="提交" />
			</span>
		</div> --%>
	</form>
</body>
</html>
