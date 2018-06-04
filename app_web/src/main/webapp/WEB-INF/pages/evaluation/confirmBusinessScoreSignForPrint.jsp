<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%--专家个人详细评审结果确认 --%>

<c:set value="${tenderItemScoreService.listTenderItemPriceScore(processBusinessKey,projectItemId,expertId,envelopeTypeOrder)}" var="resultMap" />
<c:set value="${resultMap.bidFiles}" var="bidFiles" />
<c:set value="${resultMap.statisticsList}" var="statisticsList" />
<c:set value="${myPreliminaryReviewSignService.loadMyPreliminaryReviewSignKey(processBusinessKey,projectItemId,'')}" var="myPreliminaryReviewSignKey" />


<jsp:useBean id="list2" class="java.util.ArrayList"></jsp:useBean>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<title>投标人报价签字</title>
<sys:link ca="true" uedit="true" easyui="true"/>
<style type="text/css">
.bold_red {
	font-weight: bold;
	color: red;
}
</style>
<script type="text/javascript">
	
	$(function() {
		$(function() {
			$("#complete").click(function() {
				$("#printArea").printArea({
					extraCss : '/resources/css/tablestyle_print.css'
				});
			});
		});

	});
</script>
<script type="text/javascript" src="/resources/portal/jquery.PrintArea.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
		<div class="block">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				详细评审
			</div>
			
		<div class="usBox" id="printArea">
			<table class="mytableStyle">
				<c:forEach items="${bidFiles}" var="bidFile" varStatus="bidFileStatus">

					<c:if test="${bidFileStatus.index==0}">
					<thead>
						<tr>
							<th>招标项目</th>
							<th>标段名称</th>
							<th>投标单位</th>
							<th>投标报价</th>
						</tr>
					</thead>
					</c:if>
					<tbody>
					<tr>
						<td>${bidFile.projectInstanceName}</td>
						<td>${bidFile.projectItemName}</td>
						<td>${bidFile.organBName}</td>
						<td>${bidFile.tbbjje}(${bidFile.tbbjdw=='2'?'万元':'元'})</td>
					</tr>
					</tbody>
				</c:forEach>
			</table>
			<div class="blank10"></div>

			<c:forEach items="${statisticsList}" var="statistics">
				<div class="blank10"></div>
				<table class="mytableStyle">
					<thead>
					<tr>
						<th>项目编号：</th>
						<td>${statistics.projectItem.projectInstance.zbxmbh}</td>
						<th>项目名称：</th>
						<td>${statistics.projectItem.projectInstance}${statistics.projectItem}</td>
					</tr>
					<tr>
						<th>委托单位：</th>
						<td>${statistics.projectItem.projectInstance.project.organ}</td>
						<th>开标时间：</th>
						<td><fmt:formatDate	value="${statistics.projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
					</thead>
				</table>
				<div class="blank10"></div>
				<div class="exportHTML">${statistics}</div>
				<div class="blank10"></div>
			</c:forEach>
		</div>
	
		<div style="text-align: right; position: fixed; left: 0px; right: 0px; bottom: 0px; padding-top: 10px; padding-bottom: 10px; padding-right: 30px; background-color: #efefef; z-index: 998; border: #ccc 1px solid;">
			<input type="button" class="button red" value="打印报价评分结果" id="complete" />
		</div>
		<div id="ht_end"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
	</div>
</body>
</html>
