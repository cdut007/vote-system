<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="${payItemRecordService.getPayItemRecordWithPayOrderRecord(payItemRecordId)}" var="payItemRecord" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>支付确认</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.wpsm {
	color: #f00;
}
</style>
<script type="text/javascript">
	$(function() {
		$("[name='all']").change(function() {
			$("[name='id']").prop("checked", $("[name='all']").prop("checked"));
			var sum = 0;
			$("[name='id']:checked").each(function() {
				sum += parseFloat($(this).attr("title"));
			});
			$("#J_SmallTotal").html(sum.toFixed(2));
		});
		$("[name='id']").change(function() {
			$("[name='all']").prop("checked", $("[name='id']").length == $("[name='id']:checked").length);
			var sum = 0;
			$("[name='id']:checked").each(function() {
				sum += parseFloat($(this).attr("title"));
			});
			$("#J_SmallTotal").html(sum.toFixed(2));
		});
		$("#J_SmallSubmit").click(function() {
			if ($("[name='id']:checked").length == 0) {
				$.messager.alert("系统提示", "请选择商品");
				return;
			}
			$("#payForm").submit();
		});
		$("#pay_offline").click(function() {
			if ($("[name='id']:checked").length == 0) {
				$.messager.alert("系统提示", "请选择商品");
				return;
			}
			$("#payForm").attr("action", ctx + "/pay/payItemRecord").submit();
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			支付确认
		</div>
		<div class="usBox">
			<form action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
				<input type="hidden" value="${taskId}" name="taskId" />
				<table width="98%" class="mytableStyle">
					<tbody>
						<tr>
							<td colspan="2">${payItemRecord.itemName}</td>
						</tr>
						<tr>
							<th style="width:100px;">支付单位：</th>
							<td>${payItemRecord.payOrderRecord.organ}</td>
						</tr>
						<tr>
							<th style="width:100px;">支付账号：</th>
							<td>${payItemRecord.payOrderRecord.bankAccountNo}</td>
						</tr>
						<tr>
							<th style="width:100px;">支付方式：</th>
							<td>${util:dictionary('PAY_TYPE',payItemRecord.payOrderRecord.payType)}</td>
						</tr>
						<tr>
							<th style="width:100px;">支付时间：</th>
							<td><fmt:formatDate value="${payItemRecord.payOrderRecord.payDate}" pattern="yyyy-MM-dd"/></td>
						</tr>
						<tr>
							<th style="width:100px;">支付金额：</th>
							<td><fmt:formatNumber value="${payItemRecord.price*(empty payItemRecord.itemNumber?1:payItemRecord.itemNumber)}" maxFractionDigits="2" minFractionDigits="2" /></td>
						</tr>
						<tr>
							<th style="width:100px;">备注：</th>
							<td>${payItemRecord.payOrderRecord.remark}</td>
						</tr>
						<tr>
							<th style="width:100px;">是否到账：</th>
							<td><input type="radio" value="true" name="pass" checked="checked"/>已经到账 <input type="radio" value="false"  name="pass"/>未到账或金额不符</td>
						</tr>
					</tbody>
				</table>
				<div class="blank10"></div>
				<input type="submit" class="button red" value="确定"/>
			</form>
		</div>
	</div>
</body>
</html>
