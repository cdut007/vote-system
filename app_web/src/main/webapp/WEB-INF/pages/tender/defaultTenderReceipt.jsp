<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center">
		<strong><span style="font-size: 48px;line-height:48px;font-family: 宋体">回 执 函</span></strong>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center;text-indent:16px">
		<strong><span style="font-size: 48px;font-family: 宋体">&nbsp;</span></strong>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:24px">
		<span style="font-size: 16px;font-family: 宋体">致：<span
			style="text-decoration:underline;">&nbsp; ${tenderReceipt.organBName } &nbsp;</span></span>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;line-height:24px">
		<span style="font-size: 16px;font-family: 宋体">&nbsp;</span>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
		<span style="font-size: 16px;font-family: 宋体">我公司
		<span style="text-decoration:underline;">&nbsp; ${tenderReceipt.organAName } &nbsp;</span>于
				
		<span style="text-decoration:underline;">&nbsp; <fmt:formatDate value="${tenderReceipt.createTime}" pattern="yyyy" /> &nbsp;</span>年
		<span style="text-decoration:underline;">&nbsp; <fmt:formatDate value="${tenderReceipt.createTime}" pattern="MM" /> &nbsp;</span>月
		<span style="text-decoration:underline;">&nbsp; <fmt:formatDate value="${tenderReceipt.createTime}" pattern="dd" /> &nbsp;</span>日，收到贵公司关于
							
		<span style="text-decoration:underline;">&nbsp; ${tenderReceipt.tenderItem.projectInstanceName } 【${tenderReceipt.tenderItem.projectItemName }】 &nbsp;</span>项目招标的投标书。
		</span>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center;text-indent:16px">
		<strong><span style="font-size: 48px;font-family: 宋体">&nbsp;</span></strong>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
		<span style="font-size: 16px;font-family: 宋体">特此回执！</span>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom:5px;margin-left:0;text-align:center;text-indent:16px">
		<strong><span style="font-size: 48px;font-family: 宋体">&nbsp;</span></strong>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
		<span style="font-size: 16px;font-family: 宋体">代理机构：（公章）</span>
	</p>
	<p
		style="margin-top:5px;margin-right:0;margin-bottom: 5px;margin-left:0;text-indent:32px;line-height:33px">
		<span style="font-size: 16px;font-family: 宋体">日&nbsp;&nbsp;&nbsp;&nbsp;期：
		
		<span style="text-decoration:underline;">&nbsp; <fmt:formatDate value="${Date}" pattern="yyyy" /> &nbsp;</span>年
		<span style="text-decoration:underline;">&nbsp; <fmt:formatDate value="${Date}" pattern="MM" /> &nbsp;</span>月
		<span style="text-decoration:underline;">&nbsp; <fmt:formatDate value="${Date}" pattern="dd" /> &nbsp;</span>日
		</span>
	</p>
						
