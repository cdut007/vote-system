<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
    <link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet"/>
    <link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/resources/portal/yc-js/jquery-1.4.2.min.js"></script> 
    <script type="text/javascript" src="/resources/portal/yc-js/BreakingNews.js"></script>
</head>
<body>
<jsp:include page="/front/include/header.jsp"/>
<div class="clear"></div>
<!-- 4 内容 -->
<div class="ctr content">
    <!-- 4.1 面包屑导航    通知栏 -->
    <div class="address_nav">
        <!--4.1.1 当前位置 导航-->
        <div class="address_main left">
            当前位置：<a href="${util:property('frontEnd')}">首页</a> > <a href="#">${catalogueService.getCatalogueByFlag(articleType)}</a>
        </div>
        <!-- 4.1.2通知 -->
        <jsp:include page="/front/include/inform.jsp"/>
        <div class="clear"></div>
    </div>
    <!--4.2 检索栏-->
    <div class="marginTop boxEdge1">
        <div class="boxHeadT1"><span>按条件检索</span></div>
        <form:form action="${pageContext.request.contextPath}/front_article/${articleType}/pagingArticle" method="get" modelAttribute="searchModel" onsubmit="if($(this).find('.search_ipt').val()=='关键字查询'){$(this).find('.search_ipt').val('');}return true;">
	   		<form:hidden path="interval"/>	
	        <div class="mainCo_if">
	            <ul>
	                 <li><span>发布日期：</span><a ${empty searchModel.interval?"class='tab_in_a'":""} href="javascript:$('#interval').val('').parent().submit();">全部</a><c:forEach items="${util:dictionaryTree('INTERVAL',false)}" var="item"><a ${searchModel.interval==item.itemCode?"class='tab_in_a'":""} href="javascript:$('#interval').val('${item.itemCode}').parent().submit();">${item}</a></c:forEach></li>
	            </ul>
	        </div>
	        <script>
	            $(".mainCo_if ul li a ").bind("click", function () {
	                $(this).parent().find("a").removeClass("tab_in_a");
	                $(this).addClass("tab_in_a");
	            });
	        </script>
	        <div class="clear"></div>
	        <!--下拉列表-->
	        <c:if test="${articleType=='news'}">
	        <div class="left select_if">
                <form:select cssClass="select_main" path="industry">
                    <form:option value="" label="所有行业"/>
                    <form:options itemLabel="itemName" itemValue="itemCode" items="${util:dictionaryTree('INDUSTRY',false)}"/>
                </form:select>
	        </div>
	        </c:if>
	        <div class="searchSmall left">
	            <input class="search_ipt left" name="keywords" type="text" value="${empty searchModel.keywords?'关键字查询':searchModel.keywords}"
	                   onfocus="
	                                        if(this.value=='关键字查询'){
	                                        this.value='';
	                                        this.style.color='#252525';}"
	                   onblur="
	                                        if(this.value==''){
	                                        this.value='关键字查询';
	                                        this.style.color='#cdcdcd';
	                                        }"
	                    style="color:${empty searchModel.keywords?'#cdcdcd':'#252525'}"/>
	            <input class="search_iptBtn right" type="submit" value="查询"/>
	        </div>
        </form:form>
        <div class="clear"></div>
    </div>
</div>
<div class="clear"></div>
<!--5 内容列表栏------------------------------------------------------>
<div class="ctr marginTop">
    <!--5.1 列表内容栏  左栏-->
    <div class="ContentList_conT left">
    	<c:forEach items="${page.rows}" var="item">
    		<div class="list_box">
	            <span class="${articleType=='policy'?'ico_Zcfg':'ico_Hyzx'}"><a href="${pageContext.request.contextPath}/front_article/${articleType}/articleDetail/${item.id}">${item}</a></span>
	            <span class="right">发布日期：<fmt:formatDate value="${item.publishTime}" pattern="yyyy-MM-dd"/></span>
	            <span class="Xm_con">${toolBean.getTextFromHtml(item.articleContent)}</span>
	            <div class="clear"></div>
	        </div>
    	</c:forEach>
        <sys:page href="${pageContext.request.contextPath}/front_article/${articleType}/pagingArticle" page="${page}"/>
        <script>
            $(".pageNum span a").bind("click", function () {
                $(".pageNum span a ").removeClass("inNum");
                $(this).addClass("inNum");
            });
        </script>
    </div>
    <!--右侧边栏  代理机构-->
    <div class="boxWidth_290 right">
    <div class="boxEdge">
        <div class="boxHeadT box_ico_dljg">代理机构<a class="right" href="${pageContext.request.contextPath}/front_organ/A/pagingOrgan" target="_blank">更多&gt;</a></div>
        <div class="CtList_width_270 Content_list CtList_height_300">
            <ul class="Content_list_out ContentWidth_254">
                <c:forEach items="${organService.retrieveOrganATop(14)}" var="item">
               		<li><a href="${pageContext.request.contextPath}/front_organ/A/organIndex/${item.id}" target="_blank" title="${item.ztmc00}"><span class="list_spot"> · </span>${item.ztmc00}</a></li>
               	</c:forEach>
            </ul>
        </div>
    </div>
    <!--右侧边栏   热门资讯-->
    <div class=" boxEdge marginTop">
        <div class="boxHeadT box_ico_rmzx">热门资讯<a class="right" href="${pageContext.request.contextPath}/front_article/news/pagingArticle" target="_blank">更多&gt;</a></div>
        <div class="CtList_width_270 Content_list CtList_height_300">
            <ul class="Content_list_out ContentWidth_254">
                <c:forEach items="${articleService.retrieveArticleTop('news',8)}" var="item">
             		<li><a href="${pageContext.request.contextPath}/front_article/news/articleDetail/${item.id}" target="_blank" title="${item}"><span class="list_spot"> · </span>${item}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    </div>
</div>

<div class="clear"></div>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>