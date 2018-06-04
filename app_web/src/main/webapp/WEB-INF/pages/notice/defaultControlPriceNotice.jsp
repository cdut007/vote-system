<%@page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h1 style="text-align:center">
	${tenderNotice.noticeTitle}
</h1>
<h2 style="text-align:center">
	(招标编号：${projectInstance.zbxmbh})
	<br>
</h2>
<h2>
	一、内容：
</h2>
<p>
	${tenderNotice.controlPriceContent}
<br />
<p></p>
<br />
</p>
	<p style="text-indent:0em;">
		<span></span>项目名称：<span class="need_input u" name="projectInstance.zbxmmc">${projectInstance.zbxmmc}</span>
	</p>
	<p style="text-indent:0em;">
		<span></span>招标编号：<span class="need_input u" name="projectInstance.zbxmbh">${projectInstance.zbxmbh}</span>
	</p>
	<c:if test="${tenderNotice.ggxzdm=='6'}">	
				<c:choose>
					<c:when test="${projectInstance.projectInstanceType=='A01'||projectInstance.projectInstanceType=='A02'}">
						<p style="text-indent:0em;">
							<span></span>最高投标限价总价：<span class="need_input u" name="tenderNotice.controlPrice"><fmt:formatNumber value="${tenderNotice.controlPrice}" pattern="#,###.00"/></span>元
						</p>
						<p style="text-indent:0em;">
							<span></span>最高投标限价分部分项工程费合价：<span class="need_input u" name="tenderNotice.FBFXGCF"><fmt:formatNumber value="${tenderNotice.FBFXGCF}" pattern="#,###.00"/></span>元
						</p>
						<p style="text-indent:0em;">
							<span></span>最高投标限价措施项目费合价：<span class="need_input u" name="tenderNotice.CSXMF"><fmt:formatNumber value="${tenderNotice.CSXMF}" pattern="#,###.00"/></span>元
						</p>
						</c:when>
						<c:otherwise>
						<p style="text-indent:0em;">
							<span></span>最高投标限价：<span class="need_input u" name="tenderNotice.controlPrice"><fmt:formatNumber value="${tenderNotice.controlPrice}" pattern="#,###.00"/></span>元
						</p>
						</c:otherwise>
			</c:choose>
	</c:if> 
		<br />
	<p></p>


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


	
	<p>
    <br/>
	</p>
	<c:if test="${attachments.size() > 0}">
	<p style="text-indent:0em;">
		<span></span>附件：
	</p>
	
	<c:forEach items="${attachments}" var="attachment">
			<li><a target="_blank" href="${attachment.path}">${attachment.fjmc00}</a></li>
	</c:forEach>
	</c:if>
