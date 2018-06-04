<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<table id="qualificationGroup" class="mytableStyle" style="width:100%;">
	<thead>
		<tr style="width:100%;">
			<th style="width:30px;" >序号</th>
			<th style="width:50px;" >分类</th>
			<th style="width:50px;" >算法</th>
			<th style="width:*" >详评项目</th>
		</tr>
	</thead>
	<tbody class="other">
		<tr>
			<th>1</th>
			<td>报价部分<input type="hidden" name="groupFlag" value="price" class="groupFlag"/><input type="hidden" name="firstGroup" value="报价部分" class="firstGroup"/></td>
			<td>平均法</td>
			<td style="padding:0px;">
				<table id="scoreGroup1" class="mytableStyle">
					<thead>
						<tr>
							<th style="width:35px;">序号</th>
							<th style="width:65px;">分值构成</th>
							<th style="width:65px;">是否合议</th>
							<th style="width:60px">分值(分)</th>
							<th style="width:*">详细</th>
						</tr>
					</thead> 
					<tbody class="other">
						<tr>
							<th>1</th>
							<td><input type="hidden" name="flag" value="price" /><input type="hidden" name="groupName" value="报价部分" />报价部分</td>
							<td><input type="hidden" name="needUnify" value="0"/>否</td>
							<td><input name="groupFullScore" class="tr inputxt" value="<fmt:formatNumber value="${scoreReview.groupFullScore}" minFractionDigits="2"/>" /></td>
							<td style="text-align:left;padding:3px;':'padding:0px;" id="price">${recruitFile.evaluationMethodInstance.descriptionHtml}</td>
						</tr>
					</tbody>

				</table>
			</td>
		</tr>
	</tbody>
	<tbody class="editor">
		<c:if test="${!empty groupMap}">
		<c:forEach var="firstGroup" items="${groupMap}" varStatus="status">
		<c:set var="qualificationGroup" value="${firstGroup.value}" />
		<c:set var="groupList" value="${groupMap[firstGroup.key]}" />
		<c:set var="scoreReviewTypeList" value="${scoreReviewTypeMap[firstGroup.key]}" />
		<tr>
			<th>1</th>
			<td><input type="hidden" name="groupFlag" value="" /> <textarea name="firstGroup">${firstGroup.key}</textarea></td>
			<td><select name="groupAlgorithm"><option value="0" ${groupList[0].groupAlgorithm==0?'selected':''} >平均法</option><option value="1" ${groupList[0].groupAlgorithm==1?'selected':''}>去掉最高最低再平均</option></select></td>
			<td style="padding:0px;">
				<table id="scoreGroup2" class="mytableStyle">
					<thead>
						<tr>
							<th style="width:35px;">序号</th>
							<th style="width:65px;">分值构成</th>
							<th style="width:65px;">是否合议</th>
							<th style="width:60px">分值(分)</th>
							<th style="width:*">详细</th>
						</tr>
					</thead> 
					<tbody class="editor">
					<c:forEach begin="0" end="${fn:length(scoreReviewTypeList)}" varStatus="status">
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
									<tbody class="statistics">
										<tr>
											<th>小计</th>
											<td></td>
											<td></td>
											<td><input name="sum[2-2][0-*]" class="tr inputxt" readonly="readonly" /></td>
											<td></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty groupMap}">
		<tr>
			<th>1</th>
			<td><input type="hidden" name="groupFlag" value="" /> <textarea name="firstGroup"></textarea></td>
			<td><select name="groupAlgorithm"><option value="0">平均法</option><option value="1">去掉最高最低再平均</option></select></td>
			<td style="padding:0px;">
				<table id="scoreGroup2" class="mytableStyle">
					<thead>
						<tr>
							<th style="width:35px;">序号</th>
							<th style="width:65px;">分值构成</th>
							<th style="width:65px;">是否合议</th>
							<th style="width:60px">分值(分)</th>
							<th style="width:*">详细</th>
						</tr>
					</thead> 
					<tbody class="editor">
					<c:forEach begin="0" end="${fn:length(scoreReviewTypeList)-1}" varStatus="status">
						<c:set var="scoreGroup" value="${scoreReviewTypeList[status.index]}" />
						<c:if test="${scoreGroup.flag ne 'price'}">
						<tr>
							<th>${scoreGroup.flag }</th>
							<td><input type="hidden" name="flag" value="${scoreGroup.flag}" />${scoreGroup.groupName}</td>
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
						</c:if>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
		</c:if>
	</tbody>
</table>
