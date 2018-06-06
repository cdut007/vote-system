<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<sys:link ca="true" uedit="true" easyui="true" />
<style type="text/css">
.plan {
	position: absolute;
	background-color: #fff;
	z-index: 1000;
	border: 2px #D40000 solid;
	left: 200px;
	top: 200px;
	width: 850px;
	height: 470px;
	display: none;
}

.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 100;
	-moz-opacity: 0.2;
	opacity: .20;
	filter: alpha(opacity = 20);
}
</style>
	<script type="text/javascript" src="/resources/print/jquery.PrintArea.js"></script>
	<script type="text/javascript">
		$(function() {
			sealUtil.loadAllSealWithBKey("${commissionContract.id}","data=string2sign","signdataIdStr");
			$("#btnPrint").click(function() {
				$("#printNR").printArea();
			});
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
			查看委托合同 <input type="button" id="btnPrint" value="打印" />
		</div>
		<div class="blank10"></div>
		<div id="printContent">
			<c:choose>
				<c:when test="${empty commissionContract.attachmentId}">
					<div class="usBox main" id="ht_content">
						<div id="printNR">${commissionContract.htnr00}</div>
					</div>
					<div id="ht_end"></div>
				</c:when>
				<c:otherwise>
					<iframe
						src="${pageContext.request.contextPath}/attachment/download/${commissionContract.attachment.path}"
						style="border:1px solid #ddd;height:400px;width:100%;"></iframe>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
	<form:form modelAttribute="commissionContract">
		<form:hidden path="htnr00" />
	</form:form>
</body>

</html>