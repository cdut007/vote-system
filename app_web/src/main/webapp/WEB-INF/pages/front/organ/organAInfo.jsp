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
    <script type="text/javascript" src="/resources/portal/yc-js/jquery.SuperSlide.2.1.1.js"></script>
</head>
<body>
<jsp:include page="/front/include/topbar.jsp"></jsp:include>
<div class="clear"></div>
<!--2banner栏-->
<jsp:include page="/front/include/organBanner.jsp"/>
<!--3导航栏-->
<jsp:include page="/front/include/organNavigation.jsp"/>
<div class="clear"></div>
<!-- 4内容栏 -->
<div class="content ctr">
    <!--4.1内容栏 左-->
    <jsp:include page="/front/include/organLeft.jsp"/>
    <!--4.2内容栏 右-->
    <div class="contentR right">
        <div class="marginTop contentMain pro_info">
        	<c:choose>
        		<c:when test="${type==2}">
        			<div class="">中标候选人公示</div>
		            <div class="content_list3">
		                <table>
		                    <tbody>
		                    	<c:forEach items="${page.rows}" var="item">
		                    		<tr><td><a href="${pageContext.request.contextPath}/front_notice/noticeDetail/${item.id}" target="_blank">${item}</a></td><td width="100">${util:dictionaryPath('REGION',item.projectInstance.project.region)}</td><td width="100"><fmt:formatDate value="${item.gskssj}" pattern="yyyy-MM-dd"/></td></tr>
		                    	</c:forEach>
		                    </tbody>
		                </table>
		                <sys:page href="${pageContext.request.contextPath}/front_organ/A/organAInfo/${organ.id}/${type}" page="${page}"></sys:page>
		            </div>
        		</c:when>
        		<c:when test="${type==3}">
        			<div class="">中标公告</div>
		            <div class="content_list3">
		                <table>
		                    <tbody>
		                    	<c:forEach items="${page.rows}" var="item">
		                    		<tr><td><a href="${pageContext.request.contextPath}/front_notice/noticeDetail/${item.id}" target="_blank">${item.noticeTitle}</a></td><td width="100">${util:dictionaryPath('REGION',item.projectInstance.project.region)}</td><td width="100"><fmt:formatDate value="${item.publishDate}" pattern="yyyy-MM-dd"/></td></tr>
		                    	</c:forEach>
		                    </tbody>
		                </table>
		                <sys:page href="${pageContext.request.contextPath}/front_organ/A/organInfo/${organ.id}/${type}/${page}" page="${page}"></sys:page>
		            </div>
        		</c:when>
        		<c:otherwise>
        			<div class="">招标公告</div>
		            <div class="content_list3">
		                <table>
		                    <tbody>
		                    	<c:forEach items="${page.rows}" var="item">
		                    		<tr><td><a href="${pageContext.request.contextPath}/front_notice/noticeDetail/${item.id}" target="_blank">${item}</a></td><td width="100">${util:dictionaryPath('REGION',item.projectInstance.project.region)}</td><td width="100"><fmt:formatDate value="${item.ggfbsj}" pattern="yyyy-MM-dd"/></td></tr>
		                    	</c:forEach>
		                    </tbody>
		                </table>
		                <sys:page href="${pageContext.request.contextPath}/front_organ/A/organInfo/${organ.id}/${type}" page="${page}"></sys:page>
		            </div>
        		</c:otherwise>
        	</c:choose>
            
        </div>
    </div>
</div>
<div class="clear"></div>
<jsp:include page="/front/include/footer.jsp"/>
</body>
</html>