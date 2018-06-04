$(function(){
	function addOrEditArticle(articleId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (articleId?"编辑":"添加")+"文章",
			href : ctx + "/organ/organNewsEdit",
			queryParams:{id:articleId},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			/* onOpen:function(){
				var ue1 = UE.getEditor('articleContent', {
					toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
					elementPathEnabled : false,
					autoHeightEnabled : false
				});
			}, */
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
								$('#organNews-datagrid').datagrid('reload');
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
	function deleteArticle(ids){
		$.messager.confirm("系统提示","确认删除吗",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/article/deleteArticle",
					type:"post",
					dataType:"json",
					data:$(ids).map(function(){return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$('#organNews-datagrid').datagrid('reload');
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	function restoreArticle(ids){
		$.ajax({
			url:ctx+"/article/restoreArticle",
			type:"post",
			dataType:"json",
			data:$(ids).map(function(){return "id="+this;}).get().join("&"),
			success:function(data){
				if(data.success){
					$('#organNews-datagrid').datagrid('reload');
				}
				$.jGrowl(data.msg);
			}
		});
	}
	$("#organNews-datagrid").datagrid({
		title:"企业动态列表",
		url:ctx+"/organ/pagingOrganNewsData",
		striped:true,
		pagination:true,
		rownumbers:true,
		idField:"id",
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				window.location.href=ctx+"/organ/organNewsEdit?id="+$(this).parent().parent().parent().children("td").find(":checkbox").val();
			});
			$(this).on("click","a.delete",function(){
				deleteArticle([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
		},
		toolbar:[
			{iconCls:"myicon-page_add",text:"添加企业动态",handler:function(){
				window.location.href=ctx+"/organ/organNewsEdit";
				return;
				//addOrEditArticle();
			}},
			{iconCls:"myicon-page_edit",text:"编辑企业动态",handler:function(){
				var rows=$("#organNews-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一条数据编辑！");
					return;
				}
				window.location.href=ctx+"/article/articleEdit?id="+rows[0]["id"];
				return;
				addOrEditArticle(rows[0]["id"]);
			}},
			{iconCls:"myicon-page_delete",text:"删除企业动态",handler:function(){
				var rows=$("#organNews-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的数据！");
					return;
				}
				deleteArticle($(rows).map(function(){return this["id"];}).get());
			}},
			{iconCls:"myicon-arrow_undo",text:"还原企业动态",handler:function(){
				var rows=$("#organNews-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要还原的数据！");
					return;
				}
				restoreArticle($(rows).map(function(){return this["id"];}).get());
			}}
		],
		columns:[[
			{field:"id",checkbox:true},
			{title:"动态标题",field:"articleTitle",width:500},
			{title:"发布时间",field:"publishTime"},
			{title:"操作",field:"createTime",formatter:function(){
				return "<a class=\"button orange small edit\">编辑</a><a class=\"button red small delete\">删除</a>";
			}}
		]]
	});
});