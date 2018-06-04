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
</head>
<body>
<jsp:include page="/front/include/header.jsp"/>
<div class="clear"></div>
<!-- 4 内容 -->
<div class="ctr marginTop">
    <!--左侧分类容器-->
    <c:set value="${productService.retrieveProductTypeTree()}" var="productTypeItemList"/>
    <div class="boxWidth_560 left ">
    	<c:set value="0,3" var="indexArray"/>
    	<c:forEach items="${fn:split(indexArray,',')}" var="index">
	        <c:set value="${productTypeItemList[index]}" var="productTypeItem"/>
	        <div class="boxEdge marginTop">
	        	<c:set value="${productTypeItemList[index]}" var="productTypeItem"/>
	            <div class="boxHeadT3">${productTypeItem}</div>
	            <div class="pro_class_box ">
	            	<c:forEach items="${productTypeItem.children}" var="childItem" varStatus="childItemStatus">
		           		<div class="pro_class_tr" ${fn:length(productTypeItem.children)==childItemStatus.count?"style='border-bottom: none;'":""}>
		                    <div class="pro_class_td1 left"><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${childItem.itemCode}"><nobr>${fn:substring(childItem.itemName,0,6)}${fn:length(childItem.itemName) gt 6?"...":""}</nobr></a></div>
		                    <div class="pro_class_td2 right">
		                        <c:forEach items="${childItem.children}" var="leafItem"><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${leafItem.itemCode}"><dd>${leafItem}</dd></a> </c:forEach>
		                    </div>
		                    <div class="clear"></div>
		                </div>
	                </c:forEach>
	            </div>
	        </div>
        </c:forEach>
    </div>
    <!-- 右侧分类容器-->
    <div class="boxWidth_560 right">
    	<c:set value="1,2" var="indexArray"/>
    	<c:forEach items="${fn:split(indexArray,',')}" var="index">
	        <div class="boxEdge marginTop">
		        <c:set value="${productTypeItemList[index]}" var="productTypeItem"/>
		        <div class="boxHeadT3">${productTypeItem}</div>
		        <div class="pro_class_box ">
		        	<c:forEach items="${productTypeItem.children}" var="childItem" varStatus="childItemStatus">
		        		<div class="pro_class_tr" ${fn:length(productTypeItem.children)==childItemStatus.count?"style='border-bottom: none;'":""}>
		                 <div class="pro_class_td1 left"><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${childItem.itemCode}"><nobr>${fn:substring(childItem.itemName,0,6)}${fn:length(childItem.itemName) gt 6?"...":""}</nobr></a></div>
		                 <div class="pro_class_td2 right">
		                     <c:forEach items="${childItem.children}" var="leafItem"><a href="${pageContext.request.contextPath}/front_product/pagingProduct?productType=${leafItem.itemCode}"><dd>${leafItem}</dd></a> </c:forEach>
		                 </div>
		                 <div class="clear"></div>
		             </div>
		            </c:forEach>
		        </div>
	        </div>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<div class="clear"></div>
<br/>
<jsp:include page="/front/include/footer.jsp"/>
<div class="clear"></div>
</body>
</html>