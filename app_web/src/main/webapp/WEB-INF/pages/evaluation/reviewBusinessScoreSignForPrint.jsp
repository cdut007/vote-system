<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8" import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set value="${tenderItemScoreService.listAllTenderItemScore(processBusinessKey,projectItemId,'first')}" var="resultMap" />
<c:set value="${tenderItemScoreService.listAllTenderItemWithQualificationScore(processBusinessKey,projectItemId,'first')}" var="qualificationResultMap" />
<jsp:useBean id="list" class="java.util.ArrayList"></jsp:useBean>
<c:choose>
		<c:when test="${not empty resultMap.scoreReviewTypeList}">
		<c:set var="MODE" value="SCORE"/>
	</c:when>
	<c:otherwise>
		<c:set value="PASS" var="MODE"/>
	</c:otherwise>
</c:choose>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商务部分评分合议结果确认</title>
<jsp:include page="/common/link.jsp" />
<!--ready事件-->

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
			商务评分合议
		</div>
		<div class="usBox" id="printArea">
			<div style="text-align: center;">
				<font style="font-size: 14pt; font-weight: bold;">${projectInstance}详细评审结果合议确认</font>
			</div>
			<form id="reviewBusinessScoreForm" action="${pageContext.request.contextPath}/evaluation/saveReviewBusinessScore" method="post">
				<input type="hidden" name="expertApplyId" value="${processBusinessKey}"/>
				<c:choose>
					<c:when test="${MODE=='SCORE'}">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width:120px;">投标单位</th>
									<th style="width:250px;">得分项描述</th>
									<th style="width:80px;">专家</th>
									<th style="width:50px;">得分</th>
									<th style="width:50px;">合议得分</th>
								</tr>
							</thead>
							<tbody>
							<c:set value="${resultMap.scoreReviewResultDetailMap}" var="scoreReviewResultDetailMap" />
							<c:set value="${resultMap.scoreReviewTypeList}" var="scoreReviewTypeList" />
							<c:set value="${resultMap.tenderItemList}" var="tenderItemList" />
							<c:set value="${resultMap.qualificationResultDetailMap}" var="qualificationResultDetailMap" />
							<c:set value="${resultMap.expertList}" var="expertList" />
							<c:set value="${resultMap.scoreAvgMap}" var="scoreAvgMap" />

								<c:forEach items="${tenderItemList}" var="tenderItem" varStatus="tenderItemStatus">
									<c:forEach items="${scoreReviewTypeList}" var="scoreReviewType" varStatus="scoreReviewTypeStatus">									
									<c:set value="${scoreReviewType.scoreReviewList}" var="scoreReviewList" />
									<c:forEach items="${scoreReviewList}" var="scoreReviewItem" varStatus="scoreReviewItemStatus">
										<c:forEach items="${expertList}" var="expertItem" varStatus="expertItemStatus">
												<c:set value="${expertItem.id}" var="expertId" />
										
													<c:if test="${tenderItemStatus.index==0 and scoreReviewItemStatus.index==0 and scoreReviewTypeStatus.index==0 and expertItemStatus.index==0}">
														<tr>
															<th colspan="5" style="padding:0px;"><h4 class="tableTitle">${tenderItem.projectItem.bdbh00}-${tenderItem.projectItem}</h4></th>
														</tr>
													</c:if>
													<tr>
														<c:if test="${scoreReviewTypeStatus.index==0 and expertItemStatus.index==0 and scoreReviewItemStatus.index==0}">
															<td rowspan="${resultMap.scoreReviewTypeListLength * expertList.size() }">${tenderItem.organ}</td>
														</c:if>
														
														<c:if test="${expertItemStatus.index==0}">
															<td style="text-align: left" rowspan="${expertList.size()}" >
																${scoreReviewItem.evaluationFactor}:${scoreReviewItem.reviewStandard}
																<em style="float:right">(0~<fmt:formatNumber value="${scoreReviewItem.itemFullScore}" maxFractionDigits="2" minFractionDigits="2"></fmt:formatNumber>)
																</em>
															</td>
														 </c:if>
														 
														 <td>${expertItem}</td>
														<c:set value="${scoreReviewItem.id}${tenderItem.id}${expertItem.id}" var="score_id" />
														<c:set value="${scoreReviewItem.id}${tenderItem.id}" var="score_avg_id" />
														 <td>${scoreReviewResultDetailMap[score_id].scoreValue}</td>
														 <c:if test="${expertItemStatus.index==0}">
														 			<td rowspan="${expertList.size()}" >
														 			<fmt:formatNumber value="${scoreAvgMap[score_avg_id]}" maxFractionDigits="2" minFractionDigits="2"></fmt:formatNumber>
														 		</td>
														 </c:if>	
														 
													</tr>
									
											</c:forEach>
										</c:forEach>
									</c:forEach>
								</c:forEach>
								<%-- <c:forEach items="${tenderItemScoreWithTenderAvgItemScoreList}" var="tenderItemScoreWithTenderAvgItemScore" varStatus="status">
									<c:set var="tenderItemScore" value="${tenderItemScoreWithTenderAvgItemScore[0]}" />
									<c:set var="tenderAvgItemScore" value="${tenderItemScoreWithTenderAvgItemScore[1]}" />
									<c:if test="${status.index==0 || (tenderItemScore.tenderItem.projectItem != projectItem)}">
										<tr>
											<th colspan="6" style="padding:0px;"><h4 class="tableTitle">${tenderItemScore.tenderItem.projectItem.bdbh00}-${tenderItemScore.tenderItem.projectItem}</h4></th>
										</tr>
										<c:set var="projectItem" value="${tenderItemScore.tenderItem.projectItem}"></c:set>
									</c:if>
									<tr>
										<td class="rowspan" key="${tenderItemScore.tenderItem.projectItem.id}-${tenderItemScore.tenderItem.organ.id}">${tenderItemScore.tenderItem.organ}</td>
										<td class="rowspan" key="${tenderItemScore.tenderItem.projectItem.id}-${tenderItemScore.tenderItem.id}-${tenderItemScore.scoreItem.id}" style="text-align: left">${tenderItemScore.scoreItem.itemDescription}<em style="float:right">(0~<fmt:formatNumber value="${tenderItemScore.scoreItem.itemFullScore}" maxFractionDigits="2" minFractionDigits="2"></fmt:formatNumber>)
											</em>
										</td>
										<td class="rowspan" key="${tenderItemScore.tenderItem.projectItem.id}-${tenderItemScore.tenderItem.id}-${tenderItemScore.scoreItem.id}-${tenderItemScore.expert.id}">${tenderItemScore.expert}</td>
										<td>
											<fmt:formatNumber value="${tenderItemScore.scoreValue}" maxFractionDigits="2" minFractionDigits="2"></fmt:formatNumber>
										</td>
										<td class="rowspan" key="${tenderItemScore.tenderItem.projectItem.id}-${tenderAvgItemScore.id}">
											<input type="hidden" value="${tenderAvgItemScore.id}" name="id" />
											<sys:number name="scoreValue" value="${tenderAvgItemScore.scoreValue}" min="0" max="${tenderItemScore.scoreItem.itemFullScore}" precision="2" required="true"></sys:number>
											<input type="text" value="${tenderAvgItemScore.scoreValue}" name="scoreValue" class="easyui-numberbox easyui-validatebox" data-options="required:true,min:0,precision:2,max:${tenderItemScore.scoreItem.itemFullScore}" />
										</td>
									</tr>
								</c:forEach> --%>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
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
							<c:set value="${qualificationResultMap.scoreReviewResultDetailMap}" var="scoreReviewResultDetailMap" />
							<c:set value="${qualificationResultMap.qualificationReviewTypeList}" var="scoreReviewTypeList" />
							<c:set value="${qualificationResultMap.tenderItemList}" var="tenderItemList" />
							<c:set value="${qualificationResultMap.expertList}" var="expertList" />
							<c:set value="${qualificationResultMap.rowSpan}" var="rowSpan" />
								<c:forEach items="${tenderItemList}" var="tenderItem" varStatus="tenderItemStatus">
									<c:set value="合格" var="score_result" />
									<c:forEach items="${scoreReviewTypeList}" var="scoreReviewType" varStatus="scoreReviewTypeStatus">									
									<c:set value="${scoreReviewType.qualificationReviewList}" var="scoreReviewList" />
									<c:forEach items="${scoreReviewList}" var="scoreReviewItem" varStatus="scoreReviewItemStatus">
										<c:forEach items="${expertList}" var="expertItem" varStatus="expertItemStatus">
												<c:set value="${expertItem.id}" var="expertId" />
										
													<c:if test="${tenderItemStatus.index==0 and scoreReviewItemStatus.index==0 and scoreReviewTypeStatus.index==0 and expertItemStatus.index==0}">
														<tr>
															<th colspan="10" style="padding:0px;"><h4 class="tableTitle">${tenderItem.projectItem.bdbh00}-${tenderItem.projectItem}</h4></th>
														</tr>
													</c:if>
													<tr>
														<c:if test="${scoreReviewTypeStatus.index==0 and expertItemStatus.index==0 and scoreReviewItemStatus.index==0}">
															<td rowspan="${qualificationResultMap.rowSpan }">${tenderItem.organ}</td>
														</c:if>
														
														<c:if test="${scoreReviewItemStatus.index==0 and expertItemStatus.index==0}">
															<td style="text-align: left" rowspan="${expertList.size()*scoreReviewList.size()}" >
																${scoreReviewType.preliminaryReviewType}
																
																</em>
															</td>
														 </c:if>
														 
														 <c:if test="${expertItemStatus.index==0}">
					 	
														  		<td  rowspan="${expertList.size()}" >${scoreReviewItem.evaluationFactor}</td>
																 <td  rowspan="${expertList.size()}" >${scoreReviewItem.reviewStandard}</td>
														 </c:if>
														
														<c:set value="${scoreReviewItem.id}${tenderItem.id}${expertItem.id}" var="score_id" />
														<c:set value="${scoreReviewItem.id}${tenderItem.id}" var="qualificationFinalResult_id" />
														<c:set value="${qualificationResultMap.qualificationResultMap[qualificationFinalResult_id]}" var="qualificationFinalResult" />
														 <td>${expertItem}</td>
														<td>${util:dictionary('QUALIFICATION_RESULT',qualificationResultMap.scoreReviewResultDetailMap[score_id].qualificationResult)}</td>
														 <td>${qualificationResultMap.scoreReviewResultDetailMap[score_id].qualificationResultReason}</td>
														 
														 <c:if test="${expertItemStatus.index==0}">
														 	  <input type="hidden" value="${qualificationFinalResult.id}" name="id2" />
														 		<td rowspan="${expertList.size()}" >						 				
																		${util:dictionary('QUALIFICATION_RESULT',qualificationFinalResult.qualificationResult)}					 		
														 		</td>
														 		
														 		<td rowspan="${expertList.size()}">
																		${qualificationFinalResult.qualificationResultReason}
																</td>
																<c:if test="${qualificationFinalResult.qualificationResult==1}">
																	<c:set value="不合格" var="score_result" />
																</c:if>
														 </c:if>	
														 
													
													
													<c:if test="${scoreReviewTypeStatus.index==0 and expertItemStatus.index==0 and scoreReviewItemStatus.index==0}">
															<td rowspan="${qualificationResultMap.rowSpan }">${score_result}</td>
													</c:if>
													
													</tr>
											</c:forEach>
										</c:forEach>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
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
		</form>
	</div>
		<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:998;border: #ccc 1px solid;">
	 	<input type="button" class="button red" value="打印详评结果" id="complete" />
	 	</div>
</body>
</html>
