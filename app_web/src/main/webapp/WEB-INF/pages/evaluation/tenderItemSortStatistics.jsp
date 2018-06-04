<%@page pageEncoding="utf-8" import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标人排序表</title>
<sys:link easyui="true"/>
<script type="text/javascript">
$(function(){
	$(".exportXLS").click(function(){
		var form=$("<form/>").attr("action",ctx+"/attachment/expertXLS").attr("method","POST").css("display","none").appendTo($("body"));
		form.append($("<input/>").attr("name","html").val($("#exportHTML").html()));
		form.append($("<input/>").attr("name","exportName").val("${statistics.projectItem.projectInstance}投标人排序表.xls"));
		form.submit();
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<c:forEach items="${statisticsList}" var="statistics">
			<a class="exportXLS easyui-linkbutton" data-options="iconCls:'myicon-page_excel'">导出数据</a>
			<div class="blank10"></div>
			<table class="mytableStyle">
				<tr>
					<td>项目编号：</td>
					<td>${statistics.projectItem.projectInstance.zbxmbh}</td>
					<td>项目名称：</td>
					<td>${statistics.projectItem.projectInstance}${statistics.projectItem}</td>
				</tr>
				<tr>
					<td>委托单位：</td>
					<td>${statistics.projectItem.projectInstance.project.organ}</td>
					<td>开标时间：</td>
					<td>
						<fmt:formatDate value="${statistics.projectItem.tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div id="exportHTML">${statistics}</div>
			<div class="blank10"></div>
		</c:forEach>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>