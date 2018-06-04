<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		_task_assignee_list = jq('#task-assignee-list').datagrid({
			title : "委托人",
			singleSelect : true,
			height : 450,
			rownumbers : true,
			striped : true,
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					_task_candidate_win.window('open');
					_task_candidate_win.window('setTitle', '委托人配置');
					_task_candidate_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/addAssignee?t=' + new Date().getTime());
				}
			} ]
		});
		_task_candidate_win = jq('#task-candidate-win').window({
			//href:'${pageContext.request.contextPath}/wf/procdef/procdef!forTaskListenerConfig.action', 
			title : "委托人配置",
			closed : true,
			//cache:false,
			draggable : false,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			modal : true,
			shadow : true
		});
		loadTaskAssignee();
	});
	function assigneeBtFormatter(value, rowData, rowIndex) {
		var d = '<img onclick="deleteAssignee()" src="/resources/designer/image/delete.gif" title="删除" style="cursor:hand;"/>';
		return d;
	}
	function deleteAssignee() {
		task.assignee = null;
		loadTaskAssignee(); 
	}
	function loadTaskAssignee() {
		var assignee_grid_rows = [];
		var assignee = task.assignee;
		if (assignee != null) {
			assignee_grid_rows[0] = assignee;
		}
		var assignee_grid_data = {
			rows : assignee_grid_rows
		};
		_task_assignee_list.datagrid('loadData', assignee_grid_data);
	}
//-->
</script>
<!--<div id="task-candidate-users-panel">-->
<table id="task-assignee-list" name="task-candidate-users-list">
	<thead>
		<tr>
			<th field="userName" width="100" align="middle" sortable="false">姓名</th>
			<th field="userSex" width="50" align="middle" sortable="false">性别</th>
			<th field="email" width="100" align="middle" sortable="false">邮件</th>
			<th field="action" width="80" align="middle" formatter="assigneeBtFormatter">操作</th>
		</tr>
	</thead>
</table>
<!--</div>-->