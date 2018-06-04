<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--项目信息确认 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建项目信息</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.none {
	display: none;
}

.need {
	color: red;
}

table {
	width: 100%;
}

table th {
	text-align: center;
	background: #efefef;
}

table td,table th {
	border: 1px solid #ddd;
}

table td .inputxt,table td textarea {
	width: 100%;
}

table td {
	padding: 2px 6px;
}
</style>
<script type="text/javascript">
$(function() {
	var myChart = new FusionCharts("/resources/fusionCharts/Scatter.swf", "chartContainerId", "100%", "400"); 
	myChart.setDataURL("${pageContext.request.contextPath}/reverseAuctionDemand/report?_="+new Date().getTime());  
	myChart.render("chartContainer");  
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			反向拍卖规则
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<div class="easyui-layout" style="width:100%;height:400px;border:1px solid #ddd">
					<div data-options="region:'center'" style="overflow: hidden;">
						<div id="chartContainer" style="width:100%;height:100%">
						</div>
					</div>
					<div data-options="region:'east',width:200" style="padding:10px;">
						<h1>
							系统时间
						</h1>
						<h1>
							竞价剩余时间：
						</h1>
						<h1>
							最低竞价：
						</h1>
						<h1>
							最低竞价方：
						</h1>
					</div>
				</div>
				<div class="blank10"></div>
				<form method="post" action="${pageContext.request.contextPath}/reverseAuctionDemand/createAuctionDemant" onsubmit="return $(this).form('validate');">
					<table>
						<tbody>
							<tr>
								<th style="width:120px;">出价金额</th>
								<td><sys:number/></td>
							</tr>
							<tr>
								<th>产品描述</th>
								<td><textarea></textarea></td>
							</tr>
							<tr>
								<th>其他服务</th>
								<td><textarea></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="blank10"></div>
					<input type="submit" class='button red' value="保 存" /> <input type="reset" class='button red' value="重 置" />
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
</body>
</html>
