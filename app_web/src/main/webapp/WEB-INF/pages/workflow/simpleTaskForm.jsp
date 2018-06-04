<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html>
<head>
<title>流程定义管理</title>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<form action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
		<input type="hidden" name="taskId" value="${taskId}" /> 
		<input type="hidden" name="pass" value="true" /> 
		<input type="submit" class="button red" value="通过" />
	</form>
</body>
</html>
