<%@page pageEncoding="UTF-8"  import="com.mhb.common.util.DateUtils"%>
<p style="text-align: center;">
	<strong><span style="font-family: 宋体; font-size: 20px;">${bidEndingQuestion.organAName}</span></strong>
</p>
<p style="height: 10px;"></p>
<p style="text-align: center;">
	<strong><span style="font-family: 宋体; font-size: 20px;">${bidEndingQuestion.projectInstanceName}答疑文件</span></strong>
</p>
<p style="line-height: 33px;">
	<span style="font-family: 宋体; font-size: 16px;">投标单位：</span>
	<span style="font-size: 16px;text-decoration: underline;">&nbsp;${bidEndingQuestion.organBName }&nbsp;</span>
</p>
<p style="line-height: 27px; text-indent: 32px;">
	<span style="font-family: 宋体; font-size: 16px;">&nbsp;</span> 
</p>
<p style="line-height: 32px; text-indent: 32px;">
	<span style="font-family: 宋体; font-size: 16px;">招标编号为
	<strong><span style="text-decoration: underline;">${bidEndingQuestion.projectInstance.zbxmbh}</span></strong>
	的
	<strong><span style="text-decoration: underline;">${bidEndingQuestion.projectInstance.zbxmmc}</span></strong>答疑文件，内容如下：
	</span>
</p>
<p style="line-height: 33px;">
</p>
	
	<pre readonly="true" style="white-space:pre-wrap; word-wrap:break-word;font-family: 宋体; font-size:16px; border:0px; width:700px;height:100%;overflow-y:visible; margin-left:32px;" id="detail_content">&nbsp;</pre>

<p style="line-height: 33px;">
	<span style="font-family: 宋体; font-size: 16px;"></span>
</p>
<p style="line-height: 33px;">
	<span style="font-family: 宋体; font-size: 16px;"></span>
</p>
<p style="line-height: 150%; text-indent: 450px;">
	<span style="line-height: 150%; font-family: 宋体; font-size: 16px;">${bidEndingQuestion.organAName}</span>
</p>
<p style="line-height: 150%;text-indent: 450px;">
	<span style="font-family: 宋体; font-size: 16px;"><%=DateUtils.getYear()%>年<%=DateUtils.getMonth()%>月<%=DateUtils.getDay()%>日</span>
</p>