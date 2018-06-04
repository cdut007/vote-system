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
				$("#3").hide();
				$("#4").hide();
				$("#zb").click(function(){
					$("#1").show();
					$("#2").hide();
					$("#3").hide();
					$("#4").hide();
				});
				$("#zd").click(function(){
					$("#2").show();
					$("#1").hide();
					$("#3").hide();
					$("#4").hide();
				});
				$("#tb").click(function(){
					$("#3").show();
					$("#1").hide();
					$("#2").hide();
					$("#4").hide();
				}); 
				$("#zj").click(function(){
					$("#3").hide();
					$("#1").hide();
					$("#2").hide();
					$("#4").show();
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
			操作流程	
		</div>
	</div>
	<div class="block">
		<div>
		<ul>
			<li id="zb" style="width:180"><a href="javascript:;">1、招标单位操作流程</a></li>
			<li id="zd" style="width:180"><a href="javascript:;">2、招标代理机构操作流程</a></li>
			<li id="tb" style="width:180"><a href="javascript:;">3、投标单位操作流程</a></li>
			<li id="zj" style="width:180"><a href="javascript:;">4、专家操作流程</a></li>
		</ul>
		</div>
		<iframe src="/resources/help/招标单位操作手册.html" width="1200px" height="800px" frameborder="0" id="1">			
		</iframe>
		<iframe src="/resources/help/招标代理机构操作手册.html" width="1200px" height="800px" frameborder="0" id="2">			
		</iframe>
		<iframe src="/resources/help/投标单位操作手册.html" width="1200px" height="800px" frameborder="0" id="3">			
		</iframe>
		<iframe src="/resources/help/专家操作手册.html" width="1200px" height="800px" frameborder="0" id="4">			
		</iframe>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	</body>		
</html>