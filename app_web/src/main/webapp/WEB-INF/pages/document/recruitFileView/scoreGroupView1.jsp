<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<table id="scoreGroup" class="mytableStyle">
	<thead>
		<tr>
			<th style="width:35px;">序号</th>
			<th style="width:50px;">分值构成</th>
			<th style="width:50px;">是否合议</th>
			<th style="width:50px">分值(分)</th>
			<th style="width:*">详细</th>
		</tr>
	</thead>
	<tbody class="editor">
		<c:forEach begin="0" end="${fn:length(scoreReviewTypeList) le 1?2:(fn:length(scoreReviewTypeList)-1)}" varStatus="status">
			<c:set var="scoreGroup" value="${scoreReviewTypeList[status.index]}" />
			<tr>
				<th>${status.index+1}</th>
				<td><input type="hidden" name="flag" value="${scoreGroup.flag}" /> <textarea name="groupName">${scoreGroup.groupName}</textarea></td>
				<td>
					<select name="needUnify" class="inputxt" defaultValue="0">
						<option value="0" ${scoreGroup.needUnify=='0'?"selected='selected'":""}>否</option>
						<option value="1" ${scoreGroup.needUnify=='1'?"selected='selected'":""}>是</option>
					</select>
				</td>
				<td><input name="groupFullScore" class="tr inputxt" value="<fmt:formatNumber value="${scoreGroup.groupFullScore}" minFractionDigits="2"/>" /></td>
				<td style="padding:0px;">
					<table class="mytableStyle">
						<thead>
							<tr>
								<th style="width:50px;">序号</th>
								<th>评审因素</th>
								<th>评审标准</th>
								<th style="width:50px">分值(分)</th>
							</tr>
						</thead>
						<tbody class="editor">
							<c:forEach items="${scoreGroup.scoreReviewList}" var="scoreItem" varStatus="statusItem">
								<tr>
									<th>${statusItem.count}</th>
									<td><textarea name="evaluationFactor">${scoreItem.evaluationFactor}</textarea></td>
									<td><textarea name="reviewStandard">${scoreItem.reviewStandard}</textarea></td>
									<td><input name="itemFullScore" class="tr inputxt" value="<fmt:formatNumber value="${scoreItem.itemFullScore}" minFractionDigits="2"/>" datatype="number" minFractionDigits="2" limit="(0,100)" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	</tbody>
</table>