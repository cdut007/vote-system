$(function(){
	function addOrEditPolicy(policyId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (policyId?"编辑":"添加")+"政策法规",
			href : ctx + "/policy/policyEdit",
			queryParams:{id:policyId},
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
								$('#policy-datagrid').datagrid('reload');
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
	function deletePolicy(ids){
		$.messager.confirm("系统提示","确认删除吗",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/policy/deletePolicy",
					type:"post",
					dataType:"json",
					data:$(ids).map(function(){return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$('#policy-datagrid').datagrid('reload');
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	function restorePolicy(ids){
		$.ajax({
			url:ctx+"/policy/restorePolicy",
			type:"post",
			dataType:"json",
			data:$(ids).map(function(){return "id="+this;}).get().join("&"),
			success:function(data){
				if(data.success){
					$('#policy-datagrid').datagrid('reload');
				}
				$.jGrowl(data.msg);
			}
		});
	}
	$("#policy-datagrid").datagrid({
		title:"政策法规列表",
		url:ctx+"/policy/pagingPolicyData",
		idField:"id",
		striped:true,
		pagination:true,
		rownumbers:true,
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				window.location.href=ctx+"/policy/policyEdit?id="+$(this).parent().parent().parent().children("td").find(":checkbox").val();
			});
			$(this).on("click","a.delete",function(){
				deletePolicy([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
		},
		toolbar:[
			{text:"添加政策法规",handler:function(){
				window.location.href=ctx+"/policy/policyEdit";
				return;
				addOrEditPolicy();
			}},
			{text:"编辑政策法规",handler:function(){
				var rows=$("#policy-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一条数据编辑！");
					return;
				}
				window.location.href=ctx+"/policy/policyEdit?id="+rows[0]["id"];
				return;
				addOrEditPolicy(rows[0]["id"]);
			}},
			{text:"删除政策法规",handler:function(){
				var rows=$("#policy-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的数据！");
					return;
				}
				deletePolicy($(rows).map(function(){return this["id"];}).get());
			}},
			{text:"还原政策法规",handler:function(){
				var rows=$("#policy-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要还原的数据！");
					return;
				}
				restorePolicy($(rows).map(function(){return this["id"];}).get());
			}}
		],
		columns:[[
			{field:"id",checkbox:true},
			{title:"政策发法规标题",field:"policyTitle",width:700},
			{title:"发布时间",field:"publishTime"},
			{title:"操作",field:"publishUserId",formatter:function(value,rowData,rowIndex){
				return "<a class=\"button orange small edit\">编辑</a><a class=\"button red small delete\">删除</a>";
			}}
		]]
	});
});