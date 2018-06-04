<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html>
<head>
<title>待办任务管理</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	function complete() {
		if ($(":input:checked").length == 1) {
			taskForm($(":input:checked").val(), function() {
				$("form").submit();
			});
		}
	}
	function formatter(value, row, index) {
		if (value && value != null) {
			return "<a class=\"button orange small\"  href=\"${pageContext.request.contextPath}/workflow/customTaskForm?taskId=" + row.id + "\">办理</a>";
		} else {
			return "<a class=\"button blue small\" href=\"#\" onclick=\"var obj=this;$.ajax({url : '${pageContext.request.contextPath}/workflow/claim?taskId=" + row.id + "',type : 'post',success : function(data) {$('#tasklist').datagrid('reload');}});\">签收</a>";
		}
	}
</script>
</head>
<body>
	<table id="tasklist" class="easyui-datagrid" data-options="title:'流程定义管理',url:'${pageContext.request.contextPath}/workflow/pagingTask',idField:'id',pagination:true,rownumbers:true,fit:true,striped:true,fitColumns:true">
		<thead>
			<tr>
				<th data-options="title:'任务名称',field:'name'"></th>
				<th data-options="title:'任务描述',field:'description'"></th>
				<th data-options="title:'创建时间',field:'createTime'"></th>
				<th data-options="title:'操作',field:'assignee',formatter:formatter"></th>
			</tr>
		</thead>
	</table>
</body>
</html>
