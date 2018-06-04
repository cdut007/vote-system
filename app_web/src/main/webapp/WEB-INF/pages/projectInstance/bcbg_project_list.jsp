<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:技术得分点标准信息表表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<title>技术得分点信息</title>
<jsp:include page="/common/link.jsp" />
</head>
<body>
<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				招标文件补充变更
			</div>
		</div>
		<div class="blank10"></div>
	    <div class="wraper">
	    	<div class="tableTitle">可补充或变更项目列表</div>
			<table class="mytableStyle" cellspacing="0">
				<thead>
					<tr>
						<th width="20px"><nobr>序号</nobr></th>
						<th width="">项目编号</th>
						<th width=""><nobr>项目名称</nobr></th>
						<th >招标人</th>
						<th >招标方式</th>
						<th >立项时间</th>
						<th >操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="p" varStatus="status">
					<tr>
						<th>${status.count}</th>
						<td>${p.zbxmbh}</td>
						<td>${p.zbxmmc}</td>
						<td>${p.zbr000}</td>
						<td>${p.zbfs00}</td>
						<td><fmt:formatDate value="${p.lxsj00}" type="both" pattern="yyyy-MM-dd HH:mm:ss" dateStyle="default" timeStyle="default" /></td>
						<td><a href='${pageContext.request.contextPath}/t_zbwj/bcbg?zbxmid=${p.id}'>补充变更</a></td>
					</tr>
				</c:forEach>
				<c:if test="${empty page.rows}">
					<td colspan='5'>暂无信息！</td>
				</c:if>	
				</tbody>
			</table>
			<div class="blank10"></div>
		</div>
	</div>
</body>
</html>
