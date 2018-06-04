<%@page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h1 style="text-align:center">
	${tenderNotice.noticeTitle}
</h1>
<h2 style="text-align:center">
	(招标编号：${projectInstance.organProjectCode})
	<br>
</h2>
<h2>
	一、内容：
</h2>
<p>
我单位于
<u><fmt:formatDate value="${tenderNotice.ggfbsj}" pattern="yyyy" /></u>
年
<u><fmt:formatDate value="${tenderNotice.ggfbsj}" pattern="MM" /></u>
月
<u><fmt:formatDate value="${tenderNotice.ggfbsj}" pattern="dd" /></u>
日在
	<u>&nbsp;&nbsp;${tenderNoticeData.ggfbmt==null?"山西省招标投标公共服务平台":tenderNoticeData.ggfbmt}&nbsp;&nbsp;</u>
发布了
	<u>&nbsp;&nbsp;${referenceNotice.noticeTitle}&nbsp;&nbsp;</u>
，现将该招标项目时间调整如下：
<br />
</p>
<p>&nbsp;</P>

<p>原信息内容：</p>

<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报名时间：从<u>&nbsp;&nbsp;<fmt:formatDate value="${tenderNotice.ggfbsj}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</u> 到 <u>&nbsp;&nbsp;<fmt:formatDate value="${tenderNotice.ggjssj}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</u>
</p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;招标文件发售时间：从<u>&nbsp;&nbsp;<fmt:formatDate value="${tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</u> 到 <u>&nbsp;&nbsp;<fmt:formatDate value="${tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</u>
</p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开标时间：<u>&nbsp;&nbsp;<fmt:formatDate value="${tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</u>
</p>
<p>&nbsp;</p>

<p>现延期为：</p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报名时间：从<u id="bmkssj">&nbsp;&nbsp;&nbsp;&nbsp;</u> 到 <u id="bmjssj">&nbsp;&nbsp;&nbsp;&nbsp;</u>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;招标文件发售时间：从<u>&nbsp;&nbsp;<fmt:formatDate value="${tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</u> 到 <u id="bstzsj">&nbsp;&nbsp;&nbsp;&nbsp;</u>
</p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开标时间：<u id="kbsj">&nbsp;&nbsp;&nbsp;&nbsp;</u>
</p>
<p>&nbsp;</p>


<h2>
	二、监督部门：
</h2>
<p>
	本招标项目的监督部门为：${projectInstance.jdbmmc}
	<br />
	<br />
</p>



<h2>
	三、联系方式：
</h2>
<p>
	招标人：${organT.ztmc00}
	<br />
</p>

<p>
	地址：${organT.address}
	<br />
</p>

<p>
	联系人：${projectInstance.project.contacts}
	<br />
</p>

<p>
	联系方式：${projectInstance.project.phones}
	<br />
	<br />
</p>

<p>
	招标代理机构：${organA.ztmc00}
	<br />
</p>

<p>
	地址：${organA.address}
	<br />
</p>

<p>
	联系人：${projectInstance.contacts}
	<br />
</p>

<p>
	联系方式：${projectInstance.phones}
	<br />
	<br />
</p>

<p>
	平台网站：www.jcebid.com
	<br />
	<br />
	<br />
</p>

<p>
	招标人或其招标代理机构主要负责人（项目负责人）：           （签名）
	<br />
	<br />
</p>
<p>
	招标人或其招标代理机构：                 （盖章）
	<br />
	<br />
</p>

	
	<c:if test="${attachments.size() > 0}">
	<p style="text-indent:0em;">
		<span></span>附件：
	</p>
	
	<c:forEach items="${attachments}" var="attachment">
			<li><a target="_blank" href="${attachment.path}">${attachment.fjmc00}</a></li>
	</c:forEach>
	</c:if>
		