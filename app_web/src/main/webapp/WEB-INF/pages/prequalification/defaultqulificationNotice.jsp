<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:formatDate value="${notice.publishDate}" pattern="yyyy" var="yearBegin"/>
<fmt:formatDate value="${notice.deadline}" pattern="yyyy" var="yearEnd"/>
<%-- <h1 style="text-align: center;">
    ${projectInstance}（${projectItem}）中标公告
</h1> --%>
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
    ${organA}受${organT}的委托，对${projectInstance}（${notice.projectItemNames}）组织了${util:dictionary('ZBFS00',projectInstance.zbfs00)}，并已完成了资格预审工作。经评标委员会评议推荐，现将该项目资格预审合格投标人公示如下：
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

<p>资格预审合格投标人：${notice.organs}</p>

<p>
    &nbsp;
</p>
<p>
    公告时间：<fmt:formatDate value="${notice.publishDate}" pattern="yyyy年MM月dd日"/>——<c:choose><c:when test="${yearBegin eq yearEnd}"><fmt:formatDate value="${notice.deadline}" pattern="MM月dd日"/></c:when><c:otherwise><fmt:formatDate value="${notice.deadline}" pattern="yyyy年MM月dd日"/></c:otherwise></c:choose>
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

<c:if test="${not empty notice.contacts}">
<p>
    联&nbsp;系&nbsp;人:${notice.contacts}
</p>
</c:if>

<c:if test="${not empty notice.phone}">
<p>
    联系电话:${notice.phone}
</p>
</c:if>

<c:if test="${not empty notice.email}">
<p>
    电子邮箱:${notice.email}
</p>
</c:if>
<p>
    <br/>
</p>
<p>
   ${organA}
</p>
<p>
    <fmt:formatDate value="${notice.publishDate}" pattern="yyyy年MM月dd日"/>
</p>