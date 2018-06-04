<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 标书费用支付页面 -->
<head>
<title>标书费用支付</title>
<sys:link />
<script language="javascript">
	function createOrderInfo() {
		var tmpDate = new Date();
		var day = tmpDate.getDate();
		var month = tmpDate.getMonth() + 1;
		var year = tmpDate.getFullYear();
		var hours = tmpDate.getHours();
		var minutes = tmpDate.getMinutes();
		var seconds = tmpDate.getSeconds();

		month = ((month < 10) ? "0" : "") + month;
		day = ((day < 10) ? "0" : "") + day;
		hours = ((hours < 10) ? "0" : "") + hours;
		minutes = ((minutes < 10) ? "0" : "") + minutes;
		seconds = ((seconds < 10) ? "0" : "") + seconds;

		document.all.TranDate.value = year + month + day;
		document.all.TranTime.value = hours + minutes + seconds;
		document.all.MerOrderNo.value = "Test00" + year + month + day + hours
				+ minutes + seconds;
		document.all.MerTranSerialNo.value = "Mer" + year + month + day + hours
				+ minutes + seconds;
	}
</script>
<style type="text/css">
.money {
	font-weight: bold;
	color: orange;
	font-size: 14px;
}
</style>
</head>
<body>
	<%@ include file="/common/top.jsp"%>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="/index">首页</a>
			<code>&gt;</code>
			线下支付
		</div>
		<div class="blank10"></div>
		<div class='tableTitle2'>支付内容</div>
		<table class="mytableStyle">
			<tr>
				<th>商品信息</th>
				<th>单价（元）</th>
				<th>数量</th>
				<th>金额（元）</th>
			</tr>
			<c:set value="0" var="totalPrice" />
			<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
				<tr>
					<td><input type="hidden" value="${item.id}" name="id" />${item.itemName}</td>
					<td><fmt:formatNumber value="${item.price}" pattern="0.00" maxFractionDigits="2" /></td>
					<td>${empty item.itemNumber?1:item.itemNumber}</td>
					<td><fmt:formatNumber value="${(empty item.itemNumber?1:item.itemNumber)*item.price}" pattern="0.00" maxFractionDigits="2" /></td>
				</tr>
				<c:set value="${totalPrice+((empty item.itemNumber?1:item.itemNumber)*item.price)}" var="totalPrice" />
			</c:forEach>
			<tr style="height:40px;">
				<td colspan='6'>共计：<span class='money'>¥ <c:out value="${totalPrice}" /></span>
					<div class="fr">
						
						<button class='button red' id='online' onclick="$('#form1').submit();">网银支付</button>
						<!-- <button class='button red' id='offline' onclick="$('#payForm').submit();">电汇</button> -->
					</div>
				</td>
			</tr>
		</table>
		<form id="form1" method="post" action="${pageContext.request.contextPath}/unionpay/payOrder">
			<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
				<input type="hidden" value="${item.id}" name="id" />
			</c:forEach>
		</form>
		<form id="payForm" method="post" action="${pageContext.request.contextPath}/pay/paySure">
			<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
				<input type="hidden" value="${item.id}" name="id" />
			</c:forEach>
		</form>
		<div class="blank10"></div>
		<div class='tableTitle2'>支付方式说明</div>
		<div class="usBox">
			<p>为最大限度的给代理机构和投标单位提供便利，系统支持以下多种不同的支付方式：</p>
			<br />
			<p style="text-indent: 2em;">
				直接在系统中选择网银支付（支付便捷，系统自动对账） <i style="font-size:14pt;color:red">推荐！</i>
			</p>
			<p style="text-indent: 10em;">
				<span style="border:1px solid #ccc;color:red;padding:5px;cursor:pointer">网银支付</span>
			</p>
			
		</div>
		<%-- <form name="form1" method="post" action="http://127.0.0.1:8080/BPAYMer2/bocompay/pay1_singleLayerSingleOrderCreateAndPay.jsp">
			<p>
				<input type="hidden" name="merCert" value=""> 交易创建并付款(方便单层协议商户测试) 
			</p>

			<hr />
			<p>
				<font color="blue">商户证书ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> <input type="text" style="border-color:blue" name="MerCertID" value="301310063009501">
			</p>
			<hr />

			<table width="75%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="23%">交易码</td>

					<td width="77%"><input type="text" name="TranCode" value="BPAYPY4101"> <input type="submit" id="Submit" value="提交" name="submit"></td>
				</tr>
				<tr>
					<td width="23%">一级商户协议号*</td>

					<td width="77%"><input type="text" name="MerPtcId" value="1BPAY1404151029"></td>
				</tr>

				<tr>
					<td width="23%">请求日期*</td>

					<td width="77%"><input type="text" name="TranDate" value=""> yyyyMMdd <input type="button" name="createOrderId" value="生成时间" onClick="javascript:createOrderInfo();"></td>
				</tr>

				<tr>
					<td width="23%">请求时间*</td>

					<td width="77%"><input type="text" name="TranTime" value=""> HHmmss </td>
				</tr>
				<tr>
					<td>商户交易流水号*</td>
					<td width="77%"><input type="text" name="MerTranSerialNo" value=""></td>
				</tr>

				<tr>
					<td width="23%">协议信息:</td>
					<td></td>
				</tr>

				<tr>
					<td width="23%">业务信息:</td>
					<td></td>
				</tr>
				<tr>
					<td>平台商户（外部）订单号*</td>
					<td width="77%"><input type="text" name="MerOrderNo" value=""></td>
				</tr>
				<tr>
					<td width="23%">会员信息:</td>
					<td></td>
				</tr>
				<tr>
					<td>买家会员编号</td>
					<td width="77%"><input type="text" name="BuyerId" value="bId01"></td>
				</tr>
				<tr>
					<td>买家昵称</td>
					<td width="77%"><input type="text" name="BuyerName" value="bName01"></td>
				</tr>
				<tr>
					<td>卖家会员编号</td>
					<td width="77%"><input type="text" name="SellerId" value="sId01"></td>
				</tr>
				<tr>
					<td>卖家昵称</td>
					<td width="77%"><input type="text" name="SellerName" value="sName01"></td>
				</tr>

				<tr>
					<td width="23%">商品信息:</td>
					<td></td>
				</tr>
				<tr>
					<td>商品名称</td>
					<td width="77%"><input type="text" name="GoodsName" value="Cake01"></td>
				</tr>
				<tr>
					<td>商品简称</td>
					<td width="77%"><input type="text" name="GoodsTxt" value="C01"></td>
				</tr>
				<tr>
					<td>商品详情</td>
					<td width="77%"><input type="text" name="GoodsDesc" value="Genaral"></td>
				</tr>

				<tr>
					<td width="23%">交易信息:</td>
					<td></td>
				</tr>
				<tr>
					<td>交易方式*<br /> &nbsp;&nbsp;E(escrow)担保交易<br /> &nbsp;&nbsp;D(Direct)普通支付(单层协议)<br /> &nbsp;&nbsp;F(Fastpay)二级清分<br /> &nbsp;&nbsp;U(Current)实时到帐
					</td>
					<td width="77%" valign="top"><input type="text" name="TranModeId" value="D"></td>
				</tr>
				<tr>
					<td>交易金额(须两位小数)*</td>
					<td width="77%"><input type="text" name="TranAmt" value="${totalPrice}"></td>
				</tr>
				<tr>
					<td>交易币种*</td>
					<td width="77%"><input type="text" name="TranCry" value="CNY"></td>
				</tr>

				<tr>
					<td width="23%">通道信息:</td>
					<td></td>
				</tr>
				<tr>
					<td>通道接口编号</td>
					<td width="77%" valign="top"><input type="text" name="ChannelApi" value="3010001010"></td>
				</tr>
				<tr>
					<td>通道所属机构</td>
					<td width="77%"><input type="text" name="ChannelInst" value="netpay"></td>
				</tr>
				<tr>
					<td width="23%">备注信息:</td>
					<td></td>
				</tr>
				<tr>
					<td>买家备注</td>
					<td width="77%" valign="top"><input type="text" name="BuyerMemo" value="BuyerMemo"></td>
				</tr>
				<tr>
					<td>卖家备注</td>
					<td width="77%"><input type="text" name="SellerMemo" value="SellerMemo"></td>
				</tr>
				<tr>
					<td>平台商备注</td>
					<td width="77%" valign="top"><input type="text" name="PlatMemo" value="PlatMemo"></td>
				</tr>
				<tr>
					<td>付款备注</td>
					<td width="77%"><input type="text" name="PayMemo" value="PayMemo"></td>
				</tr>
				<tr>
					<td>安全域</td>
					<td width="77%"><input type="text" name="SafeReserved" value=""></td>
				</tr>
			</table>
			<p>&nbsp;</p>
		</form> --%>
	</div>
	<div class="blank10"></div>
	<%@ include file="/common/bottom.jsp"%>
</body>
</html>