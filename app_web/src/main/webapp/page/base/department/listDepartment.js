$(function() {
	$("#searchBtn").click(function(){
		queryOrganizationUser();
	});
	$("#addDepartment").click(function(){
		addOrganization();
	});
	$("#editDepartment").click(function(){
		editOrganization();
	});
	$("#removeDepartment").click(function(){
		removeOrganization();
	});
	$("#addOrganizationUserList").click(function(){
		addOrganizationUserList();
	});
	$("#removeOrganizationUser").click(function(){
		removeOrganizationUser();
	});
	function queryOrganizationUser() {
		var organization = $("#department-treegrid").treegrid("getSelected");
		var searchParam={
			userName : $("[name='userName']").val()
		};
		key=$("[name='cascade']").is(":checked")?"departmentIdIn":"departmentId";
		searchParam[key]=organization.id,
		$("#userList").datagrid({
			url : ctx + "/user/pagingUserData",
			queryParams :searchParam
		});
	}
	/**
	 * 添加部门
	 */
	function addOrganization() {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "添加部门",
			href : ctx + "/department/departmentEdit",
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
								$('#department-treegrid').treegrid('reload');
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
	 * 编辑部门
	 */
	function editOrganization() {
		var rowData = $('#department-treegrid').treegrid('getSelected');
		if (rowData == null || rowData.parentId == undefined || rowData.parentId == null) {
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
			title : "编辑部门",
			href : ctx + "/department/departmentEdit?id=" + rowData['id'],
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
								$('#department-treegrid').treegrid('reload');
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
	 * 删除部门
	 */
	function removeOrganization() {
		var rowData = $('#department-treegrid').treegrid('getSelected');
		if (rowData == null || rowData.parentId == undefined || rowData.parentId == null) {
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
					url : ctx + "/department/deleteDepartment",
					success : function(data) {
						if(data.success){
							$('#department-treegrid').treegrid('reload');
							$('#department-treegrid').treegrid('unselectAll');
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

	function addOrganizationUserList() {
		var organization = $("#department-treegrid").treegrid("getSelected");
		if (organization == null || organization.parentId == undefined || organization.parentId == null) {
			top.$.jGrowl("请选择目标部门！");
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
			title : "添加部门人员",
			href : ctx + "/department/pagingAddDepartmentUser?t=" + new Date().getTime(),
			queryParams:{notDepartmentId:organization.id},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					var checkedArray = $("#" + id + " #adddepartmentuser-datagrid").datagrid("getChecked");
					if(checkedArray == null || checkedArray == ""){
						$.messager.alert('系统提示','请选择人员');
						return;
					}
					$.ajax({
						url : ctx + "/department/addDepartmentUser?t=" + new Date().getTime(),
						type : "post",
						data : "departmentId=" + organization.id + "&userId=" + $(checkedArray).map(function() {
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
							top.$.jGrowl("操作失败！");
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
	function removeOrganizationUser() {
		var checkedUsers = $("#userList").datagrid("getChecked");
		var organization = $("#department-treegrid").treegrid("getSelected");
		if (organization == null || organization.parentId == undefined || organization.parentId == null) {
			top.$.jGrowl("请选择目标部门！");
			return;
		}
		if (organization.children && organization.children.length > 0 && $("[name='cascade']").is(":checked") && $("[name='cascade']").is(":enabled")) {
			top.$.jGrowl("包含子部门人员时不能移除！");
			return;
		}
		if (checkedUsers == null || checkedUsers.length == 0) {
			top.$.jGrowl("请选择要移出的用户！");
			return;
		}
		$.messager.confirm("系统提示", "确认移除人员吗？", function(ok) {
			if (ok) {
				$.ajax({
					type : "post",
					url : ctx + "/department/removeDepartmentUser?t=" + new Date().getTime(),
					data : "departmentId=" + organization.id + "&userId=" + $(checkedUsers).map(function() {
						return this.id;
					}).get().join("&userId="),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$("#userList").datagrid("reload", {
								departmentId : organization.id
							});
						}
						top.$.jGrowl(data.msg);
					},
					error : function(e, s1, s2) {
						top.$.jGrowl("操作失败！");
					}
				});
			}
		});
	}
	$("#department-treegrid").treegrid({
		title : "部门结构",
		fitColumns : true,
		idField : "id",
		border : false,
		striped : true,
		treeField : "departmentName",
		animate : false,
		url : ctx + "/department/getDepartmentTree",
		columns : [ [ 
			{field : "departmentName",title : "部门名称",width : 100} 
		] ],
		onSelect : function(rowData) {
			queryOrganizationUser();
			/*$("#userList").datagrid({
				url : ctx + "/user/pagingUserData",
				queryParams : {
					departmentIdIn : rowData.id
				}
			});*/
		},
		onLoadSuccess : function(row, data) {
			if (data.length > 0) {
				$(this).treegrid("select", data[0].id);
			}
		}
	});
	$("#userList").datagrid({
		title:"人员列表",
		toolbar:'#userlisttoolbar',
		rownumbers:true,
		//sortName:"userName",
		//sortOrder:"asc",
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

