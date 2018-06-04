<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="navBg">
    <div class="ctr navSize ">
        <!--3.1导航栏 -->
        <div class="nav1 left">
            <div class="nav">
                <div class="navMain">
                    <ul id="nav_all">
                        <li><a href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organIndex/${organ.id}" ${empty ORGAN_NAVIGATION?"class='hover'":""}> 首 页 </a></li>
                        <li><a href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organAbout/${organ.id}" ${ORGAN_NAVIGATION=='organAbout'?"class='hover'":''}>企业简介</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organNews/${organ.id}" ${ORGAN_NAVIGATION=='organNews'?"class='hover'":''}>企业动态</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organInfo/${organ.id}" ${ORGAN_NAVIGATION=='tenderBidInfo'?"class='hover'":''}>采招信息</a></li>
                        <li><a href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/contactUs/${organ.id}" ${ORGAN_NAVIGATION=='contactUs'?"class='hover'":''}>联系我们</a></li>
                    </ul>
                </div>
            </div>
            <script type="text/javascript">
                $(function () {
                    var st = 180;
                    $('#nav_all>li').mouseenter(function () {
                        $(this).find('ul').stop().slideDown(st);
                    }).mouseleave(function () {
                        $(this).find('ul').stop().slideUp(st);
                    });
                });
            </script>
        </div>
        <!--3.2搜索栏-->
        <div class="searchSm right">
	        <form:form action="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organInfo/${organ.id}/${type}" modelAttribute="searchModel" method="get" onsubmit="if($(this).find('.search_ipt').val()=='关键字查询'){$(this).find('.search_ipt').val('');}return true;">
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
		        <input class="iptBtn right" type="submit" value="查询"/>
	        </form:form>
        </div>
    </div>
</div>