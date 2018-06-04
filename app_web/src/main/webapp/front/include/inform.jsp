<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<div class="BreakingNewsController easing right" id="breakingnews">
    <div class="bn-title"></div>
    <img src="/resources/portal/yc-images/lb.gif" alt=""/>
    <ul>
        <c:forEach items="${articleService.retrieveArticleTop('inform',8)}" var="item">
       		 <li><a href="${pageContext.request.contextPath}/front_article/inform/articleDetail/${item.id}" target="_blank" title="${item}">${item}</a></li>
       	</c:forEach>
    </ul>
    <div class="bn-arrows"><span class="bn-arrows-left"></span><span class="bn-arrows-right"></span></div>
    <script type="text/javascript">
        $("#breakingnews").BreakingNews({
            background: "#FFF",
            title: "通 知",
            titlecolor: "#FFF",
            titlebgcolor: "#1caceb",
            linkcolor: "#333",
            linkhovercolor: "#1caceb",
            fonttextsize: 16,
            isbold: false,
            border: "solid 1px #1caceb",
            width: "700px",
            timer: 3000,
            autoplay: true,
            effect: "fade"
        });
    </script>
</div>