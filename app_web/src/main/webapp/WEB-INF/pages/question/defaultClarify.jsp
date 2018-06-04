<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<p style="text-align: center;">
	<strong><span style="font-family: 宋体; font-size: 20px;">${project.organ}</span></strong>
</p>
<p style="height: 10px;"></p>
<p style="text-align: center;">
	<strong><span style="font-family: 宋体; font-size: 20px;">${projectInstance.zbxmmc}(${projectItem.bdmc00})答疑文件</span></strong>
</p>
<p style="line-height: 33px;">
	<span style="font-family: 宋体; font-size: 16px;">投标单位：</span>
	<span style="font-size: 16px;text-decoration: underline;">&nbsp;${question.organBName }&nbsp;</span>
</p>
<p style="line-height: 27px; text-indent: 32px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span> 
</p>
<p style="line-height: 32px; text-indent: 32px;">
	<span style="font-family: 宋体; font-size: 16px;">招标编号为<strong><span style="text-decoration: underline;">${projectInstance.zbxmbh}</span></strong>的<strong><span style="text-decoration: underline;">${projectInstance.zbxmmc}(${projectItem.bdmc00})答疑文件</span></strong>,内容如下：
	</span>
</p>
<p style="line-height: 33px;">
</p>
	
	<pre readonly="true" style="white-space:pre-wrap; word-wrap:break-word;font-family: 宋体; font-size:16px; border:0px; width:700px;height:100%;overflow-y:visible; margin-left:32px;" id="detail_content">&nbsp;</pre>

<p style="line-height: 33px;">
	<span style="font-family: 宋体; font-size: 16px;">此答疑文件为招标文件的补充，与招标文件等效。</span>
</p>
<p style="line-height: 33px;">
	<span style="font-family: 宋体; font-size: 16px;">请收到本答疑文件后尽快确认并将回执递交于我公司。</span>
</p>
<p style="line-height: 150%; text-indent: 450px;">
	<span style="line-height: 150%; font-family: 宋体; font-size: 16px;">${project.organ}</span>
</p>
<p style="line-height: 150%;text-indent: 450px;">
	<span style="font-family: 宋体; font-size: 16px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
</p>
<%-- <p style="line-height: 150%;">
	<span style="line-height: 150%; font-size: 16px;"><span style="font-family: Times New Roman;">&nbsp;</span></span>
</p>
<p style="text-align: center; line-height: 150%;">
	<span style="left: -26px; top: 13px; width: 628px; height: 17px; position: relative; z-index: 251657728;"><span style="font-family: 宋体;"></span></span><span style="line-height: 150%; font-family: 宋体; font-size: 16px;">&nbsp;</span>
</p>
<p>
	<span style="font-family: 宋体;"><br clear="all" /></span>
</p>
<p style="text-align: center; line-height: 27px;">
	<strong><span style="font-family: 宋体; font-size: 16px;">回&nbsp;&nbsp;&nbsp;&nbsp; 执</span></strong>
</p>
<p style="line-height: 32px;">
	<span style="text-decoration: underline;"><span style="font-family: 宋体; font-size: 16px;">${projectInstance.organ}：</span></span>
</p>
<p style="line-height: 32px; text-indent: 38px;">
	<span style="font-family: 宋体; font-size: 16px;">我们已收到招标编号为<strong><span style="text-decoration: underline;">${projectInstance.organProjectCode}</span></strong>的<strong><span style="text-decoration: underline;">${projectInstance.zbxmmc}(${projectItem.bdmc00})变更通知</span></strong>,现予以确认。
	</span>
</p>
<p style="line-height: 32px; text-indent: 28px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
</p>
<p style="text-indent: 252px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span>
</p>
<p style="text-indent: 252px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;&nbsp;&nbsp; </span>
</p>
<p style="text-indent: 252px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;&nbsp;&nbsp; </span><span style="font-family: 宋体; font-size: 16px;">投标厂商全称(或签章)：</span>
</p>
<p style="text-indent: 28px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
</p>
<p style="margin: 0px 37px 0px 0px; text-indent: 248px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span><span style="font-family: 宋体; font-size: 16px;">投标代表（签字）<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>
</p>
<p style="text-indent: 264px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span>
</p>
<p>
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=DateUtils.getYear() %></span><span style="font-family: 宋体; font-size: 16px;">年&nbsp; &nbsp;月 &nbsp;&nbsp;日</span>
</p>
<p>&nbsp;</p>
<p></p> --%>