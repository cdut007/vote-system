<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<table id="scoreGroup" class="mytableStyle">
	<thead>
	<tr>
		<th style="width: 35px;">序号</th>
		<th style="width: 65px;">分值构成</th>
		<th style="width: 65px;">是否合议</th>
		<th style="width: 60px">分值(分)</th>
		<th style="width: 550px;">详细</th>
	</tr>
	</thead>
		<tbody class="editor">
		<c:forEach items="${evaluationMethodJson.detailedReviewTableJson}" var="xiangPingXiangMu">
			<c:if test="${xiangPingXiangMu.fzgc!='报价部分'&&xiangPingXiangMu.fzgc!='评标价'&&xiangPingXiangMu.fzgc!='投标报价' }">
				<tr>
					<th>${xiangPingXiangMu.id}</th>
					<td><input type="hidden" name="flag" readonly="readonly"
						value="${xiangPingXiangMu.fzgc}" /> <textarea
							readonly="readonly" name="groupName">${xiangPingXiangMu.fzgc}</textarea></td>
					<td><select name="needUnify" class="inputxt" defaultValue="0">
							<option value="${xiangPingXiangMu.sfhy=='no'?0:1}" selected>${xiangPingXiangMu.sfhy=='no'?'否':'是'}</option>
					</select></td>
					<td><input name="groupFullScore" class="tr inputxt" readonly="readonly"
						value="<fmt:formatNumber value="${xiangPingXiangMu.score}" minFractionDigits="2"/>" /></td>
					<td style="padding: 0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width: 50px;">序号</th>
									<th>评审因素与评审标准</th>
									<th style="width: 50px">分值(分)</th>
								</tr>
							</thead>
							<tbody class="editor">
								<c:forEach items="${xiangPingXiangMu.detail}" var="detail">
									<tr>
										<th>${detail.id}</th>
										<td><textarea name="evaluationFactor" readonly="readonly">${detail.psbz}</textarea></td>
										<td><input name="itemFullScore" class="tr inputxt"
											readonly="readonly"
											value="<fmt:formatNumber value="${detail.score}" minFractionDigits="2"/>"
											datatype="number" minFractionDigits="2" limit="(0,100)" /></td>
									</tr>
								</c:forEach>
							</tbody>
							<tbody class="statistics">
								<tr>
									<th>小计</th>
									<td></td>
									<td><input class="tr inputxt" readonly="readonly"
										value="<fmt:formatNumber value="${xiangPingXiangMu.score}" minFractionDigits="2"/>"
										datatype="number" minFractionDigits="2" limit="(0,100)" /></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		</tbody>
</table>