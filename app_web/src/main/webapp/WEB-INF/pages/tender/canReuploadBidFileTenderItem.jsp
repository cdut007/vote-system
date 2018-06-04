<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 标书费用支付页面 -->
<head>
<title>投标文件管理</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	
</script>
<style type="text/css">
.money {
	font-weight: bold;
	color: orange;
	font-size: 14px;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="/index">首页</a>
			<code>&gt;</code>
			投标文件递交
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<div class='tableTitle'>投标管理</div>
				<table class="mytableStyle">
					<thead>
						<tr>
							<th style="width:35px">序号</th>
							<th style="width:250px">招标项目</th>
							<th style="width:150px">标段</th>
							<th style="width:150px">上传时间</th>
							<th style="width:150px">投标截止时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tenderItemList}" var="item" varStatus="status">
							<c:set value="${item[0]}" var="tenderItem"></c:set>
							<c:set value="${item[1]}" var="uploadDate"></c:set>
							<tr>
								<td>${status.count}</td>
								<td>${tenderItem.projectInstanceName}</td>
								<td>${tenderItem.projectItemName}</td>
								<td>
									<fmt:formatDate value="${uploadDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td></td>
								<td>
									<a class="easyui-linkbutton" href="${pageContext.request.contextPath}/bidReuploadEdit?tenderItemId=${tenderItem.id}">重新上传</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>