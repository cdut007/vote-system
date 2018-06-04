<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
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
	<style type="text/css">
	.Gg_Content_info pre{
		font-family:微软雅黑;
		font-color:#666666;
		font-size:14px;
		overflow: hidden;
		white-space: pre; /* CSS2 */
		white-space: -moz-pre-wrap; /* Mozilla */
		white-space: -hp-pre-wrap; /* HP printers */
		white-space: -o-pre-wrap; /* Opera 7 */
		white-space: -pre-wrap; /* Opera 4-6 */
		white-space: pre-wrap; /* CSS 2.1 */
		white-space: pre-line; /* CSS 3 (and 2.1 as well, actually) */
		word-wrap: break-word; /* IE */
	}
	</style>
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
            当前位置：<a href="${util:property('frontEnd')}">首页</a> &gt; <a href="#">${catalogueService.getCatalogueByFlag(articleType)}</a>
        </div>
        <!-- 4.1.2通知 -->
        <jsp:include page="/front/include/inform.jsp"/>
        <div class="clear"></div>
    </div>
</div>
<div class="clear"></div>


<!--5 内容信息栏------------------------------------------------------>
<div class="ctr marginTop ">
    <div class="boxWidth_840  left">
        <span class="Gg_Content_bt">
            <p>${article.articleTitle}</p>
            <p>发布日期：<fmt:formatDate value="${article.publishTime}" pattern="yyyy-MM-dd"/></p>
        </span>
        <%-- <span class="Gg_Content_lab marginTop ">
            <table width="818">
                <tr>
                    <td>招标编号：<span>${notice.projectInstance.organProjectCode}</span></td>
                    <td>资金来源：<span>${notice.projectInstance.project.funding}</span></td>
                    <td>所属行业：<span>${util:dictionary('INDUSTRY',notice.projectInstance.project.industry)}</span></td>
                </tr>
                <tr>
                    <td>实施地：<span>${notice.tenderNoticeData.deliveryPlace}</span></td>
                    <td>开标时间：<span><fmt:formatDate value="${notice.tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd"/></span></td>
                    <td>招标方案核准号：<span>0000001</span></td>
                </tr>
            </table>
        </span> --%>
        <span class="Gg_Content_info marginTop marginTop">
        	${article.articleContent}
        </span>
    </div>
    <div class="boxWidth_290 right">
        <div class="boxWidth_290 right boxEdge">
            <div class="boxHeadT box_ico_dljg">代理机构<a class="right" href="${pageContext.request.contextPath}/front_organ/A/pagingOrgan">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                     <c:forEach items="${organService.retrieveOrganATop(14)}" var="item">
               			<li><a href="${pageContext.request.contextPath}/front_organ/A/organIndex/${item.id}" target="_blank" title="${item.ztmc00}"><span class="list_spot"> · </span>${item.ztmc00}</a></li>
               		</c:forEach>
                </ul>
            </div>
        </div>
        <!--热们资讯-->
        <div class="boxWidth_290 right boxEdge marginTop">
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
<!--报名---------------------------->
<div style="height: 100px;"></div>
<!-- <div class="signUp" id="signUp">
    <a href="#">
        <div class="Btn_Want">
            我要报名
        </div>
    </a>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= $(document).height() - $(window).height() - 430) {
                var scrollTopEr = $(document).height() - 430;
                $("#signUp").css({"position": "absolute", "top": scrollTopEr});
            }
        });
    });
</script> -->
<div class="clear"></div>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>