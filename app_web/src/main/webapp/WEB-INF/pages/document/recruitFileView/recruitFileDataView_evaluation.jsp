<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set var="templateList" value="${templateService.retrieveTemplateList(CURRENT_USER_SESSION_INFO.id)}" scope="request" />
<c:set var="evaluationMethodList" value="${evaluationMethodService.createEvaluationMethodQuery().list()}" scope="request" />
<c:set var="benchmarkList" value="${benchmarkService.createBenchmarkQuery().list()}"></c:set>
<c:set var="uniqueMethodId" value="${recruitFile.evaluationMethodInstance.evaluationMethod.uniqueMethodId}"></c:set>


<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 招标文件基本信息
author: ZORO
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>招标文件信息</title>
<sys:link easyui="true" jgrowl="true" datepicker="true" plupload="true"/>
<!-- <script type="text/javascript" src="/resources/page/document/recruitFileDataEdit_step.js"></script> -->
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
</style>


</head>

<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">项目管理</a>
			<code>&gt;</code>
			招标文件信息
		</div>
	</div>
	<div class="block">
		<form:form id="zbwjForm" method="post" action="${pageContext.request.contextPath}/flow/completeTask" modelAttribute="recruitFile">
	
			<input type="hidden" name="token" value="${token}" />
			<input type="hidden" name="envelopeTypeOrder" value="${recruitFile.nextStep == '2_1' ? 'first':'second'}" />
			<input type="hidden" name="nextStep" value="${recruitFile.nextStep}" />
			<input type="hidden" id="id" name="id" value="${recruitFileIds}" />
			
			<div class="easyui-panel" data-options="title:'项目概况',collapsible:true">
				<table style="width:98%;table-layout:fixed;margin:0 auto;">
					<tbody>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标编号</td>
							<td>${projectInstance.zbxmbh}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标项目名称</td>
							<td>${projectInstance.zbxmmc}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标人</td>
							<td>${projectInstance.project.organ.ztmc00}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标方式</td>
							<td>${util:dictionary('ZBFS00',projectInstance.zbfs00)}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标组织形式</td>
							<td>${util:dictionary('ZBZZXS',projectInstance.zbzzxs)}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>资金来源</td>
							<td>${projectInstance.project.funding}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>
								招标内容与范围
								<!-- (项目概况) -->
							</td>
							<td>${projectInstance.nryfw0}</td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			
					<div class="easyui-panel" data-options="title:'${recruitFile.nextStep == '2_1' ? '第一':'第二'}信封评标办法',collapsible:true">
					        <table width="98%" style="table-layout:fixed;margin:0 auto;">
								<tbody>	
										
								
									<tr>
										<td class="need">*</td>
										<td style="width:100px">${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}</td>
										<td>
											<jsp:include page="qualificationView.jsp" />
										</td>
									</tr>
									<c:if test="${recruitFile.nextStep == '2_1' || (recruitFile.nextStep == '2_2' && 'JT_LOWEST_PRICE_METHOD'!=uniqueMethodId && 'JT_TECH_SCORE_LOWEST_PRICE_METHOD'!=uniqueMethodId)}">
										<tr>
											<td class="need">*</td>
											<td style="width:100px">详细评审模式</td>
											<td>
												<form:select id="reviewMode" path="recruitFileData.reviewMode">
													<form:option value="SCORE" label="分数制"/>
													<c:if test="${'JT_TECH_SCORE_LOWEST_PRICE_METHOD'!=recruitFile.evaluationMethodInstance.evaluationMethod.uniqueMethodId && 'JT_ZHPF_METHOD'!=recruitFile.evaluationMethodInstance.evaluationMethod.uniqueMethodId}">
														<form:option value="PASS" label="通过制"/>
													</c:if>
												</form:select> 
												<%-- <label id="reviewMode" value="SCORE">分数制</label>--%>
											</td>
										</tr>
										<tr>
											<td class="need">*</td>
											<td>详细评审</td>
											<td>
												<jsp:include page="scoreGroupView_one.jsp" />
												<jsp:include page="qualificationView_one.jsp" />
											</td>
										</tr>
									</c:if>
									<c:if test="${recruitFile.nextStep == '2_2' && ('JT_LOWEST_PRICE_METHOD'==uniqueMethodId || 'JT_TECH_SCORE_LOWEST_PRICE_METHOD'==uniqueMethodId)}">
										<tr>
											<td class="need">*</td>
											<td style="width:100px">详细评审模式</td>
											<td>
												${recruitFile.evaluationMethodInstance.evaluationMethodName}
											</td>
										</tr>
									
									</c:if>
								</tbody>
							</table>
					 
					 
					</div>		
					
	
			<div class="blank10"></div>
			<input id="return_" type="button" class="button red" value="上一步"   onclick="history.go(-1)" />
		
			<c:if test="${recruitFile.nextStep=='2_1'}">	
				<input type="button" class="button red" value="下一步" onclick="window.location.href='/recruitFileData/viewRecruitFileEnvelop?id=${recruitFile.id}&nextStep=2_2'"/>
			</c:if>
			<c:if test="${recruitFile.nextStep=='2_2'}">	
				<input type="button" class="button gray" value="保存" />			
				<input type="button" class="button gray" value="提交" />
			</c:if>
		</form:form>
	</div>
	<div class="blank10"></div>
	
	<script>
		var uniqueMethodId = "${recruitFile.evaluationMethodInstance.evaluationMethod.uniqueMethodId}";
		if(uniqueMethodId == "JT_TECH_SCORE_LOWEST_PRICE_METHOD" || uniqueMethodId=="JT_ZHPF_METHOD"){
			$("#reviewMode").val("SCORE");
		}
	</script>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>