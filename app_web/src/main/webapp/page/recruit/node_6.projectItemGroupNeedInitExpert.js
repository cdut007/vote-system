$(function(){
	
	var initBtn = $("#preInitApply");
	initBtn.attr('disabled',true);
	initBtn.removeClass().addClass("button gray");
	initBtn.bind('click',function(){
		
		var data = {'projectInstanceId':''};
		data.projectInstanceId = projectInstanceId;

		var items = $("input[name='itemsFor']");
		var itemname = "";
		var itemidAtrr= [];
		var itemi = 0;
		$.each(items,function(i,item){
			var nd = $(this);
			if(nd.is(":checked") && nd.prop("disabled")==false){
				itemidAtrr[itemidAtrr.length] = nd.val() ;
				nd.attr("disabled",true);
				data['projectItemList['+itemi+'].id']=nd.val()

				itemi++ ;
			}
		});
		if(itemi==0){
			$.messager.alert("系统提示","请选择标段！");
		}else{

			$.ajax({
				url : ctx+"/expertApplication/save?_"+Math.random(),
				type : "post",
				data : data,
				dataType : "json",
				beforeSend:function(){
					initBtn.attr("disabled","true");
					$.messager.progress({
						title:"系统提示",
						msg:"正在提交专家抽取申请表"
					});
				},
				success : function(data) {
					
					var applytable = "#projectitemgroupneedexpert-datagrid";
					$(applytable).datagrid("reload",{projectInstanceId:$(":input[name='id']").val()});
					
					//$(applytable).datagrid("appendRow",data);
					$.messager.progress("close");
					initBtn.attr("disabled",true);
					$("#preInitApply").removeClass().addClass("button gray");
				},
				complete:function(){
					
				}
			});
			
		}
		
		
		
		
		
		
		
		
		
		
	});
	


	//初始化　招标项目的待专家申请的标段
	//var ctx = 'http://localhost:8080';
			$.ajax({
				url : ctx+"/projectItem/needApplyItemList?_"+Math.random(),
				type : "post",
				data : {'projectInstanceId':projectInstanceId},
				dataType : "json",
				success : function(data) {
					var itemsForSelect = $("#itemsForSelect");
					$.each(data,function(i){
						var preAppend = "<div style='border:1px solid lightcoral;display:inline;padding: 5px;margin-right: 4px;height:100%'>";
						$.each(this,function(i2){
							// preAppend+="<input name='itemsFor' value='"+this.id+"' id='itemsFor_"+i+"_"+i2+"' type='checkbox' style='width:20px;height:20px;'/>";
							preAppend+="<input name='itemsFor' value='"+this.id+"' currentBidStage='"+this.currentBidStage+"' id='itemsFor_"+i+"_"+i2+"' type='checkbox' style='width:20px;height:20px;'/>";
							preAppend+="<label id='itemsFor_' for='itemsFor_'>"+this.bdmc00+"</label>&nbsp;&nbsp;";
						});
						preAppend+="</div>";
						itemsForSelect.append(preAppend);
					});
				},
				complete:function(){

					$("input[name='itemsFor']").bind('click',function(){

						$("#preInitApply").attr('disabled',false);
						$("#preInitApply").removeClass().addClass("button red");
						console.log(this.value+" "+this.id+" itemsFor");
						
						//现在选的不是已选择的组，不允许选择
						var thisid = this.id.substring(0,this.id.lastIndexOf("_"));
						var oldthis = this ;
						var itemsSelected = $("input[name='itemsFor']:checked").not(':disabled');
						if(itemsSelected.length>1){
							var isok = false;
							$.each(itemsSelected,function(i,item){
								var itemid=item.id;
								var compIda = itemid.substring(0,itemid.lastIndexOf("_"));
								console.log('thisid='+thisid);
								console.log('compIda='+compIda);
								console.log('oldthis.id='+oldthis.id+" itemid="+itemid);
								if(thisid==compIda && oldthis.id!=itemid && item.prop('disabled')==false){
									isok = true ;
								}
								console.log('已经选择了的标段的id:'+item.id);
							});
							if(isok == false){

								$(oldthis).attr('checked',false);
								$.messager.alert("系统提示","必须选择“开标时间  、开标地点  、专家人数、业主专家人数”相同的标段！");
							}
						}
					});
			
				}
			});
	
	/*****
	 * 需要抽取专家的标段
	 */
	$("#projectitemgroupneedexpert-datagrid").datagrid({
		title:"待抽取专家列表",
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		collapsible:true,
		height:300,
		url : ctx+"/projectItem/expertApplyListForEdit",
		queryParams:{projectInstanceId:$(":input[name='id']").val()},
		idField:"projectItemId",
		columns : [ [ 
		    {field : "projectInstanceNumber",title : "项目编号",align : "left",width:100,hidden:true}, 
 		    {field : "projectInstanceName",title : "项目名称",align : "left",width:100,hidden:true}, 
 		    {field : "projectItemNumber",title : "标段编号",align : "left",hidden:true,width:100}, 
 		    {field : "projectItemName",title : "标段名称",align : "left",width:200,formatter:function(value,rowData,rowIndex){

				var items = rowData["projectItemList"];
				var itemsFor = $("input[name='itemsFor']");
				var stageOfData = rowData["currentBidStage"];
				if(items!=null && items.length && items.length>0){
					var ret = "";
					$.each(items,function(i){
						ret += "，"+this.bdmc00;
						//console.log('后台查出的的标段：'+this.id);
						if(itemsFor.length>0){
							var itId = this.id;
							$.each(itemsFor,function(jj){
								//console.log('所有的待置灰的标段：'+$(this).val());
                                var stageOfFor=$(this).attr('currentBidStage');
								if($(this).val()==itId  && stageOfFor==stageOfData){//增加必须stage也一样
									$(this).attr("disabled",true);
									$(this).attr("checked",true);
								}
							});
						}
					});
					return ret.substring(1);
				}
		    	return "";
		    }}, 
 		    {field : "currentBidStage",title : "预/后审",align : "left",width:80,formatter:function(value,rowData,rowIndex){
 		    	return rowData["currentBidStage"]=='1'?"预审":(rowData["currentBidStage"]=='2'?"后审":"");
 		    }}, 
 		    {field : "bidOpenDate",title : "开标时间",align : "left",width:180}, 
 		    {field : "bidOpenPlace",title : "开标地点",align : "left",width:200}, 
 		    {field : "expertNum",title : "专家人数",align : "left",width:80,formatter:function(value,rowData,rowIndex){
 		    	return rowData["juryExpertNum"]+rowData["juryTUserNum"]+"人";
 		    }}, 
 		   {field : "reviewStatus",title : "状态",align : "left",width:200,formatter:function(value,rowData,rowIndex){
 			   
		    	var re = rowData["reviewStatus"],au = rowData["auditStatus"];
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
				console.log('reviewStatus='+re+" auditStatus="+au);
//reviewStatus  auditStatus
				if(ifThisValue("","1")){return "待保存/提交";}//初始
				else if(ifThisValue("0","")){return "待提交";}//保存草稿
				else if(ifThisValue("1","")){return "代理机构审核";}//已提交　待代理机构审核　代理机构审核
                else if(ifThisValue("0","3")){return "代理机构审核不通过";}//代理机构审核不通过
                else if(ifThisValue("0","5")){return "招标单位审核不通过";}//招标单位审核不通过
				else if(ifThisValue("0","4")){return "平台审核不通过";}//平台审核不通过
                else if(ifThisValue("0","1")){return "招标单位审核";}//代理机构通过后
                else if(ifThisValue("1","1")){return "招标单位审核";}//代理机构通过后
                else if(ifThisValue("0","6")){return "平台审核";}//招标单位通过后
                else if(ifThisValue("1","6")){return "平台审核";}//招标单位通过后
				else if(ifThisValue("100","2")){return "成功:等待开标后抽取专家";}
				else if(ifThisValue("1","2")){return "提交申请到公共服务平台";}//平台通过后
				else if(ifThisValue("2","2")){return "协会审核";}//已提交申请到公共服务平台
				else{return "协会审核";}//其它，如协会审核时，后面
//				
//				
//		    	if(re!=null && re=='100') return "成功:等待开标后抽取专家";
//		    	if(au!=null && au!='1'){
//		    		if(au=='2') return '平台审核通过';
//		    		if(au=='3') return '代理机构审核不通过';
//		    		if(au=='4') return '平台审核不通过';
//		    	}else{ 
//			    	if(re==null || re=="") return "";
//			    	if(re=="0") return "待提交";
//			    	if(re=="1") return "待审核";
//			    	if(re=="2") return "已完成";
//			    	if(re=="3") return "未通过";
//			    	else return "协会审核中";
//		    	}
		    }}, 
 			{title : "操作",field : "projectItemId",width:150,formatter : function(value, rowData) {
 				var taskId = $("input[name='taskId']").val();
 				taskId = "&forRefreshTaskId="+taskId;
 				taskId += "&id="+rowData.id;
 				
 				var showword="";
		    	var re = rowData["reviewStatus"],au = rowData["auditStatus"];
		    	if(re!=null && re=='100'){
		    		showword="查看";// return "成功:等待开标后抽取专家";
		    	}else if(au!=null && au!="" && (au!='1'&&au!='6')){
		    		if(au=='2'){
		    			showword="查看";//return '平台审核通过';
		    		}else if(au=='3'||au=='5'){
		    			showword="编辑申请";//return '代理机构审核不通过';
		    		}else if(au=='4'){
		    			showword="编辑申请";//return '平台审核不通过';
		    		}
		    	}else{ 
			    	if(re==null || re==""){
			    		showword="抽取申请";
			    	}else if(re=="0"){
			    		showword="抽取申请";//return "待提交";
			    	}else if(re=="1"){
			    		showword="查看";//return "待审核";
			    	}else if(re=="2"){
			    		showword="查看";//return "已完成";
			    	}else if(re=="3"){
			    		showword="编辑申请";//return "未通过";
			    	}else{
			    		showword="查看";//return "协会审核中";
			    	}
		    	}
		    	
 				//if(rowData["expertApplyId"]=="") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+"'>抽取申请</a>";
 				//if(rowData["reviewStatus"]=="0") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+"'>编辑</a>";
 				//if(rowData["reviewStatus"]=="2"||rowData["reviewStatus"]=="1") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyView?"+$.param(rowData)+"'>查看</a>";//"已完成";
 				//if(rowData["reviewStatus"]=="3") return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+$.param(rowData)+"'>重新抽取</a>";
 				return "<a class='small button red' href='"+ctx+"/expertApplication/expertApplyForm?"+taskId+"'>"+showword+"</a>";
 			}} 
 		] ]
	});
});
