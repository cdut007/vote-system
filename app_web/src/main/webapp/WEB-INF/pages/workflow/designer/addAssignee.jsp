<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		_task_unselected_assignee_panel = jq('#task-unselect-assignee-panel').panel({
			border : false,
			noheader : true,
			top : 0,
			left : 0
		});
		_task_unselect_assignee_list = jq('#task-unselect-assignee-list').datagrid({
			url : "${pageContext.request.contextPath}/workflow/designer/searchCandidateUser",
			singleSelect:true,
			//width:900,
			height : 420,
			idField : 'id',
			pagination : true,
			pageSize : 15,
			pageNumber : 1,
			pageList : [ 10, 15 ],
			rownumbers : true,
			sortName : 'userName',
			sortOrder : 'asc',
			striped : true,
			onLoadSuccess : function(data) {
				var rows = data.rows;
				for (var i = 0; i < rows.length; i++) {
					if (task.getCandidateUser(rows[i].sso) != null) {
						jq(this).datagrid('selectRow', i);
					}
				}
			},
			toolbar : [ {
				text : "保存",
				iconCls : 'icon-save',
				handler : function() {
					addAssignee();
				}
			} ]
		});
		_task_unselect_assignee_group = jq('#task-unselect-assignee-group').combobox({
			url : '${pageContext.request.contextPath}/pm/group/group!getAllGroups.action',
			//editable:false,
			valueField : 'groupId',
			textField : 'name'
		});
	});
	function searchAssignee() {
		var name = jq("#task-unselect-assignee-userName").val();
		var group = _task_unselect_assignee_group.combobox('getValue');
		//alert(group);
		var email = jq("#task-unselect-assignee-email").val();
		//alert(sso);
		_task_unselect_assignee_list.datagrid('reload', {
			userName : name,
			roleList : group,
			email : email
		});
	}
	function addAssignee() {
		var rows = _task_unselect_assignee_list.datagrid("getSelections");
		if(rows.length==1){
			var user = rows[0];
			task.assignee={
				id : user.id,
				userAccount : user.userAccount,
				userName : user.userName,
				userSex : user.userSex,
				title : user.title,
				email : user.email
			};
			loadTaskAssignee();
			_task_candidate_win.window('close');
		}else{
			jq.messager.alert('系统提示', '请选择代办人!', 'info');
		}
	}
//-->
</script>
<!--<table id="candidate-users-tree-list">-->
<!--</table>-->
<!--<ul id="candidate-users-tree"></ul>-->
<div id="task-unselect-candidate-user-panel" style="padding:5px;">
	<table border="0">
		<tr>
			<td>角色:</td>
			<td>
				<select id="task-unselect-assignee-group" name="task-unselect-assignee-group" style="width:120px">
					<option value="">-全部-</option>
					<c:forEach items="${roles}" var="role">
						<option value="${role.id}">${role.roleName}</option>
					</c:forEach>
				</select>
			</td>
			<td>用户名:</td>
			<td>
				<input type="text" id="task-unselect-assignee-userName" name="task-unselect-assignee-userName" value="" size="9" />
			</td>
			<td>邮箱:</td>
			<td>
				<input type="text" id="task-unselect-assignee-email" name="task-unselect-assignee-email" value="" size="9" />
			</td>
			<td>
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchAssignee();">搜索</a>
			</td>
		</tr>
	</table>
	<table id="task-unselect-assignee-list">
		<thead>
			<tr>
				<th field="userAccount" align="middle" sortable="true"></th>
				<th field="userName" width="100" align="middle" sortable="true">姓名</th>
				<th field="userSex" width="100" align="middle" sortable="true">性别</th>
				<th field="email" width="200" align="middle">邮箱</th>
				<th field="deleteMark" width="200" align="middle">帐号状态</th>
			</tr>
		</thead>
	</table>
</div>