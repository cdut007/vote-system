<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="0" var="totalPrice" />
<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
	<c:set value="${totalPrice+((empty item.itemNumber?1:item.itemNumber)*item.price)}" var="totalPrice" />
</c:forEach>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<TITLE></TITLE>
<jsp:include page="/common/link.jsp" />
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
<link href="/resources/css/cashier.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.zfTable {
	font-size: 12px;
	width: 100%;
	border: #ccc 1px solid;
}

.zfTable th {
	height: 27px;
	text-align: right
}

.zfTable td {
	height: 27px;
	text-align: left
}

.tableTitle {
	background-color: #eee;
	border-top: #bbb 1px solid;
	border-left: #bbb 1px solid;
	border-right: #bbb 1px solid;
	padding: 5px 5px 5px 5px;
	font-weight: bold;
	color: #222;
}

.bottom_table {
	padding: 4px 6px 4px 0px;
	margin: 3px auto 3px auto;
	color: #313031;
	TEXT-ALIGN: center;
}

.buttonDiv {
	TEXT-ALIGN: center;
}

.btn {
	color: #484848;
	font: 12px/1.5 arial;
	padding-top: 8px;
	padding-bottom: 8px;
	align: center
}

.money {
	font-weight: bold;
	color: orange;
	font-size: 14px;
}
</style>
<script>
	function resetVal() {
		document.getElementById('ggbt00').value = '';
	}
</script>
</head>
<body>
	<%@ include file="/common/top.jsp"%>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			网银支付页面
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<form name="form1" method="post" action="http://jinchan-pc:8080/bocompay/bocompay/pay1_singleLayerSingleOrderCreateAndPay.jsp">
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
			</form>
			<form action='${ctx}/pay.do' method='post'>
				<table class='zfTable'>
					<tr>
						<td>金额：<span class='money'>¥ ${totalPrice}</span></td>
					</tr>
				</table>
				<div id="bank">
					<div class="long-logo">
						<div id="J-chooseBankList" class="xbox ui-form">
							<h2>选择银行</h2>
							<div id="J-bankContainer">
								<ul class="ui-list-icons fn-mt-20 fn-clear " data-area="山西">
									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-abc906-115" value="ABCabc906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" checked="checked" /> <label class="icon-box limited-coupon " for="J-debit_express-abc906-115" data-channel="biz-channelType(DEBIT_EXPRESS)-ABC-中国农业银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon ABC" title="中国农业银行"></span> <span class="bank-name">中国农业银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-icbc906-215" value="ICBCicbc906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-icbc906-215" data-channel="biz-channelType(DEBIT_EXPRESS)-ICBC-中国工商银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon ICBC" title="中国工商银行"></span> <span class="bank-name">中国工商银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-ccb906-315" value="CCBccb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-ccb906-315" data-channel="biz-channelType(DEBIT_EXPRESS)-CCB-中国建设银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CCB" title="中国建设银行"></span> <span class="bank-name">中国建设银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-psbc907-415" value="PSBCpsbc907_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-psbc907-415" data-channel="biz-channelType(DEBIT_EXPRESS)-PSBC-中国邮政储蓄银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon PSBC" title="中国邮政储蓄银行"></span> <span class="bank-name">中国邮政储蓄银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-boc907-515" value="BOCboc907_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-boc907-515" data-channel="biz-channelType(DEBIT_EXPRESS)-BOC-中国银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon BOC" title="中国银行"></span> <span class="bank-name">中国银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-cmb906-615" value="CMBcmb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-cmb906-615" data-channel="biz-channelType(DEBIT_EXPRESS)-CMB-招商银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CMB" title="招商银行"></span> <span class="bank-name">招商银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-comm907-715" value="COMMcomm907_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-comm907-715" data-channel="biz-channelType(DEBIT_EXPRESS)-COMM-交通银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon COMM" title="交通银行"></span> <span class="bank-name">交通银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-spdb906-815" value="SPDBspdb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-spdb906-815" data-channel="biz-channelType(DEBIT_EXPRESS)-SPDB-浦发银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon SPDB" title="浦发银行"></span> <span class="bank-name">浦发银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-ceb906-915" value="CEBceb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-ceb906-915" data-channel="biz-channelType(DEBIT_EXPRESS)-CEB-中国光大银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CEB" title="中国光大银行"></span> <span class="bank-name">中国光大银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-citic906-1015" value="CITICcitic906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-citic906-1015" data-channel="biz-channelType(DEBIT_EXPRESS)-CITIC-中信银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CITIC" title="中信银行"></span> <span class="bank-name">中信银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-spabank906-1115" value="SPABANKspabank906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-spabank906-1115" data-channel="biz-channelType(DEBIT_EXPRESS)-SPABANK-深圳平安银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon SPABANK" title="深圳平安银行"></span> <span class="bank-name">深圳平安银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-cmbc907-1215" value="CMBCcmbc907_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-cmbc907-1215" data-channel="biz-channelType(DEBIT_EXPRESS)-CMBC-中国民生银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CMBC" title="中国民生银行"></span> <span class="bank-name">中国民生银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-hxbank906-1315" value="HXBANKhxbank906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-hxbank906-1315" data-channel="biz-channelType(DEBIT_EXPRESS)-HXBANK-华夏银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon HXBANK" title="华夏银行"></span> <span class="bank-name">华夏银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-gdb906-1415" value="GDBgdb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-gdb906-1415" data-channel="biz-channelType(DEBIT_EXPRESS)-GDB-广发银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon GDB" title="广发银行"></span> <span class="bank-name">广发银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-cib906-1515" value="CIBcib906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-cib906-1515" data-channel="biz-channelType(DEBIT_EXPRESS)-CIB-兴业银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CIB" title="兴业银行"></span> <span class="bank-name">兴业银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-jinchb906-1615" value="JINCHBjinchb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-jinchb906-1615" data-channel="biz-channelType(DEBIT_EXPRESS)-JINCHB-晋城银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon JINCHB" title="晋城银行"></span> <span class="bank-name">晋城银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-czccb906-1715" value="CZCCBczccb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-czccb906-1715" data-channel="biz-channelType(DEBIT_EXPRESS)-CZCCB-长治市商业银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon CZCCB" title="长治市商业银行"></span> <span class="bank-name">长治市商业银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-rxcb906-1815" value="RXCBrxcb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-rxcb906-1815" data-channel="biz-channelType(DEBIT_EXPRESS)-RXCB-榆次融信村镇银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> <span class="action-rt j-bank-discount-apop " data-target="J-promotion-rxcb906-"> <span class="action-rt-type">惠</span> <span class="rt-discount">9折</span>
											</span>
												<div class="j-apop-detail fn-hide" id="J-promotion-rxcb906-">
													<ul class="discount-list">
														<li class=""><span class="action-rt"> <span class="action-rt-type">惠</span> <span class="rt-discount">9折</span>
														</span> | <em>20元封顶</em></li>
													</ul>
												</div>
										</span> <span class="false icon RXCB" title="榆次融信村镇银行"></span> <span class="bank-name">榆次融信村镇银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-jzbank906-1915" value="JZBANKjzbank906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-jzbank906-1915" data-channel="biz-channelType(DEBIT_EXPRESS)-JZBANK-晋中银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon JZBANK" title="晋中银行"></span> <span class="bank-name">晋中银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-jsb906-2015" value="JSBjsb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-jsb906-2015" data-channel="biz-channelType(DEBIT_EXPRESS)-JSB-晋商银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon JSB" title="晋商银行"></span> <span class="bank-name">晋商银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>

									<li class="cashier-bank-kj "><input type="radio" name="channelToken" id="J-debit_express-yqccb906-2115" value="YQCCByqccb906_PAYMENT_DEBIT_EXPRESS_XBOX_MODEL" /> <label class="icon-box limited-coupon " for="J-debit_express-yqccb906-2115" data-channel="biz-channelType(DEBIT_EXPRESS)-YQCCB-阳泉市商业银行-type(unsave)"> <span class="icon-box-sparkling" bbd="false"> </span> <span class="false icon YQCCB" title="阳泉市商业银行"></span> <span class="bank-name">阳泉市商业银行</span> <!-- CMS:统一收银台/帮助/渠道健康度提示文案开始:cashier/help/healthyText.vm --> <!-- CMS:统一收银台/帮助/渠道健康度提示文案结束:cashier/help/healthyText.vm -->
									</label></li>
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="青海">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="四川">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="江苏">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="河北">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="西藏">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="福建">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="吉林">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="云南">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="上海">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="湖北">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="海南">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="湖南">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="甘肃">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="河南">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="山东">
								</ul>
								<ul class="ui-list-icons fn-mt-20 fn-clear  fn-hide " data-area="黑龙江">
								</ul>
							</div>
							<cite class="ui-list-tip"></cite>
							<p class="ui-btn ui-btn-ok fn-mt-10">
								<input type="button" class="ui-btn-text" value="下一步" seed="next-step-btn" onclick="$.messager.alert('系统提示','正在努力建设中，敬请期待。。。','info');" />
							</p>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="blank10"></div>
</body>
</html>