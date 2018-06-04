<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="statistics" type="com.mhb.evaluation.dto.EvaluationScoreStatistics" required="true" description="招标评委评分汇总对象"%>
<table class="mytableStyle">
	<thead>
		<tr style="text-align:center; font-size:15px"><td colspan="50">项目名称:${instance}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="50">项目标段:${projectItem.bdmc00}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="50">项目编号:${instance.organProjectCode}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="50">项目开标时间:<fmt:formatDate value="${projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy年MM月dd日HH时mm分ss秒" /></td></tr>
		<tr>
			<th colspan="2"></th>
			<c:forEach items="${statistics.userList}" var="user">
				<th>${user}</th>
			</c:forEach>
			<th>总分</th>
			<th>均分</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${statistics.organList}" var="organ" varStatus="status">
			<tr>
				<td style="text-align:center">${status.count}</td>
				<td>${organ}</td>
				<c:set value="0" var="scoreTotal"/>
				<c:forEach items="${statistics.userList}" var="user">
					<c:set value="${scoreTotal+statistics.tenderTotalScoreMap[organ.id][user.id].scoreValue}" var="scoreTotal"/>
					<td style="text-align:center"><fmt:formatNumber value="${statistics.tenderTotalScoreMap[organ.id][user.id].scoreValue}" maxFractionDigits="2" minFractionDigits="2"/></td>
				</c:forEach>
				<td style="text-align:center"><fmt:formatNumber value="${scoreTotal}" maxFractionDigits="2" minFractionDigits="2"/></td>
				<td style="text-align:center"><fmt:formatNumber value="${scoreTotal/fn:length(statistics.userList)}" maxFractionDigits="2" minFractionDigits="2"/></td>
			</tr>
		</c:forEach>
	</tbody>
</table>