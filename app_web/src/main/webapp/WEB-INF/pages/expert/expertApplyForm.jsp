<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>抽取专家申请信息</title>
<sys:link easyui="true" jgrowl="true" ca="true" datepicker="true"/>
<script type="text/javascript" src="/resources/page/expert/expertApplyForm.js"></script>
<script type="text/javascript">
	$(function(){
		//alert("${taskId}");
		var taskId = "${taskId}";
		$("#taskId").val(taskId);
	});

	var platId = "${expertApplication.projectInstance.zbxmbh}";
	var planExtractDate = "${expertApplication.bidOpenDate}";
	var bidOpenTime = "${expertApplication.bidOpenDate}";
	var bidOpenAddress = "${expertApplication.bidOpenPlace}";
	var bidEvaluateTime = "${expertApplication.bidOpenDate}";
	var bidEvaluateAddress = "${expertApplication.evaluatePlace}";
	var tendereeOrg = "${expertApplication.projectInstance.organTName}";
	var tendereePrincipal = "${expertApplication.projectInstance.organTName}";
	var tendereePhone = "${expertApplication.projectInstance.organZb.phone}";
	var agencyOrg = "${expertApplication.projectInstance.organAName}";
	var agencyPrincipal = "${expertApplication.projectInstance.organ.ztklxr}";
	var agencyPhone = "${expertApplication.projectInstance.organ.phone}";
	var watchdogOrg = "${expertApplication.projectInstance.jdbmmc}";
	var watchdogPrincipal = "${expertApplication.projectInstance.jdbmfzr}";
	var watchdogPhone = "${expertApplication.projectInstance.jdbmdh}";
	var bidEvaluateCommittee = "${expertApplication.juryTUserNum+expertApplication.juryExpertNum}";
	
	/* var investment = parseFloat($('#bdhtgj').val()).toFixed(4);
	var bidContent = $('#bdnr00').val();
	var areaCode = $('#zjszqy').val();
	var callbackUrl = "www.11.com"; */
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			专家抽取申请信息
		</div>
	</div>
	<div class="block">
		<form:form class="registerform" method="post" modelAttribute="expertApplication">
			<input type="hidden" name="token" value="${token}"/>
			<form:hidden path='id' />
			<form:hidden path='projectInstanceId' />
			<form:hidden path='juryExpertNum' />
			<form:hidden path='juryTUserNum' />
			<form:hidden path='bidOpenDate' />
			<form:hidden path='bidOpenPlace' />
			<form:hidden path='juryTUserNum' />
			<form:hidden path='currentBidStage' />
			<form:hidden path='taskId' />
			<div class="easyui-panel" data-options="title:'招标项目信息'">
				<table class="mytableStyle" style="table-layout:fixed;margin:0 auto;border:none;">
					<col style="width:120px;"/>
					<col/>
					<col style="width:120px;"/>
					<col/>
					<tr>
						<th width="120px">项目编号：</th>
						<td colspan="3">${expertApplication.projectInstance.zbxmbh}</td>
					<tr>
					<tr>
						<th width="120px">项目名称：</th>
						<td colspan="3">${expertApplication.projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">招标单位：</th>
						<td colspan="3">${expertApplication.projectInstance.organTName}</td>
					</tr>
					<tr>
						<th width="120px">代理机构：</th>
						<td colspan="3">${expertApplication.projectInstance.organAName}</td>
					</tr>
					<tr>
						<th>招标方式：</th>
						<td>${util:dictionary('ZBFS00',expertApplication.projectInstance.zbfs00)}</td>
						<th width="120px">招标组织形式：</th>
						<td>${util:dictionary('ZBZZXS',expertApplication.projectInstance.zbzzxs)}</td>
					</tr>
					<tr>
						<th>标段：</th>
						<td colspan="3">
							<c:forEach items="${projectItemList}" var="item">
								<input name="projectItemList" value="${item.id}" id="${item.id}" type="checkbox" ${expertApplication.projectItemList.contains(item)?"checked='checked'":""}/>
								<label for="${item.id}">${item.bdmc00}</label>&nbsp;&nbsp;
								<!-- 数字签名：标段合同投资额 -->
								<input type="hidden" value="${item.bdhtgj}" id="bdhtgj">
								<!-- 数字签名：招标内容 -->
								<input type="hidden" value="${item.bdnr00}" id="bdnr00">
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>开标时间：</th>
						<td><fmt:formatDate value="${expertApplication.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<th width="120px">开标地点：</th>
						<td>${expertApplication.bidOpenPlace}</td>
					</tr>
					<tr>
						<th>评标委员会组建：</th>
						<td colspan="3">
							评标委员会构成： ${expertApplication.juryTUserNum+expertApplication.juryExpertNum}人，其中招标人代表 ${expertApplication.juryTUserNum}人，专家${expertApplication.juryExpertNum}人。
						</td>
					</tr>
				</table>
			</div>
			<div class="blank10"></div>
			<table style="width:100%;">
				<tr>
					<td class="need">*</td>
					<td style="width:100px;">评标时间：</td>
					<td>
						<form:input path="evaluateTime" cssClass="inputxt easyui-datetimebox" cssStyle="width:150px" data-options="required:true"/>
					</td>
					<td class="need">*</td>
					<td style="width:100px;">评标地点：</td>
					<td>
						<form:input path="evaluatePlace" cssClass="inputxt" />
					</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td style="width:100px;">评标用时：</td>
					<td>
						<form:select path="dayNumber" cssClass="inputxt">
							<form:option value="">请选择</form:option>
							<form:options items="${util:dictionaryTree('PBSJDM',false)}" itemLabel="itemName" itemValue="itemCode" />
						</form:select>
					</td>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td class="need" style="width:10px;">*</td>
					<td>所属库：</td>
					<td>
						<form:select path="expertDatabase">
							<form:options items="${util:dictionaryTree('SSK000',false)}" itemValue="itemCode" itemLabel="itemName"/>
						</form:select>
					</td>
					<td class="need">*</td>
					<td>专家所在区域：</td>
					<td>
						<form:select path="expertRegion" cssClass="inputxt" id="zjszqy">
							<form:options items="${dictionaryService.retrieveCacheChildrenByItemCode4Combo('REGION','140000')}" itemValue="itemCode" itemLabel="itemName"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>专家组长抽取方式:</td>
					<td>
						<form:select path="expertElect" cssClass="inputxt">
							<form:option label="专家选举" value="0"/>
							<form:option label="代理机构指定" value="1"/>
						</form:select>
					</td>
					<td class="need">*</td>
					<td>抽取终端编号：</td>
					<td>
						<select name="extractTerminalCode"	id="extractTerminalCode" class="inputxt extractCode">
							<option value="">--</option>
							<option value="140000001">省终端</option>
							<option value="140000002">大同市终端</option>
							<option value="140000003">朔州市终端</option>
							<option value="140000004">忻州市终端</option>
							<option value="140000005">晋中市终端</option>
							<option value="140000006">太原市终端</option>
							<option value="140000007">晋城市终端</option>
							<option value="140000008">长治市终端</option>
							<option value="140000009">吕梁市终端</option>
							<option value="140000010">运城市终端</option>
							<option value="140000011">临汾市终端</option>
							<option value="140000012">阳泉市终端</option>
							<option value="140000013">孝义市终端</option>
						</select>
					</td>

				</tr>
				<tr>
					<td class="need"></td>
					<td>备注说明：</td>
					<td colspan='4'>
						<form:textarea path="beizhu" cssStyle="width:99%;height:60px;" class="inputxt easyui-validatebox" data-options="validType:'length[0,100]'"/>
					</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<table id="expertDemand-datagrid"></table>
			<div id = "sealPos" class="blank10"></div>
			<table id="avoidOrgan-datagrid"></table>
			
			<div class="blank10"></div>
			<!-- <input class="button orange" onclick="history.go(-1)" type="button" value="返回"/>
			<input type="button" id='demand' class='button red' value="抽取要求" /> 
			<input type="button" id='avoidance' class='button red' value="回避条件" /> -->
			<input type="button" id="expertApplySave" class='button red' value="保 存" /> 
			<input type="button" id="expertApplySubmit" class='button red' value="提交" />
			<input type="hidden" value="${taskId}" id="taskId"/>
		</form:form>
		<form:form id="taskform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="expertApplication">
			<%-- <input type="hidden" name="taskId" value="${taskId}" id="taskId"/> --%>
			<form:hidden path='taskId' value="${taskId }"/>
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
	<div id="expert_demandBox"></div>
	<div id="avoidanceBox"></div>
</body>
</html>