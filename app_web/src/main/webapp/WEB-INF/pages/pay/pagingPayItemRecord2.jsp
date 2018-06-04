<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎使用金蝉科技电子交易平台</title>
<link href="/resources/css/shopping.css" type="text/css" rel="stylesheet"/>
	<script src="/resources/easyui/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			$("[name='all']").change(
					function() {
						$("[name='id']").prop("checked",
								$("[name='all']").prop("checked"));
						var sum = 0;
						$("[name='id']:checked").each(function() {
							sum += parseFloat($(this).attr("title"));
						});
						$("#J_SmallTotal").html(sum.toFixed(2));
					});
			$("[name='id']")
					.change(
							function() {
								$("[name='all']")
										.prop(
												"checked",
												$("[name='id']").length == $("[name='id']:checked").length);
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
			$("#pay_offline").click(
					function() {
						if ($("[name='id']:checked").length == 0) {
							$.messager.alert("系统提示", "请选择商品");
							return;
						}
						$("#payForm")
								.attr("action", ctx + "/pay/payItemRecord")
								.submit();
					});
		});
	</script>
</head>
<body>
	<div class="head">
		<div class="head-top">
			<div>您好，欢迎光临金蝉科技电子招投标交易平台！</div>
			<div class="user">
				超级管理员<span>[退出]</span>
			</div>
			<ul class="head-right">
				<img src="/resources/images/shopping.png">
					<li>购物车(0)</li>
					<li>我的任务</li>
					<li>加入收藏</li>
			</ul>
		</div>
	</div>
	<div class="logo">
		<img src="/resources/images/logo.png">
			<ul class="jindu">
				<li class="moren">1</li>
				<img src="/resources/images/jindutiao.png">
					<li>2</li> <img src="/resources/images/jindutiao.png">
						<li>3</li> <img src="/resources/images/jindutiao.png">
							<li>4</li>
			</ul>
			<div class="wenzi">我的购物车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确认订单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支付成功</div>
	</div>
	<div class="clearfix"></div>
	<div class="goods">
		<div class="goods-info">
			<div class="biaoti">
				全部商品&nbsp;<span>2</span>
			</div>
			<ul class="shuxing">
				<li class="J_CheckBoxItem"><input type="checkbox" name="items[]" value="282816992884" checked="" /></li>
				<li class="shuxing_spxx">商品信息</li>
				<li class="shuxing_spxx"></li>
				<li class="shuxing_dj">单价（元）</li>
				<li class="shuxing_sl">数量</li>
				<li class="shuxing_je">金额（元）</li>
			</ul>
			<div class="goods-title">
				<input class="J_CheckBoxItem" type="checkbox" name="items[]" value="282816992884" checked="" />
				<h4>同煤集团招投标电子有限公司</h4>
				<c:forEach items="${payItemRecordList}" var="item" varStatus="status">
					<ul class="shuxing02">
						<li class="J_CheckBoxItem"><input type="checkbox" name="id" value="${item.id}" checked="" /></li>
						<li class="spxx">${item.itemName}</li>
						<li class="dj">￥<fmt:formatNumber value="${item.price}" pattern="#.00" maxFractionDigits="2" /></li>
						<li class="sl">${empty item.itemNumber?1:item.itemNumber}</li>
						<li class="je">￥<fmt:formatNumber value="${(empty item.itemNumber?1:item.itemNumber)*item.price}" pattern="0.00" maxFractionDigits="2" /></li>
					</ul>
				</c:forEach>
			</div>
				<%-- <tr>
					<td>
						<input type="checkbox" name="id" value="${item.id}" title="${(empty item.itemNumber?1:item.itemNumber)*item.price}" />
					</td>
					<td>${item.itemName}</td>
					<td>
						<fmt:formatNumber value="${item.price}" pattern="0.00" maxFractionDigits="2" />
					</td>
					<td>${empty item.itemNumber?1:item.itemNumber}</td>
					<td>
						<fmt:formatNumber value="${(empty item.itemNumber?1:item.itemNumber)*item.price}" pattern="0.00" maxFractionDigits="2" />
					</td>
				</tr> --%>
			<!-- 
			<div class="goods-title">
				<input class="J_CheckBoxItem" type="checkbox" name="items[]" value="282816992884" checked="" />
				<h4>同煤集团招投标电子有限公司</h4>
				<ul class="shuxing02">
					<li class="J_CheckBoxItem"><input type="checkbox" name="items[]" value="282816992884" checked="" /></li>
					<li class="spxx">2016年度选煤厂配件采购招标文件</li>
					<li class="dj">￥300.00</li>
					<li class="sl">1</li>
					<li class="je">￥300.00</li>
				</ul>
				<ul class="shuxing02_shixiao">
					<li class="shixiao">失效</li>
					<li class="spxx">2016年度选煤厂配件采购招标文件</li>
					<li class="dj">￥300.00</li>
					<li class="sl">1</li>
					<li class="je">￥300.</li>
				</ul>
			</div>
			<div class="goods-title">
				<input class="J_CheckBoxItem" type="checkbox" name="items[]" value="282816992884" checked="" />
				<h4>同煤集团招投标电子有限公司</h4>
				<ul class="shuxing02">
					<li class="J_CheckBoxItem"><input type="checkbox" name="items[]" value="282816992884" checked="" /></li>
					<li class="spxx">山西潞安集团蒲县后堡煤业有限公司 井下防爆变压器设备采购</li>
					<li class="dj">￥500.00</li>
					<li class="sl">1</li>
					<li class="je">￥500.00</li>
				</ul>
			</div>
			 -->
		</div>
		<ul class="balance">
			<li><input class="J_CheckBoxItem" type="checkbox" name="items[]" value="282816992884" checked="">全选</li>
			<li class="delete">删除选中商品</li>
			<li class="total">合计: <span> 0.00<span></li>
			<li class="jiesuan"><strong>去结算</strong></li>
		</ul>
		<div class="clearfix"></div>
	</div>
	<div class="helper">
		<div class="ctrl">
			<ul>
				新手上路
				<li><a href="">招标流程</a></li>
				<li><a href="">投标流程</a></li>
				<li><a href="">业务介绍</a></li>
				<li><a href="">操作流程</a></li>

			</ul>
			<ul>
				公司信息
				<li><a href="">人才招聘</a></li>
				<li><a href="">交流合</a></li>
				<li><a href="">公司介绍</a></li>

			</ul>
			<ul>
				公司信息
				<li><a href="">人才招聘</a></li>
				<li><a href="">交流合作</a></li>
				<li><a href="">公司介绍</a></li>

			</ul>
			<ul>
				使用指南
				<li><a href="">视频教程</a></li>
				<li><a href="">常见问题</a></li>
				<li><a href="">注册会员</a></li>

			</ul>

			<ul>
				友情链接
				<li><a href=""> 国家商务部</a></li>
				<li><a href="">国家发展和改革委员会</a></li>
				<li><a href="">国家财政部</a></li>
				<li><a href="">国家交通运输部</a></li>

			</ul>

			<!-- 6.2 电话栏 -->
			<div class="call_phone">


				<img src="/resources/images/call-ico.png"> <span class="right_rx">热线</span> <span class="phone">0351-5288092</span>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<!-- 7底部栏 -->


	<div class="footer">
		<div class="ctr_footer">
			<p class="copyright">Copyright ® 2001-2015 版权所有 晋ICP备00000000号-1 公网安备00000000000000号</p>
			<p class="sxjc">山西金蝉科技网 金蝉电子商务有限公司 电话：0351-5288092</p>
		</div>
	</div>
	<div class="clearfix"></div>


</body>
</html>
