<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html>
<head>
<title>流程定义管理</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.content h1 {
	font-size: 34px;
	color: #fd7d00;
	height: 46px;
	line-height: 46px;
	padding-top: 37px;
}

.content h2 {
	font-size: 20px;
	color: #989898;
	height: 32px;
	line-height: 32px;
}
</style>
<script type="text/javascript">
	$(function() {
		window.setInterval(function() {
			var second = parseInt($("#second").html()) - 1;
			if (second == 0) {
				window.location.href = ctx + "/home";
			} else {
				$("#second").html(second);
			}
		}, 1000);
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div class="usBox">
			<div class="content clearfix">
				<h1>已过投标截至时间,不接受投标文件!</h1>
				<h2>
					<span id="second">5</span>秒后跳转至我的待办任务!<a></a>
				</h2>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>