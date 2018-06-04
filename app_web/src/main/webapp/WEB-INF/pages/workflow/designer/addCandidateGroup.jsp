<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
<!--
	jq(function() {
		_task_candidate_unselected_group_panel_obj = jq('#_task_candidate_unselected_group_panel').panel({
			//height:600,
			border : false,
			noheader : true,
			top : 0,
			left : 0
		});
		_task_candidate_unselected_group_grid = jq('#_task_candidate_unselected_group_table').datagrid({
			//title : "用户组",
			url : "${pageContext.request.contextPath}/workflow/designer/searchCandidateGroup",
			//singleSelect:true,
			idField : 'id',
			height : 420,
			pagination : true,
			pageSize : 15,
			pageNumber : 1,
			pageList : [ 10, 15 ],
			rownumbers : true,
			sortName : 'name',
			sortOrder : 'asc',
			striped : true,
			onLoadSuccess : function(data) {
				var rows = data.rows;
				for (var i = 0; i < rows.length; i++) {
					if (task.getCandidateGroup(rows[i].name) != null) {
						jq(this).datagrid('selectRow', i);
					}
				}
			},
			toolbar : [ {
				text : "保存",
				iconCls : 'icon-save',
				handler : function() {
					addCandidateGroups();
				}
			} ]
		});
	});
	function searchTaskCandidateUnselectedGroup() {
		_task_candidate_unselected_group_grid.datagrid('reload', {
			roleName : jq("#filter_LIKES_name").val(),
			groupType:jq("#filter_groupType").val()
		});
	}
	function addCandidateGroups() {
		var rows = _task_candidate_unselected_group_grid.datagrid("getSelections");
		for (var i = 0; i < rows.length; i++) {
			var group = rows[i];
			task.addCandidateGroup({
				id:group.id,
				roleName:group.name
			});
		}
		loadTaskCandidateGroups();
		_task_candidate_win.window('close');
	}
//-->
</script>
<div id="_task_candidate_unselected_group_panel" style="padding:5px;">
	<div>
		<table border="0">
			<tr>
				<td>名称:</td>
				<td>
					<input id="filter_LIKES_name" type="text" name="filter_LIKES_name" value="" size="9" />
				</td>
				<td>
					<select id="filter_groupType" type="text" name="filter_groupType"  style="width:120px">
						<option value="TBRole">角色</option>
						<option value="TBDepartment">部门</option>
					</select>
				</td>
				<td>
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTaskCandidateUnselectedGroup();">查询</a>
				</td>
			</tr>
		</table>
	</div>
	<div>
		<table id="_task_candidate_unselected_group_table">
			<thead>
				<tr>
					<th field="id" align="middle" checkbox="true"></th>
					<th field="name" width="200" align="middle" sortable="true">角色名称</th>
				</tr>
			</thead>
		</table>
	</div>
</div>