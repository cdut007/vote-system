<%@page pageEncoding="UTF-8" import="com.mhb.common.util.DateUtils"%>
<p style="text-align: center; line-height: 27px;">
	<strong><span style="font-family: 宋体; font-size: 30px;">回&nbsp;&nbsp;&nbsp;&nbsp; 执</span></strong>
</p>
<p style="line-height: 32px;">
	<span style="text-decoration: underline;"><span style="font-family: 宋体; font-size: 16px;">${recruitFile.projectInstance.organ}：</span></span>
</p>
<p style="line-height: 32px; text-indent: 30px;">
	<span style="font-family: 宋体; font-size: 16px;">我们已收到招标编号为<strong><span style="text-decoration: underline;">${recruitFile.projectInstance.zbxmbh}</span></strong>的<strong><span style="text-decoration: underline;">${recruitFile.projectInstance.zbxmmc}(${recruitFile.projectItem.bdmc00})</span>答疑文件</strong>,现予以确认。
	</span>
</p>
<p style="text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span>
</p>
<p style="text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp; </span>
</p>
<p style="text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;">投标人/供货商(签字或签章)：${CURRENT_USER_SESSION_INFO.organ}</span>
</p>
<p style="text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span>
</p>
<p style="margin: 0px 37px 0px 0px; text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;">投标代表(签字或签章)<span style="text-decoration: underline;" id="sealPosition">${CURRENT_USER_SESSION_INFO}</span></span>
</p>
<p style="text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span>
</p>
<p style="text-indent: 220px;">
	<span style="font-family: 宋体; font-size: 16px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
</p>
<p>&nbsp;</p>
<p></p>