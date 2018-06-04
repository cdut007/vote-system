$(function(){
	$("#user-datagrid").datagrid({
		title:"人员列表",
		url:ctx+"/organ/pagingRegistOrgan",
		pagination:true,
		rownumbers:true,
		striped:true,
		height:400,
		method:"post",
		toolbar:[],
		idField:"id",
		columns:[[
		    {field:'id',checkbox:true},
		    /*{title:"姓名",field:'userName',align:"center",width:100},*/
		    /*{title:"机构代码",field:'organ.ztdm00',width:80},*/
		    {title:"单位名称",field:'ztmc00',width:180},
		    {title:"组织机构代码",field:'ztdm00',width:100},
		    {title:"行政区划",field:'region',width:80},
		    {title:"行业类别",field:'industry',width:80},
		    {title:"营业执照号码",field:'yyzzhm',width:100},
		    {title:"联系电话",field:'phone',width:100},
		    {title:"邮政编码",field:'zipCode',width:100},
		    {title:"通讯地址",field:'address',width:100},
		    /*{title:"登录账号",field:'loginName',width:80},		*/    
		    /*{title:"是否缴费",field:'isPay',width:60},			*/
		    {title:"审核状态",field:'isAudits',width:60}
		   /* {title:"创建时间",field:'createTime',width:120}*/
		    /*{title:"帐号状态",field:'deleteMark',align:"center",width:100}*/
		]],
		loadFilter: function(data){
			    data.total = data.totalElements;
			    data.row = data.size;
				data.rows = data.content;
				return data;
		}
	});
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>").prependTo($("#user-datagrid").datagrid("getPanel").find(".datagrid-toolbar"));
	$searchForm.append("单位名称:<input name='organName' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#user-datagrid").datagrid("options").queryParams;
	$searchForm.on("blur",":input:not(.Wdate)",function(){
		queryParams[this.name]=this.value;
	}).on("focus",".Wdate",function(){
		WdatePicker({
			dateFmt:"yyyy-MM-dd",
			minDate:this.name=="minDate"?undefined:($(".Wdate[name='minDate']").val()==""?undefined:$(".Wdate[name='minDate']").val()),
			maxDate:this.name=="maxDate"?undefined:($(".Wdate[name='maxDate']").val()==""?undefined:$(".Wdate[name='maxDate']").val()),
			onpicked:function(){
				queryParams[this.name]=this.value;
			}
		});
	}).on("keydown",":input",function(){
		if(event.keyCode==13){
			$(this).blur();
			$("#user-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		
	
		$("#user-datagrid").datagrid('reload');
		
	});
	
});

/*********************************************************************************
 * 添加人员
 ********************************************************************************/
function addUser() {
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 600,
		height : 400,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "添加人员",
		href : ctx + "/user/userDetailed",
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
							$('#user-datagrid').datagrid('reload');
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
 * 编辑人员
 ********************************************************************************/
function editUser() {
	var rowData = $('#user-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length!=1) {
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
		href : ctx + "/user/userDetailed?id=" + rowData[0].id,
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
							$('#user-datagrid').datagrid('reload');
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
 * 审核机构信息
 ********************************************************************************/
function auditUser() {
	var rowData = $('#user-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length!=1) {
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
		title : "审核机构信息",
		href : ctx + "/user/auditUserModel?id=" + rowData[0].id,
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "通过",
			iconCls : "myicon-accept",
			handler : function() {
				var backReason=$('#backReason').val();
				if(backReason==""){
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + id).dialog('close');
								$('#user-datagrid').datagrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						}
					});
				}else{
					alert('通过用户信息，回退原因必须为空！');
					$("#" + id).dialog("refresh");
				}
				
				
			}
		}, {
			text : "退回",
			iconCls : "myicon-accept",
			handler : function() {
				var backReason=$('#backReason').val();
				if(backReason==""){
					 alert('驳回用户信息，回退原因不能为空！');
					 $("#" + id).dialog("refresh");
				}else{
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + id).dialog('close');
								$('#user-datagrid').datagrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						}
					});
				}
				
			}
		}, {
			text : "关闭",
			iconCls : "myicon-arrow_undo",
			handler : function() {
				$("#" + id).dialog("close");
			}
		}]
	});
}

/*******************************************************************************
 * 查询详细信息
 ********************************************************************************/

function selectDetailed() {
	var rowData = $('#user-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length!=1) {
		$.messager.alert('系统提示', '请选择一条数据！');
		return;
	}
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 500,
		height : 600,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "编辑部门",
		href : ctx + "/user/detailedUserInfo?id=" + rowData[0].id,
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons: [ {
            text: '关闭',
            iconCls: 'icon-cancel',
            handler: function () {
                $("#" + id).dialog('close');
            }
        }]
		
	});
	
}


/************************************************************************
 *确认缴费
 *************************************************************************/
function editPay(){
	var rowData = $('#user-datagrid').datagrid('getChecked');
	if (rowData == null ||rowData.length==0) {
		$.messager.alert('系统提示', '请选择要删除的数据！');
		return;
	}
	
	$.messager.confirm('系统提示', '确认更改缴费状态吗?', function(ok) {
		if(ok){
			$.ajax({
			    type :'post',
			    dataType : 'html',
				data : "id="+$(rowData).map(function(){return this.id;}).get().join("&id="),
				url : ctx + "/user/updateUserPay",
				success : function(data) {
					$('#user-datagrid').datagrid('reload');
					$('#user-datagrid').datagrid('unselectAll');
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '更新缴费状态失败！');
				}
				
			});
		}
		
	});
	
}

/************************************************************************
 *重置密码
 *************************************************************************/
function resetPassword(){
	var rowData = $('#user-datagrid').datagrid('getChecked');
	if (rowData == null ||rowData.length==0) {
		$.messager.alert('系统提示', '请选择要重置密码的数据！');
		return;
	}
	
	$.messager.confirm('系统提示', '确认重置密码吗?', function(ok) {
		if(ok){
			$.ajax({
			    type :'post',
			    dataType : 'html',
				data : "id="+$(rowData).map(function(){return this.id;}).get().join("&id="),
				url : ctx + "/user/resetPassword",
				success : function(data) {
					$('#user-datagrid').datagrid('reload');
					$('#user-datagrid').datagrid('unselectAll');
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '重置密码失败！');
				}
				
			});
		}
		
	});
	
}

/*******************************************************************************
 * 删除部门
 ********************************************************************************/
function removeUser() {
	var rowData = $('#user-datagrid').datagrid('getChecked');
	if (rowData == null ||rowData.length==0) {
		$.messager.alert('系统提示', '请选择要删除的数据！');
		return;
	}
	$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
		if (ok) {
			$.ajax({
				type : 'post',
				dataType : 'html',
				data : "id="+$(rowData).map(function(){return this.id;}).get().join("&id="),
				url : ctx + "/user/deleteUser",
				success : function(data) {
					$('#user-datagrid').datagrid('reload');
					$('#user-datagrid').datagrid('unselectAll');
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '删除失败！');
				}
			});
		}
	});
}

/************************************************************************
 *根据条件查询
 *************************************************************************/
function queryRoleUser() {

	$("#user-datagrid").datagrid("reload", {
		userName : $("[name='userName']").val(),
		loginName : $("[name='loginName']").val()
	});
}
