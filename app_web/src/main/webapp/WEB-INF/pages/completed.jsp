<!DOCTYPE link PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>任务完成！</title>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">
	$(function() {
		window.setTimeout(function() {
			window.location = "${pageContext.request.contextPath}/home";
		}, 5000);
		window.setInterval(function() {
			var second = parseInt($("#second").html());
			$("#second").html(--second);
		}, 1000);
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div class="usBox">
			<div style="text-align:center;height:100px;">本项目任务已完成！ 任务完成后，信息提示（项目下一步环节，及所需时间等）</div>
			<div>
				<h1>
					<span id="second">5</span>秒钟后自动跳转到我的任务。点击<a href='${pageContext}/home'>查看其他任务</a>立即跳转。
				</h1>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>