<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<td class="need">*</td>
<td style="width: 100px">详细评审</td>
<td id="xxps">
	<table id="passDetailReview" class="mytableStyle">
		<thead> 
			<tr>
				<th style="width: 35px;">序号</th>
				<th style="width: 112px;">评审类型</th>
				<th>评审内容</th>
			</tr>
		</thead>
		<tbody class="editor">
			<c:forEach items="${evaluationMethodJson.detailedReviewTableJson}"
				var="detailed" varStatus="status">
				<tr>
					<th>${detailed.id }</th>
					<td><textarea name="preliminaryReviewType" readonly="readonly">${detailed.pslx}</textarea></td>
					<td style="padding: 0px;">
						<table class="mytableStyle">
							<thead>
								<tr>
									<th style="width: 50px;">序号</th>
									<th style="width: 200px">评审核因素</th>
									<th>评审标准</th>
								</tr>
							</thead>
							<tbody class="editor">
								<c:forEach items="${detailed.psnr}" var="psnr" varStatus="s">
									<tr>
										<th>${psnr.id}</th>
										<td><textarea name="evaluationFactor" readonly="readonly">${psnr.psys}</textarea>
										</td>
										<td><textarea name="reviewStandard" readonly="readonly">${psnr.psbz}</textarea>
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
</td>
