$(function(){
	var projectInstanceId=$("#id").val();
	/****
	 * 澄清
	 */
	function clarifyRecruitFileQuestion() {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			content:"<textarea style='width : 600; height : 400'></textarea>",
			title : "澄清内容",
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons:[
			         {text:"提交"}
			]
		});
	}
	function submitRecruitFileQuestion(id) {
		$.ajax({
			type : 'post',
			dataType : 'json',
			data : {
				id : id
			},
			url : ctx + "/question/submitQuestion",
			success : function(data) {
				if (data.success) {
					$('#recruitfilequestion-datagrid').datagrid('reload');
					$('#recruitfilequestion-datagrid').datagrid('unselectAll');
				}
			},
			error : function(e, s1, s2) {
				$.messager.alert('系统提示', '提交失败！');
			}
		});
			
	}
	/*******
	 * 忽略招标文件质疑
	 */
	function ignoreRecruitFileQuestion(id) {
		$.ajax({
			type : 'post',
			dataType : 'json',
			data : {
				id : id
			},
			url : ctx + "/question/ignoreQuestion",
			success : function(data) {
				if (data.success) {
					$('#recruitfilequestion-datagrid').datagrid('reload');
					$('#recruitfilequestion-datagrid').datagrid('unselectAll');
				}
			},
			error : function(e, s1, s2) {
				$.messager.alert('系统提示', '忽略质疑失败！');
			}
		});
	}
	/****
	 * 查看问题详细
	 */
	function detailRecruitFileQuestion(rowData){
		var dialog=undefined;
		var buttons=[];
		if(rowData.replied=="未处理"){
			buttons.push({text:"忽略",handler:function(){
				$.messager.confirm('系统提示', '确认忽略吗?', function(ok) {
					if (ok) {
						ignoreRecruitFileQuestion(rowData["id"]);
						dialog.dialog("destroy");
					}
				});
			}});
		}
		if(rowData.organTId!=null && rowData.replied!="已澄清"){
			buttons.push({text:"转交招标人",handler:function(){
		    	$.messager.confirm("系统提示","是否转交招标人?",function(ok){
		    		if(ok){
		    			submitRecruitFileQuestion(rowData["id"]);
		    			dialog.dialog("destroy");
		    		}
		    	});
			}});
		}
		buttons.push({text:"关闭",handler:function(){
		    	dialog.dialog("destroy");
		}});
		dialog=$("<div/>").css({"padding":5,"overflow":"hidden"}).appendTo($("body")).dialog({
			title:"招标文件质疑",
			content:"<table class='mytableStyle'>\
						<tr><th style='width:60px;'>投标单位</th><td>"+rowData["organBName"]+"</td></tr>\
						<tr><th>质疑内容</th><td><textarea style='width:100%;height:234px;' readonly='readonly'>"+rowData["questionContent"]+"</textarea></td></tr>\
						<tr><th>质疑时间</th><td>"+rowData["questionDate"]+"</td></tr>\
					</table>",
			width:600,
			height:400,
			buttons:buttons
		});
	}
	//需要澄清的问题列表
	$("#recruitfilequestion-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		//fitColumns : true,
		striped : true,
		pagination : true,
		collapsible:true,
		height:300,
		title : "需要澄清的问题列表",
		url : ctx+"/question/pagingRecruitFileQuestionDataByA",
		queryParams: {projectInstanceId:$(":input[name='id']").val()},
		idField : "id",
		toolbar:[
		         {text:"新建澄清",handler:function(){
		        	 var questionRows=$($("#recruitfilequestion-datagrid").datagrid("getRows")).filter(function(){return this.replied=='未处理';}).get();
		        	 var projectItemId=$("[name=projectItemId_withquestion]").val();
		        	 if(projectItemId=="" || projectItemId==null){
		        		 $.messager.alert("系统提示","请选择需要澄清的标段");
		        		 return;
		        	 }		
		        	 if(questionRows.length==0){
		        		 $.messager.alert("系统提示","此标段无需建澄清的问题");
		        		 return;
		        	 }
		        	 window.location.href=ctx+"/question/form?projectItemId="+$("[name='projectItemId_withquestion']").val()+"&"+$(questionRows).map(function(){return "questionId="+this.id;}).get().join("&");
		         }}
		],
		onOpen:function(){
			$(this).on("click","a.detail",function(){
				var rowIndex=parseInt($(this).attr("datagrid-row-index"));
				detailRecruitFileQuestion($("#recruitfilequestion-datagrid").datagrid("getRows")[rowIndex]);
			});
		},
		columns : [ [ 
		    {field : "projectInstanceName",title : "招标项目",align : "left",width:150,hidden:true}, 
		    {field : "projectItemName",title : "标段",align : "left",width:180}, 
			{hidden : false,field : "organBName",title : "投标单位",align : "center",width:180}, 
			{hidden : false,field : "questionContent",title : "问题内容",align : "left",width : 350}, 
			{hidden : true,field : "questionDate",title : "创建时间",align : "center",width:120}, 
			{hidden : false,field : "replied",title : "状态",align : "center",width:80}, 
			{title : "操作",field : "opt",width:120,formatter : function(value, rowData,rowIndex) {
				return "<a class='button red small detail' datagrid-row-index='"+rowIndex+"'>查看</a>";
			}} 
		] ],
		onDblClickRow:function(rowIndex,rowData){
			detailRecruitFileQuestion(rowData);
		}
	});
	
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>").prependTo($("#recruitfilequestion-datagrid").datagrid("getPanel").find(".datagrid-toolbar"));
	$searchForm.append("标段：<select name='projectItemId' class='inputxt'></select>");
	//$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#recruitfilequestion-datagrid").datagrid("options").queryParams;
	$searchForm.on("blur",":input:not(.Wdate)",function(){
		queryParams[this.name]=this.value;
	}).on("change","select",function(){
		$("#recruitfilequestion-datagrid").datagrid('options').queryParams["projectItemId"]=this.value;
		$("#recruitfilequestion-datagrid").datagrid('reload');
		$("#projectItemId_withquestion").val(this.value);
	});
	$.ajax({
		url:ctx+"/projectItem/pagingProjectItemData",
		type:"post",
		dataType:"json",
		data:{projectInstanceId:projectInstanceId},
		success:function(data){
			var projectItemArray=[{id:"",bdmc00:"全部"}];
			varLeaf(data,projectItemArray);
			$("[name='projectItemId']").append($(projectItemArray).map(function(){return "<option value='"+this["id"]+"'>"+this["bdmc00"]+"</option>";}).get().join("")).change();
		}
	});
	function varLeaf(data,array){
		for(var i=0,l=data.length;i<l;i++){
			var item=data[i];
			var children=item.children;
			if(children!=null&&children.length>0){
				varLeaf(children,array);
			}else{
				array.push(item);
			}
		}
	}
});