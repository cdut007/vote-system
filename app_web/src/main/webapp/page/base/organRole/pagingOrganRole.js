$(function() {
	$("#organrole-datagrid").datagrid({
		fit : true,
		title : "机构角色列表",
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		fitColumns : true,
		idField : "id",
		striped : true,
		url : ctx + "/organRole/pagingOrganRoleLoadData",
		columns : [ [ {
			field : "roleName",
			title : "角色名称",
			width : 30
		}, {
			field : "roleFlag",
			title : "角色标识符",
			width : 20
		}, {
			field : "description",
			title : "角色描述",
			width : 50
		}, {
			field : "id",
			title : "操作",
			formatter : function(value) {
				return "<a class=\"button red small\" onclick=\"grantOrganRole({id:'" + value + "'});\">授权</a>";
			}
		} ] ]
	});
});

function grantOrganRole(rowData) {
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 600,
		height : 400,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "机构角色授权",
		href : ctx + "/organRole/grantOrganRole?id=" + rowData["id"],
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "确认",
			color : "red",
			handler : function() {
				var rows = $("#organroleauthtree").tree("getChecked");
				$.ajax({
					url : ctx + "/organRole/grantAuthToOrganRole",
					type : "post",
					dataType : "json",
					data : "roleId=" + rowData["id"] + (rows.length == 0 ? "" : "&menuId=" + $(rows).map(function() {
						return this.id;
					}).get().join("&menuId=")),
					success : function(data) {
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