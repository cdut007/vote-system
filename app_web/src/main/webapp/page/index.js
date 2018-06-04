$(function() {

	function handleTask(value,index){
		var rows = $("#activititask-datagrid").datagrid('getRows');
		var row = rows[index];
		if(value==null){
			value=row.assignee;
		}
		var taskId = row.id ;
		console.log('taskId='+taskId)
					if (value && value != null) {
						window.location.href=ctx+"/workflow/customTaskForm?taskId=" + taskId;
					} else {
						var obj = this;
						$.ajax({
							url : ctx+"/workflow/claim?taskId="+taskId,
							type : 'post',
							success : function(data) {
								$('#activititask-datagrid').datagrid('reload');
							}
						});
					}
	}

	
	$("#activititask-datagrid").datagrid({
		title : "待办任务列表",
		idField : "id",
		//fitColumns : true,
		singleSelect:true,
		nowrap:false,
		striped : true,
		rownumbers:true,
		pagination:true,
		height : 420,
		toolbar:[],
		url : ctx + "/workflow/pagingTask",
		onLoadSuccess:function(data){
			//console.log(data);
		},
		onDblClickRow:function(index,row){
			handleTask(null,index);
		},
		columns : [[
			{title:'任务名称',field:'name',width:120,formatter:function(value, row, index){
				return "<a href=\""+(row["assignee"]==null?"#":(ctx+"/workflow/customTaskForm?taskId=" + row.id)) + "\">"+value+"</a>";
			}},
			{title:'任务描述',field:'description',width:420},
			{title:'创建时间',field:'createTime',width:150},
			{title:'操作',field:'assignee',width:80,formatter:function(value, row, index) {
				if (value && value != null) {
					return "<a class=\"button orange small\"  href=\""+ctx+"/workflow/customTaskForm?taskId=" + row.id + "\">办理</a>";
				} else {
					return "<a class=\"button blue small\" onclick=\"var obj=this;$.ajax({url : '"+ctx+"/workflow/claim?taskId=" + row.id + "',type : 'post',success : function(data) {$('#activititask-datagrid').datagrid('reload');}});\">签收</a>";
				}
			}}
		]]
	});
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>").prependTo($("#activititask-datagrid").datagrid("getPanel").find(".datagrid-toolbar"));
	$searchForm.append("关键字:<input name='keywords' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#activititask-datagrid").datagrid("options").queryParams;
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
			$("#activititask-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#activititask-datagrid").datagrid('reload');
	});
	$("#message-datagrid").datagrid({
		fit:true,
		title:"金蝉助理消息记录",
		rownumbers:true,
		pagination:true,
		singleSelect:true,
		striped:true,
		url:ctx+"/message/pagingSystemMessage",
		columns:[[
		          {title:"消息内容",field:"content",width:460},
		          {title:"发送时间",field:"sendTime",height:120}
		]]
	});
	/*var geshu=parseInt($("#showTotalQty").html());
	if(geshu>0){
		$.messager.show({
		title:"我的购物车",
		msg:"您的购物车有"+geshu+"件待支付的商品,<a href='"+ctx+"/pay/pagingUnPayItemRecord',style='color:blue'>点击查看</a>",
		showType:'slide',
		style:{
			right:'',
			bottom:''
			}
		});
	}*/
});


