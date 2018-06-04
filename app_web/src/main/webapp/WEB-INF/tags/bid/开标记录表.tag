<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="statistics" type="com.mhb.evaluation.dto.BidOpenRecordStatistics" required="true" description="初步评审统计对象"%>

<table class="mytableStyle">
	
	<thead>
		<tr style="text-align:center; font-size:15px"><td colspan="8">项目名称:${instance}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="8">项目标段:${projectItem.bdmc00}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="8">项目编号:${instance.organProjectCode}</td></tr>
		<tr style="text-align:center; font-size:15px"><td colspan="8">项目开标时间:<fmt:formatDate value="${projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy年MM月dd日HH时mm分ss秒" /></td></tr>
		<tr>
			<th>序号</th>
			<th>投标单位</th>
			<th>投标报价</th>
			<th>质量</th>
			<th>工期</th>
			<th>其它说明 （书面修改或撤回投标通知等）</th>
			<th>是否缴纳投标保证金</th>
			<th>投标人签字</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${statistics.bidFileList}" var="bidFile" varStatus="status">
			<tr>
				<td style="text-align:center">${status.count}</td>
				<td>${bidFile.organ}</td>
				<td>${bidFile.tbbjje*("1"==bidFile.tbbjdw ? 1 : 10000)}</td>
				<td>${bidFile.quality}</td>
				<td>${bidFile.gq0000}</td>
				<td></td>
				<td style="text-align:center">${"1" eq bidFile.isContributeDeposit ? "是" : "否"}</td>
				<td style="text-align:center">${"1" eq bidFile.isConfirm ? "是" : "否"}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
