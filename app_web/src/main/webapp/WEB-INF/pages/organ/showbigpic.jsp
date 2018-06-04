<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Constants.PLATFORM_NAME%></title>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>${fjid00}
			图片显示
		
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<img src="${pageContext.request.contextPath} /aptitude/showpic?id=${fjid00}" />
			<a class="button red" href="javascript:history.go(-1)">返回</a>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
<script  type="text/javascript">

</script>
</html>