<%@tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@attribute name="expertApplyId" type="java.lang.String" required="true" description="专家申请ID"%>
<%@attribute name="projectItemId" type="java.lang.String" required="true" description="标段ID"%>
<c:set value="select projectItem,bidOpenRecord from TBProjectItem projectItem,TBBidOpenRecord bidOpenRecord,TBExpertApply expertApply where expertApply.id='${expertApplyId}' and projectItem.id in (split(expertApply.projectItemId,',')) and projectItem.id=bidOpenRecord.projectItemId and projectItem.id='${projectItemId}' and bidOpenRecord.expertApplyId=expertApply.id order by bidOpenRecord.openStatus desc,projectItem.bdbh00" var="hql" />
<c:set value="${baseService.retrieveByHQL(hql)}" var="projectItemWithBidOpenRecordList"/>
<c:forEach items="${projectItemWithBidOpenRecordList}" var="projectItemWithBidOpenRecord" varStatus="status">
	<c:set value="${projectItemWithBidOpenRecord[0]}" var="projectItem" />
	<c:set value="${projectItemWithBidOpenRecord[1]}" var="bidOpenRecord" />
	<h4 class="tableTitle">${projectItem.bdmc00}</h4>
	<c:choose>
		<c:when test="${bidOpenRecord.openStatus=='1'}">
			<table class="mytableStyle" align="center" style="width:100%;background-color:#fff;">
				<thead>
					<tr class="firstRow">
						<th style="width:20px;">排名</th>
						<th style="width:365px;">投标单位</th>
						<th style="width:123px;">最终得分</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${evaluationReportService.retrieveTenderItemTop3(projectItem.id,expertApplyId)}" var="tenderItem" varStatus="s">
						<tr>
							<td>${s.count}</td>
							<td>${tenderItem.organBName}</td>
							<td><fmt:formatNumber value="${tenderItem.pjf000}" maxFractionDigits="2" minFractionDigits="2" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
		<c:otherwise>
			<p>流标：${bidOpenRecord.closeReason}</p>
		</c:otherwise>
	</c:choose>
</c:forEach>