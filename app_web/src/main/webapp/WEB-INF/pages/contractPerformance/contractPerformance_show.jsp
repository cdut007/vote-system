<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/contractPerformance/contractPerformance.js"></script>
<script type="text/javascript">
	

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			合同和履约管理
			<code>&gt;</code>
			查看合同和履约
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				查看合同和履约
			</h4>
			<div class="blank10"></div>
			<form:form id="contractForm" method="post" action='${pageContext.request.contextPath}/contract/saveOrUpdateContractPerformance' modelAttribute="contractPerformance" onsubmit="return $(this).form('validate');">
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id"/>
				<input type="hidden" id="projectInstanceId" name="projectInstanceId" value="${projectInstance.id}"/>
				
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%">项目标段（包）：</td>
						<td colspan="4">
							${contractPerformance.projectItem.bdmc00}					
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:100px;">合同名称：</td>
						<td>
							${contractPerformance.contractName}
						</td>
					</tr>
					
					<!-- 以下为手动输入内容 -->
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:100px;">合同金额：</td>
						<td>
							${contractPerformance.contractPrice} 万元
						</td>
						<td class="need" style="width:10px;"></td>
						<td style="width:100px;">合同结算金额：</td>
						<td>
							${contractPerformance.settlePrice} 万元
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:100px;">合同期限：</td>
						<td>
							${contractPerformance.contractPeriod} 年
						</td>
						<td class="need"></td>
						<td style="width:100px;">质量要求：</td>
						<td>
							${contractPerformance.qualityRequire}
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:100px;">合同完成时间：</td>
						<td>${contractPerformance.finishTime}</td>
 					
						<td class="need"></td>
						<td style="width:100px;">实际履约期限：</td>
						<td>
							${contractPerformance.actuallyPeriod} 年
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:100px;">递交时间：</td>
						<td>${contractPerformance.submitTime}</td>
					
						<td class="need"></td>
						<td style="width:100px;">合同签署时间：</td>
						<td>${contractPerformance.contractSignTime}</td>
					</tr>
					<tr>
						
						<td class="need"></td>
						<td style="width:100px;">履约信息：</td>
						<td>
							${contractPerformance.performInfo}
						</td>
					</tr>
					<tr>
						<td class="need"></td>
						<td style="vertical-align:middle">合同主要内容:</td>
						<td colspan='4'>
							${contractPerformance.contractContent}
						</td>
					</tr>
					<tr>
						<td class="need"></td>
						<td style="vertical-align:middle">履约变更内容:</td>
						<td colspan='4'>
							${contractPerformance.performChangeContent}
						</td>
					</tr>
				</table>
				
				<!-- <div class="blank10"></div>
				<input type="hidden" id='sealName' name="sealName" value="SigndataStr"/>
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataStrSealName' name="SigndataStrSealName" />
				<input type="hidden" id='SigndataStrSignData' name="SigndataStrSignData" /> -->
				<div class="blank10"></div>
				<div class="blank10"></div>
				<div class="blank10"></div>
			</form:form>

				<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
		</div>
	</div>
</body>
</html>