<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set var="tender" value="${tenderService.createTenderQuery().includeTenderItem().includeLazyProperties().tenderId(tenderId).singleResult()}" scope="request" />
<c:set var="projectInstance" value="${tender.projectInstance}" scope="request" />
<jsp:useBean class="com.mhb.common.model.SearchModel" id="searchModel"/>
<jsp:setProperty property="isAudits" name="searchModel" value="2"/>
<jsp:setProperty property="organId" name="searchModel" value="${tender.organId}"/>
<%-- <c:set var="aptitudeList" value="${aptitudeService.retrieveAptitudeWithAttachment(searchModel)}"/> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--投标报名申请表--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<head>
<title>报名申请</title>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" plupload="true" ca="true"/>
<script src="/resources/page/tender/tenderApplyReview.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<script type="text/javascript">
	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${tender.pdfAttachment.fjid00}");
	    //document.all.HWPostil1.ForceSignType=7;
	}
	
    /* var xmbh00="${tender.projectInstance.project.xmbh00}";
    var zbxmbh="${tender.projectInstance.zbxmbh}";
    var bidderName = "${tender.organName}";
    var bidderCode = "${tender.organId}";
    var signStr = "PROJECT_CODE:" + xmbh00 + "&TENDER_PROJECT_CODE:" + zbxmbh + "&BIDDER_NAME:" + bidderName + "&BIDDER_ORG_CODE:" + bidderCode;
    $(function() {
            sealUtil.loadAllSealWithBKey("${tender.noticeId}:${tender.ownerId}","data="+signStr,"sealPos");
		}) */
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			报名申请
		</div>
		<div class="blank10"></div>
			<div id="tender_application" style="display:none;background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${tender.content}</div>
			
			<div class="usBox main" style="padding: 3px;height:660px;" id="">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			</div>
			
			<div id="ht_end"></div>
		<div class="blank10"></div>
		<div class="tableTitle2">投标申请附件</div>
		<table class='mytableStyle'>
			<thead>
				<tr>
					<th width="20px"></th>
					<th>附件名称</th>
					<th>上传时间</th>
					<th>附件大小（K）</th>
					<th>附件归属</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${attachmentService.createAttachmentQuery().referenceObjectId(tender.id).list()}" var="fileItem" varStatus="status">
					<tr>
						<th>${status.count}</th>
						<td>${fileItem.fjmc00}</td>
						<td>${fileItem.uploadTime}</td>
						<td>
							<fmt:formatNumber value="${fileItem.length/(1024)}" pattern="#,###.##" />
						</td>
						<td>${util:dictionary('FJGSLX',fileItem.fjgslx)}</td>
						<td align="center">
							<a href="${pageContext.request.contextPath}/attachment/download/${fileItem.fjid00}" target="_blank">下载</a> &nbsp;&nbsp; <a href="${pageContext.request.contextPath}/attachment/preview/${fileItem.fjid00}" target="_blank">预览</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${not empty aptitudeList}">
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'资质证书'" style="padding:10px;">
				<c:forEach items="${aptitudeList}" var="item">
					<img title="${item}" src="${pageContext.request.contextPath}/attachment/zoom/${item.attachmentList[0].path}?width=255&height=186" style="width:225px;height:186px;" />
				</c:forEach>
			</div>
		</c:if>
		<div id="sealPos"></div>
		<div id="nopassReason">
			<form:form id="tenderApplyReviewForm" method="post" modelAttribute="tender" action="${pageContext.request.contextPath}/workflow/completeForm">
				<input type="hidden" name="taskId" value="${taskId}" />
				<form:hidden path="id" id="id" />
				<form:hidden id="content" path="content" />
				<%-- <form:hidden path="sealSignData" id="sealSignData" /> --%>
				<form:hidden path="projectInstanceId" />
				<form:hidden path="noticeId" />
				<input type="hidden" name="pass" value="true" />
				<textarea id="nopassReason" name="nopassReason" style="width:678px;height:365px;"></textarea>
				<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
			</form:form>
		</div>
		<c:if test="${tender.reviewStatus=='0'}">
			<div style="text-align:right;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:999;border: #ccc 1px solid;">
				<!-- <input type="button" id='sign' class="red button"  value="签章" />  -->
				<input type="button" id='pass' class='red button' value="审核通过" />
				<input type="button" id="nopass" class='red button' value="审核不通过" />
			</div>
		</c:if>
	</div>
</body>
</html>
