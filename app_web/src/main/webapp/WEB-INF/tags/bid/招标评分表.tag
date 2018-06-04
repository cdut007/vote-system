<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="statistics" type="com.mhb.evaluation.dto.EvaluationDetailScoreStatistics" required="true" description="投标报价打分"%>
<table class="mytableStyle">
	<thead>
		<tr style="text-align:center; font-size:15px"><td colspan="15">项目名称:${instance}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="15">项目标段:${projectItem.bdmc00}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="15">项目编号:${instance.organProjectCode}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="15">项目开标时间:<fmt:formatDate value="${projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy年MM月dd日HH时mm分ss秒" /></td></tr>
		<%--<tr>
			<th rowspan="3" style="width:30px;">序号</th>
			<th rowspan="3" style="width:80px;">投标单位</th>
			<c:forEach items="${statistics.scoreGroupList}" var="scoreGroup">
				<c:set value="0" var="colspan"/>
				<c:forEach items="${statistics.scoreItemList}" var="scoreItem">
					<c:if test="${scoreItem.scoreGroupId eq scoreGroup.id}">
						<c:set value="${colspan+1}" var="colspan"/>
					</c:if>
				</c:forEach>
				<th colspan="${colspan}" >${scoreGroup.groupName}(${scoreGroup.groupFullScore}分)</th>
			</c:forEach>
			<th rowspan="3">总分</th>
		</tr>
		<tr>
			<c:forEach items="${statistics.scoreItemList}" var="scoreItem">
				<th>${scoreItem.itemDescription}</th>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach items="${statistics.scoreItemList}" var="scoreItem">
				<th>${scoreItem.itemFullScore}分</th>
			</c:forEach>
		</tr>--%>
	</thead>
	<%--  <tbody>
		<c:forEach items="${statistics.organList}" var="organ" varStatus="status">
			<tr>
				<td style="text-align:center">${status.count}</td>
				<td>${organ}</td>
				
				<c:set value="0" var="scoreTotal"/>
				<c:forEach items="${statistics.scoreItemList}" var="scoreItem">
					
					<c:set value="${scoreTotal+statistics.tenderAvgItemScoreMap[organ.id][scoreItem.id].scoreValue}" var="scoreTotal"/>
					<td style="text-align:center"><fmt:formatNumber value="${statistics.tenderAvgItemScoreMap[organ.id][scoreItem.id].scoreValue}" maxFractionDigits="2" minFractionDigits="2"/></td>
				</c:forEach>

				<td style="text-align:center"><fmt:formatNumber value="${scoreTotal}" maxFractionDigits="2" minFractionDigits="2"/></td>
				
			</tr>
		</c:forEach>
	</tbody>--%>
</table>
${statistics}