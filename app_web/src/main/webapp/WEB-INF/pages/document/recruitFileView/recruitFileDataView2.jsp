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
<%-- recruitFileDataView2　预审文件查看
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
<script type="text/javascript" src="/resources/page/document/recruitFileView.js"></script>
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
.padding0{padding:0px;}
.redborder{border: 1px solid red;}
.select600 {width:600px;}
</style>

<script>

	window.onload=function(){
		
		if("${isYS}" == "true"){
			$("#applyDateBegin").val('');
			$("#applyDateEnd").val('');
			$("#bidDeadline").val('');
			$("#bidOpenDate").val('');
		}
		
		if("${ZFZJ}"=="true"){
			$("#TJHXR").hide();
			$("#QD").attr("checked","checked");
			$("#candidateNum").val('1');
			//$("#TJ").attr('disabled','disabled');
			//$("#TJ").attr('disabled');
		}
	}
	
	var ZFZJ = "${ZFZJ}";
	var isPrejudication = "${recruitFile.isPrejudication}";
	var prereviewType="${projectInstance.prereviewType}";
</script>

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
			<span title="预审招标文件信息">招标文件信息</span>
		</div>
	</div>
	<div class="block">
		<form:form id="zbwjForm" method="post" action="${pageContext.request.contextPath}/flow/completeTask" modelAttribute="recruitFile">
			<input id="ZFZJ" type="hidden" value="${ZFZJ}"/>
			<input id="isPrejudication" type="hidden" value="${recruitFile.isPrejudication}"/>
			<c:if test="${not (recruitFile.reviewStatus=='0' or recruitFile.reviewStatus=='1' or recruitFile.reviewStatus=='9' or recruitFile.reviewStatus=='91')}">
				<div class="easyui-panel" data-options="collapsible:true,title:'申请状态',border:false">
					<table class="mytableStyle">
						<tr>
							<th width="150px;">审核结果：</th>
							<td>
								<span class="f1">${util:dictionary('GGZT',recruitFile.reviewStatus)}</span>
							</td>
						</tr>
						<tr>
							<th>审核不通过原因</th>
							<td>${recruitFile.nopassReason}</td>
						</tr>
					</table>
				</div>
			</c:if>
			<div class="blank10"></div>
			<input type="hidden" name="token" value="${token}" />
			<form:hidden path="id" />
			<form:hidden path="isPrejudication" />
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
						<%-- <tr>
							<td class="need"></td>
							<td>资格审查方式</td>
							<td>${util:dictionary('ZGSHFS',projectInstance.zgshfs)}</td>
						</tr> --%>
						<tr>
							<td class="need"></td>
							<td>标段（包）</td>
							<td>
								<c:choose>
									<c:when test="${empty recruitFile.projectItemId}">
										<table id="projectItem" class="mytableStyle">
											<thead>
												<tr>
													<th style="width:20px;">
														<!-- <input type="checkbox"/> -->
													</th>
													<th style="width:80px">标段名称</th>
													<th>(交货/施工/服务)内容</th>
													<th>交货期/工期/服务期<%-- ${projectInstance.tenderProjectClassifyCode=='A'?'工期':projectInstance.tenderProjectClassifyCode=='B'?'交货期':'服务期'} --%></th>
													<th style="width:80px">标段分类</th>
													<th style="width:100px">预算价</th>
													<th style="width:80px">单位</th>
													<th style="width:80px">币种</th>
													<th style="width:80px">标书售价(元)</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${projectItemList}" var="projectItem">
													<tr>
														<td style="width:20px;">
															<input type="checkbox" value="${projectItem.id}" name="projectItemId" />
														</td>
														<%-- <td>${projectItem.bdbh00}</td> --%>
														<input type="hidden" value="${projectItem.projectInstanceId}" id="projectInstanceId" />
														<td>${projectItem.bdmc00}</td>
														<td>${projectItem.bdnr00}</td>
														<td>${projectItem.deliveryTimeLimit}</td>
														<td>${util:dictionary('PROJECT_ITEM_TYPE',projectItem.projectItemType)}</td>
														<td>${projectItem.bdhtgj}</td>
														<td>${util:dictionary('JEDWDM',projectItem.bdgjdw)}</td>
														<td>${util:dictionary('CURRENCY',projectItem.bdgjdm)}</td>
														<td>${projectItem.price}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<form:hidden path="projectItemId" />
										<table id="projectItem" class="mytableStyle">
											<thead>
												<tr>
													<!-- <th style="width:50px;">编号</th> -->
													<th style="width:80px">标段名称</th>
													<th>(交货/施工/服务)内容</th>
													<th>交货期/工期/服务期<%-- ${projectInstance.tenderProjectClassifyCode=='A'?'工期':projectInstance.tenderProjectClassifyCode=='B'?'交货期':'服务期'} --%></th>
													<th style="width:80px">标段分类</th>
													<th style="width:100px">预算价</th>
													<th style="width:80px">单位</th>
													<th style="width:80px">币种</th>
													<th style="width:80px">标书售价(元)</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<%-- <td>${recruitFile.projectItem.bdbh00}</td> --%>
													<input type="hidden" value="${recruitFile.projectItem.projectInstanceId}" id="projectInstanceId" />
													<input type="hidden" value="${recruitFile.projectItem.id}" id="projectItemId" />
													<td>${recruitFile.projectItem.bdmc00}</td>
													<td>${recruitFile.projectItem.bdnr00}</td>
													<td>${recruitFile.projectItem.deliveryTimeLimit}</td>
													<td>${util:dictionary('PROJECT_ITEM_TYPE',recruitFile.projectItem.projectItemType)}</td>
													<td>${recruitFile.projectItem.bdhtgj}</td>
													<td>${util:dictionary('JEDWDM',recruitFile.projectItem.bdgjdw)}</td>
													<td>${util:dictionary('CURRENCY',recruitFile.projectItem.bdgjdm)}</td>
													<td>${recruitFile.projectItem.price}</td>
												</tr>
											</tbody>
										</table>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<%-- 
						<tr>
							<td class="need">*</td>
							<td>交货期/工期/服务期</td>
							<td>
								<c:forEach items="projectItemList" var="item">
									<p>${item.bdmc00}:${item.deliveryTimeLimit}</p>
								</c:forEach>
							</td>
						</tr> 
						--%>
						<tr>
							<td class="need">*</td>
							<td>(交货/施工/服务)地点</td>
							<td>
								<form:textarea path="tenderNoticeData.deliveryPlace" cssClass="easyui-validatebox" style="width:100%;" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			<c:choose>
			<c:when test="${recruitFile.isPrejudication == true}">
				<div class="easyui-panel" data-options="title:'资格预审文件',collapsible:true">
					<table width="98%" style="table-layout:fixed;margin:0 auto;">
						<tbody>
							<tr>
								<td class="need">*</td>
								<td style="width:100px">申请资格</td>
								<td>
									<form:textarea path="applyQualification" cssClass="easyui-validatebox" data-options="required:true" style="width:100%;" />										
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td style="width:100px">文件开启方法：</td>
								<td>
									<form:textarea path="fileOpenMethod" cssClass="easyui-validatebox" data-options="required:true" style="width:100%;" />										
									
								</td>
							</tr>
								<tr>
								<td class="need">*</td>
								<td style="width:100px">已发布招标文件</td>
								<td>
									<select id="zbwj"  name="advanceTenderFileId" class="select600">
									</select>
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td style="width:100px">资格预审文件获取时间</td>
								<td>
									<fmt:formatDate value="${recruitFile.tenderNoticeData.applyDateBegin}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
									
									<%-- ${recruitFile.tenderNoticeData.applyDateBegin} --%>
									<%--<form:hidden id="applyDateBegin" path="tenderNoticeData.applyDateBegin" /> --%>
									<%-- <fmt:formatDate value="${recruitFile.tenderNoticeData.applyDateBegin}" type="both" pattern="yyyy-MM-dd hh:mm:ss"/> --%>
									至

									<fmt:formatDate value="${recruitFile.tenderNoticeData.applyDateEnd}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
									<%--${recruitFile.tenderNoticeData.applyDateEnd}--%>
									<%-- <fmt:formatDate value="${recruitFile.tenderNoticeData.applyDateEnd}" type="both" pattern="yyyy-MM-dd hh:mm:ss"/> --%>
									<%-- <form:hidden id="applyDateEnd" path="tenderNoticeData.applyDateEnd" /> --%>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</c:when>
			</c:choose>
			<div class="blank10"></div>
			<table id="attachmentUpload"></table>			
			
			<div class="blank10"></div>
			<c:choose>
			<c:when test="${recruitFile.isPrejudication == true}">
				<div class="easyui-panel" data-options="title:'预审申请文件',collapsible:true">
					<table width="98%" style="table-layout:fixed;margin:0 auto;">
						<tbody>
							<tr>
								<td class="need">*</td>
								<td style="width:100px">申请有效期</td>
								<td>
									<form:input path="recruitFileData.bidValidity" cssClass="inputxt tr easyui-numberbox" data-options="required:true" />天
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td>申请截止时间</td>
								<td>
									<fmt:formatDate value="${recruitFile.tenderNoticeData.bidDeadline}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
									<%--${recruitFile.tenderNoticeData.bidDeadline}--%>
									<%-- <fmt:formatDate value="${recruitFile.tenderNoticeData.bidDeadline}" type="both" pattern="yyyy-MM-dd hh:mm:ss"/> --%>
									<%-- <form:hidden id="bidDeadline" path="tenderNoticeData.bidDeadline" /> --%>
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td>答疑澄清截止时间</td>
								<td>
									<fmt:formatDate value="${recruitFile.clarifytime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td>申请文件递交方法:</td>
								<td>
									<form:textarea path="tenderNoticeData.bidSendForm" cssClass="easyui-validatebox" style="width:100%;" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</c:when>
			</c:choose>

			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'开标信息',collapsible:true">
				<table width="98%" style="table-layout:fixed;margin:0 auto;">
					<tbody>
						<tr>
							<td class="need">*</td>
							<td style="width:100px">开标时间</td>
							<td>
								<%-- <c:if test="${empty recruitFile.tenderNoticeData.bidOpenDate }"> --%>
									<fmt:formatDate value="${recruitFile.tenderNoticeData.bidOpenDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
								
								<%-- </c:if> --%>
								<%-- <c:if test="${not empty recruitFile.tenderNoticeData.bidOpenDate }">
								${recruitFile.tenderNoticeData.bidOpenDate}
									<fmt:formatDate value="${recruitFile.tenderNoticeData.bidOpenDate}" type="both" pattern="yyyy-MM-dd hh:mm:ss"/>
									<form:hidden id="bidOpenDate" path="tenderNoticeData.bidOpenDate" />
								</c:if> --%>
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>开标地点</td>
							<td>
								<form:textarea path="tenderNoticeData.bidOpenPlace" cssClass="easyui-validatebox" data-options="required:true" style="width:100%;" />
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>开标方式</td>
							<td>
								<form:textarea path="recruitFileData.bidOpenForm" cssClass="easyui-validatebox" data-options="required:true" style="width:100%;" />
							</td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>评标委员会组建:</td>
							<td>
								<table style="width:100%;">
									<tbody>
										<tr>
											<td style="width:100px;">招标人代表</td>
											<td>
											<sys:number id="UserNum" name="recruitFileData.juryTUserNum" style="width:100px" value="${recruitFile.recruitFileData.juryTUserNum}" precision="0"  />
											人</td>
										</tr>
										<tr>
											<td>专家</td>
											<td>
											<sys:number id="ExpertNum" name="recruitFileData.juryExpertNum" style="width:100px" value="${recruitFile.recruitFileData.juryExpertNum}" precision="0" required="true" />
											人</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<%--<c:if test="${recruitFile.projectInstance.prereviewType == '1'}">
						<tr>
							<td class="need">*</td>
							<td>通过资格预审人数:</td>
							<td><form:input path="passTenders" cssClass="inputxt tr easyui-numberbox" data-options="required:true" />人</td>
						</tr>
						</c:if> --%>
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'评标办法',collapsible:true">
				<table width="98%" style="table-layout:fixed;margin:0 auto;">
					<tbody>
					
						<tr>
							<td class="need">*</td>
							<td style="width:100px">初步评审</td>
							<td>
								<jsp:include page="qualificationView.jsp" />
							</td>
						</tr>
						
						<c:choose>
						<c:when test="${projectInstance.prereviewType == '2'}">
							<tr>
								<td class="need">*</td>
								<td style="width:100px">详细评审</td>
								<td class="redborder">
									<jsp:include page="qualificationView3.jsp" />
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="need">*</td>
								<td>详细评审</td>
								<td>
									<jsp:include page="scoreGroupView1.jsp" />
								</td>
							</tr>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>

			<div class="blank10"></div>
			<c:if test="${recruitFile.reviewStatus=='19' || recruitFile.reviewStatus=='0' || recruitFile.reviewStatus=='2' || recruitFile.reviewStatus=='3' || recruitFile.reviewStatus=='4'}">
				<input type="button" class="button gray" value="保 存草稿" />
				<input type="button" class="button gray" value="提交审核" />
			</c:if>
			<a class="button orange" onclick="history.go(-1)">返回</a>
			<input type="hidden" id="attachmentSsztId" value="${recruitFile.id}"/>
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
<!-- 	<script src="/resources/page/recruit/recruitFile.js" type="text/javascript"></script>  -->
</body>
</html>