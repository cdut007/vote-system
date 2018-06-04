<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<jsp:include page="/common/link.jsp" />
		<script type="text/javascript">
			$(function(){
				$("#1").show();
				$("#2").hide();
				$("#yz").click(function(){
					$("#1").show();
					$("#2").hide();
				});
				$("#gz").click(function(){
					$("#2").show();
					$("#1").hide();
				}); 
			});
		</script>		
	</head>
	<body>
		<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			常见问题	
		</div>
	</div>
	<div class="block">		
		<!-- <iframe src="/resources/help/客户常见问题.html" width="1004px" height="800px" frameborder="0" id="1">			
		</iframe> -->
		<iframe src="/resources/other/questions.html" width="1004px" height="800px" frameborder="0">			
		</iframe>		
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	</body>		
</html>