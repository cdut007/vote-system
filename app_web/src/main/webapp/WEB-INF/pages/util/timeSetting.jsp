<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%--项目信息确认 --%>
<html>
<head>
<title>设置-日期时间</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#changeTimeBtn").click(function() {
			$("#changeTimeForm").ajaxSubmit({
				dataType : "json",
				success : function(data) {
					$.jGrowl(data.msg);
				}
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			日期时间
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<form id="changeTimeForm" action="${pageContext.request.contextPath}/time/changeTime" method="post">
					输入时间：<input id="date" type="text" name="date" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />&nbsp;<a id="changeTimeBtn" class="easyui-linkbutton">提交</a>
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
