<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<table id="qualificationReview" class="mytableStyle">
	<thead>
		<tr>
			<th style="width:35px;">序号</th>
			<th style="width:80px;">评审类型</th>
			<th>评审内容</th>
		</tr>
	</thead>
	<tbody class="editor">
		<c:choose>
			<c:when test="${empty qualificationReviewTypeList}">
				<c:forEach begin="0" end="2" varStatus="status">
					<tr>
						<th>${status.count}</th>
						<td>
							<%-- ${status.index==0?'形式评审':status.index==1?'资格评审':'响应性评审'}
							<input type="hidden" value="${status.index==0?'形式评审':status.index==1?'资格评审':'响应性评审'}" name="preliminaryReviewType"/> --%>
							<textarea name="preliminaryReviewType">${status.index==0?'形式评审':status.index==1?'资格评审':'响应性评审'}</textarea>
						</td>
						<td style="padding:0px;">
							<table class="mytableStyle">
								<thead>
									<tr>
										<th style="width:50px;">序号</th>
										<th style="width:160px">评审因素及评审标准</th>
									</tr>
								</thead>
								<tbody class="editor">
									<tr>
										<th>1</th>
										<td>
											<textarea name="evaluationFactor"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach items="${qualificationReviewTypeList}" var="qualificationReviewType" varStatus="status">
					<tr>
						<th>${status.count}</th>
						<td>
							<input type="hidden" name="preliminaryReviewType" value="${qualificationReviewType.preliminaryReviewType}"/>
							${qualificationReviewType.preliminaryReviewType}
						</td>
						<td style="padding:0px;">
							<table class="mytableStyle">
								<thead>
									<tr>
										<th style="width:50px;">序号</th>
										<th style="width:200px">评审因素及评审标准</th>
									</tr>
								</thead>
								<tbody class="editor">
									<c:forEach items="${qualificationReviewType.qualificationReviewList}" var="qualificationRequirement" varStatus="s">
										<tr>
											<th>${s.count}</th>
											<td>
												<textarea name="evaluationFactor">${qualificationRequirement.evaluationFactor}</textarea>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
	</tbody>
</table>