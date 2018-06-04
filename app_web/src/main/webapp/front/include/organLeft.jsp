<%@page pageEncoding="utf-8" %>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="contentL left">
    <!--4.1.1 banner-->
    <div class="marginTop">
        <img src="/resources/portal/yc-images/bannerS-vip.jpg" width="350" height="240"/>
    </div>
    <!--4.1.2 联系方式-->
    <c:if test="${ORGAN_NAVIGATION!='contactUs'}">
    <div class="marginTop callSize contentMain">
        <div>联系方式</div>
        <div class="content_list2" >
            <p>所属行业：${util:dictionaryPath('REGION',organ.industry)}</p>
            <p>所属地区：${util:dictionaryPath('REGION',organ.region)}</p>
            <span>
                <p>地　址：${organ.address}</p>
                <p>电　话：${organ.phone}</p>
                <p>传　真：${organ.faxNo}</p>
                <p>邮　编：${organ.zipCode}</p>
                <p>联系人：${TODO}</p>
            </span>
        </div>
    </div>
    </c:if>
    <!--4.1.3 企业动态-->
    <c:if test="${ORGAN_NAVIGATION!='organNews'}">
	    <div class="marginTop contentMain">
	        <div>企业动态<a class="right a_white" href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organNews/${organ.id}">更多&gt;</a></div>
	        <div class="content_list2">
	        	<jsp:useBean id="searchModel" class="com.mhb.common.model.SearchModel"/>
	        	<jsp:setProperty property="organId" name="searchModel" value="${organ.id}"/>
	        	<jsp:setProperty property="articleType" name="searchModel" value="platform"/>
	        	<c:set var="organNewsList" value="${articleService.retrieveArticleTopWithSearchModel(searchModel,7)}"/>
	            <ul>
	            	<c:forEach items="${organNewsList}" var="item">
	            		<li><a href="${pageContext.request.contextPath}/front_article/${item.articleType}/articleDetail/${item.id}" target="_blank">${item}</a></li>
	            	</c:forEach>
	            	<c:forEach begin="${fn:length(organNewsList)}" end="7">
	            		<li>&nbsp;</li>
	            	</c:forEach>
	            </ul>
	        </div>
	    </div>
    </c:if>
</div>