<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:formatDate value="${winBidNotice.publishDate}" pattern="yyyy" var="yearBegin"/>
<fmt:formatDate value="${winBidNotice.deadline}" pattern="yyyy" var="yearEnd"/>
<h2 style="text-align:center">
    ${winBidNotice.noticeTitle}
</h2>
<h4 style="text-align:center">
    (招标编号：${projectInstance.organProjectCode})
    <br>
</h4>

<p>
    本${projectInstance}（招标项目编号：${projectInstance.organProjectCode}），经评标委员会评审，确定${itemList}的中标人如下：
</p>

<h4>一、中标人信息</h4>
${itemList}:
    <c:forEach items="${list}" var="item">
        <p>中&nbsp;标&nbsp;人：${item.organB}</p>
        <p>中&nbsp;标&nbsp;价：${item.bidFile.tbbjje}${util:dictionary('JEDWDM',item.bidFile.tbbjdw)}${util:dictionary('CURRENCY',item.bidFile.bjbzdm)}</p>
    </c:forEach>

<h4>二、其他公示内容</h4>
    <p style="text-indent:0em;">
        <span>${winBidNotice.otherContent}</span>
    </p>

<h4>
    三、监督部门：
</h4>
<p>
    本招标项目的监督部门为：${projectInstance.jdbmmc}
</p>


<h4>
    四、联系方式：
</h4>
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












<%--
<p>
    <span class="ye">招标编号：${projectInstance.zbxmbh}</span>
</p>
<p>
    <span class="ye">资金来源：<c:forEach items="${fn:split(project.zjly00,',')}" var="item">${util:dictionary('ZJLYDM',item)}&nbsp;&nbsp;</c:forEach></span>
</p>
<p>
    <span class="ye">所属行业：${util:dictionary('INDUSTRY',project.industry)}</span>
</p>
<p>
    <span class="ye">实&nbsp;施&nbsp;地：${util:dictionaryPath('REGION',project.region)}</span>
</p>
<p>
    <span class="ye"><br/></span>
</p>
<p>
    <span class="ye">开标时间：<fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
</p>
<p>
    <span class="ye"><br/></span>
</p>
<p>
    ${organA}受${organT}的委托，对${projectInstance}（${projectItemList}）组织了${util:dictionary('ZBFS00',projectInstance.zbfs00)}，并已完成了评标工作。经评标委员会评议推荐，现将该项目中标人公告如下：
</p>
<p>
    &nbsp;
</p>
<p>
    项目名称：${projectInstance}
</p>
<p>
    &nbsp;
</p>
<c:forEach items="${list}" var="item">
	<p>
		${item.projectItem}
	</p>
	<p>中&nbsp;标&nbsp;人：${item.organB}</p>
	<p>中&nbsp;标&nbsp;价：${item.bidFile.tbbjje}${util:dictionary('JEDWDM',item.bidFile.tbbjdw)}${util:dictionary('CURRENCY',item.bidFile.bjbzdm)}</p>
</c:forEach>
<p>
    &nbsp;
</p>
<p>
    公告时间：<fmt:formatDate value="${winBidNotice.publishDate}" pattern="yyyy年MM月dd日"/>——<c:choose><c:when test="${yearBegin eq yearEnd}"><fmt:formatDate value="${winBidNotice.deadline}" pattern="MM月dd日"/></c:when><c:otherwise><fmt:formatDate value="${winBidNotice.deadline}" pattern="yyyy年MM月dd日"/></c:otherwise></c:choose>
</p>
<p>
    &nbsp;
</p>
<p>
    各投标人若有异议的，可以在公示时间内，以书面形式向${organA}提出异议，逾期将不再受理。&nbsp;
</p>
<p>
    <br/>
</p>
<p>
    招&nbsp;标&nbsp;人:${organT}
</p>
<p>
    <br/>
</p>
<p>
    招标代理:${organA}
</p>

<c:if test="${not empty winBidNotice.contacts}">
<p>
    联&nbsp;系&nbsp;人:${winBidNotice.contacts}
</p>
</c:if>

<c:if test="${not empty winBidNotice.phone}">
<p>
    联系电话:${winBidNotice.phone}
</p>
</c:if>

<c:if test="${not empty winBidNotice.email}">
<p>
    电子邮箱:${winBidNotice.email}
</p>
</c:if>
<p>
    <br/>
</p>
<p>
   ${organA}
</p>
<p>
    <fmt:formatDate value="${winBidNotice.publishDate}" pattern="yyyy年MM月dd日"/>
</p>--%>
