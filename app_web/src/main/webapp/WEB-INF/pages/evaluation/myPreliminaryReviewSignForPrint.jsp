<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%--专家个人初步评审结果确认 --%>
<c:set value="${qualificationResultDetailService.listMyPriQualificationResultDetailList(processBusinessKey,projectItemId,reviewType,expertId,envelopeTypeOrder)}" var="result" />
<c:set value="${userService.getUserInfo(expertId)}" var="expert" />
<c:set value="${result.tenderItems}" var="tenderItems" />
<c:set value="${result.reviews}" var="reviews" />
<c:set value="${result.detailMap}" var="detailMap" />
<c:set value="${result.recruitFile}" var="recruitFile" />
<c:set value="${myPreliminaryReviewSignService.loadMyPreliminaryReviewSignKey(processBusinessKey,projectItemId,reviewType)}" var="myPreliminaryReviewSignKey" />
<jsp:useBean id="list" class="java.util.ArrayList"></jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}结果合议</title>
<sys:link ca="true" uedit="true" easyui="true"/>
<style type="text/css">
.bold_red {font-weight: bold;color: red;}
/* .usBox table{border-right:1px solid #F00;border-bottom:1px solid #F00} 
.usBox table td{border-left:1px solid #F00;border-top:1px solid #F00}  */
</style>
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
			${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}明细确认
		</div>
		<div class="usBox" id="printArea">
			<div style="text-align: center;">
				<font style="font-size: 14pt; font-weight: bold;">${expert.userName}&nbsp;${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}明细</font>
			</div>
			<div class="blank10"></div>
			<c:set value="${CURRENT_USER_SESSION_INFO.id}" var="content"></c:set>
			<table class="mytableStyle" style="">
				<col style="width:150px;" />
				<col style="width:120px;" />
				<col style="width:200px;" />
				<col style="width:400px;" />
				<col style="width:80px;" />
				<col style="width:80px;" />
				<col style="width:100px;" />
				<col style="width:120px" />
				<col style="width:100px" />
				<thead>
					<tr>
						<th>投标单位</th>
						<th>评审类型</th>
						<th>评审因素</th>
						<th>评审标准</th>
						<th>评审结果</th>
						<th>评审意见</th>
					</tr>
				</thead>
				<tbody>
							<c:forEach items="${tenderItems}" var="tenderItem" varStatus="tenderItemStatus">
								<c:forEach items="${reviews}" var="qualificationView" varStatus="qualificationViewStatus">
									<c:set value="${tenderItem.id}${qualificationView.id}" var="result_id" />
									<c:set value="${detailMap[result_id]}" var="qualificationResultDetail" />
									
								
									<c:if test="${tenderItemStatus.index==0 and qualificationViewStatus.index==0}">
										<tr>
											<th colspan="6" style="padding:0px;"><h4 class="tableTitle">${qualificationResultDetail.tenderItem.projectItem.bdbh00}-${qualificationResultDetail.tenderItem.projectItem}</h4></th>
										</tr>
									</c:if>
									<tr>
										<c:if test="${qualificationViewStatus.index==0}">
											<td rowspan="${reviews.size()}">${qualificationResultDetail.tenderItem.organ}</td>
										</c:if>
									
										<td>${qualificationResultDetail.qualificationReview.preliminaryReviewType}</td>
										<td>${qualificationResultDetail.qualificationReview.evaluationFactor}</td>
										<td style="text-align: left;">${qualificationResultDetail.qualificationReview.reviewStandard}</td>
										<td>${util:dictionary('QUALIFICATION_RESULT',qualificationResultDetail.qualificationResult)}</td>
										<td>${qualificationResultDetail.qualificationResultReason}</td>
									</tr>
								</c:forEach>
							</c:forEach>
				</tbody>
			</table>
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
		<!--<form id="myPreliminaryReviewSignForm" action="${pageContext.request.contextPath}/evaluation/saveMyPreliminaryReviewSign" method="post">
			
			<input type="hidden" name="projectItemId" value="${projectItemId}" /> 
			<input type="hidden" name="expertApplyId" value="${processBusinessKey}" />
			<input type="hidden" id="sealSignData" name="sealSignData" value="${myPreliminaryReviewSign.sealSignData}" />
		</form>-->
		<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:998;border: #ccc 1px solid;">
			<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
				<input type="hidden" id="DocumentID" name="DocumentID" value="${processBusinessKey}:${projectItemId}:${CURRENT_USER_SESSION_INFO}"/> 
				<input type="hidden" id="content" name="content" value="${content}" /> 
				<input type="hidden" name="taskId" value="${taskId}" /> 
				<input type="hidden" name="back" value="false" />
				<%--<input type="hidden" name="projectItemId" value="${projectItemId}" />  --%>
				<%-- <c:if test="${empty myPreliminaryReviewSign.sealSignData}">
					<a class="button red" id="back" href="${pageContext.request.contextPath}/workflow/completeForm?taskId=${taskId}&back=true">返回</a>
				</c:if>
				<a class="button red" id="sign">电子印章</a> <a class="button red" id="complete">提交下一步</a> --%>
				
				<input type="button" class="button red" value="打印初评结果" id="complete" />
				
			</form>
		</div>
	</div>
	<%-- <jsp:include page="/common/bottom.jsp"/> --%>
</body>
</html>
