<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>抽取专家申请信息</title>
<c:set value="${expertApplyService.getExpertApply(expertApplyId)}" var="expertApply" scope="request"></c:set>
<c:set value="${expertApplyService.getDemandList(expertApplyId)}" var="expertDemandList" scope="request"></c:set>
<c:set value="${expertApplyService.getAvoidOrganList(expertApplyId)}" var="avoidanceOrganList" scope="request"></c:set>
<sys:link easyui="true" jgrowl="true" datepicker="true" ca="true" />
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
<!--该事件在AIP引擎初始化完毕之后触发-->
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
      HWPostil1_NotifyCtrlReady();
</SCRIPT>
<!--在执行以下操作的时候触发此事件（打印；删除页面；删除节点；删除印章；添加印章；用户登录）。-->
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyAfterAction(lActionType,lType,strName,strValue)>
       HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue);
</SCRIPT>
<script type="text/javascript">

$(function() {
	var posX = 130;
	var posY = -280;
	//sealUtil.verifySeal($("#SigndataWtrSignData").val());
	var sealName="${CURRENT_USER_SESSION_INFO.organName}";

	//**************签章用的demo**********************************
	/*var shaObj = new jsSHA("SHA-256", "TEXT");
	shaObj.update("输入需要签名保护的内容");
	var hash = shaObj.getHash("HEX");
	$("input[name='signSha256']").val(hash);*/
	//************************************************

	
	$("#pass").click(function() {
		$("input[name=pass]").val("true");
		$("#expertApplyForm").submit();
	});
	$("#unpass").click(function() {
		$("input[name=pass]").val("false");
		$("#expertApplyForm").submit();
	});
});
function HWPostil1_NotifyCtrlReady() {
    document.all.HWPostil1.HideMenuItem(30);
    OpenFile("${pageScope.basePath}/attachment/download/${expertApply.pdfAttachmentId}");
}
function  HWPostil1_NotifyAfterAction(lActionType,lType,strName,strValue) {
    if(lActionType==3 && lType==3){
        sealNum--;
        sealNum = sealNum <=0 ?0:sealNum;
	}else if(lActionType==5 && lType==0){
        sealNum++;
	}
}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			专家抽取申请信息
		</div>
	</div>
	<div class="usBox block" style="padding: 3px;height:660px;">
		<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
		<script src="${pageScope.basePath}/resources/aip/LoadAip.js"></script>
		<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->	
	</div>
	<div class="block">
		<form:form id="expertApplyForm" method="post" modelAttribute="expertApply" action='${pageContext.request.contextPath}/workflow/completeForm'>
			<input type="hidden" name="token" value="${token}" />
			<form:hidden path='id' />
			<form:hidden id="expertGroupId" path='expertGroup.id' />
			<form:hidden path='projectInstanceId' />
			<form:hidden path='juryExpertNum' />
			<form:hidden path='juryTUserNum' />
			<form:hidden path='bidOpenDate' />
			<form:hidden path='bidOpenPlace' />
			<form:hidden path='juryTUserNum' />
		<%-- 	<div class="easyui-panel" data-options="title:'招标项目信息'">
				<table class="mytableStyle" style="table-layout:fixed;margin:0 auto;border:none;">
					<col style="width:120px;" />
					<col />
					<col style="width:120px;" />
					<col />
					<tr>
						<th width="120px">项目编号：</th>
						<td colspan="3">${expertApply.projectInstance.zbxmbh}</td>
					<tr>
					<tr>
						<th width="120px">项目名称：</th>
						<td colspan="3">${expertApply.projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th width="120px">招标单位：</th>
						<td colspan="3">${expertApply.projectInstance.organTName}</td>
					</tr>
					<tr>
						<th width="120px">代理机构：</th>
						<td colspan="3">${expertApply.projectInstance.organAName}</td>
					</tr>
					<tr>
						<th>招标方式：</th>
						<td>${util:dictionary('ZBFS00',expertApply.projectInstance.zbfs00)}</td>
						<th width="120px">招标组织形式：</th>
						<td>${util:dictionary('ZBZZXS',expertApply.projectInstance.zbzzxs)}</td>
					</tr>
					<tr>
						<th>标段：</th>
						<td colspan="3">
							<c:forEach items="${expertApply.projectItemList}" var="item">
								<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>开标时间：</th>
						<td><fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th width="120px">开标地点：</th>
						<td>${expertApply.bidOpenPlace}</td>
					</tr>
					<tr>
						<th>评标委员会组建：</th>
						<td colspan="3">评标委员会构成： ${expertApply.juryTUserNum+expertApply.juryExpertNum}人，其中招标人代表 ${expertApply.juryTUserNum}人，专家${expertApply.juryExpertNum}人。</td>
					</tr>
					<tr>
						<th style="width:100px;">评标时间：</th>
						<td><fmt:formatDate value="${expertApply.evaluateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th style="width:100px;">评标地点：</th>
						<td>${expertApply.evaluatePlace}</td>
					</tr>
					<tr>
						<th style="width:100px;">评标用时：</th>
						<td>${util:dictionary('PBSJDM',expertApply.dayNumber)}</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>所属库：</th>
						<td>${util:dictionary('SSK000',expertApply.expertDatabase)}</td>
						<th>专家所在区域：</th>
						<td>${util:dictionaryPath('REGION',expertApply.expertRegion)}</td>
					</tr>
					<tr>
						<th>备注说明：</th>
						<td colspan='3'>${expertApply.beizhu}<span id="sealPos"></span></td>
					</tr>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'抽取需求'">
				<table class="mytableStyle">
					<thead>
						<tr>
							<th>序号</th>
							<th>专业</th>
							<th>人数</th>
							<th>报到时间</th>
							<th>报到地点</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${expertDemandList}" var="expertDemand" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td>${expertDemand.specialtyFirstTypeName}-${expertDemand.specialtySecondTypeName}-${expertDemand.specialtyThirdTypeName}</td>
								<td>${expertDemand.expertCount}</td>
								<td>${expertDemand.expertCheckInTime}</td>
								<td>${expertDemand.expertCheckInAddress}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'回避单位'">
				<table class="mytableStyle">
					<thead>
						<tr>
							<th>序号</th>
							<th>回避单位代码</th>
							<th>回避单位名称</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${avoidanceOrganList}" var="avoidanceOrgan" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td>${avoidanceOrgan.organCode}</td>
								<td>${avoidanceOrgan.organName}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			 --%>
			<div class="blank10"></div>
			<!-- <div id="expert-datagrid"></div> -->
			<input type="hidden" name="signSha256"/>
			<input type='hidden' name="id" value="${expertApply.id}">
			<input type='hidden' name="taskId" value="${taskId}">
			<input type="hidden" id='signData' name="signData" />
			<input type="hidden" name="pass" value="true" />
			<input type="button" class="button red" value="通过" id="pass" />
			<input type="button" class="button red" value="不通过" id="unpass" />
		</form:form>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
