<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="statistics" type="com.mhb.evaluation.dto.TenderItemSortStatistics" required="true" description="投标人排序对象"%>
<table class="mytableStyle">
	<thead>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目名称:${instance}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目标段:${projectItem.bdmc00}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目编号:${instance.organProjectCode}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目开标时间:<fmt:formatDate value="${projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy年MM月dd日HH时mm分ss秒" /></td></tr>
		<tr>
			<th>序号</th>
			<th>投标单位</th>
			<!-- <th>投标报价</th>
			<th>投标报价得分</th> -->
			<th>合计得分（100分）</th>
			<th>排名</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${statistics.objectArrayList}" var="tenderItemDetailInfo" varStatus="status">
			<tr>
				<td style="text-align:center">${status.count}</td>
				<td>${tenderItemDetailInfo.organ}</td>
				<%-- <td><fmt:formatNumber value="${tenderItemDetailInfo.tenderAvgGroupScore.scoreValue}" maxFractionDigits="2" minFractionDigits="2"/></td>
				<td><fmt:formatNumber value="${tenderItemDetailInfo.tenderItem.pjf000}" maxFractionDigits="2" minFractionDigits="2"/></td> --%>
				<td style="text-align:center"><fmt:formatNumber value="${tenderItemDetailInfo.tenderAvgTotalScore}" maxFractionDigits="2" minFractionDigits="2"/></td>
				<td style="text-align:center">${status.count}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>