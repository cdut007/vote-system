$(function() {
   function createOrUpdateBenchmarkMethod(id){
	   window.location.href=ctx+"/benchmark/benchmarkMethodEdit"+(id?("?id="+id):"");
   }
   function deleteBenchmark(param){
	   $.post(ctx+"/benchmark/deleteBenchmark",param,function(data){
		   var ajax=$.parseJSON(data);
		   if(ajax.success){
			   $("#benchmark-datagrid").datagrid("reload");
		   }
		   $.messager.alert("系统提示",ajax.msg);
	   });
   }
	$("#benchmark-datagrid").datagrid({
		title : "评标基准价算法列表",
		idField : "id",
		fitColumns : true,
		singleSelect:true,
		striped : true,
		rownumbers:true,
		pagination:true,
		height : 400,
		toolbar:[
		         {text:"添加",handler:function(){
		        	 createOrUpdateBenchmarkMethod();
		         }},
		         {text:"编辑",handler:function(){
		        	 var rows=$("#benchmark-datagrid").datagrid("getSelections");
		        	 if(rows.length!=1){
		        		 $.messager.alert("系统提示","请选择要编辑的数据!");
		        		 return;
		        	 }
		        	 createOrUpdateBenchmarkMethod(rows[0].id);
//		        	 window.location.href=ctx+"/benchmark/benchmarkMethodEdit";
		         }},
		         {text:"删除",handler:function(){
		        	 var rows=$("#benchmark-datagrid").datagrid("getSelections");
		        	 if(rows.length<1){
		        		 $.messager.alert("系统提示","请选择要删除的数据!");
		        		 return;
		        	 }
		        	 var param=$(rows).map(function(){ return {name:"id",value:this.id};}).get();
		        	 deleteBenchmark(param);
		         }}
		],
		url : ctx + "/benchmark/pagingBenchmarkData",
		onLoadSuccess:function(data){
		},
		columns : [[
			{title:'算法名称',field:'benchmarkName',width:150},
			{title:'算法描述',field:'benchmarkDescription',width:600},
			{title:'算法表达式',field:'benchmarkExpression',width:150}
		]]
	});
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>").prependTo($("#benchmark-datagrid").datagrid("getPanel").find(".datagrid-toolbar"));
	$searchForm.append("关键字:<input name='keywords' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#benchmark-datagrid").datagrid("options").queryParams;
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
			$("#benchmark-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#benchmark-datagrid").datagrid('reload');
	});
});


