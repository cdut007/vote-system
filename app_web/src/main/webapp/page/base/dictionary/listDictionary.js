$(function() {
	function createOrUpdateType(typeCode) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 400,
			height : 300,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (typeCode?"编辑":"添加")+"数据字典类型",
			queryParams:{typeCode:typeCode},
			href : ctx+"/dictionary/dictionaryTypeEdit",
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					var typeCode=$("#" + id + " form").find(":input[name='newTypeCode']").val();
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + id).dialog('close');
								$("#dictionaryType").datagrid({onLoadSuccess:function(){
									$(this).datagrid("selectRecord",typeCode);
								}});
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						},
						error:function(e,s1,s2){
							alert(e);
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
	function deleteType(typeCode) {
		$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
			if (ok) {
				$.ajax({
					url : ctx+"/dictionary/deleteDictionaryType",
					type : "post",
					dataType : "json",
					data : {typeCode:typeCode},
					success : function(data) {
						if (data.success) {
							$("#dictionaryType").datagrid({onLoadSuccess:function(){
								$(this).datagrid("unselectAll");
							}});
							$("#dictionaryTree").treegrid("loadData",[]);
						}
						$.jGrowl(data.msg);
					},
					error : function(e, s1, s2) {
						$.jGrowl("操作失败！");
					}
				});
			}
		});
	}
	function createOrUpdateItem(itemData) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 500,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (itemData.id?"编辑":"添加")+"数据字典类型",
			href : ctx+"/dictionary/dictionaryEdit",
			queryParams:itemData,
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
								$("#dictionaryTree").treegrid({queryParams:{typeCode:data.data.typeCode,fetchId:data.data.id},onLoadSuccess:function(){
									$(this).treegrid("select",data.data.id);
									var parentId=data.data.parentId;
									while(parentId){
										$(this).treegrid("expand",parentId);
										var parent=$(this).treegrid("find",parentId);
										parentId=parent.parentId;
									}
								}});
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
	function deleteItem(itemData) {
		$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
			if (ok) {
				$.ajax({
					url : ctx+"/dictionary/deleteDictionary",
					type : "post",
					dataType : "json",
					data : {id:itemData.id,parentId:itemData.id,typeCode:itemData.typeCode},
					success : function(data) {
						if (data.success) {
							var selected = $("#dictionaryTree").treegrid("getSelected");
							if (selected != null) {
								$("#dictionaryTree").treegrid("unselect", selected.id);
							}
							$("#dictionaryTree").treegrid("remove",itemData.id);
						}
						$.jGrowl(data.msg);
					},
					error : function(e, s1, s2) {
						$.jGrowl("操作失败！");
					}
				});
			}
		});
	}
	$("#dictionaryType").datagrid({
		title:'数据字典类型',
		border : false,
		singleSelect : true,
		rownumbers : true,
		url : ctx+'/dictionary/dictionaryTypeList',
		fit : true,
		idField : 'typeCode',
		striped : true,
		toolbar:[
	         {text:"添加类别",handler:function(){
	        	 createOrUpdateType();
	         }},
	         {text:"更新类别",handler:function(){
	        	var typeData = $("#dictionaryType").datagrid("getSelected");
	     		if (typeData == null) {
	     			$.messager.alert("系统提示","请选择字典类型！");
	     			return;
	     		}
	        	createOrUpdateType(typeData["typeCode"]);
	         }},
	         {text:"删除类别",handler:function(){
				var typeData = $("#dictionaryType").datagrid("getSelected");
				if (typeData == null) {
					$.messager.alert("系统提示","请选择字典类型！");
					return;
				}
				deleteType(typeData["typeCode"]);
	         }}
		],
		columns:[[
			{field:'typeName',width:150,title:"字典类型名称"},
			{field:'typeCode',width:150,title:"字典类型编码"}
		]],
		onSelect : function(rowIndex, rowData) {
			var selected = $("#dictionaryTree").treegrid("getSelected");
			if (selected != null) {
				$("#dictionaryTree").treegrid("unselect", selected.id);
			}
			$("#dictionaryTree").treegrid({
				"url" : ctx+"/dictionary/dynamicDictionaryTree",
				queryParams : {
					typeCode : rowData.typeCode
				}
			});
		}
	});
	$("#dictionaryTree").treegrid({
		title:'数据字典项',
		lines:true,
		rownumbers:true,
		border:false,
		fit:true,
		idField: 'id',
		treeField: 'itemName',
		striped:true,
		toolbar:[
	         {text:"添加项",handler:function(){
	        	 var typeData = $("#dictionaryType").datagrid("getSelected");
	        	 if(typeData==null){
	        		 if (typeData == null) {
	 					$.messager.alert("系统提示","请选择字典类型！");
	 					return;
	 				}
	        	 }
	        	 var itemData = $("#dictionaryTree").datagrid("getSelected");
	        	 createOrUpdateItem({parentId:(itemData==null?undefined:itemData.id),typeCode:typeData.typeCode});
	         }},
	         {text:"更新项",handler:function(){
	        	var itemData = $("#dictionaryTree").datagrid("getSelected");
	     		if (itemData == null||itemData.parentId==null) {
	     			$.messager.alert("系统提示","请选择字典项！");
	     			return;
	     		}
	        	createOrUpdateItem({id:itemData.id,typeCode:itemData.typeCode});
	         }},
	         {text:"删除项",handler:function(){
				var itemData = $("#dictionaryTree").datagrid("getSelected");
				if (itemData == null||itemData.parentId==null) {
					$.messager.alert("系统提示","请选择字典项！");
					return;
				}
				deleteItem({id:itemData.id});
	         }}
		],
		columns:[[
			{field:'itemName',width:200,title:"字典名称"},
			{field:'itemCode',width:80,title:"字典值"},
			{field:'orderNo',width:60,title:"排序号"},
			{field:'description',width:300,title:"字典描述"}
		]]
	});
});