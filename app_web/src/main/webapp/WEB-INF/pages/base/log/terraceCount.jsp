<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/page/base/log/terraceCount.js"></script>
</head>
<script type="text/javascript">
$(function(){
	$(".Wdate").click(function(){
		WdatePicker({
			dateFmt:"yyyy-MM-dd",
			minDate:this.name=="minDate"?undefined:($(".Wdate[name='minDate']").val()==""?undefined:$(".Wdate[name='minDate']").val()),
			maxDate:this.name=="maxDate"?undefined:($(".Wdate[name='maxDate']").val()==""?undefined:$(".Wdate[name='maxDate']").val())
		});
	});
});
</script>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			系统管理
			<code>&gt;</code>
			平台访问统计
		</div>
	</div>
		<div class="block">
		开始时间:<input id='minDate' class='inputxt Wdate' />&nbsp;&nbsp;结束时间:<input id='maxDate' class='inputxt Wdate' />
		<a class='button searchBtn red medium' style='float:right' id="countData">时间段查询</a>
		<table id="terrace-datagrid"></table>
		</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>