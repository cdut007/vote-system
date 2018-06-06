<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set var="templateList" value="${templateService.retrieveTemplateList(CURRENT_USER_SESSION_INFO.id)}" scope="request" />
<c:set var="evaluationMethodList" value="${evaluationMethodService.createEvaluationMethodQuery().list()}" scope="request" />
<c:set var="benchmarkList" value="${benchmarkService.findFrontTBBenchmarks()}"></c:set>
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
<script type="text/javascript" src="/resources/page/document/recruitFileView.js"></script>
<style type="text/css">
#bigJE {
	color: #f00;
	font-size: 14px;
	font-weight: 900
}
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
			招标文件信息
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
			<input type="hidden" name="nextStep" value="2_1" />
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
									<td style="width:100px">资格预审文件获取时间</td>
									<td>
										<form:input path="tenderNoticeData.applyDateBegin" id="applyDateBegin" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="ltTime['#applyDateEnd','资格预审文件获取开始时间不能大于截止时间']" />
										
										至
										<form:input path="tenderNoticeData.applyDateEnd" id="applyDateEnd" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="gtTime['#applyDateBegin','资格预审文件获取截止时间不能小于开始时间']"/>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:when>
				<c:otherwise>
					<div class="easyui-panel" data-options="title:'招标文件',collapsible:true">
						<table width="98%" style="table-layout:fixed;margin:0 auto;">
							<tbody>
								<tr>
									<td class="need">*</td>
									<td style="width:100px">已发布招标文件</td>
									<td>
										<select id="zbwj"  name="advanceTenderFileId">
										</select>
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td style="width:100px">招标文件获取时间</td>
									<td>
										<form:input path="tenderNoticeData.applyDateBegin" id="applyDateBegin" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="ltTime['#applyDateEnd','招标文件获取时间不能大于截止时间']" />
										
										至
										<form:input path="tenderNoticeData.applyDateEnd" id="applyDateEnd" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="gtTime['#applyDateBegin','招标文件获取截止时间不能小于开始时间']"/>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:otherwise>
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
										<form:input id="bidDeadline" path="tenderNoticeData.bidDeadline" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="gtTime['#applyDateEnd','投标截止时间不能小于招标文件获取截止时间']" />
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>答疑澄清截止时间</td>
									<td>
										<form:input id="clarifytime" path="clarifytime" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true"  />
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
				<c:otherwise>
					<div class="easyui-panel" data-options="title:'投标文件',collapsible:true">
						<table width="98%" style="table-layout:fixed;margin:0 auto;">
							<tbody>
								<tr>
									<td class="need">*</td>
									<td style="width:100px">投标有效期</td>
									<td>
										<form:input path="recruitFileData.bidValidity" cssClass="inputxt tr easyui-numberbox" data-options="required:true" />天
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>投标截止时间</td>
									<td>
										<form:input id="bidDeadline" path="tenderNoticeData.bidDeadline" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="gtTime['#applyDateEnd','投标截止时间不能小于招标文件获取截止时间']" />
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>答疑澄清时间</td>
									<td>
										<form:input id="clarifytime" path="clarifytime" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true"  />
									</td>
								</tr>
								<tr>
									<td></td>
									<td>控制价(最高限价)</td>
									<td>
										<form:input id="controlPrice" path="controlPrice" cssClass="inputxt  easyui-validatebox" type="number"  />(元)
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>投标保证金</td>
									<td>
										<table style="width:100%;">
											<tbody>
												<tr>
													<td style="width:150px;"><input type="radio" id="bidDepositType" name="recruitFileData.bidDepositType" value="0"  disabled="true" ${recruitFile.recruitFileData.bidDepositType=='0'?"checked='checked'":''}/>投标报价百分比</td>
													<td>
														<div id="baifenzhi">
															<form:input id="bidDepositValue" path="recruitFileData.bidDepositValue" cssClass="inputxt easyui-numberbox" data-options="required:true" style="width:80px" max="2" precision="2" disabled="true" />% (暂不支持)
														</div>
													</td>
												</tr>
												<tr>
													<td><input type="radio" id="bidDepositTypes" name="recruitFileData.bidDepositType" value="1" ${recruitFile.recruitFileData.bidDepositType=='1'?"checked='checked'":''}/>固定金额</td>
													<td>
														<div id="dingzhi">
															<sys:number id="bidDepositAmount" name="recruitFileData.bidDepositAmount" style="width:100px" value="${recruitFile.recruitFileData.bidDepositAmount}" precision="2" required="true" onChange="function(oldValue,newValue){$('#bidDepositUnit').change();}"  />
															<form:select id="bidDepositUnit" path="recruitFileData.bidDepositUnit" style="width:80px" disabled="${recruitFile.recruitFileData.bidDepositType=='0'}">
																<form:options items="${util:dictionaryTree('JEDWDM',false)}" itemValue="itemCode" itemLabel="itemName"></form:options>
															</form:select>
															<%-- <form:select id="bidDepositCurrency" path="recruitFileData.bidDepositCurrency" style="width:80px" disabled="${recruitFile.recruitFileData.bidDepositType=='0'}">
																<form:options items="${util:dictionaryTree('CURRENCY',false)}" itemValue="itemCode" itemLabel="itemName" />
															</form:select> --%>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
								<%--<tr>
									<td class="need">*</td>
									<td>保证金支付方式</td>
									<td>
										<input type="radio" name="payType" value="1" ${recruitFile.payType!="0"?"checked":""} />支付给平台
										<input type="radio" name="payType" value="0" ${recruitFile.payType=="0"?"checked":""}/>支付给代理机构
									</td>
								</tr>--%>
								<tr id="jindaxie" ${recruitFile.recruitFileData.bidDepositType=='0'?"style='display:none'":''}>
									<td class="need"></td>
									<td>金额大写</td>
									<td style="text-align:left">
										<span id="bigJE"></span>
									</td>
								</tr>
								<tr>
									<td class="need">*</td>
									<td>投标文件递交方法:</td>
									<td>
										<form:textarea path="tenderNoticeData.bidSendForm" cssClass="easyui-validatebox" data-options="required:true" style="width:100%;" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="blank10"></div>
			<c:if test="${recruitFile.isPrejudication == false}">
				<c:choose>
					<c:when test="${isYS == true}">
					<div id="invitation_div">
						<div class="easyui-panel" data-options="title:'投标邀请',collapsible:true" >
							<table width="98%" style="table-layout:fixed;margin:0 auto;">
								<tbody>
									<tr>
										<td class="need">*</td>
										<td style="width:100px">投标资格</td>
										<td>
											<textarea id="bidQualification"  name="invitation.bidQualification" value="${invitation.bidQualification}" style="width:50%; height:30px;"  class="inputxt easyui-validatebox" data-options="required:true" >${invitation.bidQualification}</textarea>
										</td>								
									</tr>
									<tr>
										<td class="need">*</td>
										<td style="width:100px">回复截止时间</td>
										<td>
											<input id="inviteEndTime" type="text" value="${invitation.inviteEndTime}" name="invitation.inviteEndTime" class="inputxt Wdate easyui-validatebox" data-options="required:true" ></input>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</c:when>
					
				</c:choose>
				
			</c:if>
			
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'开标信息',collapsible:true">
				<table width="98%" style="table-layout:fixed;margin:0 auto;">
					<tbody>
						<tr>
							<td class="need">*</td>
							<td style="width:100px">开标时间</td>
							<td>
									
									<form:input id="bidOpenDate" path="tenderNoticeData.bidOpenDate" cssClass="inputxt Wdate easyui-validatebox" data-options="required:true" validType="gtTime['#applyDateEnd','开标时间不能小于招标文件获取截止时间']" />
								
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
											<td><form:input id="UserNum" path="recruitFileData.juryTUserNum" cssClass="inputxt easyui-validatebox" data-options="required:true"/>人</td>
										</tr>
										<tr>
											<td>专家</td>
											<td><form:input id="ExpertNum" path="recruitFileData.juryExpertNum" cssClass="inputxt easyui-validatebox" data-options="required:true"/>人</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'评标办法',collapsible:true">
				<table width="98%" style="table-layout:fixed;margin:0 auto;">
					<tbody>
						<c:if test="${recruitFile.isPrejudication == false}">
							<tr>
								<td class="need">*</td>
								<td style="width:100px">评标信封:</td>
								<td>
									<select id="envelopeType" name="envelopeType">
										<option value="two" label="双信封"/>
									</select>
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td>评标基准价</td>
								<td>
									<form:select id="benchmarkId" path="recruitFileData.benchmarkId">
										<c:forEach var="item" items="${benchmarkList}">
											<form:option value="${item.id}" label="${item.benchmarkName}" title="${item.benchmarkDescription}"/>
										</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<td class="need">*</td>
								<td style="width:100px">评标办法</td>
								<td>
									<%-- 综合评估法 --%>
									<form:select id="evaluationMethodId" path="recruitFileData.evaluationMethodId">
										<c:forEach items="${evaluationMethodList}" var="evaluationMethod">
											<form:option path="recruitFileData.evaluationMethodId" value="${evaluationMethod.id}" label="${evaluationMethod.evaluationMethodName}"/>
										</c:forEach>
									</form:select>
								
								</td>
							</tr>
							
					</tbody>
				</table>					
					</c:if>
			</div>
			<c:if test="${recruitFile.isPrejudication == false}">
				<div class="blank10"></div>
				<div class="easyui-panel" data-options="title:'定标',collapsible:true">
					<table width="98%" style="table-layout:fixed;margin:0 auto;">
					
						<tbody>
							<tr>
								<td class="need">*</td>
								<td style="width:100px">定标方式</td>
								<td>
									<table style="width:100%;">
										<tbody>
											<tr id="TJHXR">
												<td style="width:150px;"><input type="radio" id="TJ" name="DBFS" value="0" />推荐中标候选人数:</td>
												<td>
												<form:input id="candidateNum" path="recruitFileData.candidateNum" cssClass="inputxt  easyui-validatebox" type="number" value="${recruitFile.recruitFileData.candidateNum}" precision="0"  />
												</td>
											</tr>
											<tr>
												<td style="width:150px;"><input type="radio" id="QD" name="DBFS" value="1" />确定中标人:</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					
					</table>
				</div>
			</c:if>
			<div class="blank10"></div>
				<input type="button" class="button gray" value="保 存" />
				<input type="button" class="button red" value="下一步" onclick="window.location.href='/recruitFileData/viewRecruitFileEnvelop?id=${recruitFile.id}&nextStep=2_1'"/>
			<a class="button orange" onclick="history.go(-1)">返回</a>
			<input type="hidden" id="attachmentSsztId" value="${recruitFile.id}"/>
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
<!-- 	<script src="/resources/page/recruit/recruitFile.js" type="text/javascript"></script>  -->
</body>
</html>