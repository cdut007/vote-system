$(function(){
	$("#invitationfile-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		height:300,
		collapsible:true,
		title : "投标邀请列表",
		region : "center",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		url : ctx+"/invitationFile/pagingInvitationFileData",
		idField : "id",
		columns : [ [ 
		   {field:"id",checkbox:true,hidden:true},
		   {field : "projectInstanceName",title : "招标项目",align : "left",width:100,hidden:true},
		   {field : "projectItemName",title : "标段",align : "left",width:100}, 
		   {field : "organTName",title : "招标单位",align : "center",width:120}, 
		   {field : "authorName",title : "编制人",align : "center",width:80}, 
		   {field : "organAName",title : "代理机构",align : "center",hidden : true,width:120}, 	
		   {field : "rev",title : "版本号",align : "right",width:40}, 
		   {field : "createTime",title : "创建时间",align : "center",width:120}, 
		   {field : "editTime",title : "修改时间",align : "center",width:120}, 
		   {field : "reviewStatus",title : "文件状态",align : "center",width:80}
		] ],
		toolbar:[{
			text:"新建投标邀请",
			iconCls : "myicon-application_add",
			handler:function(){
				window.location.href=ctx+"/invitationFile/addInvitationFile?&projectInstanceId="+$(":input[name='id']").val();
				
			}
	
		},{
			text:"编辑",
			iconCls : "myicon-application_edit",
			handler:function(){
				var row=$("#invitationfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择投标邀请文件");
					return;
				}
				if(row.reviewStatus=='待审核' || row.reviewStatus=='审核通过'){
					$.messager.alert("系统提示","此状态投标邀请不允许编辑");
					return;
				}
				window.location.href=ctx + "/invitationFile/editInvitationFile?id="+row.id;
			}
		},{
			text:"查看",
			iconCls : "myicon-page_word",
			handler:function(){
				var row=$("#invitationfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择投标邀请文件");
					
					return;
				}
			
				window.open(ctx + "/invitationFile/view?id="+row.id);
			}
		},{
			text:"删除",
			iconCls : "myicon-application_delete",
			handler:function(){
				var row=$("#invitationfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择投标邀请文件");
					return;
				}
				if(row.reviewStatus=='待审核' || row.reviewStatus=='审核通过'){
					$.messager.alert("系统提示","待审核或审核通过状态的招标文件不能删除！");
					return;
				}
				$.ajax({ 
					url:ctx+"/invitationFile/deleteInvitationFile",
					data:{id:row.id},
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							$("#invitationfile-datagrid").datagrid("unselectAll");
							$("#invitationfile-datagrid").datagrid("reload");
						}
						$.messager.alert("系统提示",data.msg);
					}
				});
			}
		}]
	});
});

