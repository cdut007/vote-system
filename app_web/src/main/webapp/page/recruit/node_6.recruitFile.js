$(function(){
	$("#recruitfile-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		height:300,
		collapsible:true,
		title : "招标/预审文件列表",
		region : "center",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		url : ctx+"/recruitFile/pagingRecruitFileData",
		idField : "id",
		columns : [ [ 
		   {field:"id",checkbox:true,hidden:true},
		   {field : "projectInstanceName",title : "所属招标项目",align : "left",width:100,hidden:true},
		   {field : "projectItemName",title : "所属标段",align : "left",width:100}, 
		   {field : "organTName",title : "招标单位",align : "center",width:120}, 
		   {field : "authorName",title : "编制人",align : "center",width:80}, 
		   {field : "organAName",title : "代理机构",align : "center",hidden : true,width:120}, 
		   {field : "isPrejudication",title : "文件类型",align : "center",width:120, formatter: function(value, rowData){
			   if(value){
				   return "预审文件";
			   }
			   return "招标文件";
		   }}, 
		   {field : "rev",title : "版本号",align : "right",width:40}, 
		   {field : "createTime",title : "创建时间",align : "center",width:120}, 
		   {field : "editTime",title : "修改时间",align : "center",width:120}, 
		   {field : "reviewStatus",title : "文件状态",align : "center",width:80, formatter: function(value, rowData){
			   return value=='1'?'待审核':value=='2'?'代理机构审核未通过':value=='19'?'经理审核未通过':value=='0'?'草稿':value=='9'?'审核通过':value=='3'?'招标人审核未通过':
				   value=='5'?'代理机构审核':value=='6'?'招标人审核':value=='99'?'已发布':value=='4'?'公共服务平台审核未通过':value=='91'?'已作废':'公共服务平台审核';
		   }}, 
			{title : "下载历史",field : "_id",formatter : function(value, rowData) {
				var str="<button class='button red small' onclick=\"viewRecruitFile('"+rowData.id+"');\">查看</button>";
				if(env=="false"&&rowData.reviewStatus=='9'){
					str+="<button class='button red small' onclick=\"openBid('" + rowData.id + "');\">立即开标</button>";
					str+="<button class='button red small' onclick=\"startExpertGroupSelection('" + rowData.id + "');\">选举专家组长</button>";
				}
				if(env=="false"){
					str+="<button class='button red small' onclick=\"download('" + rowData.id + "');\">下载</button>";
				}
				return str;
			}} 
		] ],
		toolbar:[{
			text:"新建招标文件",
			iconCls : "myicon-application_add",
			handler:function(){
				$.ajax({ 
					url:ctx+"/recruitFileData/validRecruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val(),
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							if(data.msg=="0"){
								$.jGrowl("没有标段[招标公告已审核]需要新建招标文件");
							}else{
								window.location.href=ctx+"/recruitFileData/recruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val();
							}
						}
					
					}
				});
				
			}
		},{
			text:"新建招标文件(房建经评审)",
			iconCls : "myicon-application_add",
			handler:function(){
				$.ajax({ 
					url:ctx+"/recruitFileData/validRecruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val(),
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							if(data.msg=="0"){
								$.jGrowl("没有标段[预审公告已审核]需要新建预审文件");
							}else{
								window.location.href=ctx+"/recruitFileData/recruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val()+"&nextStep=jps";
							}
						}
					
					}
				});
				
			}
		},{
			text:"新建招标文件(双信封)",
			iconCls : "myicon-application_add",
			handler:function(){
				$.ajax({ 
					url:ctx+"/recruitFileData/validRecruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val(),
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							if(data.msg=="0"){
								$.jGrowl("没有标段[招标公告已审核]需要新建招标文件");
							}else{
								window.location.href=ctx+"/recruitFileData/recruitFileDataCreate?envelopeType=two&isPrejudication=false&projectInstanceId="+$(":input[name='id']").val();
							}
						}
					
					}
				});
				
			}
		},{
			text:"新建预审文件",
			iconCls : "myicon-application_add",
			handler:function(){
				$.ajax({ 
					url:ctx+"/recruitFileData/validRecruitFileDataCreate?isPrejudication=true&projectInstanceId="+$(":input[name='id']").val(),
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							if(data.msg=="0"){
								$.jGrowl("没有标段[预审公告已审核]需要新建预审文件");
							}else{
								window.location.href=ctx+"/recruitFileData/recruitFileDataCreate?isPrejudication=true&projectInstanceId="+$(":input[name='id']").val();
							}
						}
					
					}
				});
				
			}
		},{
			text:"编辑",
			iconCls : "myicon-application_edit",
			handler:function(){
				var row=$("#recruitfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择招标文件");
					return;
				}
				if(row.reviewStatus=='9' || row.reviewStatus=='1' || row.reviewStatus=='91'){
					$.jGrowl("此状态招标文件不允许编辑");
					return;
				}
				window.location.href=ctx + "/recruitFileData/recruitFileDataEdit?id="+row.id;
			}
		},{
			text:"预览",
			iconCls : "myicon-page_word",
			handler:function(){
				var row=$("#recruitfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择招标文件");
					return;
				}
				if(row.templateId==null){
					$.jGrowl("当前招标文件还没有模板！");
					return;
				}
				window.open(ctx + "/recruitFile/editRecruitFile?id="+row.id);
			}
		},{
			text:"删除",
			iconCls : "myicon-application_delete",
			handler:function(){
				var row=$("#recruitfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择招标文件");
					return;
				}
				if(row.reviewStatus=='9' || row.reviewStatus=='1'){
					$.jGrowl("待审核或审核通过状态的招标文件不能删除！");
					return;
				}
				$.ajax({ 
					url:ctx+"/recruitFile/deleteRecruitFile",
					data:{id:row.id},
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							$("#recruitfile-datagrid").datagrid("unselectAll");
							$("#recruitfile-datagrid").datagrid("reload");
						}
						$.jGrowl(data.msg);
					}
				});
			}
		}]
	});
	$("#invitefile-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		height:300,
		collapsible:true,
		title : "招标文件列表",
		region : "center",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		url : ctx+"/recruitFile/pagingRecruitFileData",
		idField : "id",
		columns : [ [ 
		   {field:"id",checkbox:true,hidden:true},
		   {field : "projectInstanceName",title : "所属招标项目",align : "left",width:100,hidden:true},
		   {field : "projectItemName",title : "所属标段",align : "left",width:100}, 
		   {field : "organTName",title : "招标单位",align : "center",width:120}, 
		   {field : "authorName",title : "编制人",align : "center",width:80}, 
		   {field : "organAName",title : "代理机构",align : "center",hidden : true,width:120}, 
		   {field : "isPrejudication",title : "文件类型",align : "center",width:120, formatter: function(value, rowData){
			   if(value){
				   return "预审文件";
			   }
			   return "招标文件";
		   }}, 
		   {field : "rev",title : "版本号",align : "right",width:40}, 
		   {field : "createTime",title : "创建时间",align : "center",width:120}, 
		   {field : "editTime",title : "修改时间",align : "center",width:120}, 
		   {field : "reviewStatus",title : "文件状态",align : "center",width:80, formatter: function(value, rowData){
			   return value=='1'?'待审核':value=='2'?'代理机构审核未通过':value=='19'?'经理审核未通过':value=='0'?'草稿':value=='9'?'审核通过':value=='3'?'招标人审核未通过':
				   value=='5'?'代理机构审核':value=='6'?'招标人审核':value=='99'?'已发布':value=='4'?'公共服务平台审核未通过':value=='91'?'已作废':'公共服务平台审核';
		   }}, 
			{title : "下载历史",field : "_id",formatter : function(value, rowData) {
				return "<button class='button red small' onclick=\"openDownloadHistory('" + rowData.projectItemId + "');\">查看</button>";
			}} 
		] ],
		toolbar:[{
			text:"新建招标文件",
			iconCls : "myicon-application_add",
			handler:function(){
				$.ajax({ 
					url:ctx+"/recruitFileData/validRecruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val(),
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							if(data.msg=="0"){
								$.jGrowl("没有标段[招标公告已审核]需要新建招标文件");
							}else{
								window.location.href=ctx+"/recruitFileData/recruitFileDataCreate?isPrejudication=false&projectInstanceId="+$(":input[name='id']").val();
							}
						}
					
					}
				});
				
			}
		},{
			text:"编辑",
			iconCls : "myicon-application_edit",
			handler:function(){
				var row=$("#invitefile-datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择招标文件");
					return;
				}
				if(row.reviewStatus=='9' || row.reviewStatus=='1' || row.reviewStatus=='91'){
					$.jGrowl("此状态招标文件不允许编辑");
					return;
				}
				window.location.href=ctx + "/recruitFileData/recruitFileDataEdit?id="+row.id;
			}
		},{
			text:"预览",
			iconCls : "myicon-page_word",
			handler:function(){
				var row=$("#recruitfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择招标文件");
					return;
				}
				if(row.templateId==null){
					$.jGrowl("当前招标文件还没有模板！");
					return;
				}
				window.open(ctx + "/recruitFile/editRecruitFile?id="+row.id);
			}
		},{
			text:"删除",
			iconCls : "myicon-application_delete",
			handler:function(){
				var row=$("#recruitfile-datagrid").datagrid("getSelected");
				if(row==null){
					$.jGrowl("请选择招标文件");
					return;
				}
				if(row.reviewStatus=='1' || row.reviewStatus=='9'){
					$.jGrowl("待审核或审核通过状态的招标文件不能删除！");
					return;
				}
				$.ajax({ 
					url:ctx+"/recruitFile/deleteRecruitFile",
					data:{id:row.id},
					dataType:"json",
					type:"post",
					success:function(data){
						if(data.success){
							$("#recruitfile-datagrid").datagrid("unselectAll");
							$("#recruitfile-datagrid").datagrid("reload");
						}
						$.jGrowl(data.msg);
					}
				});
			}
		}]
	});
});


function openDownloadHistory(projectItemId){
	$("#recruitfile_download_history_dialog").window({
	    title: '招标文件下载情况',
	    width: 800,
	    height: 400,
	    closed: true,
	    cache: false,
	    modal: true
	});
	$('#recruitfile_download_history_dialog').window('open');
	
	$("#recruitfile_download_history").datagrid({
		url : ctx + "/bidOpen/listRecruitFileDownloadHistory",
		pagination : true,		
		rownumbers : true,
		striped : true,
		fit:true,
		method : "post",
		queryParams : {
			projectItemId:projectItemId
		},
		onLoadSuccess:function(){
			
		},
		columns : [ [ 
			{field : 'projectItemName',width:150,title : "标段名称"}, 
			{field : 'organBName',title : "投标单位",width:150,align : "center"}, 
			
			{field : 'type',title : "事件",width : 60,formatter:function(value,rowData,rowIndex){
				if(rowData.type == 1){
					return "下载";
				}
				return "预览";
			}}, 
			
			{field : 'downloadTime',title : "下载/预览时间",width : 150},

			
		] ]
		
	});
}

function openBid(recruitId){
	$.ajax({ 
		url:ctx+"/bidOpen/openBidByRecruitId?recruitId="+recruitId,
		dataType:"json",
		type:"post",
		success:function(data){
			$.jGrowl(data.msg);
		}
	});
}

function startExpertGroupSelection(recruitId){
	$.ajax({ 
		url:ctx+"/bidOpen/startExpertGroupSelection?recruitId="+recruitId,
		dataType:"json",
		type:"post",
		success:function(data){
			$.jGrowl(data.msg);
		}
	});
}
function download(recruitId){
	window.open(ctx+"/attachment/recruitfile/dow?recruitFileId="+recruitId);
}
function viewRecruitFile(id){ window.location.href=ctx + "/recruitFileData/viewRecruitFileData?id="+id+"&_"+Math.floor(Math.random()*10000); }
