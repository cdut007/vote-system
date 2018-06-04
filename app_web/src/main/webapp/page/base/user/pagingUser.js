$(function(){
	/**
	 * 添加人员
	 */
	function createOrUpdateUser(userId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (userId?"编辑":"添加")+"人员",
			href : ctx + "/user/userEdit",
			queryParams:{"id":userId},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					if($("#pwd2").val() != $("#pwd1").val()){
						$.messager.alert('系统提示','两次输入的密码不一致！');
						$("#pwd1").val("");
						$("#pwd2").val("");
						return;
					}
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {							
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + id).dialog('close');
								$('#user-datagrid').datagrid('reload');
								$.messager.alert('系统提示', '添加成功!');
								
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
	/*******************************************************************************
	 * 删除部门
	 */
	function removeUser(userIdArray) {
		$.messager.confirm('系统提示', '确认删除吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'json',
					data : $(userIdArray).map(function(){return "id="+this;}).get().join("&"),
					url : ctx + "/user/deleteUser",
					success : function(data) {
						if(data.success){
							$('#user-datagrid').datagrid('reload');
							$('#user-datagrid').datagrid('unselectAll');
						}
						$.jGrowl(data.msg);
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '删除失败！');
					}
				});
			}
		});
	}
	$("#user-datagrid").datagrid({
		fit:true,
		title:"人员列表",
		remoteSort: true,
		//sortName:"userName",
		//sortOrder:"asc",
		url:ctx+"/user/pagingUserData",
		pagination:true,
		rownumbers:true,
		striped:true,
		method:"post",
		toolbar:[
	         {text:"添加人员",iconCls:"myicon-user_add",handler:function(){
	        	 createOrUpdateUser(); 
	         }},
	         {text:"编辑人员",iconCls:"myicon-user_edit",handler:function(){
	        	var rowData = $('#user-datagrid').datagrid('getChecked');
	     		if (rowData == null || rowData.length!=1) {
	     			$.messager.alert('系统提示', '请选择一条数据！');
	     			return;
	     		}
	        	createOrUpdateUser(rowData[0].id); 
	         }},
	         {text:"删除人员",iconCls:"myicon-user_delete",handler:function(){
	        	var rowData = $('#user-datagrid').datagrid('getChecked');
	     		if (rowData == null ||rowData.length==0) {
	     			$.messager.alert('系统提示', '请选择要删除的数据！');
	     			return;
	     		}
	        	removeUser($(rowData).map(function(){return  this.id;}).get());
	         }}
		],
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				createOrUpdateUser($(this).parents("tr:first").find(":checkbox").val()); 
			});
			$(this).on("click","a.del",function(){
				removeUser([$(this).parents("tr:first").find(":checkbox").val()]);
			});
		},
		columns:[[
		    {field:'id',checkbox:true},
		    {title:"姓名",field:'userName',align:"center",width:100},
		    {title:"性别",field:'gender',align:"center",width:60},
		    {title:"所属部门",field:'department.departmentName',width:80},
		    {title:"联系电话",field:'phone',width:100},
		    {title:"登录账号",field:'loginName',width:80},
		    {title:"添加时间",field:'createDate',width:120},
		    {title:"最后修改时间",field:'modifyDate',width:120},
		    {title:"帐号状态",field:'deleteMark',align:"center",width:100},
		    {title:"操作",field:'opt',align:"center",width:120,formatter:function(value,rowData,rowIndex){
		    	return "<a class='button orange small edit'>编辑</a><a class='button red small del'>删除</a>";
		    }}
		]]
		/*onLoadSuccess: function(data){
			var rows = data.row;
			var total = data.total;
			var newData = {
					'rows': rows,
					'total': total
			}
			$("#user-datagrid").datagrid('loadData', newData);
		}*/
	});
	
	/*$('#user-datagrid').datagrid('getPager').pagination({  
                pageSize: 10,  
                pageNumber: 1,  
                pageList: [10, 20, 30, 40, 50],  
                beforePageText: '第',//页数文本框前显示的汉字   
                afterPageText: '页    共 {pages} 页',  
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',  
           });*/
	
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>").prependTo($("#user-datagrid").datagrid("getPanel").find(".datagrid-toolbar"));
	$searchForm.append("姓名:<input name='userName' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#user-datagrid").datagrid("options").queryParams;
	$searchForm.on("blur",":input:not(.Wdate)",function(){
		queryParams[this.name]=this.value;
	}).on("focus",".Wdate",function(){
		WdatePicker({
			dateFmt:"yyyy-MM-dd",
			minDate:this.name=="minDate"?undefined:($(".Wdate[name='minDate']").val()==""?undefined:$(".Wdate[name='minDate']").val()),
			maxDate:this.name=="maxDate"?undefined:($(".Wdate[name='maxDate']").val()==""?undefined:$(".Wdate[name='maxDate']").val()),
			onpicked:function(){
				queryParams[this.name]=this.value;
			}
		});
	}).on("keydown",":input",function(){
		if(event.keyCode==13){
			$(this).blur();
			$("#user-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#user-datagrid").datagrid('reload');
	});
});