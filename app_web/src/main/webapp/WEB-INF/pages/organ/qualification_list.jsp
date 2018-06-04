<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="Generator" content="ECSHOP v2.7.3" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="ECSHOP演示站" />
<meta name="Description" content="ECSHOP演示站" />
<title>${util:property('business.platformName')}电子招投标交易平台</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.mytableStyle {
 font-size: 12px;
 width: 100%;
 border-collapse: collapse;
 border: #ccc 1px solid;
 border-width: 1px 0 0 1px;
}

.mytableStyle th {
 height: 27px;
 border: 1px #ccc solid;
 background-color: #eee;
 text-align: center;
}

.mytableStyle td {
 border: #ccc 1px solid;
 border-width: 0 1px 1px 0;
 height: 27px;
}

.tableTitle {
 background-color: #eee;
 border-top: #bbb 1px solid;
 border-left: #bbb 1px solid;
 border-right: #bbb 1px solid;
 padding: 5px 5px 5px 5px;
 font-weight: bold;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业管理
			<code>&gt;</code>
			资质管理
		</div>
	</div>
	<div class="block">
		<table class='mytableStyle'>
			<thead>
				<tr>
					<th style="width:30px"></th>
					<th style="width:30px"><input type="checkbox" /></th>
					<th>资质证书标号</th>
					<th>资质申报人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.rows}" var="item" varStatus="status">
					<tr>
						<th>${(page.page-1)*page.pageSize+status.count}</th>
						<td style="text-align:center"><input name="userId" type="checkbox" value="${item.id }" /></td>
						<td><a onclick="edit('${item.id}');">${item.zzzsbh}</a></td>
						<td>${item.zzsbr0}</td>
						<td align="center"><a href="/organ/department_form?id=${item.id}">更新</a>|<a href="/organ/deleteTBDepartment?id=${item.id}">删除</a></td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(page.rows)+1}" end="${page.pageSize}" varStatus="status">
					<tr>
						<th>${fn:length(page.rows)+(page.page-1)*page.pageSize+status.count}</th>
						<td style="text-align:center"><input type="checkbox" disabled="disabled" /></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="blank10"></div>
		<input type="button" class="button orange" value="添加资质" onclick="window.location='${pageContext.request.contextPath}/organ/qualification_form'" />
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
