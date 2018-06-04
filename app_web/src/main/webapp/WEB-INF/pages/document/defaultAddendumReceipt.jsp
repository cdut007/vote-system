<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<p style="text-align: center;">
	<strong><span style="font-family: 宋体; font-size: 20px;">补遗文件确认函</span></strong>
</p>
<p style="height: 10px;"></p>

<p style="line-height: 23px;">
	<span style="font-family: 宋体; font-size: 14px;">致：</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.recruitFile.organAName}&nbsp;</span>
</p>

<p style="line-height: 23px;text-indent: 20px;">
	<span style="font-family: 宋体; font-size: 14px;">我单位已收悉</span>
	<span style="font-size: 14px;">&nbsp;${recruitFileAddendum.title }&nbsp;</span>
</p>

<p style="line-height: 23px;text-indent: 20px;">
	<span style="font-family: 宋体; font-size: 14px;">特此确认！</span>
</p>

<p style="line-height: 150%;text-indent: 350px;">
	<span style="font-family: 宋体; font-size: 14px;">投标人：</span>
	<span style="font-size: 14px;">&nbsp;${organBName }&nbsp;</span>
</p>
<p style="line-height: 150%;text-indent: 350px;">
	<span style="font-family: 宋体; font-size: 14px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
</p>



