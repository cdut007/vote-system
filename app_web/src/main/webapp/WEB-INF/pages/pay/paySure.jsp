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
<title>确认支付</title>
<sys:link datepicker="true" easyui="true"/>
<style type="text/css">
.money {
	font-weight: bold;
	color: orange;
	font-size: 14px;
}
</style>
<script>
	$(function() {
		$("#subBtn").click(function() {
			$("#paysureForm").attr("action", "${ctx}/fileCost/saveFileCost.do");
			$("#paysureForm").attr("method", "post");
			$("#paysureForm").submit();
		});
	});

	function bankCard() {
		$("#bankcard").css({
			top : $("#zfzh00").position().top - 30,
			left : $("#zfzh00").position().left
		});
		$("#bankcard").html($("#zfzh00").val().replace(/(\d{4})(?=\d)/g, "$1" + " "));
		$("#zfzh00").val($("#zfzh00").val().replace(/(\d{4})(?=\d)/g, "$1" + " "));
	}
</script>
</head>
<body>
	<%@ include file="/common/top.jsp"%>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			确定支付
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="blank10"></div>
			<form action="${pageContext.request.contextPath}/pay/payItemRecordByOffline" onsubmit="return $(this).form('validate')" method="post">
				<div class='tableTitle2'>支付信息</div>
				<c:set value="0" var="totalPrice" />
				<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
					<input type="hidden" value="${item.id}" name="payItemRecordId"/>
					<c:set value="${totalPrice+((empty item.itemNumber?1:item.itemNumber)*item.price)}" var="totalPrice" />
				</c:forEach>
				<table class="mytableStyle">
					<tr>
						<td class="need">*</td>
						<td>支付账号：</td>
						<td><input type="text" name="bankAccountNo" class="inputxt easyui-validatebox" data-options="required:true" /></td>
						<td class="need">*</td>
						<td>支付金额：</td>
						<td><span class='money'>¥ ${totalPrice}</span></td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td>支付方式：</td>
						<td>${util:dictionary('PAY_TYPE','2')}</td>
						<td class="need">*</td>
						<td>支付时间：</td>
						<td><input type="text" name="payDate" class="inputxt Wdate easyui-validatebox" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" data-options="required:true" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="need"></td>
						<td>备注：</td>
						<td colspan="4" style="padding:2px;"><textarea name="remark" style="width:99%;border:1px solid #ccc;height:45px"></textarea></td>
					</tr>
				</table>
				<div class="blank10"></div>
				<input type='submit' class="button red" id="subBtn" value='确定支付' />
			</form>
		</div>
	</div>
	<div class="blank10"></div>
</body>
</html>
