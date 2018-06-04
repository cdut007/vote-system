<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<style type="text/css">
p {
 margin: 1px;
 paddding: 1px;
}

pre {
 white-space: pre-wrap; /* css-3 */
 white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
 white-space: -pre-wrap; /* Opera 4-6 */
 white-space: -o-pre-wrap; /* Opera 7 */
 word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
<sys:link webedit="true"></sys:link>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标公告详细
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<form id="noticeZhaob_form_detail" action="${pageContext.request.contextPath}/notice/saveOrUpdate" method="post">
				<table style="width:100%;">
					<tr height="100px">
						<td colspan='4' align='center'><h2>${noticeZhaob.noticeTitle}</h2></td>
					</tr>
					<tr>
						<td colspan='4'>
							${noticeZhaob.ggnrwb}
						</td>
					</tr>
				</table>
			</form>
			<div class="blank10"></div>
			<div style="text-align: center">
				<input type='button' class="button red" value="收 藏" /> 
				<c:if test="${noticeZhaob.applyAble&&noticeZhaob.projectInstance.organId!=CURRENT_USER_SESSION_INFO.organId&&noticeZhaob.projectInstance.project.organId!=CURRENT_USER_SESSION_INFO.organId}">
					<a class="button red" href="${pageContext.request.contextPath}/tenderApply/tenderApplyForm?noticeId=${noticeZhaob.id}" target="_blank">申请报名</a>
				</c:if>
				<%-- <input type='button' class="button red" id="bm_btn" <c:if test="${hasTender=='false'}">onclick="sqbm('${noticeZhaob.projectInstance.id}')"</c:if> value="申请报名" />  --%>
				<input type='button' class="button red" value='关 闭' onclick='window.close()' />
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/resources/plug-in/validform/js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript">
		$(function() {
			if ("${hasTender}" == "true") {
				$("#bm_btn").attr("disabled", true);
				$("#bm_btn").removeClass("red").addClass("gray");
				$("#bm_btn").attr("value", "您已报名");
			}
		});
		function sqbm(id) {
			$.messager.confirm('系统提示', "您确定要申请报名该项目吗？", function(r) {
				if (r) {
					window.location.href = '${pageContext.request.contextPath}/tenderApply/start?projectInstanceId=' + id;
				}
			});
		}
	</script>
</body>
</html>