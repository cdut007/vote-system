<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- <c:set value="${noticeService.getSignatureDataById(processBusinessKey)}" var="signatureData" scope="request" /> --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			资格预审结果公告
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>资格预审结果公告</h4>
			<%-- 	<form:hidden path="id" />
				<form:hidden path="projectInstanceId" />
				<form:hidden path="publishDate" />
				<form:hidden path="deadline" />
				<form:hidden path="contacts" />
				<form:hidden path="phone" />
				<form:hidden path="email" />
				<form:hidden path="noticeContent" id="noticeContent"/> --%>
				
				<input type="hidden" name="DocumentID" value="${notice.id}" />
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" />
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" />
				<div class="blank10"></div>
				<table class='mytableStyle'>
					<col style="width:100px" />
					<col />
					<col style="width:100px" />
					<col />
					<tr>
						<td width="120px">招标项目名称</td>
						<td>${notice.projectInstance}</td>
					</tr>
					<tr>
						<td width="120px">标段</td>
						
						<td>${notice.projectItemNames}</td>
						
					</tr>
				</table>
				<div class="blank10"></div>
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<span id="noticeCont"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${notice.noticeContent}</div>
					<span id="sealPos"></span>
				</div>
				<div class="blank10"></div>
				<table style="table-layout:fixed;width:100%">
					
					<tr>
						<td colspan="2" style="padding:10px 0 18px 0;">
							
							<input type="button" class="button red" value="返回" id="unpass" onclick="history.go(-1)" />
						</td>
					</tr>
				</table>
		</div>
	</div>
</body>
</html>