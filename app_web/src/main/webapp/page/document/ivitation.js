$(function() {
	$("#recruitFileOpenDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	$("#recruitFileOpenDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	
	$("#recruitFileDeadLine").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	$("#bidFileSendStartDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	$("#confirmEndDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	
	$("#bidEndDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	
	
	/***************************************************************************
	 * 提交事件
	 */
	$("#complete").click(function() {
		$("#isComplete").val("true");
		sendInvitationFileData(true);
	});
	/***************************************************************************
	 * 保存事件
	 */
	$("#save").click(function() {
		$("#isComplete").val("false");
		sendInvitationFileData(false);
	});
	
	
	
	var dgrid = $("#invitation_tender_datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : false,
		height:300,
		collapsible:true,
		title : "投标人列表",
		region : "center",
		queryParams:{invitationId:$(":input[name='id']").val()},
		url : ctx+"/invitationFile/pagingInvitationFileTenderData",
		idField : "id",
		columns : [ [ 
		   {field:"id",checkbox:true,hidden:true},
		   {field : "ztmc00",title : "投标单位单位",align : "center",width:120}, 
		   {field : "phone",title : "联系电话",align : "center",width:120}, 
		   {field : "address",title : "联系地址",align : "center",width:120}
		] ],
		toolbar:[{
			text:"新增",
			iconCls : "myicon-application_add",
			handler:function(){
				var id = new Date().getTime();
				$("#container").append("<div style='padding:10px' id='"+id+"'></div>");
				$("#" + id).dialog({
					width : 800,
					height : 550,
					closed : false,
					modal : true,
					loadingMessage : "正在加载...",
					title : "添加投标人",
					href : "/invitationFile/bidder_choose",
					queryParams : {
						
					},
					onClose : function() {
						$("#" + id).dialog("destroy");
					},
					buttons : [ {
						text : "确认",
						color : "red",
						handler : function() {
							var selectedRows = $("#expertUser-datagrid").datagrid("getSelections");
							var rows = $('#invitation_tender_datagrid').datagrid('getRows');	
							for (var i = 0; i < selectedRows.length; i++) {
								var exists = false;
								for(var j=0; j<rows.length; j++){
									if(rows[j].id==selectedRows[i].id){
										exists = true;
										break;
									}
								}
								if(!exists){
									$('#invitation_tender_datagrid').datagrid('appendRow',selectedRows[i]);	
								}
							}
							
									

						
							$("#" + id).dialog("close");

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
	
		},{
			text:"删除",
			iconCls : "myicon-application_delete",
			handler:function(){
				var row=$("#invitation_tender_datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择投标单位");
					return;
				}
				$("#invitation_tender_datagrid").datagrid('deleteRow', $("#invitation_tender_datagrid").datagrid('getRowIndex',row));
			}
		},{
			text:"邀请书预览",
			iconCls : "myicon-application_delete",
			handler:function(){
				var row=$("#invitation_tender_datagrid").datagrid("getSelected");
				if(row){
					var html_str = $("#invitationContentShow").html();
					html_str = html_str.replace("XXXXXXXXXX",row.ztmc00);
					$("#container1").html(html_str);
					$("#container1").dialog({
						width : 800,
						height : 650,
						closed : false,
						modal : true,
						loadingMessage : "正在加载...",
						title : "邀请书预览",				
						onClose : function() {
							$("#" + id).dialog("destroy");
						}
						
					});
				
				}
				
			}
		}]
	});
	
	
	$(document).on("blur",":input",function(){
		if($(this).attr("type")=="button"||$(this).attr("type")=="submit"){
			return;
		}
		loadDefaultContent();
	});
	

});


function loadDefaultContent(){
	var paramArray=$("#invitation_form").serializeArray();

	$.ajax({
		url:ctx+"/invitationFile/template",
		type:"post",
		data:paramArray,
		dataType:"html",
		success:function(data){
			
			$("#invitationContentShow").html(data);
			$("#invitationContent").val(data);
		
		}
	});
}

function sendInvitationFileData(isComplete){	

		if(isComplete){
			var rows = $('#invitation_tender_datagrid').datagrid('getRows');			
			if(rows.length <1){
				$.messager.alert("系统提示","投标人不能小于一家","info",function(){
				
				});
			}else{				
				var validate=	$("#invitation_form").form("validate");
				if(validate){
					$.messager.confirm("系统提示","确认提交吗？",function(r){
						if(r){
							saveInvitationFileData(isComplete);
						}
					});
				}			
			}
		}else{
			saveInvitationFileData(isComplete);
		}
}

function saveInvitationFileData(){
	
	var tenderusers = $("#invitation_tender_datagrid").datagrid("getRows");
	var idStr = "";
	for (var i = 0; i < tenderusers.length; i++) {
		idStr += tenderusers[i].id + "#";
	}
	
		$("#bidderUserIds").val(idStr);
	
		
		$("#invitation_form").ajaxSubmit({
			dataType:"json",
			beforeSend:function(){
				$.messager.progress({
					title:"系统提示",
					msg:"正在保存投标邀请文件"
				});
			},
			success : function(data) {
				if(data.success){
					$.messager.alert("系统提示","投标邀请文件创建成功！","info",function(){
						history.go(-1);
					});
				}
			},
			complete:function(){
				$.messager.progress("close");
			}
		});

	
}
