$(function(){
	function deleteNotice(noticeId){
		$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'html',
					data : $(noticeId).map(function(){return "id="+noticeId;}).get().join("&"),
					url : ctx + "/notice/deleteBidNotice",
					success : function(data) {
						$('#tendernotice-datagrid').datagrid('reload');
						$('#tendernotice-datagrid').datagrid('unselectAll');
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '删除公告失败!');
					}
				});
			}
		});
	}
	$("#tendernotice-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		//fitColumns : true,
		pagination : true,
		collapsible:true,
		height:420,
		title:"招标/资格预审公告列表",
		url : ctx+"/notice/bidNoticeList",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		idField : "id",
		columns : [[
           {field:"noticeTitle",title:"公告标题",align:"left",width:250},
           {field:"gglxdm",title:"公告类型",align:"center",width:30},
           {field:"ggxzdm",title:"公告性质",align:"center",width:60},
           {field:"ggfbsj",title:"公告发布时间",align:"center",width:120},
           {field:"ggjssj",title:"公告结束日期",align:"center",width:50,hidden:true},
           {field:"ggzt",title:"公告状态",align:"center",width:80},
           {field:"opt",title:"操作",align:"left",width:380,formatter : function(value,row,index) {
        	   var returnValue="<a class='button red small' href=\""+ctx+"/notice/showBidNotice?id="+row["id"]+"\">查看</a>";
        	   $.ajax({
					url:ctx+"/notice/HasCancelledOrAgainNotice",
					async:false,
					type:"post",
					data:{noticeId:row['id']},
					dataType:"json",
					success:function(shuju){
						var bidOpen = shuju.data.bidOpenDate.replace(/\-/g, "/");
						var bidOpenDate = new Date(bidOpen);
						if(!shuju.data.hasCancelledNotice&&new Date()<=new Date(bidOpenDate)){
							   if(row["ggxzdm"]=="正常公告"){
											if(shuju.data.hasAgainNotice||row["ggzt"]=="草稿" || row["ggzt"]=="待审核" || row["ggzt"]=="代理机构审核未通过" || row["ggzt"]=="招标人审核未通过" || row["ggzt"]=="公共服务平台审核未通过" || row["ggzt"]=="代理机构审核" || row["ggzt"]=="招标人审核" || row["ggzt"]=="公共服务平台审核"|| row["ggzt"]=="项目经理审核未通过"){
												   
											   }else{
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=5&referenceNoticeId="+row["id"]+"\">再次</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=6&referenceNoticeId="+row["id"]+"\">控制价</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=4&referenceNoticeId="+row["id"]+"\">延期</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=2&referenceNoticeId="+row["id"]+"\">变更</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=7&referenceNoticeId="+row["id"]+"\">补充</a>";
												   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=3&referenceNoticeId="+row["id"]+"\">撤销</a>";
											   }
								}
							   if(row["ggzt"]=="审核通过"){
								   if(row["ggxzdm"]=="再次公告"){
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=5&referenceNoticeId="+row["id"]+"\">再次</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=6&referenceNoticeId="+row["id"]+"\">控制价</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=4&referenceNoticeId="+row["id"]+"\">延期</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=2&referenceNoticeId="+row["id"]+"\">变更</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=7&referenceNoticeId="+row["id"]+"\">补充</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=3&referenceNoticeId="+row["id"]+"\">撤销</a>"; 
								   }
								   if(row["ggxzdm"]=="控制价"){
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=2&referenceNoticeId="+row["id"]+"\">变更</a>";
									   returnValue+="<a class='button red small' href=\""+ctx+"/notice/copyBidNotice?projectInstanceId="+row["projectInstanceId"]+"&ggxzdm=3&referenceNoticeId="+row["id"]+"\">撤销</a>"; 
								   }
							   }
								
						  }
						}
				});
        	   return returnValue; 
        	   
           }}
        ]],
		toolbar:[{
			text : "新建招标公告",
			iconCls : "myicon-application_add",
			handler : function() {
				var data=$("#projectitem-datagrid").treegrid("getRoots");
				if(data.length==0){
					$.jGrowl("请添加标段!");
				}else{
					window.location.href=ctx+"/notice/addOrEditBidNotice?projectInstanceId="+$(":input[name='id']").val()+"&ggxzdm=1&gglxdm=1";
				}
			}
		},{
			text : "新建资格预审公告",
			iconCls : "myicon-application_add",
			handler : function() {
				var data=$("#projectitem-datagrid").treegrid("getRoots");
				if(data.length==0){
					$.jGrowl("请添加标段!");
				}else{
					window.location.href=ctx+"/notice/addOrEditBidNotice?projectInstanceId="+$(":input[name='id']").val()+"&ggxzdm=1&gglxdm=2";
				}
			}
		},{
			text : "编辑公告",
			iconCls : "myicon-application_edit",
			handler : function() {
				var row=$("#tendernotice-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择公告!");
					return;
				}
				if(row.ggzt == "待审核"||row.ggzt == "审核通过"||row.ggzt == "代理机构审核"||row.ggzt=="招标人审核"||row.ggzt=="公共服务平台审核"){
					$.messager.alert("系统提示","该公告处于"+row.ggzt+"状态，不能修改!");
					return;
				}
				window.location.href=ctx+"/notice/addOrEditBidNotice?id="+row.id;
			}
		},{
			text : "删除公告",
			iconCls : "myicon-application_delete",
			handler : function() {
				var row=$("#tendernotice-datagrid").datagrid("getSelected");
				if(row==null){
					$.messager.alert("系统提示","请选择公告!");
					return;
				}
				if(row["ggzt"]!="草稿"){
					$.messager.alert("系统提示","公告已经提交!");
					return;
				}
				deleteNotice([row["id"]]);
			}
		}]
	});
});