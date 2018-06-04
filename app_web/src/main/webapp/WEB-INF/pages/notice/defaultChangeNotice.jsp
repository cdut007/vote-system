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
 ，现将原公告部分内容进行变更:
	<br />
</p>

<p>
变更原因为：
<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </u>
<br />
<br />
<br />
</p>

<p>
变更的内容为：
${tenderNotice.changeContent}
<br />
<br />
<br />
</p>


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
		
