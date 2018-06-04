<%@page pageEncoding="utf-8" import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" scope="request"/>
<%-- <c:set value="select projectItem,bidOpenRecord from TBProjectItem projectItem,TBBidOpenRecord bidOpenRecord,TBExpertApply expertApply where expertApply.id='${processBusinessKey}' and projectItem.id in (split(expertApply.projectItemId,',')) and projectItem.id=bidOpenRecord.projectItemId and bidOpenRecord.expertApplyId=expertApply.id and projectItem.id='${projectItemId}' order by bidOpenRecord.openStatus desc,projectItem.bdbh00" var="hql"/> --%>
<%-- <c:set value="${baseService.retrieveByHQL(hql)}" var="projectItemWithBidOpenRecordList" scope="request"/>
 --%><c:set value="${expertApply.projectInstance}" var="projectInstance" scope="request"/>
<%-- <c:set value="${projectItemService.createProjectItemQuery().expertApplyId(processBusinessKey).projectItemId(projectItemId).list()}" var="projectItemList" scope="request"/>
 --%><c:set value="${expertSealSignService.getListByExpertApplyAndProjectItemIdId(processBusinessKey)}" var="evaluationReportSign" scope="request"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>编辑评标报告</title>
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
		$("#scoreDetail").click(function() {
			if ($("#scoreDetail").val() == "显示评分汇总表") {
				$("#scoreDetail").val("隐藏评分汇总表");
			} else {
				$("#scoreDetail").val("显示评分汇总表");
			}
			$("#scoreDetail_divToggle").toggle();
		});
		$("#chatDetail").click(function() {
			if ($("#chatDetail").val() == "显示询标澄清表") {
				$("#chatDetail").val("隐藏询标澄清表");
			} else {
				$("#chatDetail").val("显示询标澄清表");
			}
			$("#chatDetail_divToggle").toggle();
		});
		var ue1 = UE.getEditor('evaluationReportContent', {
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
			编辑评标报告
		</div>
	</div>
	<form action="${pageContext.request.contextPath}/evaluation/completeFormEvaluationReport" onsubmit="return confirm('确定提交吗？');" method="post">
		<div class="block">
			<textarea id="evaluationReportContent" name="evaluationReportContent" style="width:100%;height:400px;overflow-y:visible">
				<jsp:include page="defaultEvaluationReport.jsp" />
			</textarea>
		<c:if test="${not empty evaluationReportSign}">
			<table width="100%" class="mytableStyle" style="table-layout:fixed;">
							<tr>
								<th style="vertical-align:middle">不通过意见:</th>
								<td colspan='3'>
								<c:forEach items="${evaluationReportSign}" var="evaluationReport" >
										${evaluationReport.disagreeReason}<br/>
								</c:forEach> 
								</td>
							</tr>
			</table>
		</c:if>
		</div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10">
		</div>
		
		<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;position:fixed;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
			<input type="hidden" name="taskId" value="${taskId}" />
			<input type="hidden" name="projectItemId" value="${projectItemId}"/>
			<input type="hidden" name="expertApplyId" value="${processBusinessKey}" />
			<span style="float:left"> 
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/bidOpenStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">开标记录表</a> 
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryStatisticsPass?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">初步评审表</a> 
				<%--<a class="button red" href="${pageContext.request.contextPath}/evaluation/priceScoreStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">报价打分表</a> --%>
				<c:choose>
					<c:when test="${projectInstance.prereviewType=='1'||projectInstance.prereviewType=='3'}" >
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/evaluationDetailScoreStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">招标评分表</a>  
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/tenderItemSortStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">投标人排序表</a>
					</c:when>
					<c:otherwise>
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryStatistics1?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">详细评审表</a>
					</c:otherwise>
				</c:choose>
			</span> 
			<span style="float:right"> 
				<!-- 
					<input type='button' class="button red" id='chatDetail' value="显示询标澄清表" /> 
					<input type='button' class="button red" id='scoreDetail' value="显示评分汇总表" /> 
				--> 
				<!-- 
					<input type='button' class="button red" value="保存" /> 
				--> 
				<input type='submit' class="button red" id='sub' value="提交" />
			</span>
		</div>
	</form>
</body>
</html>
