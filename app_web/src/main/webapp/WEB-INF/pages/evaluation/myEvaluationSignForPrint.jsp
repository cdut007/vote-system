<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%--专家个人详细评审结果确认 --%>
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${tenderItemScoreService.listMyTenderItemScore(processBusinessKey,projectItemId,expertId,'first')}" var="resultMap" />
<c:set value="${resultMap.scoreReviewResultDetailMap}" var="scoreReviewResultDetailMap" />
<c:set value="${resultMap.scoreReviewTypeList}" var="scoreReviewTypeList" />
<c:set value="${resultMap.tenderItemList}" var="tenderItemList" />
<c:set value="${resultMap.qualificationResultDetailMap}" var="qualificationResultDetailMap" />
<c:set value="${resultMap.qualificationReviewTypeList}" var="qualificationReviewTypeList" />
<c:set value="${myPreliminaryReviewSignService.loadMyPreliminaryReviewSignKey(processBusinessKey,projectItemId,'')}" var="myPreliminaryReviewSignKey" />
<c:set value="${userService.getUserInfo(expertId)}" var="expert" />

<jsp:useBean id="list2" class="java.util.ArrayList"></jsp:useBean>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>评标</title>
<sys:link ca="true" uedit="true" easyui="true"/>
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
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			详细评审明细确认
		</div>
		
		<div class="usBox" id="printArea">
		
			<div style="text-align: center;">
				<font style="font-size: 14pt; font-weight: bold;">${expert.userName}&nbsp;详细评审明细</font>
			</div>
			<div class="mytableStyle" style="width:100%; height:auto">
				
				<c:forEach items="${tenderItemList}" var="tenderItem" >
	        	<h2 class="tableTitle">${tenderItem.organBName}</h2>
				<div id="score_dialog">
					<div class="block" style="width:100%;">
						<c:forEach items="${scoreReviewTypeList}" var="detailReviewType" varStatus="status">
							<h3 class="">${status.count}、${detailReviewType.groupName}(共计：${detailReviewType.groupFullScore})</h3>
							<c:choose>
								<c:when test="${detailReviewType.flag=='price'}">
									<table class="mytableStyle">
										<thead>
											<tr>
												<th style="width:15%">评审项目</th>
												<th>评分办法</th>
												<th style="width:60px">得分</th>
											</tr>
										</thead>
										<tr>
											<td>${detailReviewType.groupName}</td>
											<td style="text-align:left;text-indent: 2em" id="pbbfss">${detailReviewType.scoreReviewList[0].reviewStandard}</td>
											<c:set value="${detailReviewType.scoreReviewList[0].id}${tenderItem.id}" var="price_score_id" />
											<td align="right">
												${scoreReviewResultDetailMap[price_score_id].scoreValue}
											</td>
										</tr>
									</table>
								</c:when>
								<c:otherwise>
									<table class='mytableStyle' id="scoreTable">
										<thead>
											<tr>
												<th style='width:30px'>序号</th>
												<th style="width:12%">评审项目</th>
												<th>评审因素</th>
												<th>评审标准</th>
												<th style="width:10%">分值范围</th>
												<th style="width:60px">得分</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${detailReviewType.scoreReviewList}" var="item" varStatus="status">
												<tr>
													<th>${status.count}</th>
													<c:if test="${status.index==0}">
														<td rowspan="${fn:length(detailReviewType.scoreReviewList)}">${detailReviewType.groupName}</td>
													</c:if>
													<td style="text-align:left;">${item.evaluationFactor}</td>
													<td style="text-align:left;">${item.reviewStandard}</td>
													<td align="center">（0~${item.itemFullScore}）</td>
													<c:set value="${item.id}${tenderItem.id}" var="score_id" />
													
													<td align="center">
														${scoreReviewResultDetailMap[score_id].scoreValue}
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:otherwise>
							</c:choose>
							<div class="blank10"></div>
						</c:forEach>
						<c:forEach items="${qualificationReviewTypeList}" var="qualificationReviewType" varStatus="status">
							<h3 class="tableTitle">${fn:length(qualificationReviewTypeList)+status.count}、${qualificationReviewType.preliminaryReviewType}</h3>
							<table class="mytableStyle">
								<thead>
									<tr>
										<th style="width:50px;">序号</th>
										<th style="width:350px;">评分因素</th>
										<th style="width:350px;">评审标准</th>
										<th style="width:80px;">评审</th>
										<th style="width:80px;">原因</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${qualificationReviewType.qualificationReviewList}" var="qualificationReview" varStatus="childStatus">
										<c:set value="${qualificationReview.id}${tenderItem.id}" var="qualificationReview_score_id" />
										<c:set value="${qualificationResultDetailMap[qualificationReview_score_id]}" var="qualificationReviewScore" />
										<tr>
											<th>${childStatus.count}</th>
											<td style="text-align:left">${qualificationReview.evaluationFactor}</td>
											<td style="text-align:left">${qualificationReview.reviewStandard}</td>
											<td>
												<input type="hidden" name="qualificationRequirementId" value="${qualificationReview.id}" /> 
												${util:dictionary('QUALIFICATION_RESULT',qualificationReviewScore.qualificationResult)}	
											</td>
											<td>
												${qualificationReviewScore.qualificationResultReason}
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="blank10"></div>
						</c:forEach>
					</div>
					</div>
				</c:forEach>
				</div>
			<div id="ht_end"></div>
		</div>
	</div>

	<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:998;border: #ccc 1px solid;">
		<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
			<input type="button" class="button red" value="打印详评结果" id="complete" />
		</form>
	</div>
</body>
</html>
