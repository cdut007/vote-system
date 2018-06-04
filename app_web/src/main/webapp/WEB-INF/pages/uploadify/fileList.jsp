<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>


<!--ready事件-->
<script type="text/javascript">
	function down(id, opFlag) {
		$('#downloadForm').attr('action', '${pageContext.request.contextPath}/attachment/download/' + id + '?opFlag=' + opFlag);
		$('#downloadForm').attr('method', 'post');
		$('#downloadForm').attr('enctype', 'multipart/form-data');
		$('#downloadForm').submit();
	}

	function del(id,fjsszt,fjgslx) {
		$.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
			if(r){
				$.ajax({
					url : '${pageContext.request.contextPath}/attachment/deleteAttachment?id=' + id,
					success : function(data) {
						$('#fileListDiv'+fjsszt).load('${pageContext.request.contextPath}/attachment/fileList', {
							"random" : Math.random(),
							"uploadUserId" : '${CURRENT_USER_SESSION_INFO.id}',
							"fjsszt" : fjsszt,
							"fjgslx" : fjgslx
						});
					}
				});
			}
		});
	}
</script>
	<table class='mytableStyle'> 
		<thead>
			<tr>
				<th width="20px"></th>
				<th width="20px"><input type="checkbox" /></th>
				<th>附件名称</th>
				<th>上传时间</th>
				<th>附件大小（K）</th>
				<th>附件归属</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${fileList}" var="t_fj_item" varStatus="status">
				<tr>
					<th>${status.count}</th>
					<td><input name="t_fj_id" type="checkbox" value="${t_fj_item.fjid00 }" /></td>
					<td>${t_fj_item.fjmc00}</td>
					<td>${t_fj_item.uploadTime}</td>
					<td><fmt:formatNumber value="${t_fj_item.length/(1024)}" pattern="#,###.##" /></td>
					<td>${util:dictionary('FJGSLX',t_fj_item.fjgslx)}</td>
					<td align="center"><a href="javascript:down('${t_fj_item.fjid00}','download');">下载</a> &nbsp;&nbsp; <a href="${pageContext.request.contextPath}/attachment/download/${t_fj_item.fjid00}" target="_blank">预览</a> &nbsp;&nbsp; <a href="javascript:del('${t_fj_item.fjid00}','${t_fj_item.fjsszt}','${t_fj_item.fjgslx}');">刪除</a></td>
				</tr>
			</c:forEach>
			<c:if test="${empty fileList}">
				<tr>
					<td colspan='8' style='text-align: center'>暂无附件！</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<form id='downloadForm'></form>


