<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		_task_candidate_win = jq('#task-candidate-win').window({
			//href:'${pageContext.request.contextPath}/wf/procdef/procdef!forTaskListenerConfig.action',
			title:"候选角色配置",
			closed : true,
			//cache:false,
			draggable : false,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			modal : true,
			shadow : true
		});
		_task_candidate_groups_list = jq('#task-candidate-groups-list').datagrid({
			title : "候选角色",
			singleSelect : true,
			height : 450,
			rownumbers : true,
			striped : true,
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					_task_candidate_win.window('open');
					_task_candidate_win.window('setTitle', '候选角色配置');
					_task_candidate_win.window('refresh', '${pageContext.request.contextPath}/workflow/designer/addCandidateGroup?t='+new Date().getTime());
				}
			} ]
		});
		loadTaskCandidateGroups();
	});
	function candidateGroupsBtFormatter(value, rowData, rowIndex) {
		var id = rowData.id;
		var d = '<img onclick="deleteCandidateGroup(\'' + id + '\')" src="/resources/designer/image/delete.gif" title="' + "删除" + '" style="cursor:hand;"/>';
		return d;
	}
	function deleteCandidateGroup(id) {
		task.deleteCandidateGroup(id);
		loadTaskCandidateGroups();
	}
	function loadTaskCandidateGroups() {
		var candidateGroups = task.candidateGroups;
		var candidate_groups_grid_rows = [];
		//alert(listeners.getSize());
		for (var i = 0; i < candidateGroups.getSize(); i++) {
			var candidateGroup = candidateGroups.get(i);
			var group = {
				id:candidateGroup.id,
				roleName : candidateGroup.roleName,
				roleRemark : candidateGroup.roleRemark,
				action : ''
			};
			candidate_groups_grid_rows[i] = group;
		}
		//alert(listener_grid_rows);
		var candidate_groups_grid_data = {
			total : candidateGroups.getSize(),
			rows : candidate_groups_grid_rows
		};
		_task_candidate_groups_list.datagrid('loadData', candidate_groups_grid_data);
	}
//-->
</script>
<!--<div id="task-candidate-groups-panel">-->
<table id="task-candidate-groups-list" name="task-candidate-groups-list">
	<thead>
		<tr>
			<th field="roleName" width="100" align="middle" sortable="false">角色名称</th>
			<th field="roleRemark" width="100" align="middle" sortable="false">备注</th>
			<th field="action" width="80" align="middle" formatter="candidateGroupsBtFormatter">Action</th>
		</tr>
	</thead>
</table>
<!--</div>-->
