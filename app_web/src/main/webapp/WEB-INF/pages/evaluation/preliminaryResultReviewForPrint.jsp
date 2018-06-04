<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page pageEncoding="utf-8" import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set value="${qualificationResultDetailService.listReviewQualificationResultDetailList(expertApplyId,projectItemId,reviewType,envelopeTypeOrder)}" var="result" />
<c:set value="${result.tenderItems}" var="tenderItems" />
<c:set value="${result.reviews}" var="reviews" />
<c:set value="${result.experts}" var="experts" />
<c:set value="${result.detailMap}" var="detailMap" />
<c:set value="${result.finalMap}" var="finalMap" />
<c:set value="${result.organMap}" var="organMap" />
<c:set value="${result.recruitFile}" var="recruitFile" />

<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(expertApplyId).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${projectItemService.createProjectItemQuery().expertApplyId(expertApplyId).list()}" var="projectItemList" />
<jsp:useBean id="list" class="java.util.ArrayList"></jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${recruitFile.isPrejudication == true ? '资格预审':(reviewType=='1'?'详细评审':'初步评审')}合议结果确认签名</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.bold_red {
	font-weight: bold;
	color: red;
}
</style>
<script type="text/javascript">
	
	$(function() {
		$(function() {
			$("#complete").click(function() {
				$("#printArea").printArea({
					extraCss : '/resources/css/tablestyle_print.css'
				});
			});
		});

	});
</script>
<script type="text/javascript" src="/resources/portal/jquery.PrintArea.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}合议结果确认签名
		</div>
		<div class="usBox" id="printArea">
			<div style="text-align: center;">
				<font style="font-size: 14pt; font-weight: bold;">${projectInstance}${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}结果合议</font>
			</div>
			<div class="blank10"></div>
			<form id="reviewResultForm" action="${pageContext.request.contextPath}/evaluation/saveQualificationResult">
				<input type="hidden" name="expertApplyId" value="${processBusinessKey}" />
				<input type="hidden" name="reviewType" value="${reviewType}" />
				<table class="mytableStyle">
					<thead>
						<tr>
							<th style="width:120px;">投标单位</th>
							<th style="width:120px;">评审类型</th>
							<th>评审因素</th>
							<th>评审标准</th>
							<th style="width:80px;">专家</th>
							<th style="width:60px">评审结果</th>
							<th style="width:100px;">评审意见</th>
							<th style="width:80px">单项合议结果</th>
							<th style="width:80px">单项合议意见</th>
							<th style="width:80px">最终合议结果</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tenderItems}" var="tenderItem" varStatus="tenderItemStatus">
								<c:set value="${organMap[tenderItem.id]}" var="qualificationOrganResult" />
								<c:forEach items="${reviews}" var="qualificationView" varStatus="qualificationViewStatus">
									<c:forEach items="${experts}" var="expert" varStatus="expertStatus">
										
											<c:set value="${tenderItem.id}${qualificationView.id}${expert.id}" var="detail_result_id" />
											<c:set value="${tenderItem.id}${qualificationView.id}" var="final_result_id" />
											<c:set value="${detailMap[detail_result_id]}" var="qualificationResultDetail" />
											<c:set value="${finalMap[final_result_id]}" var="qualificationFinalResult" />
											
											<c:if test="${tenderItemStatus.index==0 and qualificationViewStatus.index==0 and expertStatus.index==0}">
												<tr>
													<th colspan="11" style="padding:0px;"><h4 class="tableTitle">${qualificationResultDetail.tenderItem.projectItem.bdbh00}-${qualificationResultDetail.tenderItem.projectItem}</h4></th>
												</tr>
											</c:if>
											<tr>
												<c:if test="${qualificationViewStatus.index==0 and expertStatus.index==0 }">
													<td rowspan="${reviews.size()*experts.size()}" title="${qualificationResultDetail.tenderItem.organ}">${qualificationResultDetail.tenderItem.organ}</td>
												</c:if>
												<c:if test="${expertStatus.index==0}">
													<td rowspan="${experts.size()}">${qualificationResultDetail.qualificationReview.preliminaryReviewType}</td>
												</c:if>
												<c:if test="${expertStatus.index==0}">
													<td rowspan="${experts.size()}">${qualificationResultDetail.qualificationReview.evaluationFactor}</td>
													<td rowspan="${experts.size()}">${qualificationResultDetail.qualificationReview.reviewStandard}</td>
												</c:if>
												<td>${expert}</td>
												<td>${util:dictionary('QUALIFICATION_RESULT',qualificationResultDetail.qualificationResult)}</td>
												<td>${qualificationResultDetail.qualificationResultReason}</td>
												<c:if test="${expertStatus.index==0}">
													<td rowspan="${experts.size()}">
															${util:dictionary('QUALIFICATION_RESULT',qualificationFinalResult.qualificationResult)}
															
														</select>
													</td>
													<td rowspan="${experts.size()}">
														${qualificationFinalResult.qualificationResultReason}
													</td>
													
												<c:if test="${qualificationViewStatus.index==0 and expertStatus.index==0 }">
													<td rowspan="${reviews.size()*experts.size()}" >${util:dictionary('QUALIFICATION_RESULT',qualificationOrganResult.qualificationResult)}</td>
												</c:if>
												</c:if>
											</tr>
										</c:forEach>
									</c:forEach>
							</c:forEach>
						
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div class="blank10"></div>
	<div id="disagreeDiv" >
		<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm">
			<!-- <textarea id="disagreeReason" name="disagreeReason" style="width:250px;height:80px;"></textarea> -->
			<input type="hidden" name="taskId" value="${taskId}" /> 
			<input type="hidden" name="agree" value="true" />
		</form>
	</div>
	<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:998;border: #ccc 1px solid;">
	 	 <!-- <input type="button" class="button red" value="不同意合议结果" id="disagree" />  -->
	 	<input type="button" class="button red" value="打印初评合议结果" id="complete" />
	 	</div>
</body>
</html>
