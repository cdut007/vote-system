<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<table id="passDetailReview" class="mytableStyle">
	<thead>
		<tr>
			<th style="width:35px;">序号</th>
			<th style="width:112px;">评审类型</th>
			<th>评审内容</th>
		</tr>
	</thead>
	<tbody class="editor">
		<c:choose>
			<c:when test="${empty detailReviewTypeList}">
				<c:forEach begin="1" end="2" varStatus="status">
					<tr>
						<th>${status.count}</th>
						<td>
							<textarea name="preliminaryReviewType"></textarea><%--${status.index==1?'商务部分':'技术部分'}--%>
						</td>
						<td style="padding:0px;">
							<table class="mytableStyle">
								<thead>
									<tr>
										<th style="width:50px;">序号</th>
										<th style="width:160px">评审因素</th>
										<th>评审标准</th>
									</tr>
								</thead>
								<tbody class="editor">
									<tr>
										<th>1</th>
										<td>
											<textarea name="evaluationFactor"></textarea>
										</td>
										<td>
											<textarea name="reviewStandard"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th>3</th>
					<td>
						<textarea name="preliminaryReviewType"></textarea>
					</td>
					<td style="padding:0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<th style="width:160px">评审因素</th>
									<th>评审标准</th>
								</tr>
							</thead>
							<tbody class="editor">
								<tr>
									<th>1</th>
									<td>
										<textarea name="evaluationFactor"></textarea>
									</td>
									<td>
										<textarea name="reviewStandard"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${detailReviewTypeList}" var="qualificationReviewType" varStatus="status">
					<tr>
						<th>1</th>
						<td><textarea name="preliminaryReviewType">${qualificationReviewType.preliminaryReviewType}</textarea></td>
						<td style="padding:0px;">
							<table class="mytableStyle">
								<thead>
									<tr>
										<th style="width:50px;">序号</th>
										<th style="width:200px">评审核因素</th>
										<th>评审标准</th>
									</tr>
								</thead>
								<tbody class="editor">
									<c:forEach items="${qualificationReviewType.qualificationReviewList}" var="qualificationRequirement" varStatus="s">
										<tr>
											<th>${s.count}</th>
											<td>
												<textarea name="evaluationFactor">${qualificationRequirement.evaluationFactor}</textarea>
											</td>
											<td>
												<textarea name="reviewStandard">${qualificationRequirement.reviewStandard}</textarea>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th>${fn:length(detailReviewTypeList)+1}</th>
					<td>
						<textarea name="preliminaryReviewType"></textarea>
					</td>
					<td style="padding:0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<th style="width:160px">评审因素</th>
									<th>评审标准</th>
								</tr>
							</thead>
							<tbody class="editor">
								<tr>
									<th>1</th>
									<td>
										<textarea name="evaluationFactor"></textarea>
									</td>
									<td>
										<textarea name="reviewStandard"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>