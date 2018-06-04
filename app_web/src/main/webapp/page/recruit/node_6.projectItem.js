$(function(){
	function createOrUpdateProjectItem(projectItemId,projectInstanceId){
		$.ajax({
			type : 'post',
			dataType : 'json',
			data : {projectItemId:projectItemId,projectInstanceId:projectInstanceId},
			url : ctx + "/projectItem/check_GGZT",
			//async : true,
			success : function(data) {
				//console.info(data.msg);
				if(!data.success){
					$.jGrowl(data.msg);
					return;
				}
				var id = new Date().getTime();
				$("body").append("<div style='padding:10px' id='" + id + "'></div>");
				$("#" + id).dialog({
					width : 600,
					height : 600,
					closed : false,
					modal : true,
					loadingMessage : '正在加载...',
					title : "添加标段(包)",
					href : ctx + "/projectItem/projectItemEdit?_="+new Date().getTime(),
					queryParams:{projectInstanceId:$(":input[name='id']").val(),id:projectItemId},
					onClose : function() {
						$("#" + id).dialog("destroy");
					},
					buttons : [ {
						text : "确认",
						color : "red",
						handler : function() {
							$("#" + id + " form").ajaxSubmit({
								dataType:"json",
								beforeSend:function(){
									$.messager.progress({
										title:"系统提示",
										msg:"正在提交，请稍后..."
									});
									var valid =  $("#" + id + " form").form("validate");
									if(valid && $("#bdfldm").combotree('getValue').length!=7){
										valid = false;
										$.messager.alert('系统提示', '请选择标段(包)分类代码到3级（如果有）！');
									}

									if(valid == false){
                                        $.messager.progress("close");
									}

									return valid;
								},
								dataType:"json",
								success:function(data){
									$.messager.progress("close");
									$.jGrowl(data.msg);
									if(data.success){
										$("#projectitem-datagrid").treegrid("reload");
										$("#" + id).dialog("destroy");
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
				/*$.jGrowl(data.msg);*/
			}			
		});	
	}
	function deleteProjectItem(projectItemId){
		//console.info($(projectItemId).map(function(){return "id="+this;}).get().join("&"));
		$.ajax({
			type : 'post',
			dataType : 'json',
			data : $(projectItemId).map(function(){return "id="+this;}).get().join("&"),
			url : ctx + "/projectItem/check_GGZT_delete",
			//async : true,
			success : function(data) {
				if(!data.success){
					$.jGrowl(data.msg);
					return;
				}
				$.messager.confirm('系统提示', '确认删除吗?', function(ok) {					
					if (ok) {
						$.ajax({
							type : 'post',
							dataType : 'json',
							data : $(projectItemId).map(function(){return "id="+this;}).get().join("&"),
							url : ctx + "/projectItem/deleteProjectItem",
							success : function(data) {
								if(data.success){
									$('#projectitem-datagrid').treegrid('reload');
									$('#projectitem-datagrid').treegrid('unselectAll');
								}
								$.jGrowl(data.msg);
							},
							error : function(e, s1, s2) {
								$.jGrowl('删除标段(包)失败！');
							}
						});
					}
				});				
			}	
		});				
	}
	function lookProjectItem(projectItemId){
		$("body").append("<div style='padding:10px' id='" + projectItemId[0] + "'></div>");
		$("#"+projectItemId[0]).dialog({
			open : false,
			title : '投标资料审核表',
			closed:false,
			modal:true,
			loadingMessage : '正在加载...',
			content:"<table id='registration'></table>",
			onClose : function() {
				$("#" + projectItemId[0]).dialog("destroy");
			},
			width:570,
			height:400
		});
		$("#registration").datagrid({
			url : ctx + "/projectItem/registration?projectItemId="+projectItemId[0],
			pagination : true,		
			rownumbers : true,
			striped : true,
			fit:true,
			columns : [ [ 
				{field : 'organName',width:150,title : "投标单位"}, 
				{field : 'auditorName',title : "审核人",width:150,align : "center"}, 
				{field : 'auditDate',title : "审核时间",width : 150},
			] ]
			
		});
		$("#registrationdiv").dialog("open");
		
	}
	$("#projectitem-datagrid").treegrid({
		title:"标段(包)列表",
		idField:"id",
		url:ctx+"/projectItem/pagingProjectItemData",
		rownumbers:true,
		striped:true,
		singleSelect:false,
		collapsible:true,
		height:300,
		treeField:'bdmc00',
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				createOrUpdateProjectItem($(this).parent().parent().parent().children("td").find(":checkbox").val(),$(":input[name='id']").val());
			});
			$(this).on("click","a.delete",function(){
				deleteProjectItem([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
			$(this).on("click","a.look",function(){
				lookProjectItem([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
			window.setTimeout(function(){
				var uploader = new plupload.Uploader({
					runtimes : 'html5,flash,silverlight,html4',
					browse_button : "shangchuan",
					url : ctx + '/projectItem/resolveEcxel',
					flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
					silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
					multi_selection : false,
					multipart_params : {
						projectInstanceId:$(":input[name='id']").val()
					},
					filters : {
						 mime_types  : [
							{title:"*",extensions : "xls"}
						],
						prevent_duplicates : true,
						max_file_size : '200mb'
					},
					init : {
						PostInit : function() {
							//alert(1);
						},
						FilesAdded : function(up, files) {
							//alert(3)
							up.start();
							top.$.messager.progress({
								title : "正在上传......"
							});
						},
						UploadProgress : function(up, file) {							
						},
						FileUploaded : function(up, file, result) {
							var data = $.parseJSON(result.response);
							if (data.success) {
								$("#projectitem-datagrid").treegrid("reload");	
								up.removeFile(file);
							}
							//$.jGrowl(data.msg);
							/*****************************************
							 * 上传完成后，提示完善标段信息
							 **/
							$.messager.alert("系统提示","上传成功，请完善上传标段信息！",function(){
								
							});
						},
						UploadComplete : function(uploader, files) {
							//$("#projectitem-datagrid").datagrid("reload");	
							$.messager.progress("close");
						},
						Error : function(up, err) {
							//alert(2);
							$.jGrowl(err.message);
						}
					}
				}).init();
			},1000);				
		},		
		columns:[[
		    {field:"id",checkbox:true},
		    {title:'标段(包)名称',field:'bdmc00',width:100},
			{title:'标段(包)内容',field:'bdnr00',width:100},
			{title:'标段(包)类别',field:'bdfldm',align:"center",width:60},
			{title:'标段(包)合同估价',field:'bdhtgj',align:'right',width:80},
			{title:'估价单位',field:'bdgjdw',align:'right',width:30},
			{title:'估价币种',field:'bdgjdm',align:'right',width:80},
			{title:'标书售价（元）',field:'price',align:'right',width:90},
			{title:'开标时间',field:'tenderNoticeData',align:'center',width:120,formatter:function(value,rowData,rowIndex){
				if (rowData.tenderNoticeData) {
					return rowData.tenderNoticeData.bidOpenDate;
				}
			}},
			{title:'操作',field:"opt",formatter:function(value,rowData,rowIndex){
				return "<a class=\"button orange small edit\">编辑</a><a class=\"button red small delete\">删除</a><a class=\"button red small look\">报名资料审核表</a>";
			}}
		]],
		toolbar:[{
			text : "添加标段(包)",
			iconCls : "myicon-application_add",
			handler : function() {
				/*if($("#projectitem-datagrid").datagrid("getRows").length==0){
					$("#saveBaseInfo").click();
				}*/
				createOrUpdateProjectItem("",projectInstanceId);
			}
		},{
			text : "编辑标段(包)",
			iconCls : "myicon-application_edit",
			handler : function() {
				var row=$("#projectitem-datagrid").datagrid("getChecked");
				if(row.length!=1){
					$.jGrowl("请选择一个标段(包)!");
					return;
				}
				createOrUpdateProjectItem(row[0]["id"],projectInstanceId);
			}
		},{
			text : "删除标段(包)",
			iconCls : "myicon-application_delete",
			handler : function() {
				var row=$("#projectitem-datagrid").datagrid("getChecked");
				if(row.length==0){
					$.jGrowl("请选择标段(包)!");
					return;
				}
				deleteProjectItem($(row).map(function(){return this["id"];}).get());
			}
		},{
			text:"模板下载",
			iconCls:"myicon-attach",
			handler:function(){
				window.open("/resources/templet/标段模板.xls");				
			}
		},{
			id:"shangchuan",
			text:"上传",
			iconCls:"myicon-basket_remove"
			
		}]
	});
});