<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改时间</title>
	<jsp:include page="/common/link.jsp" />
	<script type="text/javascript">
		$(function(){
			$("#tijiao").click(function(){
				var time=$("#sj").val();
				$.ajax({
					url:"${pageContext.request.contextPath}/modify/reviseTime",
					type:"post",
					data:{"time":time},
					dataType:"json",
					success:function(result){
						alert(result.msg);
						window.location="${pageContext.request.contextPath}/home";
					}
				});
			});
			$("#xiugai").click(function(){
				var xt=$("#xt").val();
				$.ajax({
					url:"${pageContext.request.contextPath}/modify/reviseXTTime",
					type:"post",
					data:{"xttime":xt},
					dataType:"json",
					success:function(result){
						alert(result.msg);
						window.location="${pageContext.request.contextPath}/home";
					}
				});
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
			修改时间
		</div>
	</div>
	<div class="block">
	<h1>修改银行时间</h1>
	<P>格式：20160606</P>
	<input id="sj" type="text" placeholder="当前时间为${bankTime }" size="22" />
	<input type="button" value="提交" id="tijiao"/>
	<br/>
	<h1>修改系统日期</h1>
	<P>格式：2016-06-06 24:00:00</P>
	<input id="xt" type="text" placeholder="当前时间为${time }" size="22" />
	<input type="button" value="修改" id="xiugai"/>
	</div>
</body>