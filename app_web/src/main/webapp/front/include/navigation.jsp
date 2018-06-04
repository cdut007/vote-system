<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<div class="navBg">
    <div class="ctr navSize ">
        <div class="nav left">
            <div class="nav">
                <div class="navMain">
                    <ul id="nav_all">
                        <li><a href="${util:property('frontEnd')}">首页</a></li>
                        <c:forEach items="${catalogueService.retrieveCatalogue()}" var="item">
                        	<c:if test="${item.display}">
                        		<li>
                        		<c:choose>
								 <c:when test="${item.catalogueFlag eq 'notice'}">
								 	<a ${NAVIGATION eq item.catalogueFlag?"":""} href="${empty item.catalogueURL?toolBean.concat('/front_notice/','pagingNotice'):item.catalogueURL}">${item}</a>
								 </c:when>
								 <c:otherwise>
								 	<a ${NAVIGATION eq item.catalogueFlag?"":""} href="${empty item.catalogueURL?toolBean.concat('/front_article/',item.catalogueFlag,'/pagingArticle'):item.catalogueURL}">${item}</a>
								 </c:otherwise>
							</c:choose>
	                        		<c:if test="${not empty item.children}">
	                        			<ul style="display: none;z-index:500;" id="nav_all_child">
		                        			<!-- <li style="width: 30px;"></li> -->
		                        			<c:forEach items="${item.children}" var="child">
		                        				 <li><a href="${child.catalogueURL}">${child}</a></li>
		                        			</c:forEach>
	                        			</ul>
	                        		</c:if>
                        		</li>
                        	</c:if>
                        </c:forEach>
                        <%-- <li><a>招标信息</a>
                            <ul style="display: none;">
                                <li style="width: 30px;"></li>
                                <li><a href="${pageContext.request.contextPath}/front_notice/pagingNotice">招标公告</a></li>
                                <li><a href="${pageContext.request.contextPath}/front_notice/pagingNotice">评标公示</a></li>
                                <li><a href="${pageContext.request.contextPath}/front_notice/pagingNotice">中标公告</a></li>
                            </ul>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/front_projectInstance/pagingProjectInstance">项目信息</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_product/productIndex">产&nbsp;&nbsp;品</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_organ/pagingOrganA">机&nbsp;&nbsp;构</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_article/pagingArticle/article">行业资讯</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_article/pagingArticle/policy">政策法规</a></li>
                        <li><a href="${pageContext.request.contextPath}/aboutUs">关于我们</a></li> --%>
                    </ul>
                </div>
            </div>
            <script type="text/javascript">
                $(function () {
                    var st = 180;
                    $('#nav_all>li').hover(function () {
                    	$(this).find('ul').stop(false, true).slideDown(st);
                    },function () {
                    	var ul=$(this).find('ul').stop(false, true);
                    	var timer=window.setTimeout(function(){
                    		ul.slideUp(st);
                    	},st*5);
                    	ul.one("mouseover",function(){
                    		clearInterval(timer);
                    	});
                    });
                    
                });
            </script>
        </div>
    </div>
</div>