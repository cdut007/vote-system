$(function(){
	function createOrUpdateMenu(menuId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (menuId?"编辑":"添加")+"菜单/权限",
			href : ctx + "/menu/menuEdit",
			queryParams:{id:menuId},
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
							$.jGrowl(data.msg);
							if (data.success) {
								$("#" + id).dialog("destroy");
								var row=data.data;
								var parentId=row["parentId"];
								var parentRow=$("#menu-treegrid").treegrid("find",parentId);
								var siblings=parentRow["children"]?parentRow["children"]:[];
								if(menuId){
									var oldRow=$("#menu-treegrid").treegrid("pop",row["id"]);
									row["children"]=oldRow["children"];
								}
								if($("#includeLock").linkbutton("options").selected||row["deleteMark"]!="删除"){
									for(var i=0,l=siblings.length;i<l;i++){
										var child=siblings[i];
										if(child["orderno"]>row["orderno"]||(child["orderno"]==row["orderno"]&&child["menuName"]>row["menuName"])){
											$("#menu-treegrid").treegrid('insert', {
												before: child["id"],
												data: row
											});
											return;
										}
									}
									$("#menu-treegrid").treegrid('append',{
										parent: parentId,
										data:[row]
									});
								}
								return;
							} 
						}
					});
				}
			}, {
				text : "取消",
				color : "red",
				handler : function() {
					$("#" + id).dialog("destroy");
				}
			} ]
		});
	}
	function deleteMenu(menuId){
		$.messager.confirm("系统提示","确认删除吗?",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/menu/lockMenu",
					type:"post",
					dataType:"json",
					data:$(menuId).map(function(){return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$(menuId).each(function(){
								var row=$("#menu-treegrid").treegrid("find",this);
								if(!$("#includeLock").linkbutton("options").selected){
									$("#menu-treegrid").treegrid("remove",row["id"]);
								}else{
									row["deleteMark"]="删除";
									$("#menu-treegrid").treegrid("update",{"id":row["id"],row:row});
								}
							});
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	function restoreMenu(menuId){
		$.ajax({
			url:ctx+"/menu/restoreMenu",
			type:"post",
			dataType:"json",
			data:$(menuId).map(function(){return "id="+this;}).get().join("&"),
			success:function(data){
				if(data.success){
					$(menuId).each(function(){
						var row=$("#menu-treegrid").treegrid("find",this);
						row["deleteMark"]="正常";
						$("#menu-treegrid").treegrid("update",{"id":row["id"],row:row});
					});
				}
				$.jGrowl(data.msg);
			}
		});
	}
	$("#menu-treegrid").treegrid({
		title:"菜单/权限列表",
		idField : "id",
		striped : true,
		treeField : "text",
		rownumbers:true,
		lines:true,
		animate : false,
		url : ctx+"/menu/getMenuTree",
		queryParams:{"includeLock":false},
		toolbar:[
	         {text:"添加菜单/权限",handler:function(){
	        	 createOrUpdateMenu();
	         }},
	         {text:"编辑菜单/权限",handler:function(){
	        	 var row=$("#menu-treegrid").treegrid("getSelected");
	        	 if(row==null){
	        		 $.jGrowl("请选择一条数据编辑!");
	        		 return;
	        	 }
	        	 createOrUpdateMenu(row["id"]);
	         }},
	         {text:"删除菜单/权限",handler:function(){
	        	 var row=$("#menu-treegrid").treegrid("getSelected");
	        	 if(row==null){
	        		 $.jGrowl("请选择菜单/权限!");
	        		 return;
	        	 }
	        	 deleteMenu([row["id"]]);
	         }},
	         {text:"还原菜单/权限",handler:function(){
	        	 var row=$("#menu-treegrid").treegrid("getSelected");
	        	 if(row==null){
	        		 $.jGrowl("请选择菜单/权限!");
	        		 return;
	        	 }
	        	 restoreMenu([row["id"]]);
	         }},
	         {text:"收起全部",handler:function(){
	        	 $('#menu-treegrid').treegrid('collapseAll');
	         }},
	         {text:"展开全部",handler:function(){
	        	 $('#menu-treegrid').treegrid('expandAll');
	         }},
	         {id:"includeLock",iconCls:"tree-checkbox0",text:"显示删除",toggle:true,selected:false,handler:function(){
	        	 var includeLock=$("#includeLock").linkbutton("options").selected;
	        	 $("#includeLock").linkbutton({iconCls:"tree-checkbox"+(includeLock?"0":"1")});
	        	 $('#menu-treegrid').treegrid('options').queryParams["includeLock"]=!includeLock;
	        	 $('#menu-treegrid').treegrid('reload');
	         }}
		],
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				createOrUpdateMenu($(this).parent().parent().parent().attr("node-id"));
			});
			$(this).on("click","a.delete",function(){
				deleteMenu([$(this).parent().parent().parent().attr("node-id")]);
			});
			$(this).on("click","a.restore",function(){
				restoreMenu([$(this).parent().parent().parent().attr("node-id")]);
			});
		},
		columns : [ [ 
			{field : "text",title : "菜单/权限名称",width : 250}, 
			{field : "menuType",title : "类型",width:100}, 
			{field : "url",title : "请求地址",width :300}, 
			{field : "orderno",title : "优先级",width : 100}, 
			{field : "deleteMark",title : "删除状态",width : 80}, 
			{field : "opt",title : "操作",width:120,formatter : function(value,rowData,rowIndex) {
				return "<a class='button orange small edit'>更新</a>"+
						(rowData["deleteMark"]=="删除"?"<a class='button red small restore'>还原</a>":"<a class='button red small delete'>删除</a>");
			}} 
		] ],
		onDblClickRow : function(rowData) {
			createOrUpdateMenu(rowData["id"]);
		}
	});
});