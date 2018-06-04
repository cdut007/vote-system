<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<td class="need">*</td>
	<td>详细评审</td>
	<td id='xxps'>
		<table id="qualificationGroup" class="mytableStyle">
			<thead>
				<tr>
					<th style="width: 30px;">序号</th>
					<th style="width: 50px;">分类</th>
					<th style="width: 50px;">算法</th>
					<th style="width: 680px;">详评项目</th>
				</tr>
			</thead> 
			<tbody class="other">
				<c:forEach items="${evaluationMethodJson.detailedReviewTableJson }"
					var="detailed" varStatus="status">
						<c:if test="${detailed.fennei=='报价部分'||detailed.fennei=='评标价'||detailed.fennei=='投标报价' }">
						<tr>
							<th>${status.count}</th>
							<td>${detailed.fennei }<input type="hidden" name="groupFlag"
								value="price" class="groupFlag" /><input type="hidden"
								name="firstGroup" value="${detailed.fennei}" class="firstGroup" /></td>
							<td>${detailed.suanfa=='pingjun'?'平均法':'去掉最高最低再平均' }</td>
							<td>
								<table id="scoreGroup1" class="mytableStyle">
									<thead>
										<tr>
											<th style="width: 35px;">序号</th>
											<th style="width: 65px;">分值构成</th>
											<th style="width: 65px;">是否合议</th>
											<th style="width: 60px">分值(分)</th>
											<th style="width: 550px;">详细</th>
										</tr>
									</thead>
									<tbody class="other">
										<c:forEach items="${detailed.xiangPingXiangMu}"
											var="xiangPingXiangMu">
											<tr>
												<th>1</th>
												<td><input type="hidden" name="flag" value="price" /><input
													type="hidden" name="groupName"
													value="${detailed.fennei }" />${xiangPingXiangMu.fenZhiGouCheng }</td>
												<td><input type="hidden" name="needUnify" value="${xiangPingXiangMu.shiFouHeYi=='no'?0:1}" />${xiangPingXiangMu.shiFouHeYi=='no'?'否':'是'}</td>
												<td><input name="groupFullScore" class="tr inputxt"  readonly="readonly"
													value="<fmt:formatNumber value="${xiangPingXiangMu.score}" minFractionDigits="2"/>" /></td>
												<td style="text-align:left;padding:3px;padding:0px;" id="price" >${xiangPingXiangMu.detail}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</td>
						</tr>
					</c:if>
					</c:forEach>
			</tbody>
			<tbody class="editor">
				<c:forEach items="${evaluationMethodJson.detailedReviewTableJson }"
					var="detailed" varStatus="status">
					<c:if test="${detailed.fennei!='报价部分'&&detailed.fennei!='评标价'&&detailed.fennei!='投标报价' }">
						<tr>
							<th>${detailed.id}</th>
							<td><input type="hidden" name="groupFlag"  readonly="readonly"
								value="${detailed.fennei }" /> <textarea name="firstGroup" readonly="readonly">${detailed.fennei }</textarea></td>
							<td><select name="groupAlgorithm"><option
										value="${detailed.suanfa=='pingjun'?0:1 }" selected>${detailed.suanfa=='pingjun'?'平均法':'去掉最高最低再平均' }</option></select></td>
							<td>
								<table id="scoreGroup2" class="mytableStyle">
									<thead>
										<tr>
											<th style="width: 35px;">序号</th>
											<th style="width: 65px;">分值构成</th>
											<th style="width: 65px;">是否合议</th>
											<th style="width: 60px">分值(分)</th>
											<th style="width: 555px;">详细</th>
										</tr>
									</thead>
									<tbody class="editor">
										<c:forEach items="${detailed.xiangPingXiangMu}"
											var="xiangPingXiangMu">
											<tr>
												<th>${xiangPingXiangMu.id}</th>
												<td><input type="hidden" name="flag"  readonly="readonly"
													value="${xiangPingXiangMu.fenZhiGouCheng}" /> <textarea readonly="readonly"
														name="groupName">${xiangPingXiangMu.fenZhiGouCheng}</textarea></td>
												<td><select name="needUnify" class="inputxt"
													defaultValue="0">
														<option value="${xiangPingXiangMu.shiFouHeYi=='no'?0:1}" 
															selected>${xiangPingXiangMu.shiFouHeYi=='no'?'否':'是'}</option>
												</select></td>
												<td><input name="groupFullScore" class="tr inputxt"  readonly="readonly"
													value="<fmt:formatNumber value="${xiangPingXiangMu.score}" minFractionDigits="2"/>" /></td>
												<td style="padding: 0px;">
													<table class="mytableStyle">
														<thead>
															<tr>
																<th style="width: 50px;">序号</th>
																<th>评审因素</th>
																<th>评审标准</th>
																<th style="width: 50px">分值(分)</th>
															</tr>
														</thead>
														<tbody class="editor">
															<c:forEach items="${xiangPingXiangMu.detail}"
																var="detail">
																<tr>
																	<th>${detail.id}</th>
																	<td><textarea name="evaluationFactor"  readonly="readonly">${detail.psys}</textarea></td>
																	<td><textarea name="reviewStandard"  readonly="readonly" >${detail.psbz}</textarea></td>
																	<td><input name="itemFullScore" class="tr inputxt"  readonly="readonly"
																		value="<fmt:formatNumber value="${detail.score}" minFractionDigits="2"/>"
																		datatype="number" minFractionDigits="2"
																		limit="(0,100)" /></td>
																</tr>
															</c:forEach>
														</tbody>
														<tbody class="statistics">
															<tr>
																<th>小计</th>
																<td></td>
																<td></td>
																<td><input class="tr inputxt"  readonly="readonly"
																		value="<fmt:formatNumber value="${xiangPingXiangMu.score}" minFractionDigits="2"/>"
																		datatype="number" minFractionDigits="2"
																		limit="(0,100)" /></td>
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
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</td>
 
<script type="text/javascript">
var reviewMode="${evaluationMethodJson.reviewMode}";
var methodName="${evaluationMethodJson.methodName}";
var benchmarkPriceId="${evaluationMethodJson.benchmarkPriceId}";
var benchmarkPrice="${evaluationMethodJson.benchmarkPrice}";
var evaluationMethodId="${evaluationMethodJson.evaluationMethodId}";
var evaluationMethod="${evaluationMethodJson.evaluationMethod}";
var groupDesignLowestPercent="${evaluationMethodJson.groupDesignLowestPercent}";
var pullDownPercent="${evaluationMethodJson.pullDownPercent}";
$("#evaluationType").html("<option value="+evaluationMethodId+" label="+evaluationMethod+" select/>");
$("#recruitFileData_evaluationMethodId").val(evaluationMethodId);
$("#evaluationMethodId").html("<option value="+benchmarkPriceId+" label="+benchmarkPrice+"/>");
if(groupDesignLowestPercent.length!=0){
	$("#CMPRate_tr").show();
	$("#CMPRate").val(groupDesignLowestPercent.replace("%",""));
}
if(pullDownPercent.length!=0){
	$("#floatRate_tr").show();
	$("#floatRate").val(pullDownPercent.replace("%",""));
}


</script>
