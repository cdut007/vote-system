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
            当前位置：<a href="${util:property('frontEnd')}">首页</a> &gt; <a href="#">机构</a>
        </div>
        <!-- 4.1.2通知 -->
        <jsp:include page="/front/include/inform.jsp"/>
        <div class="clear"></div>
    </div>
    <!--4.2 检索栏-->
    <div class="marginTop boxEdge1">
        <div class="boxHeadT1"><span>按条件检索</span></div>
        <form:form action="${pageContext.request.contextPath}/front_organ/A/pagingOrgan" method="get" modelAttribute="searchModel" onsubmit="if($(this).find('.search_ipt').val()=='关键字查询'){$(this).find('.search_ipt').val('');}return true;">
	        <form:hidden path="region"/>
	        <form:hidden path="aptitudeLevel"/>
	        <form:hidden path="aptitudeSequence"/>
	        <div class="mainCo_if">
	            <ul>
	               	<li><span>资质序列：</span><a ${empty searchModel.aptitudeSequence?"class='tab_in_a'":""} href="javascript:$('#aptitudeSequence').val('').parent().submit();">全部</a><c:forEach items="${util:dictionaryTree('ZZSEQUENCE',false)}" var="item"><a ${searchModel.aptitudeSequence==item.itemCode?"class='tab_in_a'":""} href="javascript:$('#aptitudeSequence').val('${item.itemCode}').parent().submit();">${item}</a></c:forEach></li>
	                <li><span>资质等级：</span><a ${empty searchModel.aptitudeLevel?"class='tab_in_a'":""} href="javascript:$('#aptitudeLevel').val('').parent().submit();">全部</a><c:forEach items="${util:dictionaryTree('ZZDJDM',false)}" var="item"><a ${searchModel.aptitudeLevel==item.itemCode?"class='tab_in_a'":""} href="javascript:$('#aptitudeLevel').val('${item.itemCode}').parent().submit();">${item}</a></c:forEach></li>
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
	        <div class="left select_if">
	        	<c:set var="region" value="${util:dictionaryTree('REGION',false)}"/>
                <select class="select_main"  onchange="$('#region').val(this.value);$('.siblings').hide();$('#'+this.value).val('').show();">
                    <option value="">所有地区</option>
                    <c:forEach items="${region}" var="item">
                    	<option value="${item.itemCode}" ${fn:substring(searchModel.region,0,2)==fn:substring(item.itemCode,0,2)?"selected='selected'":""}>${item}</option>
                    </c:forEach>
                </select>
                <c:forEach items="${region}" var="item">
                	<c:if test="${not empty item.children}">
		                <select id="${item.itemCode}" class="select_main siblings" ${fn:substring(searchModel.region,0,2)==fn:substring(item.itemCode,0,2)?"":"style='display:none;'"} onchange="$('#region').val(this.value);">
		                	<option value="">所有地区</option>
		                	<c:forEach items="${item.children}" var="child">
		                		<option value="${child.itemCode}" ${searchModel.region==child.itemCode?"selected='selected'":""}>${child}</option>
		                	</c:forEach>
		                </select>
	                </c:if>
                </c:forEach>
                <%-- <form:select cssClass="select_main" path="industry">
                    <form:option value="" label="所有行业"/>
                    <form:options itemLabel="itemName" itemValue="itemCode" items="${util:dictionaryTree('INDUSTRY',false)}"/>
                </form:select> --%>
	        </div>
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
<div class="ctr marginTop ">
    <!--5.1 列表内容栏  左栏-->
    <div class="ContentList_conT left">
        <table class="tab_dljg" cellpadding="0" cellspacing="0">
        	<c:forEach items="${page.rows}" var="item">
        		<tr><td class="ico_dljg"></td><td><a href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organIndex/${item.id}" target="_blank">${item.ztmc00}</a></td><td>${util:dictionaryPath('REGION',item.region)}</td></tr>
        	</c:forEach>
        </table>
        <script type="text/javascript">
            $(document).ready(function() {
               // $(".tab_dljg tr").attr("bgColor", "#f0f0f0"); //为单数行表格设置背景颜色
                $(".tab_dljg tr:even").css("background-color", "#f0f0f0"); //为双数行表格设置背颜色素
            });
        </script>
        <sys:page href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/pagingOrgan" page="${page}"/>
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
            <div class="boxHeadT box_ico_${organRoleFlag=='A'?'hxgys':'dljg'}">${organRoleFlag=='A'?'核心供应商':'代理机构'}<a class="right" href="${pageContext.request.contextPath}/front_organ/${organRoleFlag=='A'?'B':'A'}/pagingOrgan" target="_blank">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                	<c:choose>
                		<c:when test="${organRoleFlag=='A'}">
                			<c:forEach items="${organService.retrieveOrganBTop(10)}" var="item">
			             		<li><a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" title="${item}" target="_blank"><span class="list_spot"> · </span>${item}</a></li>
			                </c:forEach>
                		</c:when>
                		<c:otherwise>
                			<c:forEach items="${organService.retrieveOrganATop(10)}" var="item">
			             		<li><a href="${pageContext.request.contextPath}/front_organ/A/organIndex/${item.id}" title="${item}" target="_blank"><span class="list_spot"> · </span>${item}</a></li>
			                </c:forEach>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
        </div>
        <!--右侧边栏   热门资讯-->
        <div class=" boxEdge marginTop">
            <div class="boxHeadT box_ico_rmzx">热门资讯<a class="right" href="${pageContext.request.contextPath}/front_article/news/pagingArticle" target="_blank">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                    <c:forEach items="${articleService.retrieveArticleTop('news',10)}" var="item">
	             		<li><a href="${pageContext.request.contextPath}/front_organ/A/organIndex/${item.id}" target="_blank" title="${item}"><span class="list_spot"> · </span>${item}</a></li>
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