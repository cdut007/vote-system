<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>代理机构--公告申请</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.wpsm {
	color: #f00;
}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			公告申请
		</div>
		<div class="usBox">
			<div class="blank10"></div>
			<form class="registerform" id="rwwpForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm">
				<input type="hidden" name="taskId" value="${taskId}" />
				<div>
					<button class='button red'>申请发布公告</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
