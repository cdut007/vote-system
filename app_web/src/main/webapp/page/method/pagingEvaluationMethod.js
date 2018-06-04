$(function() {
	function createOrUpdateEvaluationMethod(id){
		window.location.href=ctx+"/evaluationMethod/evaluationMethodEdit"+(id?("?id="+id):"");
	}
	$("#evaluationMethod-datagrid").datagrid({
		title : "报价得分算法列表",
		idField : "id",
		fitColumns : true,
		singleSelect:true,
		striped : true,
		rownumbers:true,
		pagination:true,
		height : 400,
		toolbar:[
	         {text:"添加",handler:function(){
	        	 createOrUpdateEvaluationMethod();
	         }},
	         {text:"编辑",handler:function(){
	        	 var rows=$("#evaluationMethod-datagrid").datagrid("getSelections");
	        	 if(rows.length!=1){
	        		 $.messager.alert("系统提示","请选择要编辑的数据!");
	        		 return;
	        	 }
	        	 createOrUpdateEvaluationMethod(rows[0].id);
	         }},
	         {text:"停用",handler:function(){
	        	 alert(1);
	         }}
		],
		url : ctx + "/evaluationMethod/pagingEvaluationMethodData",
		onLoadSuccess:function(data){
		},
		columns : [[
			{title:'算法名称',field:'evaluationMethodName',width:150},
			{title:'算法描述',field:'evaluationMethodDescription',width:600},
			{title:'算法表达式',field:'evaluationMethodExpression',width:150}
		]]
	});
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>").prependTo($("#evaluationMethod-datagrid").datagrid("getPanel").find(".datagrid-toolbar"));
	$searchForm.append("关键字:<input name='keywords' class='inputxt'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#evaluationMethod-datagrid").datagrid("options").queryParams;
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
			$("#evaluationMethod-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#evaluationMethod-datagrid").datagrid('reload');
	});
});


