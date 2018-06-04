<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true" />
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标单位统计信息
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<form:form id="noticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="notice">
				<table width="100%" class="mytableStyle" style="table-layout:fixed;">
					<tr>
						<th>主体代码：</th>
						<td colspan="3">${organB.ztdm00}</td>
					</tr>
					<tr>
						<th>单位名称：</th>
						<td colspan="3">${organB.ztmc00}</td>
					</tr>
					<tr>
						<th>注册时间：</th>
						<td colspan="3">${organB.createTime}</td>
					</tr>
					<tr>
						<th>所属行业：</th>
						<td colspan="3">${util:dictionary("INDUSTRY",organB.industry)}</td>
					</tr>
					<tr>
						<th>行政区域：</th>
						<td colspan="3">${util:dictionary("REGION",organB.region)}</td>
					</tr>
					<tr>
						<th>联系人：</th>
						<td colspan="3">${organB.ztklxr}</td>
					</tr>
					<tr>
						<th>联系方式：</th>
						<td colspan="3">${organB.ztklxdh}</td>
					</tr>
					<tr>
						<th>法人类别：</th>
						<td colspan="3">${util:dictionary("FRLB",organB.frlb00)}</td>
					</tr>
					<tr>
						<th>法人角色：</th>
						<td colspan="3">${util:dictionary("FRJS",organB.frjs00)}</td>
					</tr>
					<tr>
						<th>法人机构类别：</th>
						<td colspan="3">${util:dictionary("FRJGLB",organB.frjglb)}</td>
					</tr>
					<tr>
						<th>法人业务状态：</th>
						<td colspan="3">${util:dictionary("FRYWZT",organB.frywzt)}</td>
					</tr>
					<tr>
						
					</tr>
					<tr>
						<th>单位诚信度：</th>
						<td colspan="3">${util:dictionary("CREDIT",organB.organCredit)}</td>
					</tr>
					<tr>
						<th>投标次数：</th>
						<td colspan="3">${tenderNum}</td>
					</tr>
					<tr>
						<th>中标次数：</th>
						<td colspan="3">${winNum}</td>
					</tr>
					<tr>
						<th>中标率：</th>
						<td colspan="3">${winOfTender}</td>
					</tr>
					
				</table>
				<div class="blank10"></div>
				<input type="button" class="button red" onclick="javascript:window.close()" value="关 闭" />
			</form:form>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>