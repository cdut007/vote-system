<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="expertApplyId" type="java.lang.String" required="true" description="专家申请ID"%>
<c:set value="${projectItemService.createProjectItemQuery().includeTenderItem().expertApplyId(processBusinessKey).list()}" var="projectItemList" />
<c:forEach items="${projectItemList}" var="item" varStatus="status">
	<h4 class="tableTitle">${item.bdmc00}</h4>
	<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
		<thead>
			<tr>
				<th style="width:30px;">排名</th>
				<th>投标单位</th>
				<c:forEach items="${item.scoreGroupList}" var="scoreGroup" varStatus="tsStatus">
					<c:if test="${scoreGroup.flag=='price'||scoreGroup.flag=='business'}">
						<th>${scoreGroup.groupName}</th>
					</c:if>
				</c:forEach>
				<th>评标专家</th>
				<c:forEach items="${item.scoreGroupList}" var="scoreGroup" varStatus="tsStatus">
					<c:if test="${scoreGroup.flag!='price'&&scoreGroup.flag!='business'}">
						<th>${scoreGroup.groupName}</th>
					</c:if>
				</c:forEach>
				<th>总分</th>
				<th>均分</th>
			</tr>
		</thead>
		<c:forEach items="${evaluationReportService.retrieveTenderItemTop3(item.id)}" var="tt" varStatus="s">
			<c:forEach items="${tenderTotalScoreService.createTenderTotalScoreQuery().tenderItemId(tt.id).list()}" var="ts" varStatus="tsStatus">
				<c:set var="sum" value="0"></c:set>
				<tr>
					<c:if test="${tsStatus.index==0}">
						<td rowspan="${fn:length(tt.tenderTotalScoreList)}">${s.count}</td>
						<td rowspan="${fn:length(tt.tenderTotalScoreList)}">${tt.tender.organ}</td>
					</c:if>
					<c:forEach items="${tenderGroupScoreService.createTenderGroupScoreWithTenderAvgGroupScoreQuery().tenderTotalScoreId(ts.id).list()}" var="tenderGroupScoreWithTenderAvgGroupScore" varStatus="gsStatus">
						<c:set var="gs" value="${tenderGroupScoreWithTenderAvgGroupScore[0]}"></c:set>
						<c:set var="tenderAvgGroupScore" value="${tenderGroupScoreWithTenderAvgGroupScore[1]}"></c:set>
						<c:if test="${gs.flag=='price'||gs.flag=='business'}">
							<c:if test="${tsStatus.index==0}">
								<td rowspan="${fn:length(tt.tenderTotalScoreList)}"><fmt:formatNumber value="${tenderAvgGroupScore.scoreValue}" maxFractionDigits="2" minFractionDigits="2"></fmt:formatNumber></td>
							</c:if>
							<c:set value="${sum+tenderAvgGroupScore.scoreValue}" var="sum" />
						</c:if>
					</c:forEach>
					<td>${ts.expert}</td>
					<c:forEach items="${ts.tenderGroupScoreList}" var="gs" varStatus="gsStatus">
						<c:if test="${gs.flag!='price'&&gs.flag!='business'}">
							<td><fmt:formatNumber value="${gs.scoreValue}" maxFractionDigits="2" minFractionDigits="2"></fmt:formatNumber></td>
							<c:set value="${sum+gs.scoreValue}" var="sum" />
						</c:if>
					</c:forEach>
					<td><fmt:formatNumber value="${sum}" maxFractionDigits="2" minFractionDigits="2" /></td>
					<c:if test="${tsStatus.index==0}">
						<td rowspan="${fn:length(tt.tenderTotalScoreList)}">
							<fmt:formatNumber value="${tt.pjf000}" maxFractionDigits="2" minFractionDigits="2" />
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
	<div class="blank10"></div>
</c:forEach>