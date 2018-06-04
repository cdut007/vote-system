


$(document).ready(function(){
	function notShowButton(){

    	var re = $("#reviewStatus").val(),au = $("#auditStatus").val();
		function ifThisValue(okRe,okAu){
			var f1 = false,f2=false ;
			if(okRe==null || okRe==''){
				if(re==null || re==''){
					f1=true;
				}
			}else if(okRe==re){
				f1=true;
			}
			
			if(okAu==null||okAu==''){
				if(au==null || au==''){
					f2=true;
				}
			}else if(okAu==au){
				f2=true;
			}
			return f1&&f2;
		}
		
		var f = true ;
		if(ifThisValue("","1")){f=false;}//初始　不显示＝＝false
		else if(ifThisValue("0","")){f=false;}//保存草稿　不显示＝＝false
		else if(ifThisValue("1","")){f = true}//已提交　待代理机构审核　代理机构审核　不显示＝＝false
        else if(ifThisValue("0","3")){f=false;}//代理机构审核不通过　不显示＝＝false
        else if(ifThisValue("0","5")){f=false;}//招标单位审核不通过　不显示＝＝false
		else if(ifThisValue("0","4")){f=false;}//平台审核不通过　不显示＝＝false
        else if(ifThisValue("1","1")){f = true}//代理机构通过后
        else if(ifThisValue("1","6")){f = true}//招标单位通过后
		else if(ifThisValue("1","2")){f = true}//平台通过后　不显示＝＝false
		else{f = true;}//其它，如协会审核时
		return f ;
		
//			    	if(re!=null && re=='100') f=true ;//return "成功:等待开标后抽取专家";
//			    	if(au!=null && au!="" && au!='1'){
//			    		if(au=='2'){ f=true ;return f;}// return '平台审核通过';
//			    		if(au=='3'){ f=true ;return f;}//return '代理机构审核不通过';
//			    		if(au=='4'){ f=true;return f;}//return '平台审核不通过';
//			    	}else{ 
//				    	if(re==null||re==""){ f=false;return f;}
//				    	if(re=="0"){ f=false;return f;}// return "待提交";
//				    	if(re=="1"){ f=false ;return f;}//return "待审核";
//				    	if(re=="2"){ f=true ;return f;}//return "已完成";
//				    	if(re=="3"){ f=false;return f;}// return "未通过";
//			    	}
	}
	if(notShowButton()){
		$("#expertApplySave").removeClass().addClass("button gray");//.toggleClass("button gray");
		$("#expertApplySubmit").removeClass().addClass("button gray");//.toggleClass("button gray");
	}
	
var itemGrpInx = 0;

function getItemNameGrp(itemGrpI){

	var result = "";
	//标段显示
	var showitemid = $("input[name^='expertItemId_"+itemGrpI+"_']");
	$.each(showitemid,function(iti,itObj){
		var itemid = $(this).val();
		var theid = $(this).attr("id");
		var foritename = "expertItemName_"+theid.substring("expertItemId_".length);
		if(iti==0){
			result += $("#"+foritename).val();
		}else{
			result += ","+ $("#"+foritename).val();
		}
	});
	return result ;
}

$("#preInitDemandTable").on("click" ,function(){
	var items = $("input[name='demendGrpList']");
	var itemname = "";
	var itemidAtrr= [];
	var itemi = 0;
	$.each(items,function(i,item){
		var nd = $(this);
		if(nd.is(":checked") && nd.prop("disabled")==false){
			var itemlab = $("#demendGrpName_"+nd.val());
			itemname += ((itemi++)==0?"":",")+ itemlab.text();
			//itemid += ((itemi)==0?"":",")+ nd.val();
			itemidAtrr[itemidAtrr.length] = nd.val() ;
			nd.attr("disabled",true);
			itemlab.attr("disabled",true);

			$("#expertItemIdDiv").append("<input id='expertItemId_"+itemGrpInx+"_"+itemi+"' name='expertItemId_"+itemGrpInx+"_"+itemi+"' value='"+nd.val()+"' type='hidden'/>");
			$("#expertItemIdDiv").append("<input id='expertItemName_"+itemGrpInx+"_"+itemi+"' name='expertItemName_"+itemGrpInx+"_"+itemi+"' value='"+itemlab.text()+"' type='hidden'/>");
		}
	});
	if(itemi==0){
		$.messager.alert("系统提示","请选择标段！");
	}else{
		var applyid = null;
		initDemandTable(itemGrpInx++,itemname,itemidAtrr,applyid);
	}


});
//初始化要求的表格
function initDemandTable(itemGrpI,itemGrpNames,itemGrpIds,applyid) {
	var demandTable = "#expertDemand-datagrid"+itemGrpI;
  	$(demandTable).datagrid({
		title : "标段【"+ itemGrpNames+"】专家专业及人数",
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
		queryParams:{expertApplyId:applyid},
		onLoadSuccess:function(data){				
			var rows=$(demandTable).datagrid("getRows");
			$(rows).each(function(i){
				$(demandTable).datagrid("updateRow",{index:i,row:{'demand2items':itemGrpIds}});
			});
		},
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				createOrUpdateExpertDemand($(demandTable).datagrid("getRows")[rowIndex],itemGrpI);
			});
			$(this).on("click","a.delete",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				deleteExpertDemand(rowIndex,itemGrpI);
			});
		},

		toolbar:[
			{text:"添加",iconCls:"myicon-application_add",handler:function(){
				createOrUpdateExpertDemand(null,itemGrpI);
				
			}},
			{text:"修改",iconCls:"myicon-application_add",handler:function(){
				var rowData = $(demandTable).datagrid("getSelected");
				if (rowData == null) {
					$.messager.alert("系统提示","请选择一条数据！");
					return;
				}
				createOrUpdateExpertDemand(rowData,itemGrpI);		
			}},
			{text : "删除",iconCls : "myicon-application_delete",handler : function() {
				var rowData = $(demandTable).datagrid("getSelected");
				if (rowData == null) {
					$.messager.alert("系统提示","请选择一条数据！");
					return;
				}
				var rowIndex=$(demandTable).datagrid("getRowIndex",rowData);
				deleteExpertDemand(rowIndex,itemGrpI);
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
}


function createOrUpdateExpertDemand(rowData,itemGrpI){
	var demandTable = "#expertDemand-datagrid"+itemGrpI;
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
			//标段显示
			var showitemid = $("input[name^='expertItemId_"+itemGrpI+"_']");
			$.each(showitemid,function(iti,itObj){
				var itemid = $(this).val();
				var theid = $(this).attr("id");
				var foritename = "expertItemName_"+theid.substring("expertItemId_".length);
				var itemname = $("#"+foritename);
				$("#dementDialogItem").append("<input type='checkbox' value='"+itemid+"' name='dementDialogItem' checked='checked' disabled='disabled'/>"+itemname.val());
			});
			
		},
		buttons : [
			{text : "确认",color : "red",handler : function() {
				var data=rowData?rowData:{itemCode:"",id:new Date().getTime()};
				$($("#" + dialogId +" form").serializeArray()).each(function(){
					data[this["name"]]=this["value"];
				});
				//弹出框上的标段id值
				var dementDialogItems = $("input[name='dementDialogItem']");
				var applyItems = [];
				$.each(dementDialogItems,function(dmi,dementDialogItem){
					var nd = $(this);
					applyItems[applyItems.length] = nd.val();
				});
				data['demand2items']=applyItems;
				
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
					var rowIndex=$(demandTable).datagrid("getRowIndex",rowData);
					$(demandTable).datagrid("updateRow",{index:rowIndex,row:data});
				}else{
					$(demandTable).datagrid("appendRow",data);
				}
				$("#"+ dialogId).dialog("destroy");
			}},
			{text : "取消",color : "red",handler : function() {
				$("#"+ dialogId).dialog("destroy");
			}} 
		]
	});
}

//
function deleteExpertDemand(rowIndex,itemGrpI){
	var demandTable = "#expertDemand-datagrid"+itemGrpI;
	$.messager.confirm("系统提示","确认删除吗?",function(ok) {
		if (ok) {
			$(demandTable).datagrid("deleteRow",rowIndex);
		}
	});
}
//
function deleteExpertAvoidance(rowIndex){
	var demandTable = "#avoidOrgan-datagrid";
	$.messager.confirm("系统提示","确认删除吗?",function(ok) {
		if (ok) {
			$(demandTable).datagrid("deleteRow",rowIndex);
		}
	});
}

function findApply1(){
	var applys = $("input[name='oldexpertApplyList']") ;
	if(applys!=null && applys.length>0){
		var apply1 = $("input[name='oldexpertApplyList']").eq(0).val();
	console.log(apply1);
		return apply1;
	}else{
		return "";
	}
}

$("#avoidOrgan-datagrid").datagrid({
	title:"回避单位",
	height:300,
	singleSelect : true,
	rownumbers : true,
	//pagination : true,
	//fitColumns : true,
	url:ctx+"/avoidanceOrgan/retrieveApplyAvoidOrganData",
	queryParams:{projectInstanceId:$("#projectInstanceId").val(),expertApplyId:findApply1()},
	idField : "organName",
	toolbar:[
		{text:"添加",iconCls:"myicon-application_add",handler:function(){
			createOrUpdateAvoidance(null);
		}},
		{text:"修改",iconCls:"myicon-application_add",handler:function(){
			var rowData = $("#avoidOrgan-datagrid").datagrid("getSelected");
			if (rowData == null) {
				$.messager.alert("系统提示","请选择一条数据！");
				return;
			}
			createOrUpdateAvoidance(rowData);		
		}},
		{text : "删除",iconCls : "myicon-application_delete",handler : function() {
			var rowData = $("#avoidOrgan-datagrid").datagrid("getSelected");
			if (rowData == null) {
				$.messager.alert("系统提示","请选择一条数据！");
				return;
			}
			var rowIndex=$("#avoidOrgan-datagrid").datagrid("getRowIndex",rowData);
			deleteExpertAvoidance(rowIndex);
		}} 
	],
	columns:[[
		{title:"回避单位代码",field:"organCode"},
		{title:"回避单位名称",field:"organName"}
	]]
});

function createOrUpdateAvoidance(rowData){
	var demandTable = "#avoidOrgan-datagrid";
	/*alert(${expertApply.juryExpertNum});*/
	var dialogId=new Date().getTime(); 
	$("<div/>").attr("id",dialogId).appendTo($("body")).css("padding",10).dialog({
		width : 600,
		height : 200,
		closed : false,
		modal : true,
		cache : false,
		loadingMessage : "正在加载...",
		title : (rowData?"编辑":"添加")+"回避单位",
		href : ctx+"/avoidanceOrgan/addOrMod",
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
				if(rowData){
					var rowIndex=$(demandTable).datagrid("getRowIndex",rowData);
					$(demandTable).datagrid("updateRow",{index:rowIndex,row:data});
				}else{
					$(demandTable).datagrid("appendRow",data);
				}
				$("#"+ dialogId).dialog("destroy");
			}},
			{text : "取消",color : "red",handler : function() {
				$("#"+ dialogId).dialog("destroy");
			}} 
		]
	});
}
	
	$("#expertApplySave").click(function() {
		if(notShowButton()){
			return ;
		}
		var paramArray=$(".registerform").serializeArray();
		var demainLineInx = 0;
		for(var grpx =0;grpx<itemGrpInx;grpx++){
			var queryParams = $('#expertDemand-datagrid'+grpx).datagrid('options').queryParams;
			var expertApplyId = queryParams.expertApplyId;
			if(expertApplyId==null || expertApplyId==''){
				expertApplyId =demainLineInx ;
			}
			var rows=$("#expertDemand-datagrid"+grpx).datagrid("getRows");
			if(rows && rows.length<1){
				$.messager.alert('系统提示','标段组合【'+getItemNameGrp(grpx)+'】没有添加专家专业及人数！');
				return ;
			}
			$(rows).each(function(i){
				for(var key in this){
					if(key=='demand2items'){//要求的标段特殊处理
						var items = this[key];
						if(items.constructor == Array){
							$(items).each(function(iti){
								paramArray.push({name:"expertDemandList["+demainLineInx+"].demand2items["+iti+"].projectItemId",value:this});
								paramArray.push({name:"expertDemandList["+demainLineInx+"].demand2items["+iti+"].expertApplyId",value:expertApplyId});
							});
						}else{
							alert('没有获取到专家要求相应的标段错误');return ;
						}
					}else{
						if(key!='demand2items'){
							paramArray.push({name:"expertDemandList["+demainLineInx+"]."+key,value:this[key]});
						}
					}
				}
				demainLineInx++;
			});
		}
		
		rows=$("#avoidOrgan-datagrid").datagrid("getRows");
		
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"avoidanceOrganList["+i+"]."+key,value:this[key]});
			}
		});

		$.ajax({
			url : ctx+"/expertApplication/saveOrUpdates?isComplete=false&_"+Math.random(),
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
					var forRefreshTaskId = $('#forRefreshTaskId').val();
					if(forRefreshTaskId!=null && forRefreshTaskId!=''){
						window.location.href=ctx+"/workflow/customTaskForm?taskId="+forRefreshTaskId;
					}
				}else{
					$.messager.alert("系统提示", data.msg);
				}
			},
			complete:function(){
				
			}
		});
	});
	$("#expertApplySubmit").click(function() {
		if(notShowButton()) return ;
		//var loadSignDataSuccess=true;
		// 专家抽取数字签名
		var extractTerminalCode = $('#extractTerminalCode').val();
		var investment = parseFloat($('#bdhtgj').val()).toFixed(4);
		var bidContent = $('#bdnr00').val();
		var areaCode = $('#zjszqy').val();
		var taskId = $('#taskId').val();
		//alert(taskId);
		
		//FIXME what is callbackUrl for?
		var callbackUrl = "${pageContext.request.contextPath/expertApplication/saveOrUpdates?isComplete=true}";
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
		var demainLineInx = 0;
		for(var grpx =0;grpx<itemGrpInx;grpx++){
			var queryParams = $('#expertDemand-datagrid'+grpx).datagrid('options').queryParams;
			var expertApplyId = queryParams.expertApplyId;
			if(expertApplyId==null || expertApplyId==''){
				expertApplyId =demainLineInx ;
			}
			var rows=$("#expertDemand-datagrid"+grpx).datagrid("getRows");
			if(rows && rows.length<1){
				$.messager.alert('系统提示','标段组合【'+getItemNameGrp(grpx)+'】没有添加专家专业及人数！');
				return ;
			}
			$(rows).each(function(i){
				for(var key in this){
					if(key=='demand2items'){//要求的标段特殊处理
						var items = this[key];
						if(items.constructor == Array){
							$(items).each(function(iti){
								paramArray.push({name:"expertDemandList["+demainLineInx+"].demand2items["+iti+"].projectItemId",value:this});
								paramArray.push({name:"expertDemandList["+demainLineInx+"].demand2items["+iti+"].expertApplyId",value:expertApplyId});
							});
						}else{
							alert('没有获取到专家要求相应的标段错误');return ;
						}
					}else{
						if(key!='demand2items'){
							paramArray.push({name:"expertDemandList["+demainLineInx+"]."+key,value:this[key]});
						}
					}
				}
				demainLineInx++;
			});
		}
		rows=$("#avoidOrgan-datagrid").datagrid("getRows");
		$(rows).each(function(i){
			for(var key in this){
				paramArray.push({name:"avoidanceOrganList["+i+"]."+key,value:this[key]});
			}
		});

		//wangzhi tmp note
		//paramArray.push({name:'signN',value:signN});
		$.ajax({
			url : ctx+"/expertApplication/saveOrUpdates?isComplete=true&_"+Math.random(),//true
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
					var forRefreshTaskId = $('#forRefreshTaskId').val();
					if(forRefreshTaskId!=null && forRefreshTaskId!=''){
						window.location.href=ctx+"/workflow/customTaskForm?taskId="+forRefreshTaskId;
					}else{
						if(taskId !=null && taskId != ""){
							$("#taskform").submit();
						}else{
							window.location.href=ctx+"/home";
						}
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
	
	//根据已有的申请记录初始化

	//根据已有的申请记录初始化
	var applys = $("input[name='oldexpertApplyList']");
	$.each(applys,function(appi,apply){
		var appId = $(this).val();
		//找出标段信息
		var itemids = $("#olddemendGrpListid_"+appId).val();
		var itemname = $("#olddemendGrpListname_"+appId).val();
		 if(itemname.indexOf(",")!=-1){
			 itemname = itemname.substring(1);
		 }
		var itemidAtrr = [];
		//已有的选择disable
		$($("input[name='demendGrpList']")).each(function(its){
			var nd = $(this);
			//这些是当前申请的,要灰掉
			$.each($("input[name^='expertItemId_"+itemGrpInx+"_']"),function(itmi,itmnd){
				if(nd.val()==$(itmnd).val()){
//					console.log('需要灰掉的id:'+nd.attr("id"));
					nd.attr("checked",true);
					nd.prop("checked",true);
					nd.attr("disabled",true);
					itemidAtrr[itemidAtrr.length]=nd.val();
				}
			});
		});

		initDemandTable(itemGrpInx++,itemname,itemidAtrr,appId);
		$('#expertDemand-datagrid'+(itemGrpInx-1)).datagrid('options').queryParams.expertApplyId=appId;
		
	});

});