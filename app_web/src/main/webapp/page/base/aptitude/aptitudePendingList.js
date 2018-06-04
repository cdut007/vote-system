$(function(){
	$("#aptitudePend-datagrid").datagrid({
		title:"待审核资质列表",
		fit:true,
		url:ctx+"/aptitude/pagingAptitudePendData",
		pagination:true,
		rownumbers:true,
		//remoteSort:true,
		//sortName:"createDate",
		//sortOrder:"desc",
		striped:true,
		method:"post",
		onLoadSuccess:function(data){
		},
		columns:[[
		    {field:'id',checkbox:true},
		    {title:"主体代码",field:'ztdm00',align:"center",width:120},
		    {title:"资质等级",field:'zzdj00',width:90},
		    {title:"证书编号",field:'zzzsbh',width:200},
		    {title:"资质名称",field:'zzname',width:110},
		    {title:"申报责任人",field:'xxsbr0',width:90},		    
		    {title:"审核状态",field:'isAudits',width:70},
		    {title:"创建时间",field:'createDate',width:140/*,sortable:true,order:"desc"*/},
		    {title:"审核时间",field:'auditsTime',width:140},
		    {title:"资质状态",field:'state',align:"center",width:100,hidden:true}
		]]
	});
});

/*******************************************************************************
 * 查询详细信息
 ********************************************************************************/

function selectDetailed() {
	var rowData = $('#aptitudePend-datagrid').datagrid('getChecked');
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
		title : "资质详细信息",
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
 * 审核资质
 ********************************************************************************/
function auditAptitude() {
	var rowData = $('#aptitudePend-datagrid').datagrid('getChecked');
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
		href : ctx + "/aptitude/auditAptitudeModel?id=" + rowData[0].id,
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
								$('#aptitudePend-datagrid').datagrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						}
					});
				}else{
					alert('通过资质，回退原因必须为空！');
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
								$('#aptitudePend-datagrid').datagrid('reload');
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

/************************************************************************
 *根据条件查询
 *************************************************************************/
function queryAptitudes() {
	$('#aptitudePend-datagrid').datagrid('reload', {
		zzzsbh : $("[name='zzzsbh']").val(),
		zzname : $("[name='zzname']").val()
	});
}

