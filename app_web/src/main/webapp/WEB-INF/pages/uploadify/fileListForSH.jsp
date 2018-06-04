<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<html>
<head>
<!--装载文件-->
<link rel="stylesheet" href="/resources/css/tablestyle.css" type="text/css" />
<!--ready事件-->
<script type="text/javascript">
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
	<%--<div class="tableTitle">
		<c:forEach items="${util:dictionaryTree('FJGSLX',false)}" var="item">
			<c:if test="${fjgslx==item.key}">
				<c:out value="${item.value}"></c:out>
			</c:if>
		</c:forEach>
	</div>
	--%><table class='mytableStyle'>
		<thead>
			<tr>
				<th width="40px">序号</th>
				<th>附件名称</th>
				<th width='100px'>附件大小（K）</th>
				<th width='120px'>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${fileList}" var="t_fj_item" varStatus="status">
			<tr>
				<th>${status.count}</th>
				<td>${t_fj_item.fjmc00}</td>
				<td><fmt:formatNumber value="${t_fj_item.length/(1024)}" pattern="#,###.##" /></td>
				<td align="center">
					<a href="javascript:down('${t_fj_item.fjid00}','download');">下载</a>
				</td>
			</tr>
		</c:forEach>
		
		<c:if test="${empty fileList}">
			<tr>
				<td colspan='4' style='text-align: center'>暂无附件！</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	<form id='downloadForm'></form>
</body>
</html>

