$(function() {
	$("#expertDemand-datagrid").datagrid({
		title : "专家专业及人数",
		height : 200,
		singleSelect : true,
		rownumbers : true,
		//pagination : true,
		//fitColumns : true,
		idField : "id",
		striped : true,
		animate : false,
		cache : false,
		url:ctx+"/expertDemand/retrieveExpertDemandData",
		queryParams:{expertApplyId:$("#id").val()==""?"-1":$("#id").val()},
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				createOrUpdateExpertDemand($("#expertDemand-datagrid").datagrid("getRows")[rowIndex]);
			});
			$(this).on("click","a.delete",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				deleteExpertDemand(rowIndex);
			});
		},
		toolbar:[
			{text:"添加",iconCls:"myicon-application_add",handler:function(){
				createOrUpdateExpertDemand();
				
			}},
			{text:"修改",iconCls:"myicon-application_add",handler:function(){
				var rowData = $("#expertDemand-datagrid").datagrid("getSelected");
				if (rowData == null) {
					$.messager.alert("系统提示","请选择一条数据！");
					return;
				}
				createOrUpdateExpertDemand(rowData);		
			}},
			{text : "删除",iconCls : "myicon-application_delete",handler : function() {
				var rowData = $("#expertDemand-datagrid").datagrid("getSelected");
				if (rowData == null) {
					$.messager.alert("系统提示","请选择一条数据！");
					return;
				}
				var rowIndex=$("#expertDemand-datagrid").datagrid("getRowIndex",rowData);
				deleteExpertDemand(rowIndex);
			}} 
		],
		data : [],
		columns : [ [ 
		    /* {field:"id",checkbox:true}, */
			{title:"专业",field:'itemCode',width:200,formatter:function(value,rowData,rowIndex){
				return $([{value:rowData["specialtyFirstTypeName"]},{value:rowData["specialtySecondTypeName"]},{value:rowData["specialtyThirdTypeName"]}]).each(function(){
					return this.value!=undefined&&this.value!=null&&this.value!="";
				}).map(function(){return this.value;}).get().join("-");
			}},
			{title:"人数",field:'expertCount',width:50,align:"right"},
			{title:"报到时间",field:'expertCheckInTime',width:120},
			{title:"报到地点",field:'expertCheckInAddress',width:400,editor:'text'},
			{title:"操作",field:"opt",width:160,formatter:function(value,rowData,rowIndex){
				return "<a class='small orange button edit'>编辑</a><a class='small red button delete'>删除</a>";
			}}
		] ]
	});
	$("#avoidOrgan-datagrid").datagrid({
		title:"回避单位",
		height:200,
		singleSelect : true,
		rownumbers : true,
		//pagination : true,
		//fitColumns : true,
		url:ctx+"/avoidanceOrgan/retrieveAvoidOrganData",
		queryParams:{projectInstanceId:$("#projectInstanceId").val()},
		idField : "organName",
		columns:[[
			{title:"回避单位代码",field:"organCode"},
			{title:"回避单位名称",field:"organName"}
		]]
	});
	function createOrUpdateExpertDemand(rowData){
		/*alert(${expertApply.juryExpertNum});*/
		var dialogId=new Date().getTime(); 
		$("<div/>").attr("id",dialogId).appendTo($("body")).css("padding",10).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			cache : false,
			loadingMessage : "正在加载...",
			title : (rowData?"编辑":"添加")+"抽取要求",
			href : ctx+"/expertDemand/addOrMod",
			onLoad:function(){				
				if(rowData){
					for(var key in rowData){
						$(this).find("[name='"+key+"']").val(rowData[key]).change();
					}
				}
			},
			buttons : [
				{text : "确认",color : "red",handler : function() {
					var data=rowData?rowData:{itemCode:"",id:new Date().getTime()};
					$($("#" + dialogId +" form").serializeArray()).each(function(){
						data[this["name"]]=this["value"];
					});
					data.itemCode="";
					if(data["specialtyFirstType"]!=""){
						data.specialtyFirstTypeName=$("#specialtyFirstType").children("option[value='"+data["specialtyFirstType"]+"']").html();
					}
					if(data["specialtySecondType"]!=""){
						data.specialtySecondTypeName=$("#specialtySecondType").children("option[value='"+data["specialtySecondType"]+"']").html();
					}
					if(data["specialtyThirdType"]!=""){
						data.specialtyThirdTypeName=$("#specialtyThirdType").children("option[value='"+data["specialtyThirdType"]+"']").html();
					}
					if(rowData){
						var rowIndex=$("#expertDemand-datagrid").datagrid("getRowIndex",rowData);
						$("#expertDemand-datagrid").datagrid("updateRow",{index:rowIndex,row:data});
					}else{
						$("#expertDemand-datagrid").datagrid("appendRow",data);
					}
					$("#"+ dialogId).dialog("destroy");
				}},
				{text : "取消",color : "red",handler : function() {
					$("#"+ dialogId).dialog("destroy");
				}} 
			]
		});
	}
	function deleteExpertDemand(rowIndex){
		$.messager.confirm("系统提示","确认删除吗?",function(ok) {
			if (ok) {
				$("#expertDemand-datagrid").datagrid("deleteRow",rowIndex);
			}
		});
	}
	$("#expertApplySave").click(function() {
		var paramArray=$(".registerform").serializeArray();
		var rows=$("#expertDemand-datagrid").datagrid("getRows");
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"expertDemandList["+i+"]."+key,value:this[key]});
			}
		});
		rows=$("#avoidOrgan-datagrid").datagrid("getRows");
		
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"avoidanceOrganList["+i+"]."+key,value:this[key]});
			}
		});
		$.ajax({
			url : ctx+"/expertApplication/saveOrUpdate?isComplete=false",
//			url : ctx+"/expertApplication/saveOrUpdate?isComplete=true",
			type : "post",
			data : paramArray,
			dataType : "json",
			beforeSend:function(){
				$.messager.progress({
					title:"系统提示",
					msg:"正在保存专家抽取申请表"
				});
			},
			success : function(data) {
				$.messager.progress("close");
				if(data.success){
					$("#id").val(data.data);
					$.messager.alert("系统提示", data.msg);
				}else{
					$.messager.alert("系统提示", data.msg);
				}
			},
			complete:function(){
				
			}
		});
	});
	$("#expertApplySubmit").click(function() {

		
		//var loadSignDataSuccess=true;
		// 专家抽取数字签名
		var extractTerminalCode = $('#extractTerminalCode').val();
		var investment = parseFloat($('#bdhtgj').val()).toFixed(4);
		var bidContent = $('#bdnr00').val();
		var areaCode = $('#zjszqy').val();
		var taskId = $('#taskId').val();
		//alert(taskId);
		//return false;
		
		//FIXME what is callbackUrl for?
		var callbackUrl = "${pageContext.request.contextPath/expertApplication/saveOrUpdate?isComplete=true}";
		var signStr = "platId="+platId+"&extractTerminalCode="+extractTerminalCode+"&planExtractDate="+planExtractDate+
						"&bidOpenTime="+bidOpenTime+"&bidOpenAddress="+bidOpenAddress+"&bidEvaluateTime="+bidEvaluateTime+
						"&bidEvaluateAddress="+bidEvaluateAddress+"&tendereeOrg="+tendereeOrg+"&tendereePrincipal="+tendereePrincipal+
						"&tendereePhone="+tendereePhone+"&agencyOrg="+agencyOrg+"&agencyPrincipal="+agencyPrincipal+
						"&agencyPhone="+agencyPhone+"&watchdogOrg="+watchdogOrg+"&watchdogPrincipal="+watchdogPrincipal+
						"&watchdogPhone="+watchdogPhone+"&bidEvaluateCommittee="+bidEvaluateCommittee+"&investment="+investment+
						"&bidContent="+bidContent+"&areaCode="+areaCode+"&callbackUrl="+callbackUrl;


		//var signN = sealUtil.addSealWithBKey($("#id").val()+":expertApply","","data="+signStr,"sealPos",200,-150);
                    //sealUtil.JitSignDataStr(signStr);
		var paramArray=$(".registerform").serializeArray();			
		var rows=$("#expertDemand-datagrid").datagrid("getRows");

		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"expertDemandList["+i+"]."+key,value:this[key]});
			}
		});
		rows=$("#avoidOrgan-datagrid").datagrid("getRows");
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"avoidanceOrganList["+i+"]."+key,value:this[key]});
			}
		});
		//paramArray.push({name:'signN',value:signN});
		$.ajax({
			url : ctx+"/expertApplication/saveOrUpdate?isComplete=true",//true
			type : "post",
			async:false,
			data : paramArray,
			dataType : "json",
			beforeSend:function(){
				$("#expertApplySubmit").attr("disabled","true");
				$.messager.progress({
					title:"系统提示",
					msg:"正在提交专家抽取申请表"
				});
		
			},
			success : function(data) {

				$.messager.progress("close");
				if(data.success){
					/***************************
					 * 提交成功后，执行completeFrom方法，删除待办任务？
					 */
					//alert(taskId);
					$("#id").val(data.data);					
					$.messager.alert("系统提示", data.msg);	
					if(taskId !=null && taskId != ""){
						$("#taskform").submit();
					}else{
						window.location.href=ctx+"/home";
					}
				}else{
					$.messager.alert("系统提示", data.msg);
					$('#expertApplySubmit').removeAttr("disabled");
				}
			},
			complete:function(){
				
			}
		});
	});
	
	$("#expertApply").click(function() {
		var paramArray=$(".registerform").serializeArray();
		var rows=$("#expertDemand-datagrid").datagrid("getRows");
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"expertDemandList["+i+"]."+key,value:this[key]});
			}
		});
		rows=$("#avoidOrgan-datagrid").datagrid("getRows");
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"avoidanceOrganList["+i+"]."+key,value:this[key]});
			}
		});
		$.ajax({
			url : ctx+"/expertApplication/sendoutApply",
			type : "post",
			data : paramArray,
			dataType : "json",
			beforeSend:function(){
				$.messager.progress({
					title:"系统提示",
					msg:"正在专家抽取申请表"
				});
			},
			success : function(data) {
				if(data.success){
					$("#id").val(data.data);
					$.messager.alert("系统提示", data.msg,function(){
						window.location.href=ctx+"/home";
					});
				}else{
					$.messager.alert("系统提示", data.msg);
				}
			},
			complete:function(){
				$.messager.progress("close");
			}
		});
	});
});