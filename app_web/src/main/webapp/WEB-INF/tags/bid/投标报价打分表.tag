<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="statistics" type="com.mhb.evaluation.dto.PriceScoreStatistics" required="true" description="投标报价打分"%>
<table class="mytableStyle">
	<thead>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目名称:${instance}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目标段:${projectItem.bdmc00}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目编号:${instance.organProjectCode}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="6">项目开标时间:<fmt:formatDate value="${projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy年MM月dd日HH时mm分ss秒" /></td></tr>
		<tr>
			<th style="width:30px">序号</th>
			<th>投标单位</th>
			<th>投标报价</th>
			<th>评标基准价</th>
			<th>偏离值（％）</th>
			<th>报价得分</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${statistics.priceInfoList}" var="priceInfo" varStatus="status">
			<tr>
				<td style="text-align:center">${status.count}</td>
				<td>${priceInfo.organ}</td>
				<td><fmt:formatNumber value="${priceInfo.bidPrice}" maxFractionDigits="2" minFractionDigits="2"/></td>
				<c:if test="${status.index==0}">
					<td rowspan="${fn:length(statistics.priceInfoList)}"><fmt:formatNumber value="${statistics.benchmark}" maxFractionDigits="2" minFractionDigits="2"/></td>
				</c:if>
				<td><fmt:formatNumber value="${priceInfo.deviation}" maxFractionDigits="2" minFractionDigits="2"/>%</td>
				<td><fmt:formatNumber value="${priceInfo.scoreValue}" maxFractionDigits="2" minFractionDigits="2"/></td>
			</tr>
		</c:forEach>
	</tbody>
</table>