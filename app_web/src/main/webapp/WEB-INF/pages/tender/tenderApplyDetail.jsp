<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标报名申请表</title>
<jsp:include page="/common/link.jsp" />
<script src="/resources/ca/Loadwebsign.js" type="text/javascript"></script>
<script src="/resources/ca/main1.js" type="text/javascript"></script>
<script src="/resources/page/tender/tenderApplyForm.js" type="text/javascript"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标报名申请表
		</div>
		<div class="blank10"></div>
		<table class="mytableStyle">
			<tr>
				<th width="150px;">审核结果：</th>
				<td>
					<span class="f1">${util:dictionary('BMSHBZ',tender.reviewStatus)}</span>
				</td>
			</tr>
			<c:if test="${tender.reviewStatus=='2'||tender.reviewStatus=='-2'}">
				<!-- 审核不通过 -->
				<th>${tender.reviewStatus=='2'?"审核不通过原因":"撤销原因"}：</th>
				<td>${tender.nopassReason}</td>
			</c:if>
		</table>
		<div class="blank10"></div>
		<div class="easyui-panel" data-options="title:'项目标段列表',border:false">
			<table class='mytableStyle'>
				<thead>
					<tr>
						<th width='20px'></th>
						<th width='40px'>序号</th>
						<th>标段编号</th>
						<th>标段名称</th>
					</tr>
				</thead>
				<c:forEach items="${projectItemWithTenderApplyAbleList}" var="item" varStatus="status">
					<c:set value="${item[0]}" var="projectItem" />
					<c:set value="${item[1]}" var="tenderApplyAble" />
					<c:set value="${item[2]}" var="checked" />
					<tr>
						<td>
							<input type='checkbox' name='item_ids' onclick="check()" value="${projectItem.id}" ${checked?"checked='checked'":""} disabled="disabled"/>
						</td>
						<td style='text-align: center'>${status.count}</td>
						<td>${projectItem.bdbh00}</td>
						<td class="itemName">${projectItem.bdmc00}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="blank10"></div>
		<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
			<div id="tender_application" style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${tender.content}</div>
			<div id="ht_end"></div>
		</div>
		<div class="blank10"></div>
		<div class="tableTitle2">投标申请附件</div>
		<c:choose>
			<c:when test="${empty tender.id||tender.reviewStatus=='-1'}">
				<y:uploadify fjsszt="${tender.id}" fjgslx="39" />
			</c:when>
			<c:otherwise>
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
									<a href="${pageContext.request.contextPath}/attachment/download/${fileItem.fjid00}">下载</a> &nbsp;&nbsp; <a href="${pageContext.request.contextPath}/attachment/download/${fileItem.path}" target="_blank">预览</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
		<form:form id="tenderApplicationForm" method="post" modelAttribute="tender">
			<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:999;border: #ccc 1px solid;display: none;">
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id" id="id" />
				<form:hidden id="content" path="content" />
				<form:hidden path="sealSignData" id="sealSignData" />
				<form:hidden path="projectInstanceId" />
				<form:hidden path="nopassReason" />
				<form:hidden path="noticeId" />
				<%-- <c:if test="${tender.reviewStatus=='-1'}">
					<input type="hidden" name="isComplete" value="false" id="isComplete" />
					<input type="button" class='red button' id="saveBtn" value="保存" />
					<input type="button" class="red button" id='sign' value="签章" />
					<input type="button" id='subBtn' class='red button' value="提交" />
				</c:if>
				<c:if test="${tender.reviewStatus!='-1'}">
					<input type="button" class='red button' id="cancelBtn" value="撤销申请" />
				</c:if> --%>
			</div>
		</form:form>
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
