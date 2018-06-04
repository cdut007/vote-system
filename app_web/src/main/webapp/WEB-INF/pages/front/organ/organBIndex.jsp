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
        <div class="marginTop contentMain company">
            <div>公司简介</div>
            <div>
                <span class="company_content">${fn:substring(toolBean.delHTMLTag(organ.description),0,350)}${fn:length(organ.description) gt 350?"...":""}</span>
            </div>
        </div>
        <!--招标公告-->
        <div class="marginTop contentMain content_head">
            <div class="">供应产品<a class="right a_white" href="${pageContext.request.contextPath}/front_organ/${organRoleFlag}/organInfo/${organ.id}">更多&gt;</a></div>
            <c:set var="productList" value="${productService.retrieveProductTop(searchModel,8)}"></c:set>
            <!--一行------------->
            <c:set var="index" value="0"/>
	    	<c:set var="rowLength" value="${fn:length(productList)}"/>
	    	<c:forEach begin="1" end="${rowLength mod 4 == 0?(rowLength/4):(rowLength==0)?0:((rowLength)/4+1)}">
	    		<div class="pro_l_tr ">
	    			<c:forEach begin="1" end="4">
	    				<c:set var="item" value="${productList[index]}"/>
	    				<c:set var="index" value="${index+1}"/>
	    				<c:if test="${not empty item}">
	    					<div class="pro_sale_td left ">
			                    <a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank"><img src="${util:property('backEnd')}/attachment/download/${item.attachment.path}" width="170" height="170" alt=""/></a>
			                    <a href="${pageContext.request.contextPath}/front_organ/productDetail/${item.id}" target="_blank"><span class="left pro_td_name text_over">${item.productName}</span></a>
			                    <div class="clear"></div>
			                    <span class="pro_td_sale">${empty item.price?'价格面议':toolBean.concat(item.price,'元','/',util:dictionary('PRODUCT_UNIT',item.productUnit))}</span>
			                </div>
		            	</c:if>
	    			</c:forEach>
	    			<div class="clear"></div>
	    		</div>
	    	</c:forEach>
        </div>
    </div>
</div>
<div class="clear"></div>
<!-- 7帮助栏 -->
<div class="help">
    <div class="ctr">
        <!-- 6.1 帮助文字栏 -->
        <table class="helpTab left" cellspacing="0" cellpadding="0">
            <tr>
                <th><a>易采入门</a></th><th><a>采购商服务</a></th><th><a>供应商服务</a></th><th><a>安全隐私</a></th><th><a>合作共赢</a></th>
            </tr>
            <tr>
                <td><a>${util:property('business.platformName')}介绍</a></td><td><a>发布采购</a></td><td><a>发布商品</a></td><td><a>用户协议</a></td><td><a>投诉与建议</a></td>
            </tr>
            <tr>
                <td><a>采购商指南</a></td><td><a>发布招标</a></td><td><a>报价投标</a></td><td><a>隐私权政策</a></td><td><a>广告服务</a></td>
            </tr>
            <tr>
                <td><a>供应商指南</a></td><td><a>在线采购</a></td><td><a>信息核实</a></td><td><a>在线交易协议</a></td><td><a>市场合作</a></td>
            </tr>
            <tr>
                <td><a>招标机构指南</a></td><td></td><td></td><td><a>在线交易安全</a></td><td><a>友情链接</a></td>
            </tr>
        </table>
        <!-- 6.2 电话栏 -->
        <div class="call right">
            <div>
                <img src="/resources/portal/yc-images/call-ico.png"/>
                <span class="right pos2">易采热线</span>
                <span class="left">400-0000-000</span>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<!-- 8底部栏 -->
<div class="foot">
    <div class="ctr footEr">
        <p class="center">Copyright © 2001-2015  版权所有 晋ICP备00000000号-1   公网安备00000000000000号</p>
        <p class="center">山西${util:property('business.platformName')}网    山西${util:property('business.platformName')}有限公司   电话：0000-000-0000</p>
    </div>
</div>
</body>
</html>