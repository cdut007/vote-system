$(function() {
	$("[name='organRoleList']").change(function(){
		var validateInput=$(this).parents("td:first").find(".for-validate");
		var map={};
		if(validateInput.val()!=""){
			var data=validateInput.val().split(",");
			for(var i=0,l=data.length;i<l;i++){
				map[data[i]]=true;
			}
		}
		map[this.value]=$(this).prop("checked");
		var array=[];
		for(var key in map){
			if(map[key]){
				array.push(key);
			}
		}
		validateInput.val(array.join(","));
	});
	$("#aptitude-datagrid").datagrid({
		title : "资质列表",
		height : 200,
		// url:ctx+"/aptitude/pagingApptitudeOwnData",
		rownumbers : true,
		striped : true,
		idField : "id",
		method : "post",
		columns : [ [ 
			{field : 'id',checkbox : true},
			//{title:"主体代码",field:'ztdm00',align:"center",width:100},
			{title : "资质等级",field : 'zzdj00',width : 80}, 
			{title : "证书编号",field : 'zzzsbh',width : 80}, 
			{title : "资质名称",field : 'zzname',width : 100},
			// {title:"申报责任人",field:'xxsbr0',width:80},
			// {title:"审核状态",field:'isAudits',width:60},
			{title : "创建时间",field : 'createDate',width : 130}
			// {title:"审核时间",field:'auditsTime',width:130},
			// {title:"资质状态",field:'state',align:"center",width:80}
		] ],
		toolbar : [ 
			{text : "添加资质",iconCls : 'icon-add',handler : addAptitude}, 
			{text : "详情",iconCls : 'icon-search',handler : selectDetailed},
			//{text : "编辑", iconCls : 'myicon-application_edit', handler :editAptitude },
			{text : "删除",iconCls : 'icon-remove',handler : delAptitudes} 
		]
	});
	// 回显之前上传的附件
	if ($("[name='aptitudeId']").length > 0) {
		$("#aptitude-datagrid").datagrid({
			url : ctx + "/common/listApptitudeData?" + $("[name='aptitudeId']").map(function() {
				return "aptitudeId=" + this.value;
			}).get().join("&")
		});
	}
});

function addAptitude() {
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 800,
		height : 600,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "资质编辑",
		href : ctx + "/common/aptitudeEdit",
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "保存",
			iconCls : "myicon-accept",
			handler : function() {
				$("#" + id + " form").ajaxSubmit({
					beforeSend : function() {
						var validate = $("#" + id + " form").form("validate");
						if (validate) {
							$.messager.progress({
								title : "请您耐心等待...",
								msg : "正保存资质信息...",
								text : "请稍后..."
							});
						}
						return validate;
					},
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$('#' + id).dialog('close');
							$.jGrowl("资质保存成功");
							$('#aptitude-datagrid').datagrid("appendRow", data.data);
							$("#registerForm").append("<input id=\"" + data.data.id + "\" type=\"hidden\" name=\"aptitudeId\" value=\"" + data.data.id + "\">");
						}
						$.messager.progress("close");
						$.messager.alert('系统提示', data.msg);
					},
					complete : function() {
						$.messager.progress("close");
					}
				});
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
 * 资质编辑
 ******************************************************************************/
function editAptitude() {
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length != 1) {
		$.messager.alert('系统提示', '请选择一条数据！');
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
		title : "资质编辑",
		href : ctx + "/common/aptitudeEdit?id=" + rowData[0].id,
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "保存",
			iconCls : "myicon-accept",
			handler : function() {
				$("#" + id + " form").ajaxSubmit({
					beforeSend : function() {
						var a = $("#" + id + " form").form("validate");
						if (!a) {
							return $("#" + id + " form").form("validate");
						} else {
							$.messager.progress({
								title : "请您耐心等待...",
								msg : "正保存资质信息...",
								text : "请稍后..."
							});
						}
					},
					dataType : "json",
					success : function(data) {
						if (data.success) {

							$('#' + id).dialog('close');
							$.messager.progress("close");
							$.jGrowl("资质保存成功");
							// $('#aptitude-datagrid').datagrid('reload');
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
				//$("#" + id).dialog("refresh");
				$("#aptitudeForm").form("clear");
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
 * 资质详情
 ******************************************************************************/

function selectDetailed() {
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length != 1) {
		$.messager.alert('系统提示', '请选择一条数据！');
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
		title : "资质详情",
		href : ctx + "/common/aptitudeInfoQuery?id=" + rowData[0].id,
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : '关闭',
			iconCls : 'icon-cancel',
			handler : function() {
				$("#" + id).dialog('close');
			}
		} ]

	});

}

/*******************************************************************************
 * 资质删除
 ******************************************************************************/
function delAptitudes() {
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length == 0) {
		$.messager.alert('系统提示', '请选择要删除的数据！');
		return;
	}
	$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
		if (ok) {
			$.ajax({
				type : 'post',
				dataType : 'json',
				data : $(rowData).map(function() {
					return "id=" + this.id;
				}).get().join("&"),
				url : ctx + "/common/delAptitudes",
				success : function(data) {
					if (data.success) {
						for (var i = 0; i < rowData.length; i++) {
							var row = rowData[i];
							var rowIndex = $('#aptitude-datagrid').datagrid('getRowIndex', row.id);
							$('#aptitude-datagrid').datagrid("deleteRow", rowIndex);
						}
						$('#aptitude-datagrid').datagrid('unselectAll');
					}
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '删除资质态失败！');
				}
			});
		}
	});
}