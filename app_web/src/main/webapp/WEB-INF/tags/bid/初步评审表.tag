<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="statistics" type="com.mhb.evaluation.dto.PreliminaryStatistics" required="true" description="初步评审统计对象"%>
<c:forEach items="${statistics.preliminaryReviewTypeList}" var="preliminaryReviewType">
	<table class="mytableStyle">
		<%-- <caption>${preliminaryReviewType}表</caption> --%>
		<thead>
			<tr>
				<th colspan="${fn:length(statistics.organList)+2}">${preliminaryReviewType}表</th>
			</tr>
			<tr>
				<th rowspan="2" style="width:30px">序号</th>
				<th rowspan="2">评审因素</th>
				<th colspan="${fn:length(statistics.organList)}">投标人是否满足要求</th>
			</tr>
			<tr>
				<c:forEach items="${statistics.organList}" var="organ">
					<th>${organ}</th>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<c:set value="1" var="count"/>
			<c:forEach items="${statistics.qualificationReviewList}" var="qualificationReview">
				<c:if test="${qualificationReview.preliminaryReviewType eq preliminaryReviewType}">
					<tr>
						<td style="width:30px;text-align:center">${count}<c:set value="${count+1}" var="count"/></td>
						<td style="text-align:center">${qualificationReview.evaluationFactor}</td>
						<c:forEach items="${statistics.organList}" var="organ">
							<td style="text-align:center">${statistics.qualificationFinalResultMap[qualificationReview.id][organ.id].qualificationResult eq '0'?"√" : "×"}</td>
						</c:forEach>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<td></td>
				<td style="text-align:center">是否通过${preliminaryReviewType}</td>
				<c:forEach items="${statistics.organList}" var="organ">
					<c:set var="finalResult" value="${1==1}"/>
					<c:forEach items="${statistics.qualificationReviewList}" var="qualificationReview">
						<c:if test="${qualificationReview.preliminaryReviewType eq preliminaryReviewType}">
							<c:set value="${finalResult and ('0' eq statistics.qualificationFinalResultMap[qualificationReview.id][organ.id].qualificationResult)}" var="finalResult"/>
						</c:if>
					</c:forEach>
					<td style="text-align:center">${finalResult ? "√" : "×"}</td>
				</c:forEach>
			</tr>
		</tbody>
	</table>
</c:forEach>