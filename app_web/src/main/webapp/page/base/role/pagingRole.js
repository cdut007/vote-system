$(function() {
	$("#role-datagrid").datagrid({
		fit:true,
		title : "角色列表",
		idField : "id",
		border : false,
		fitColumns : true,
		singleSelect:true,
		striped : true,
		rownumbers:true,
		pagination:true,
		url : ctx + "/role/pagingRoleData",
		columns : [[
			{field : "roleName",title : "角色名称",width : 100} 
		]],
		onSelect : function(rowIndex,rowData) {
			$("#userList").datagrid({
				url : ctx + "/user/pagingUserData",
				queryParams : {
					roleId : rowData.id
				}
			});
		},
		onLoadSuccess : function(data) {
			if (data.rows.length > 0) {
				$(this).datagrid("selectRow", 0);
			}
		}
	});
	$("#userList").datagrid({
		title:"人员列表",
		toolbar:'#roleUserlisttoolbar',
		rownumbers:true,
		border:false,
		pagination:true,
		fit:true,
		idField: 'id',
		striped:true,
		pageSize:20,
		columns:[[
			{field:'id',checkbox:true},
			{title:"姓名",field:'userName',align:"center",width:100},
			{title:"性别",field:'gender',align:"center",width:60},
			{title:"所属角色",field:'department.departmentName',width:80},
			{title:"联系电话",field:'phone',width:100},
			{title:"登录账号",field:'loginName',width:80},
			{title:"添加时间",field:'createDate',width:120},
			{title:"最后修改时间",field:'modifyDate',width:120},
			{title:"帐号状态",field:'deleteMark',align:"center",width:100}
		]]
	});
});

/**
 * 添加角色
 */
function addRole() {
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 600,
		height : 400,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "添加角色",
		href : ctx + "/role/roleEdit",
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "确认",
			color : "red",
			handler : function() {
				$("#" + id + " form").ajaxSubmit({
					beforeSend : function() {
						return $("#" + id + " form").form("validate");
					},
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$('#' + id).dialog('close');
							$('#role-datagrid').datagrid('reload');
						} else {
							$.messager.alert('系统提示', data.msg);
						}
					}
				});
			}
		}, {
			text : "取消",
			color : "red",
			handler : function() {
				$("#" + id).dialog("close");
			}
		} ]
	});
}
/*******************************************************************************
 * 编辑角色
 */
function editRole() {
	var rowData = $('#role-datagrid').datagrid('getSelected');
	if (rowData == null) {
		$.messager.alert('系统提示', '请选择一条数据！');
		return;
	}
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 600,
		height : 400,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "编辑角色",
		href : ctx + "/role/roleEdit?id=" + rowData['id'],
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "确认",
			iconCls : "myicon-accept",
			handler : function() {
				$("#" + id + " form").ajaxSubmit({
					beforeSend : function() {
						return $("#" + id + " form").form("validate");
					},
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$('#' + id).dialog('close');
							$('#role-datagrid').datagrid('reload');
						} else {
							$.messager.alert('系统提示', data.msg);
						}
					}
				});
			}
		}, {
			text : "重置",
			iconCls : "myicon-accept",
			handler : function() {
				$("#" + id).dialog("refresh");
			}
		}, {
			text : "取消",
			iconCls : "myicon-arrow_undo",
			handler : function() {
				$("#" + id).dialog("close");
			}
		} ]
	});
}
/*******************************************************************************
 * 删除角色
 */
function removeRole() {

	var rowData = $('#role-datagrid').datagrid('getSelected');
	
	
	if (rowData == null) {
		$.messager.alert('系统提示', '请选择一条数据！');
		return;
	}
	
	$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
		if (ok) {
			$.ajax({
				type : 'post',
				dataType : 'json',
				data : {
					id : rowData['id']
				},
				url : ctx + "/role/deleteRole",
				success : function(data) {
					if(data.success){
						$('#role-datagrid').datagrid('reload');
						$('#role-datagrid').datagrid('unselectAll');
					}else{
						$.messager.alert('系统提示', data.msg);
					}
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '删除失败！');
				}
			});
		}
	});
}

function addRoleUser() {
	var organization = $("#role-datagrid").datagrid("getSelected");
	if (organization == null) {
		$.jGrowl("请选择目标角色！");
		return;
	}
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 800,
		height : 600,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "添加角色人员",
		href : ctx + "/role/pagingAddRoleUser?t=" + new Date().getTime(),
		queryParams:{notRoleId:organization.id},
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "确认",
			color : "red",
			handler : function() {
				var checkedArray = $("#" + id + " #addroleuser-datagrid").datagrid("getChecked");
				$.ajax({
					url : ctx + "/role/addRoleUser?t=" + new Date().getTime(),
					type : "post",
					data : "roleId=" + organization.id + "&userId=" + $(checkedArray).map(function() {
						return this.id;
					}).get().join("&userId="),
					dataType : "json",
					success : function(data) {
						$("#" + id).dialog("close");
						if (data.success) {
							$("#userList").datagrid("reload");
						}
						$.jGrowl(data.msg);
					},
					error : function(e, s1, s2) {
						$.jGrowl("操作失败！");
					}
				});
			}
		}, {
			text : "取消",
			color : "red",
			handler : function() {
				$("#" + id).dialog("close");
			}
		} ]
	});
}
function removeRoleUser() {
	var checkedUsers = $("#userList").datagrid("getChecked");
	var organization = $("#role-datagrid").datagrid("getSelected");
	if (organization == null) {
		$.jGrowl("请选择目标角色！");
		return;
	}
	if (checkedUsers == null || checkedUsers.length == 0) {
		$.jGrowl("请选择要移出的用户！");
		return;
	}
	$.messager.confirm("系统提示", "确认移除人员吗？", function(ok) {
		if (ok) {
			$.ajax({
				type : "post",
				url : ctx + "/role/removeRoleUser?t=" + new Date().getTime(),
				data : "roleId=" + organization.id + "&userId=" + $(checkedUsers).map(function() {
					return this.id;
				}).get().join("&userId="),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						$("#userList").datagrid("reload", {
							roleId : organization.id
						});
					}
					$.jGrowl(data.msg);
				},
				error : function(e, s1, s2) {
					$.jGrowl("操作失败！");
				}
			});
		}
	});
}
function grantRole(){
	var rowData = $('#role-datagrid').datagrid('getSelected');
	if (rowData == null) {
		$.messager.alert('系统提示', '请选择一条数据！');
		return;
	}
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 600,
		height : 400,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "角色授权",
		href : ctx + "/role/grantRole?id="+rowData["id"],
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "确认",
			color : "red",
			handler : function() {
				var rows = $("#roleauthtree").tree("getChecked");
				$.ajax({
					url:ctx + "/role/grantAuthToRole",
					type:"post",
					dataType:"json",
					data:"roleId="+rowData["id"]+(rows.length==0?"":"&menuId="+$(rows).map(function(){return this.id;}).get().join("&menuId=")),
					success:function(data){
						if (data.success) {
							$("#" + id).dialog("close");
						}
						$.jGrowl(data.msg);
					}
				});
			}
		}, {
			text : "取消",
			color : "red",
			handler : function() {
				$("#" + id).dialog("close");
			}
		} ]
	});
}
function queryRoleUser() {
	var organization = $("#role-datagrid").datagrid("getSelected");
	$("#userList").datagrid("reload", {
		roleId: organization.id,
		userName : $("[name='userName']").val()
	});
}

function customCascadeCheck(node, checked) {
	if (checked) {
		var children = $(this).tree("getChildren", node.target);
		/* if (node.menuType == '菜单') { */
		for (var i = 0; i < children.length; i++) {
			/* if (children[i].menuType == node.menuType) { */
				children[i].checked = true;
				$(children[i].target).find(".tree-checkbox").removeClass("tree-checkbox0").addClass("tree-checkbox1");
			/* } */
		}
		/* } */
		var parent = $(this).tree("getParent", node.target);
		while (parent && parent != null) {
			parent.checked = true;
			$(parent.target).find(".tree-checkbox").removeClass("tree-checkbox0").addClass("tree-checkbox1");
			parent = $(this).tree("getParent", parent.target);
		}
	} else {
		/* if (node.menuType == '菜单'||node.menuType == '权限') { */
		var children = $(this).tree("getChildren", node.target);
		for (var i = 0; i < children.length; i++) {
			children[i].checked = false;
			$(children[i].target).find(".tree-checkbox").removeClass("tree-checkbox1").addClass("tree-checkbox0");
		}
		/* } */
	}
}
function checkAllChildren(e, node) {
	e.preventDefault();
	$(this).tree("check", node.target);
	var children = $(this).tree("getChildren", node.target);
	for (var i = 0; i < children.length; i++) {
		children[i].checked = false;
		$(children[i].target).find(".tree-checkbox").removeClass("tree-checkbox0").addClass("tree-checkbox1");
	}
}
