<%@page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<p style="text-indent:0em;text-align: center;">专家抽取申请信息</p>
<p style="text-indent:0em;">一、招标项目信息：</p>
<table border="1" cellspacing="0" width="600px">
	<tr>
		<th style="background-color: #cecece">项目编号：</th>
		<td colspan="3">${expertApply.projectInstance.zbxmbh}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece" width="120px">项目名称：</th>
		<td colspan="3">${expertApply.projectInstance.zbxmmc}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece" width="120px">招标单位：</th>
		<td colspan="3">${expertApply.projectInstance.organTName}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece" width="120px">代理机构：</th>
		<td colspan="3">${expertApply.projectInstance.organAName}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece">招标方式：</th>
		<td>${util:dictionary('ZBFS00',expertApply.projectInstance.zbfs00)}</td>
		<th style="background-color: #cecece" width="120px">招标组织形式：</th>
		<td>${util:dictionary('ZBZZXS',expertApply.projectInstance.zbzzxs)}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece">标段：</th>
		<td colspan="3">
			<c:forEach items="${expertApply.projectItemList}" var="item">
				<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th style="background-color: #cecece">开标时间：</th>
		<td><fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
		<th style="background-color: #cecece" width="120px">开标地点：</th>
		<td>${expertApply.bidOpenPlace}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece">评标委员会组建：</th>
		<td colspan="3">评标委员会构成： ${expertApply.juryTUserNum+expertApply.juryExpertNum}人，其中招标人代表 ${expertApply.juryTUserNum}人，专家${expertApply.juryExpertNum}人。</td>
	</tr>
	<tr>
		<th style="background-color: #cecece" style="width:100px;">评标时间：</th>
		<td><fmt:formatDate value="${expertApply.evaluateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
		<th style="background-color: #cecece" style="width:100px;">评标地点：</th>
		<td>${expertApply.evaluatePlace}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece" style="width:100px;">评标用时：</th>
		<td>${util:dictionary('PBSJDM',expertApply.dayNumber)}</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<th style="background-color: #cecece">所属库：</th>
		<td>${util:dictionary('SSK000',expertApply.expertDatabase)}</td>
		<th style="background-color: #cecece">专家所在区域：</th>
		<td>${util:dictionaryPath('REGION',expertApply.expertRegion)}</td>
	</tr>
	<tr>
		<th style="background-color: #cecece">备注说明：</th>
		<td colspan='3'>${expertApply.beizhu}<span id="sealPos"></span></td>
	</tr>
</table>

<p style="text-indent:0em;">二、抽取需求：</p>
<table border="1" cellspacing="0" width="600px">
	<thead>
		<tr>
			<th style="background-color: #cecece">序号</th>
			<th style="background-color: #cecece">专业</th>
			<th style="background-color: #cecece">人数</th>
			<th style="background-color: #cecece">报到时间</th>
			<th style="background-color: #cecece">报到地点</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${expertDemandList}" var="expertDemand" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td>${expertDemand.specialtyFirstTypeName}-${expertDemand.specialtySecondTypeName}-${expertDemand.specialtyThirdTypeName}</td>
			<td>${expertDemand.expertCount}</td>
			<td><fmt:formatDate value="${expertDemand.expertCheckInTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${expertDemand.expertCheckInAddress}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<p style="text-indent:0em;">三、回避单位：</p>
<table border="1" cellspacing="0" width="600px">
	<thead>
		<tr>
			<th style="background-color: #cecece">序号</th>
			<th style="background-color: #cecece">回避单位代码</th>
			<th style="background-color: #cecece">回避单位名称</th>
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