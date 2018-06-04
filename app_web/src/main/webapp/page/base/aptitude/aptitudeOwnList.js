$(function(){
	$("#aptitude-datagrid").datagrid({
		title:"资质列表",
		fit:true,
		url:ctx+"/aptitude/pagingApptitudeOwnData",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		columns:[[
		    {field:'id',checkbox:true},
		    {title:"主体代码",field:'ztdm00',align:"center",width:130},
		    {title:"资质等级",field:'zzdj00',width:90},
		    {title:"证书编号",field:'zzzsbh',width:110},
		    {title:"资质名称",field:'zzname',width:110},
		    {title:"申报责任人",field:'xxsbr0',width:90},		    
		    {title:"审核状态",field:'isAudits',width:70},
		    {title:"创建时间",field:'createDate',width:140},
		    {title:"审核时间",field:'auditsTime',width:140},
		    {title:"资质状态",field:'state',align:"center",width:80,hidden:true}
		]],
		toolbar:[{text:"详情",iconCls:'icon-search',handler:selectDetailed},
		         {text:"编辑",iconCls:'myicon-application_edit',handler:editAptitude},
		         {text:"删除",iconCls:'icon-remove',handler:delAptitudes},
				 {text:"刷新",iconCls:'myicon-arrow_refresh',handler:function(){
				 	$("#aptitude-datagrid").datagrid("reload");
				 }}
		]
	});
});


/*******************************************************************************
 * 资质编辑
 ********************************************************************************/
function editAptitude() {
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length!=1) {
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
		href : ctx + "/aptitude/aptitudeEdit?id=" + rowData[0].id,
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "保存",
			iconCls : "myicon-accept",
			handler : function() {
				$("#" + id + " form").ajaxSubmit({
					beforeSend : function() {
						var a=$("#" + id + " form").form("validate");
						if(!a){
							return $("#" + id + " form").form("validate");
						}else{
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
							$('#aptitude-datagrid').datagrid('reload');
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
 * 资质审核
 ********************************************************************************/
function auditAptitude() {
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length!=1) {
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
		title : "资质审核",
		href : ctx + "/aptitude/auditAptitudeModel.do?id=" + rowData[0].id,
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
								$('#aptitude-datagrid').datagrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						}
					});
				}else{
					alert('通过的时候，回退原因必须为空！');
					$("#" + id).dialog("refresh");
				}
				
			}
		}, {
			text : "退回",
			iconCls : "myicon-accept",
			handler : function() {
				
				var backReason=$('#backReason').val();
				if(backReason==""){
					alert('回退原因不能为空，请重新填写回退原因！');
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
								$('#aptitude-datagrid').datagrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						}
					});
				}
				
				if(undefined==backReason){
					alert('不能为空');
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
 * 资质详情
 ********************************************************************************/

function selectDetailed() {
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null || rowData.length!=1) {
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
		href : ctx + "/aptitude/aptitudeInfoQuery?id=" + rowData[0].id,
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
 *资质删除
 *************************************************************************/
function delAptitudes(){
	var rowData = $('#aptitude-datagrid').datagrid('getChecked');
	if (rowData == null ||rowData.length==0) {
		$.messager.alert('系统提示', '请选择要删除的数据！');
		return;
	}
	
	$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
		if(ok){
			$.ajax({
			    type :'post',
			    dataType : 'html',
				data : "id="+$(rowData).map(function(){return this.id;}).get().join("&id="),
				url : ctx + "/aptitude/delAptitudes",
				success : function(data) {
					$('#aptitude-datagrid').datagrid('reload');
					$('#aptitude-datagrid').datagrid('unselectAll');
				},
				error : function(e, s1, s2) {
					$.messager.alert('系统提示', '删除资质态失败！');
				}
				
			});
		}
		
	});
	
}

/************************************************************************
 *资质查询
 *************************************************************************/
function queryAptitudes() {
	$("#aptitude-datagrid").datagrid("reload", {
		zzzsbh : $("[name='zzzsbh']").val(),
		zzname : $("[name='zzname']").val(),
		isAudits : $("[name='isAudits']").val()
	});
}
