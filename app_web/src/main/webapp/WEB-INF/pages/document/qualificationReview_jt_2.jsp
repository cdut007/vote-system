<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<table id="qualificationReview" class="mytableStyle"> 
		<thead>
			<tr> 
				<th style="width: 35px;">序号</th>
				<th style="width: 80px;">评审类型</th>
				<th>评审内容</th>
			</tr>
		</thead>
		<tbody class="editor">
			<c:forEach items="${evaluationMethodJson.preliminaryReviewTableJsonTwo}"
				var="preliminaryReviewTableJson" >
				<tr>
					<th>${preliminaryReviewTableJson.id}</th>
					<td><textarea name="preliminaryReviewType" readonly="readonly">${preliminaryReviewTableJson.pslx}</textarea>
					</td>
					<td style="padding: 0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width: 50px;">序号</th>
									<th style="width: 160px">评审因素与评审标准</th>
								</tr>
							</thead>
							<tbody class="editor">
								<c:forEach items="${preliminaryReviewTableJson.psnr}"
									var="qualificationReviewType" >
									<tr>
										<th>${qualificationReviewType.id}</th>
										<td><textarea name="evaluationFactor" readonly="readonly">${qualificationReviewType.psbz }</textarea>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
