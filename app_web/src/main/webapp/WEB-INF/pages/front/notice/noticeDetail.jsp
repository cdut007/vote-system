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
<%-- <jsp:include page="/common/link.jsp" /> --%><!-- 1.不能解决$.messager.alert()无法使用问题；2.导致页面热门搜索css样式出问题！ -->
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
        <span class="Gg_Content_bt">
            <p>${notice}</p>
            <p>发布日期：<fmt:formatDate value="${notice.ggfbsj}" pattern="yyyy-MM-dd"/></p>
        </span>
        <span style=padding-left:600px;">浏览次数:&nbsp;&nbsp;${count}</span>
        <span class="Gg_Content_lab marginTop ">
            <table >
                <tr>
                    <td style="width:80px">招标编号：</td><td style="width:240px"><div style="color: #c70000;white-space:pre-wrap;word-wrap:break-word;width:239px"><span>${notice.projectInstance.zbxmbh }</span></div></td>
                    <td style="width:80px">资金来源：</td><td style="width:150px"><div style="color: #c70000;white-space:pre-wrap;word-wrap:break-word;width:149px"><span>${notice.projectInstance.project.funding }</span></div></td>
                    <td style="width:80px">所属行业：</td><td style="width:160px"><div style="color: #c70000;white-space:pre-wrap;word-wrap:break-word;width:159px"><span>${util:dictionary('INDUSTRY',notice.projectInstance.project.industry) }</span></div></td>
                </tr>
                <tr>
                    <td style="width:80px">实施地：</td><td style="width:240px"><div style="color: #c70000;white-space:pre-wrap;word-wrap:break-word;width:239px"><span>${notice.tenderNoticeData.deliveryPlace}</span></div></td>
                    <td style="width:80px">开标时间：</td><td style="width:150px"><div style="color: #c70000;white-space:pre-wrap;word-wrap:break-word;width:149px"><span><fmt:formatDate value="${notice.tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd"/></span></div></td>
                    <td style="width:80px">代理机构：</td><td style="width:160px"><div style="color: #c70000;white-space:pre-wrap;word-wrap:break-word;width:159px"><span>${notice.projectInstance.organ}</span></div></td>
                </tr>
            </table>
        </span>
        <span class="Gg_Content_info marginTop marginTop">
        	${notice.ggnrwb}
        </span>
    </div>
    
    <div class="boxWidth_290 right">
    <!--右侧边栏  代理机构-->
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
    <!--右侧边栏   热门资讯-->
    <div class="boxWidth_290 right boxEdge marginTop">
        <div class="boxHeadT box_ico_rmzx">热门资讯<a class="right" href="${pageContext.request.contextPath}/front_article/news/pagingArticle" target="_blank">更多&gt;</a></div>
        <div class="CtList_width_270 Content_list CtList_height_300">
            <ul class="Content_list_out ContentWidth_254">
            	<c:forEach items="${articleService.retrieveArticleTop('news',8)}" var="item">
             		<li><a href="${pageContext.request.contextPath}/front_article/news/articleDetail/${item.id}" title="${item}" target="_blank"><span class="list_spot"> · </span>${item}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    </div>
    
    <!--<div class="boxWidth_290 right">
        <div class="boxWidth_290 right boxEdge">
            <div class="boxHeadT box_ico_dljg">代理机构<a class="right" href="${pageContext.request.contextPath}/front_organ/A/pagingOrgan">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                    <c:forEach items="${articleService.retrieveArticleTop('news',8)}" var="item">
	             		<li><a href="#" title="${item}"><span class="list_spot"> · </span>${item}</a></li>
	                </c:forEach>
                </ul>
            </div>
        </div>
        <!--热们资讯-->
        <!--<div class="boxWidth_290 right boxEdge marginTop">
            <div class="boxHeadT box_ico_rmzx">热门资讯<a class="right" href="${pageContext.request.contextPath}/front_article/pagingArticle/article">更多&gt;</a></div>
            <div class="CtList_width_270 Content_list CtList_height_300">
                <ul class="Content_list_out ContentWidth_254">
                    <c:forEach items="${articleService.retrieveArticleTop('news',8)}" var="item">
	             		<li><a href="#" title="${item}"><span class="list_spot"> · </span>${item}</a></li>
	                </c:forEach>
                </ul>
            </div>
        </div>
    </div>-->
    
</div>

<div class="clear"></div>
<center><a href="/filedown2"><span>&nbsp;&nbsp;下载投标编辑器</span></a></center>
<!--报名---------------------------->
<div style="height: 100px;"></div>
<jsp:useBean id="now" class="java.util.Date"/>
<c:if test="${not empty CURRENT_USER_SESSION_INFO.organId}">
	<c:if test="${notice.tenderNoticeData.applyDateBegin<now&&notice.tenderNoticeData.applyDateEnd>now&& notice.projectInstance.organId!=CURRENT_USER_SESSION_INFO.organId&&(empty notice.projectInstance.project.organId || notice.projectInstance.project.organId!=CURRENT_USER_SESSION_INFO.organId) &&notice.ggxzdm!='3'&&notice.ggxzdm!='6'&&!tenderNoticeService.hasCancelledNotice(notice.id)}">
		<div class="signUp" id="signUp">
		    <a id="forbid" href="/tenderApply/tenderApplyForm?noticeId=${notice.id}" target="_blank">
		        <div class="Btn_Want">我要报名</div><!-- <div class="Btn_Download">下载投标编辑器</div> -->
		         
		    </a>
		</div>
		<script type="text/javascript">
		    $(document).ready(function () {
		        $(window).scroll(function () {
		            if ($(document).scrollTop() >= $(document).height() - $(window).height() - 380) {
		                var scrollTopEr = $(document).height() - 380;
		                $("#signUp").css({"position": "absolute", "top": scrollTopEr});
		            }
		        });	        	
		    });
		</script>
	</c:if>
 </c:if>

<div class="clear"></div>

<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
<script type="text/javascript">
	//TODO
	$(document).ready(function(){
		 var msg = "${msg}";
		if(msg==null || msg==""){

		}else{
			alert("无法报名，请联系平台管理员！");
			$.messager.alert("系统提示",msg);	//无效
			/* $("#signUp").hide();	//无效
			$("#forbid").prop("disabled",true); */	//无效
		}
	});



</script>
</body>
</html>