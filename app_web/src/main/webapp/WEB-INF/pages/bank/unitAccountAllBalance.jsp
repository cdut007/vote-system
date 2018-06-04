<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"
	import="java.math.BigDecimal"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<style type="text/css">
</style>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
		$(function(){
			$("#tixian").click(function(){
			$.messager.prompt('提示信息', '提现金额:', function(result){
				if (result){
					var basicMoney=$("#ss").val();
			        $.ajax({
						url:ctx+"/bank/proposeMoney",
						data:{"basicMoney":result},
						type:"post",
						dataType:"json",
						success:function(result){
							alert(result.msg);
					}
					});
					}
					});

			});
				
			
		});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业账户查询
		</div>
		<table class="mytableStyle">
			<tr>
				<th width="150px">单位名称</th>
				<td>${accountName}
			</tr>
			<tr>

				<th>账号</th>
				<td>${accountNo}</td>
			</tr>
			<tr>
				<th>创建时间</th>
				<td><fmt:formatDate value="${createTime}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th>企业账户可用余额</th>
				<td>${kyAmt}</td>
			</tr>



			<tr>
				<th>企业账户总金额</th>
				<td>${sjAmt}</td>
			</tr>
			<tr>
				<td colspan="3" style="padding:10px 0 18px 0;">
					<input type="button" class="button orange" value="提现" id="tixian"/>
				</td>
			</tr>
		</table>
		<div class="blank10"></div>
		<jsp:include page="/common/bottom.jsp" />
</body>
</html>
