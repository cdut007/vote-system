$(function(){
	$("#aptitudeBack-datagrid").datagrid({
		title:"回退资质列表",
		fit:true,
		url:ctx+"/aptitude/pagingAptitudeBackData",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		columns:[[
		    {field:'id',checkbox:true},
		    {title:"主体代码",field:'ztdm00',align:"center",width:120},
		    {title:"资质等级",field:'zzdj00',width:90},
		    {title:"证书编号",field:'zzzsbh',align:"center",width:100},
		    {title:"资质名称",field:'zzname',width:110},
		    {title:"申报责任人",field:'xxsbr0',width:90},		    
		    {title:"审核状态",field:'isAudits',width:70},
		    {title:"回退原因",field:'backReason',width:140},
		    {title:"审核时间",field:'auditsTime',width:140},
		    {title:"资质状态",field:'state',align:"center",width:80,hidden:true}
		]]
	});
});

/*******************************************************************************
 * 资质详情
 ********************************************************************************/

function selectDetailed() {
	var rowData = $('#aptitudeBack-datagrid').datagrid('getChecked');
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

/*******************************************************************************
 * 编辑资质
 ********************************************************************************/
function editAptitude() {
	var rowData = $('#aptitudeBack-datagrid').datagrid('getChecked');
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
						var a= $("#" + id + " form").form("validate");
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
							$('#aptitudeBack-datagrid').datagrid('reload');
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

/************************************************************************
 *根据条件查询
 *************************************************************************/
function queryAptitudes() {
	$("#aptitudeBack-datagrid").datagrid("reload", {
		zzzsbh : $("[name='zzzsbh']").val(),
		zzname : $("[name='zzname']").val(),
		isAudits : $("[name='isAudits']").val()
	});
}

