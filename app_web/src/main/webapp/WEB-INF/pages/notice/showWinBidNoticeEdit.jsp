<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- <c:set value="${winBidNoticeService.getSignatureDataById(winBidNotice.id)}" var="signatureData" scope="request" />--%>
 <html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function(){
		/* var SigndataStrSignData = '${signatureData.signatureData}';
		var sealName='${signatureData.sealName}';
		if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
			document.all.DWebSignSeal.ShowSeal(sealName, 1);
		} else {
			document.all.DWebSignSeal.SetStoreData(SigndataStrSignData); 
			document.all.DWebSignSeal.ShowWebSeals();
			document.all.DWebSignSeal.SetMenuItem(sealName,12);
			document.all.DWebSignSeal.LockSealPosition(sealName);
		} */
		sealUtil.loadAllSealWithBKey("${winBidNotice.id}","data=string2sign","sealPos");
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			中标公告查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>中标公告审核</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="winBidNotice">
				<form:hidden path="id" />
				<form:hidden path="projectInstanceId" />
				<%-- <form:hidden path="projectItemId" /> --%>
				<form:hidden path="publishDate" />
				<form:hidden path="deadline" />
				<form:hidden path="contacts" />
				<form:hidden path="phone" />
				<form:hidden path="email" />
				<!--<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" />
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" /> -->
				<form:hidden path="noticeContent" id="noticeContent"/>
				<div class="blank10"></div>
				<table class='mytableStyle'>
					<col style="width:100px" />
					<col />
					<col style="width:100px" />
					<col />
					<tr>
						<th width="120px">招标项目名称</th>
						<td>${winBidNotice.projectInstance}</td>
					</tr>
					<tr>
						<th width="120px">标段</th>
						<td>
							<c:forEach items="${winBidNotice.projectItemList}" var="item">
								<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
				</table>
				<div class="blank10"></div>
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<span id="noticeCont"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${winBidNotice.noticeContent}</div>
					<span id="sealPos"></span>
				</div>
				<div class="blank10"></div>
		        <a class="button orange" onclick="history.go(-1)">返回</a>
			</form:form>
		</div>
	</div>
</body>
</html>