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
            <div class="">产品详情</div>
            <div class="boxEdge " style="padding: 0px;">
                <div class=" pro_sale_box">
                    <img class="left" src="${util:property('backEnd')}/attachment/download/${product.attachment.path}" height="240" width="240"/>
                    <div class="pro_sale_info left">
                        <span class="pro_sale_name pro_sale_borderB">${product}</span>
                        <span class="pro_td_sale pro_sale_borderB">${empty product.price?'价格面议':toolBean.concat(product.price,'元','/',util:dictionary('PRODUCT_UNIT',product.productUnit))}</span>
                        <span>
                            <p>型号：${product.model}</p>
                            <p>品牌：${product.brand}</p>
                            <p>产地：${product.yieldly}</p>
                            <p>上架：<fmt:formatDate pattern="yyyy-MM-dd" value="${product.createTime}"/></p>
                        </span>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="pro_sale_content">
                	${product.specification}
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<div class="clear"></div>
<jsp:include page="/front/include/footer.jsp"/>
</body>
</html>