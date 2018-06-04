<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<html>
<!-- 投标人  投标文件列表 -->
<head>
<!--装载文件-->
<link rel="stylesheet" href="/resources/css/tablestyle.css" type="text/css" />
<!--ready事件-->
<script type="text/javascript">
	$(function() {	
		$('#tenderFileList').load('/attachment/tenderFileList',{'random':Math.random(),'uploadUserId':'10000000000200','fjsszt':'81d76216-9258-4deb-a343-a2da33e81685','fjgslx':'40'});	
	});	

	function down(id,opFlag){
		$('#downloadForm').attr('action', '${pageContext.request.contextPath}/attachment/download/' + id+'?opFlag='+opFlag); 
		$('#downloadForm').attr('method', 'post'); 
		$('#downloadForm').attr('enctype', 'multipart/form-data'); 
		$('#downloadForm').submit();
	}
</script>
</head>
<body>
	<div></div>
	<table class='mytableStyle'>
		<thead>
			<tr>
				<th width="40px">序号</th>
				<th>投标文件名称</th>
				<th width='100px'>文件大小（K）</th>
				<th width='120px'>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${tenderFileList}" var="item" varStatus="status">
			<tr>
				<th>${status.count}</th>
				<td>${item.fjmc00}</td>
				<td><fmt:formatNumber value="${item.length/(1024)}" pattern="#,###.##" /></td>
				<td align="center">
					<a href="javascript:down('${item.fjid00}','download');">解密</a>
					<a href="javascript:down('${item.fjid00}','download');">下载</a>
				</td>
			</tr>
		</c:forEach>
		
		<c:if test="${empty tenderFileList}">
			<tr>
				<td colspan='4' style='text-align: center'>暂无附件！</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	<form id='downloadForm'></form>
</body>
</html>

