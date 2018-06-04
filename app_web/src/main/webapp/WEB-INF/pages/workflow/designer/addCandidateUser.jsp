<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		_task_unselected_candidate_user_panel = jq('#task-unselect-candidate-user-panel').panel({
			border : false,
			noheader : true,
			top : 0,
			left : 0
		});
		_task_unselect_candidate_user_list = jq('#task-unselect-candidate-user-list').datagrid({
			url : "${pageContext.request.contextPath}/workflow/designer/searchCandidateUser",
			//singleSelect:true,
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
					addCandidateUsers();
				}
			} ]
		});
		_task_unselect_candidate_user_group = jq('#task-unselect-candidate-user-group').combobox({
			url : '${pageContext.request.contextPath}/pm/group/group!getAllGroups.action',
			//editable:false,
			valueField : 'groupId',
			textField : 'name'
		});
	});
	function searchCandidateUser() {
		var name = jq("#task-unselect-candidate-user-userName").val();
		var group = _task_unselect_candidate_user_group.combobox('getValue');
		//alert(group);
		var email = jq("#task-unselect-candidate-user-email").val();
		//alert(sso);
		_task_unselect_candidate_user_list.datagrid('reload', {
			userName : name,
			roleList : group,
			email : email
		});
	}
	function addCandidateUsers() {
		var rows = _task_unselect_candidate_user_list.datagrid("getSelections");
		for (var i = 0; i < rows.length; i++) {
			var user = rows[i];
			task.addCandidateUser({
				id : user.id,
				userAccount : user.userAccount,
				userName : user.userName,
				userSex : user.userSex,
				title : user.title,
				email : user.email
			});
		}
		loadTaskCandidateUsers();
		_task_candidate_win.window('close');
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
				<select id="task-unselect-candidate-user-group" name="task-unselect-candidate-user-group" style="width:120px">
					<option value="">-全部-</option>
					<c:forEach items="${roles}" var="role">
						<option value="${role.id}">${role.roleName}</option>
					</c:forEach>
				</select>
			</td>
			<td>用户名:</td>
			<td>
				<input type="text" id="task-unselect-candidate-user-userName" name="task-unselect-candidate-user-userName" value="" size="9" />
			</td>
			<td>邮箱:</td>
			<td>
				<input type="text" id="task-unselect-candidate-user-email" name="task-unselect-candidate-user-email" value="" size="9" />
			</td>
			<td>
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchCandidateUser();">搜索</a>
			</td>
		</tr>
	</table>
	<table id="task-unselect-candidate-user-list">
		<thead>
			<tr>
				<th field="id" align="middle" checkbox="true"></th>
				<th field="userAccount" align="middle" sortable="true"></th>
				<th field="userName" width="100" align="middle" sortable="true">姓名</th>
				<th field="userSex" width="100" align="middle" sortable="true">性别</th>
				<th field="email" width="200" align="middle">邮箱</th>
				<th field="deleteMark" width="200" align="middle">帐号状态</th>
			</tr>
		</thead>
	</table>
</div>