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
            当前位置：<a href="${util:property('frontEnd')}">首页</a> > <a href="#">招标公告</a>
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
       <%--  <span class="Gg_Content_bt">
            <p>${notice}</p>
            <p>发布日期：<fmt:formatDate value="${notice.ggfbsj}" pattern="yyyy-MM-dd"/></p>
        </span> --%>
        <span class="Gg_Content_lab marginTop ">
            <table width="818">
                <tr>
                    <td>项目名称：<span>${projectInstance.zbxmmc}</span></td>
                </tr>
                <tr>
                	<td>项目编号:<span>${projectInstance.zbxmbh}</span></td>
                </tr>
                <tr>
                    <td>建设单位：<span>${projectInstance.project.organ}</span></td>
                </tr>
                <tr>
                    <td>项目规模：<span>${projectInstance.project.xmgm00}</span></td>
                </tr>
                <tr>
                    <td>项目地点：<span>${util:dictionaryPath('REGION',projectInstance.project.region)}</span></td>
                </tr>
                <tr>
                    <td>立项时间：<span><fmt:formatDate value="${projectInstance.lxsj00}" pattern="yyyy-MM-dd"/></span></td>
                </tr>
                <tr>
                    <td>招标内容与范围：<span>${projectInstance.nryfw0}</span></td>
                </tr>
                <tr>
                	<td>招标方式:<span>${util:dictionary('ZBFS00',projectInstance.zbfs00)}</span></td>
                </tr>
                <tr>
                	<td>招标组织形式:<span>${util:dictionary('ZBZZXS',projectInstance.zbzzxs)}</span></td>
                </tr>
                <%-- <tr>
                	<td>监督部门代码:<span>${projectInstance.jdbmdm}</span></td>
                </tr>
                <tr>
                	<td>监督部门名称:<span>${projectInstance.jdbmmc}</span></td>
                </tr>
                <tr>
                	<td>审核部门代码:<span>${util:dictionary('SHBMDM',projectInstance.shbmdm)}</span></td>
                </tr>
                <tr>
                	<td>监督部门名称:<span>${projectInstance.shbmmc}</span></td>
                </tr>
                <tr>
                	<td>公共服务平台标识:<span>${util:dictionary('GGFWBS',projectInstance.ggfwbs)}</span></td>
                </tr> --%>
               <%--  <tr>
                	<td>申报责任人:<span>${projectInstance.zbzrr0}</span></td>
                </tr> --%>
                <tr>
                	<td>资格预审方式:<span>${util:dictionary('ZGSHFS',projectInstance.zgshfs)}</span></td>
                </tr>
                <%-- <tr>
                	<td>标书制作人:<span>${projectInstance.dlrzj0}</span></td>
                </tr>
                <tr>
                	<td>项目代理机构联系人:<span>${projectInstance.contacts}</span></td>
                </tr>
                <tr>
                	<td>项目代理机构联系方式:<span>${projectInstance.phones}</span></td>
                </tr>
                 --%>
                <tr>
                	<td>招标条件:<span>${projectInstance.terms}</span></td>
                </tr>
                
                <tr>
                	<td>委托方式:<span>${util:dictionary('DELEGATION_WAY',projectInstance.delegationWay)}</span></td>
                </tr>
                <tr>
                	<td>招标人名称:<span>${projectInstance.organTName}</span></td>
                </tr>
                <tr>
                	<td>代理机构:<span>${projectInstance.organAName}</span></td>
                </tr>
                <tr>
                	<td>行政区域:<span>${util:dictionaryPath('REGION',projectInstance.region)}</span></td>
                </tr>
                <tr>
                	<td>资格审核方式:<span>${util:dictionary('ZGSHFS',projectInstance.zgshfs)}</span></td>
                </tr>
            </table>
        </span>
        <span class="Gg_Content_info marginTop marginTop">
        	${notice.ggnrwb}
        </span>
    </div>
    <div class="boxWidth_290 right">
        <div class="boxWidth_290 right boxEdge">
            <div class="boxHeadT box_ico_dljg">代理机构<a class="right" href="${pageContext.request.contextPath}/front_organ/A/pagingOrgan" target="_blank">更多&gt;</a></div>
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
            <div class="boxHeadT box_ico_rmzx">热门资讯<a class="right"  href="${pageContext.request.contextPath}/front_article/news/pagingArticle" target="_blank">更多&gt;</a></div>
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
<div style="height: 100px;"></div>
<div class="clear"></div>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>