<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/ca/Loadwebsign.js"></script>
<script type="text/javascript" src="/resources/ca/main1.js"></script>
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
<script type="text/javascript">
	
	$(function() {
// 			document.all.DWebSignSeal.SetStoreData(SigndataWtrSignData); 
// 			document.all.DWebSignSeal.ShowWebSeals();
// 			document.all.DWebSignSeal.SetMenuItem(SigndataWtrSealName,12);
// 			document.all.DWebSignSeal.LockSealPosition(SigndataWtrSealName);
	});
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
<!-- 		<div class="AreaL"> -->
<!-- 			<%@include file="/common/left.jsp"%> -->
<!-- 		</div> -->
<!-- 		<div class="AreaR"> -->
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				查看评标报告
			</div>
			<div class="blank10"></div>
			<div class="usBox main" id="ht_content">
				${evaluationReport.evaluationReportContent}
			</div>
			<div id="ht_end"></div>
<!-- 		</div> -->
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div style="text-align:right;position:fixed;left:0px;right:0px;bottom:0px;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;z-index:998;border: #ccc 1px solid;">
		<input type="button" class='button red' id="noBtn" value="返回" onclick="history.back();"/>
	</div>
	<form:form>
		<textarea rows="" cols="" style="display: none;"  id="htnr00" name="htnr00">${evaluationReport.evaluationReportContent}</textarea>
	</form:form>
</body>

</html>
