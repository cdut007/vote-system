<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
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
<jsp:include page="/front/include/topbar.jsp"/>
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
            <div class="">企业简介</div>
            <div class="boxEdge " style="padding: 0px;">
                <div class="pro_sale_content pro_sale_box">
                    ${organ.description}
                </div>
                <div class=" pro_sale_box">
                	<c:forEach items="${organAptitudeList}" var="item">
                		<img title="${item}" class="left" src="${util:property('backEnd')}/attachment/download/${item.attachmentList[0].path}" height="240" width="340"/>
                	</c:forEach>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<div class="clear"></div>
<!-- 7帮助栏 -->
<jsp:include page="/front/include/footer.jsp"/>
</body>
</html>