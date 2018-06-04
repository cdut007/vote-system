<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<%-- <c:set value="${projectItemService.createProjectItemQuery().includeTenderItem().expertApplyId(processBusinessKey).list()}" var="projectItemList" /> --%>
<c:set value="${tenderItemService.retrieveTenderItemWithQualificationTotalResult(processBusinessKey,projectItemId,CURRENT_USER_SESSION_INFO.id,reviewType)}" var="tenderItemWithQualificationTotalResultList" />
<c:set value="${qualificationResultDetailService.listMyPriQualificationResultDetailList(processBusinessKey,projectItemId,reviewType)}" var="result" />
<c:set value="${result.recruitFile}" var="recruitFile" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>符合性审查</title>
<jsp:include page="/common/link.jsp" />
<!--ready事件-->
<script type="text/javascript">
	$(function() {
		if ($(":input[name='message']").val() != '') {
			$.jGrowl($(":input[name='message']").val());
		}
		$("#sub").click(function() {
			$.messager.confirm("系统提示", "确定提交吗？", function(flag) {
				if (flag) {
					$("#workflowForm").submit();
				}
			});
		});
		$("#detail").click(function(){
			
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}
		</div>
		<div class="usBox">
			<div style="text-align: center;">
				<font style="font-size: 14pt; font-weight: bold;">${projectInstance}${recruitFile.isPrejudication == true ? '资格预审':'初步评审'}</font>
			</div>
			<c:forEach items="${tenderItemWithQualificationTotalResultList}" var="item" varStatus="status">
				<c:set value="${item[0]}" var="tenderItem" />
				<c:set value="${item[1]}" var="qualificationTotalResult" />
				<c:if test="${tenderItem.projectItem==null||tenderItem.projectItem!=projectItem}">
					<c:if test="${status.index!=0}"><%="</div>"%></c:if>
					<c:set value="${tenderItem.projectItem}" var="projectItem" />
					<div class='red' style='color:yellow;padding:5px;weight:900;width:100%;display:block;'>${projectItem.bdbh00}-${projectItem.bdmc00}</div>
					<div class="blank10"></div>
					<%="<div class='clearfix'>"%>
				</c:if>
				<c:if test="${not empty tenderItem.organ.logoId}">
					<c:set var="background" value="background:url('${pageContext.request.contextPath}/attachment/zoom/${tenderItem.organ.logo.path}?width=180&height=255')"/>
				</c:if>
				<div index="${status.index}" style="width:180px;height:255px;text-align:center;border:1px solid #efefef;float:left;margin-right:2px;margin-bottom:2px;${background}">
					<br /> <br /> <br /> 
					<a title="${tenderItem.organ}" href="${pageContext.request.contextPath}/evaluation/preliminaryReviewTenderItemDetail?id=${tenderItem.id}&processBusinessKey=${processBusinessKey}&taskId=${taskId}&reviewType=${reviewType}">
						<p class="product_list1brief">${tenderItem.organ}</p>
					</a> 
					<br />
					<c:if test="${not empty qualificationTotalResult.qualificationResult}">
						<div style="filter:alpha(opacity=80);-moz-opacity:0.8;opacity:0.8;padding:10px;background:#000;color:#fff;font-size:18px;weight:900;">评审结果：${util:dictionary('QUALIFICATION_RESULT',qualificationTotalResult.qualificationResult)}</div>
					</c:if>
					<br /> <br /> <br /> <br /> <br />
				</div>
			</c:forEach>
			<div class="blank10"></div>
			<form id="workflowForm" action='${pageContext.request.contextPath}/workflow/completeForm' method='post'>
				<input type="hidden" name="message" value="${message}" /> 
				<input type="hidden" name="taskId" value="${taskId}" /> 
				<%--<input type="hidden" name="projectItemId" value="${projectItemId}" /> --%>
				<c:choose>
					<c:when test="${recruitFile.isPrejudication == true}">
						<input type='button' id="sub" class="button red" value='提交我的资格预审结果' />
					</c:when>
					<c:otherwise>
						<input type='button' id="sub" class="button red" value='提交我的初步评审结果' />
					</c:otherwise>
				</c:choose>				
			</form>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
