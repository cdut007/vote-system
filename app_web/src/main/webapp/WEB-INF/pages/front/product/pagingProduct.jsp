<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
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
            当前位置：<a href="${util:property('frontEnd')}">首页</a> > <a href="${pageContext.request.contextPath}/front_product/productIndex">产品</a>
        </div>
        <!-- 4.1.2通知 -->
        <jsp:include page="/front/include/inform.jsp"/>
        <div class="clear"></div>
    </div>
    <!--4.2 检索栏-->
    <div class="marginTop boxEdge1">
        <div class="boxHeadT1"><span>按条件检索</span></div>
        <form:form action="${pageContext.request.contextPath}/front_product/pagingProduct" method="get" modelAttribute="searchModel" onsubmit="if($(this).find('.search_ipt').val()=='关键字查询'){$(this).find('.search_ipt').val('');}return true;">
	   		<form:hidden path="interval"/>	
	   		<form:hidden path="region"/>	
	   		<form:hidden path="productType"/>
	   		<form:hidden path="brand"/>	
	   		<form:hidden path="priceSection"/>	
	   		<form:hidden path="yieldly"/>
	        <div class="mainCo_if">
	            <ul>
	            	<li><span>产品分类：</span><a ${empty searchModel.productType?"class='tab_in_a'":""} href="javascript:$('#productType').val('').parent().submit();">全部</a><c:forEach items="${util:dictionaryTree('PRODUCT_TYPE',false)}" var="item"><a ${searchModel.productType==item.itemCode?"class='tab_in_a'":""} href="javascript:$('#productType').val('${item.itemCode}').parent().submit();">${item}</a></c:forEach></li>
	                <li><span>品牌名称：</span><a ${empty searchModel.brand?"class='tab_in_a'":""} href="javascript:$('#brand').val('').parent().submit();">全部</a><c:forEach items="${brandList}" var="item"><a ${searchModel.brand==item?"class='tab_in_a'":""} href="javascript:$('#brand').val('${item}').parent().submit();">${item}</a></c:forEach></li>
	                <li><span>价格区间：</span><a ${empty searchModel.priceSection?"class='tab_in_a'":""} href="javascript:$('#priceSection').val('').parent().submit();">全部</a><c:forEach items="${util:dictionaryTree('PRICE_SECTION',false)}" var="item"><a ${searchModel.priceSection==item.itemCode?"class='tab_in_a'":""} href="javascript:$('#priceSection').val('${item.itemCode}').parent().submit();">${item}</a></c:forEach></li>
	                <li><span>生产厂地：</span><a ${empty searchModel.yieldly?"class='tab_in_a'":""} href="javascript:$('#yieldly').val('').parent().submit();">全部</a><c:forEach items="${yieldlyList}" var="item"><a ${searchModel.yieldly==item?"class='tab_in_a'":""} href="javascript:$('#yieldly').val('${item}').parent().submit();">${item}</a></c:forEach></li>
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
    	<c:set var="index" value="0"/>
    	<c:set var="rowLength" value="${fn:length(page.rows)}"/>
    	<c:forEach begin="1" end="${rowLength mod 3 == 0?(rowLength/3):(rowLength==0)?0:((rowLength)/3+1)}">
    		<div class="pro_l_tr ">
    			<c:forEach begin="1" end="3">
    				<c:set var="item" value="${page.rows[index]}"/>
    				<c:set var="index" value="${index+1}"/>
    				<c:if test="${not empty item}">
	    				<div class="pro_l_td left ">
			                <a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank"><img src="${util:property('backEnd')}/attachment/download/${item.attachment.path}" width="240" height="240" alt=""/></a>
			                <a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank"><span class="left pro_td_name text_over">${item.productName}</span></a>
			                <div class="clear"></div>
			                <span class="left pro_td_whe text_over">${item.organ}</span><span class="right">${util:dictionaryPath('REGION',item.organ.region)}</span>
			                <div class="clear"></div>
			                <span class="pro_td_sale">${empty item.price?'价格面议':toolBean.concat(item.price,'元','/',util:dictionary('PRODUCT_UNIT',item.productUnit))}</span><a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank"><span class="right pro_td_call">联系我们</span></a>
		            	</div>
	            	</c:if>
    			</c:forEach>
    			<div class="clear"></div>
    		</div>
    	</c:forEach>
        <sys:page href="${pageContext.request.contextPath}/front_product/pagingProduct" page="${page}"/>
        <script>
            $(".pageNum span a").bind("click", function () {
                $(".pageNum span a ").removeClass("inNum");
                $(this).addClass("inNum");
            });
        </script>
    </div>
    <!--右侧边栏  代理机构-->
    <div class="boxWidth_290 right">
        <div class=" boxEdge">
            <div class="boxHeadT box_ico_hot">热门产品</div>
            <div class="CtList_width_270 Content_list CtList_height_100">
                <ul class="Content_list_dd ContentWidth_254">
                	<c:set value="${searchRecordService.retrieveKeywordsTop('product',15)}" var="hotProductList"/>
	               	<c:forEach items="${hotProductList}" var="keywords" varStatus="status">
			   			<a href="javascript:window.location.href='${pageContext.request.contextPath}/front_product/pagingProduct?keywords='+encodeURI('${keywords}')"><dd>${keywords}</dd></a>
			   		</c:forEach>
                </ul>
            </div>
        </div>
        <!--核心供应商-->
        <div class=" boxEdge marginTop">
            <div class="boxHeadT box_ico_hxgys1">核心供应商<a class="right" href="${pageContext.request.contextPath}/front_organ/pagingOrganB" target="_blank">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                	<c:forEach items="${organService.retrieveOrganBTop(20)}" var="item">
                		<li><a href="${pageContext.request.contextPath}/front_organ/B/organIndex/${item.id}" target="_blank" title="${item}"><span class="list_spot"> · </span>${item}</a></li>
                	</c:forEach>
                </ul>
            </div>
        </div>
        <!--banenr small-->
        <div class="boxWidth_290 banner_ctr_small2 marginTop"></div>

        <!--右侧边栏   热门资讯-->
        <div class=" boxEdge marginTop">
            <div class="boxHeadT box_ico_rmzxre">热门资讯<a class="right" href="${pageContext.request.contextPath}/front_article/news/pagingArticle" target="_blank">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                	<c:forEach items="${articleService.retrieveArticleTop('news',10)}" var="item">
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