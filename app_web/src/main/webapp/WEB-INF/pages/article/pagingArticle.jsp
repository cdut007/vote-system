<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true" uedit="true"/>
<script type="text/javascript" src="/resources/page/article/pagingArticle.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			网站管理
			<code>&gt;</code>
			行业资讯管理
		</div>
	</div>
	<div class="block">
		文章类别：<select name="articleType" onchange="$('#article-datagrid').datagrid('reload',{articleType:this.value});">
					<option value="">全部</option>
					<c:forEach items="${catalogueService.retrieveCatalogue()}" var="item">
						<c:if test="${item.allowAddContent}">
							<option value="${item.catalogueFlag}">${item}</option>
						</c:if>
					</c:forEach>
				</select>
		<div class="blank10"></div>
		<table id="article-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
