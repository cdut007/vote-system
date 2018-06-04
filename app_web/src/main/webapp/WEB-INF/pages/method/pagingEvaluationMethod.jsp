<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html>
<html>
<head>
<sys:link easyui="true"></sys:link>
<script type="text/javascript" src="/resources/page/method/pagingEvaluationMethod.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<!--center start  -->
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				评标办法管理
				<code>&gt;</code>
				报价得分算法
			</div>
			<div class="blank10"></div>
			<table id="evaluationMethod-datagrid"></table>
		</div>
		<!--center end  -->
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>