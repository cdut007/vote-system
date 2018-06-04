<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<p style="text-align: center;">
	<strong><span style="font-family: 宋体; font-size: 20px;">${recruitFileAddendum.title}</span></strong>
</p>
<p style="height: 10px;"></p>

<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">主 题：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.subject}&nbsp;</span>
</p>

<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">项目编号：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.projectCode }&nbsp;</span>
</p>

<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">招标人：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.organTName }&nbsp;</span>
</p>
<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">监督单位：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.supervisingUnit }&nbsp;</span>
</p>
<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">代理机构：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.organAName }&nbsp;</span>
</p>
<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">电 话：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.phone }&nbsp;</span>
</p>
<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">传 真：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.fax }&nbsp;</span>
</p>
<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">发件人：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.sendingUnit }&nbsp;</span>
</p>
<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">收件人：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.receivingUnit }&nbsp;</span>
</p>

<p style="line-height: 35px;">
	<span style="font-family: 宋体; font-size: 16px;">补遗内容：</span>
</p>
<p style="line-height: 35px;">
	<span style="font-family: 宋体; font-size: 16px;">其余内容保持不变。</span>
</p>
<p style="line-height: 35px;">
	<span style="font-family: 宋体; font-size: 16px;">收到补遗文件后，请24小时内予以回函确认。</span>
</p>

<p style="line-height: 150%;text-indent: 450px;">
	<span style="font-family: 宋体; font-size: 14px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
</p>



