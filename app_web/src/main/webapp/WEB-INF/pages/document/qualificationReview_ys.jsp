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
			<th style="width:120px;">操作</th>
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
										<th style="width:160px">评审因素</th>
										<th>评审标准</th>
										<th style="width:120px;">操作</th>
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
										<td style="vertical-align: middle;">
											<a class="button small orange none insert" title="插入一行">插入</a><a class="button small red none delete" title="删除当前行">删除</a>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
						<td style="vertical-align: middle;">
						<a class="button small orange none insert" title="插入一行">插入</a><a class="button small red none delete" title="删除当前行">删除</a>
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
										<th style="width:200px">评审核因素</th>
										<th>评审标准</th>
										<th style="width:120px;">操作</th>
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
											<td style="vertical-align: middle;">
												<a class="button small orange none insert" title="插入一行">插入</a><a class="button small red none delete" title="删除当前行">删除</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</td>
						<td style="vertical-align: middle;">
						<a class="button small orange none insert" title="插入一行">插入</a><a class="button small red none delete" title="删除当前行">删除</a>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<%-- <c:set var="rownum" value="0" />
		<c:forEach items="${recruitFile.projectItem.qualificationReviewList}" var="qr" varStatus="status">
			<c:if test="${qr.preliminaryReviewType!=qrType}">
				<c:set var="qrType" value="${qr.preliminaryReviewType}" />
				<c:set var="rownum" value="${rownum+1}" />
				<tr>
					<th>${status.count}</th>
					<td>
						${qrType}
						<input type="hidden" name="preliminaryReviewType" value="${qrType}"/>
					</td>
					<td style="padding:0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<th style="width:200px">评审核因素</th>
									<th>评审标准</th>
									<th style="width:120px;">操作</th>
								</tr>
							</thead>
							<tbody class="editor">
								<c:forEach items="${recruitFile.projectItem.qualificationReviewList}" var="qualificationRequirement" varStatus="s">
									<c:if test="${qrType==qualificationRequirement.preliminaryReviewType}">
										<tr>
											<th>${s.count}</th>
											<td>
												<textarea name="evaluationFactor">${qualificationRequirement.evaluationFactor}</textarea>
											</td>
											<td>
												<textarea name="reviewStandard">${qualificationRequirement.reviewStandard}</textarea>
											</td>
											<td style="vertical-align: middle;">
												<a class="button small orange none insert" title="插入一行">插入</a><a class="button small red none delete" title="删除当前行">删除</a>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test="${fn:length(recruitFile.projectItem.qualificationReviewList)==0}">
			<c:forEach begin="0" end="2" varStatus="status">
				<tr>
					<th>${status.count}</th>
					<td>
						${status.index==0?'形式评审':status.index==1?'资格评审':'响应性评审'}
						<input type="hidden" value="${status.index==0?'形式评审':status.index==1?'资格评审':'响应性评审'}" name="preliminaryReviewType"/>
					</td>
					<td style="padding:0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width:50px;">序号</th>
									<th style="width:160px">评审因素</th>
									<th>评审标准</th>
									<th style="width:120px;">操作</th>
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
									<td style="vertical-align: middle;">
										<a class="button small orange none insert" title="插入一行">插入</a><a class="button small red none delete" title="删除当前行">删除</a>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</c:forEach>
		</c:if> --%>
	</tbody>
</table>