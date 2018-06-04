<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>费用支付</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.wpsm {
	color: #f00;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#deleteClose").click(function(){
			var closeId=$(this).parent().parent().children(":first").children().val();
			$.ajax({
				url:"${pageContext.request.contextPath}/pay/deletePayItemRecord",
				type:"post",
				data:{"id":closeId},
				dataType:"json",
				success:function(result){
					alert(result.msg);
					window.location.reload(true);
				}
			});
		});
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
		$("#pay_offline").click(function(){
			if ($("[name='id']:checked").length == 0) {
				$.messager.alert("系统提示", "请选择商品");
				return;
			}
			$("#payForm").attr("action",ctx+"/pay/payItemRecord").submit();
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			费用支付
		</div>
		<div class="usBox">
			<%--  //TODO  银联支付 --%>
			<!-- <h1 style="color:red;">线上支付正在开通中，请在待办任务下载招标文件里按照指定的提示转账汇款即可!</h1> -->
			<form id="payForm" action="${pageContext.request.contextPath}/pay/payItemRecord" method="post">
				已选商品 <strong class="price">¥<em id="J_SmallTotal">0.00</em></strong><a class="orange button small" id="J_SmallSubmit">结算</a>
				<table class="mytableStyle">
					<thead>
						<tr>
							<th style="width:30px;"><input type="checkbox" name="all" /></th>
							<th style="width:600px;">商品信息</th>
							<th>单价（元）</th>
							<th>数量</th>
							<th>金额（元）</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
							<tr>
								<td>
									<input type="checkbox" name="id" value="${item.id}" title="${(empty item.itemNumber?1:item.itemNumber)*item.price}" ${item.payStatus=='2'?"disabled='disabled'":"" }/>
								</td>
								<td>${item.itemName}</td>
								<td>
									<fmt:formatNumber value="${item.price}" pattern="0.00" maxFractionDigits="2" />
								</td>
								<td>${empty item.itemNumber?1:item.itemNumber}</td>
								<td>
									<fmt:formatNumber value="${(empty item.itemNumber?1:item.itemNumber)*item.price}" pattern="0.00" maxFractionDigits="2" />
								</td>
								<td>
									<c:if test="${item.payStatus=='2' }"><a class="red button small" id="deleteClose">删除</a></c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<div class="blank10"></div>
		</div>
	</div>
</body>
</html>
