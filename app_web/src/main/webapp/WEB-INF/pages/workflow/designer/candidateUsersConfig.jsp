<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		_task_candidate_users_list = jq('#task-candidate-users-list').datagrid({
			title : "候选人",
			singleSelect : true,
			height : 450,
			rownumbers : true,
			striped : true,
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					_task_candidate_win.window('open');
					_task_candidate_win.window('setTitle', '候选人配置');
					_task_candidate_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/addCandidateUser?t=' + new Date().getTime());
				}
			} ]
		});
		_task_candidate_win = jq('#task-candidate-win').window({
			//href:'${pageContext.request.contextPath}/wf/procdef/procdef!forTaskListenerConfig.action', 
			title : "候选人配置",
			closed : true,
			//cache:false,
			draggable : false,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			modal : true,
			shadow : true
		});
		loadTaskCandidateUsers();
	});
	function candidateUsersBtFormatter(value, rowData, rowIndex) {
		var id = rowData.id;
		var d = '<img onclick="deleteCandidateUser(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="删除" style="cursor:hand;"/>';
		return d;
	}
	function deleteCandidateUser(id) {
		task.deleteCandidateUser(id);
		loadTaskCandidateUsers();
	}
	function loadTaskCandidateUsers() {
		var candidateUsers = task.candidateUsers;
		var candidate_users_grid_rows = [];
		//alert(listeners.getSize());
		for (var i = 0; i < candidateUsers.getSize(); i++) {
			var candidateUser = candidateUsers.get(i);
			var user = {
				id : candidateUser.id,
				userAccount : candidateUser.userAccount,
				userName : candidateUser.userName,
				userSex : candidateUser.userSex,
				action : ''
			};
			candidate_users_grid_rows[i] = user;
		}
		//alert(listener_grid_rows);
		var candidate_users_grid_data = {
			total : candidateUsers.getSize(),
			rows : candidate_users_grid_rows
		};
		_task_candidate_users_list.datagrid('loadData', candidate_users_grid_data);
	}
//-->
</script>
<!--<div id="task-candidate-users-panel">-->
<table id="task-candidate-users-list" name="task-candidate-users-list">
	<thead>
		<tr>
			<th field="userName" width="100" align="middle" sortable="false">姓名</th>
			<th field="userSex" width="100" align="middle" sortable="false">性别</th>
			<th field="email" width="100" align="middle" sortable="false">邮件</th>
			<th field="action" width="80" align="middle" formatter="candidateUsersBtFormatter">操作</th>
		</tr>
	</thead>
</table>
<!--</div>-->