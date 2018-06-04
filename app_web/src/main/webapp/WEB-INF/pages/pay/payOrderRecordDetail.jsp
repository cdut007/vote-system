<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<h2>订单信息</h2>
<div class="blank10"></div>
<table  class="mytableStyle">
	<tr>
		<th style="width:100px;">支付方式</th>
		<td>${util:dictionary('PAY_TYPE',payOrderRecord.payType)}</td>
	</tr>
	<tr>
		<th>经办人</th>
		<td>${payOrderRecord.user}</td>		
	</tr>
	<tr>
		<th>支付状态</th>
		<td>${empty payOrderRecord.queryId?"支付失败":"支付成功"}</td>
	</tr>
</table>
<div class="blank10"></div>

	<table class="mytableStyle">
		<tr>
			<th style="width:30px;"><input type="checkbox" name="all" /></th>
			<th style="width:250px;">商品信息</th>
			<th>单价（元）</th>
			<th>数量</th>
			<th>金额（元）</th>
			<th>收款人</th>
		</tr>
		<c:forEach items="${payOrderRecord.payItemRecordList}" var="item" varStatus="status">
			<tr>
				<td>
					<input type="checkbox" name="id" value="${item.id}" title="${(empty item.itemNumber?1:item.itemNumber)*item.price}" ${item.payStatus=='2'||item.payStatus=='1'?"disabled='disabled'":"" }/>
				</td>
				<td style="display: none" id="ss">${payOrderRecord.id}</td>
				<td style="width:250px;" title="${item.itemName}">${item.itemName}</td>
				<td style="text-align: right" id="money"><fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2" /></td>
				<td style="text-align: right">${empty item.itemNumber?1:item.itemNumber}</td>
				<td style="text-align: right"><fmt:formatNumber value="${item.totalPrice}" minFractionDigits="2" maxFractionDigits="2" /></td>
				<td>${item.toOrganName}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan='7'>
				共计：  
				<span  style="font-weight: bold;color: orange;font-size: 14px;float:right;">¥ <fmt:formatNumber value="${payOrderRecord.totalPrice}" minFractionDigits="2" maxFractionDigits="2" /></span>
			</td>
		</tr>
	</table>
	