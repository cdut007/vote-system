//选择招标项目后触发函数
function selectProjectInstance(obj) {
	queryProjectItem(obj);
	queryProjectInstance(obj);
}
//返回上一页
function goBack(){
	var str =document.referrer;
	console.log(str);
	if(str!=null){
		location = str;
	}else{
		history.go(-1);
	}
}
// 确认以哪个数据为准
function confirmData(tenderNoticeData) {
	var id = new Date().getTime();
	$("body").append("<div style='padding:10px' id='" + id + "'></div>");
	$("#" + id).dialog({
		width : 400,
		height : 200,
		closed : false,
		modal : true,
		loadingMessage : '正在加载...',
		title : "提示信息",
		content : "所选标段数据与表单现有数据不一致，请选择以哪个数据为准",
		onClose : function() {
			$("#" + id).dialog("destroy");
		},
		buttons : [ {
			text : "以表单数据为准",
			color : "red",
			handler : function() {
				$("#" + id).dialog("close");
			}
		}, {
			text : "已所选标段数据为准",
			color : "red",
			handler : function() {
				setFormData(tenderNoticeData);
				setNoticeContentData(tenderNoticeData);
				$("#" + id).dialog("close");
			}
		} ]
	});
}
// 设置表单中的值
function setFormData(tenderNoticeData) {
	$("#bidDeadline").val(tenderNoticeData.bidDeadline);
	$("#bidSendForm").val(tenderNoticeData.bidSendForm);
	$("#bidFileObtainWay").val(tenderNoticeData.bidFileObtainWay);
	$("#applyDateBegin").val(tenderNoticeData.applyDateBegin);
	$("#applyDateEnd").val(tenderNoticeData.applyDateEnd);
	$("#bidOpenDate").val(tenderNoticeData.bidOpenDate);
	$("#bidOpenPlace").val(tenderNoticeData.bidOpenPlace);
}

// 设置公告内容中的值
function setNoticeContentData(tenderNoticeData) {
	$("span[name='projectItem.tenderNoticeData.applyDateBegin']").html(tenderNoticeData.applyDateBegin);
	$("span[name='projectItem.tenderNoticeData.applyDateEnd']").html(tenderNoticeData.applyDateEnd);
	$("span[name='projectItem.tenderNoticeData.bidDeadline']").html(tenderNoticeData.bidDeadline);
	$("span[name='projectItem.tenderNoticeData.bidOpenDate']").html(tenderNoticeData.bidOpenDate);
	$("span[name='projectItem.tenderNoticeData.bidOpenPlace']").html(tenderNoticeData.bidOpenPlace);
	$("span[name='projectInstance.applayPlace']").html(tenderNoticeData.bidFileObtainWay);
	$("span[name='projectItem.tenderNoticeData.applayPlace']").html(tenderNoticeData.bidSendForm);
}

// 判断表单中值是否为空
function isEmpty() {
	if ($("#bidDeadline").val() != '') {
		return false;
	}
	if ($("#bidSendForm").val() != '') {
		return false;
	}
	if ($("#bidFileObtainWay").val() != '') {
		return false;
	}
	if ($("#applyDateBegin").val() != '') {
		return false;
	}
	if ($("#applyDateEnd").val() != '') {
		return false;
	}
	if ($("#bidOpenDate").val() != '') {
		return false;
	}
	if ($("#bidOpenPlace").val() != '') {
		return false;
	}
	return true;
}

// 判断表单中值与所选标段的值是否一致
function accordToForm(tenderNoticeData) {
	if ($("#bidDeadline").val() != tenderNoticeData.bidDeadline && tenderNoticeData.bidDeadline) {
		return false;
	}
	if ($("#bidSendForm").val() != tenderNoticeData.bidSendForm && tenderNoticeData.bidSendForm) {
		return false;
	}
	if ($("#bidFileObtainWay").val() != tenderNoticeData.bidFileObtainWay && tenderNoticeData.bidFileObtainWay) {
		return false;
	}
	if ($("#applyDateBegin").val() != tenderNoticeData.applyDateBegin && tenderNoticeData.applyDateBegin) {
		return false;
	}
	if ($("#applyDateEnd").val() != tenderNoticeData.applyDateEnd && tenderNoticeData.applyDateEnd) {
		return false;
	}
	if ($("#bidOpenDate").val() != tenderNoticeData.bidOpenDate && tenderNoticeData.bidOpenDate) {
		return false;
	}
	if ($("#bidOpenPlace").val() != tenderNoticeData.bidOpenPlace && tenderNoticeData.bidOpenPlace) {
		return false;
	}
	return true;
}

$(function() {
	//签章验证表单
	//var nameArray=["ggnrwb"];
	//印章名称
	//var sealName=$("#sealName").val();
	function autoTitle() {
		var projectItemName = $("#bdjh").combotree("getText");
		var projectItemIds = $("#bdjh").combotree("getValues");
		var ids="";
		for(var id in projectItemIds){
			ids+=projectItemIds[id];
			if(id!=projectItemIds.length-1){
				ids+=",";
			}
		}		var projectInstanceId = $("#projectInstanceId").val();
		var noticeType = $("[name='gglxdm']").val();
		var noticeNature = $("[name='ggxzdm']").val();
		var projectInstanceName = $("#projectInstanceId").children("option[value='" + $("#projectInstanceId").val() + "']").html();
		if(projectInstanceId==""){
			$("[name='noticeTitle']").val("");
			return;
		}
		//获取公告标题
		$.ajax({
			url:ctx+"/notice/generateNoticeTitle?t="+new Date().getTime(),
			type:"post",
			dataType:"json",
			data:{
				referenceNoticeId:$("#referenceNoticeId").val(),
				projectInstanceId : projectInstanceId,
				ggxzdm : noticeNature,
				projectItemName : projectItemName,
				projectInstanceName : projectInstanceName,
				noticeType:noticeType
			},
			success:function(data){
				if(data.success){
					//alert(data.data);
					if (projectInstanceId != "" && noticeType != "9" && noticeNature != "9" && projectItemName != "") {
						$("[name='noticeTitle']").val(data.data);
					}else{
						$("[name='noticeTitle']").val("");
					}
				}
			}
		});
	
		if ($(":checkbox[name='projectItemIdArray']:checked").length > 0) {
			$("#deliveryTimeLimit").empty();
			$(":checkbox[name='projectItemIdArray']:checked").each(function() {
				var projectItemName = $(this).next().text();
				$("#deliveryTimeLimit").append($("<p/>").html(projectItemName + ":" + $(this).attr("deliveryTimeLimit") + "天"));
			});
		}
	}
	$("[name='gglxdm'],[name='ggxzdm'],#projectInstanceId").change(function() {
		autoTitle();
	});
	$(".mytableStyle").autoTable();
	$("#projectInstanceId").change(function() {
		/*$("#bdjh").combotree(this.value==""?"disable":"enable");*/
		if(this.value!=""){
			$("#bdjh").combotree("setValue","");
			$("#bdjh").combotree("reload",ctx+'/projectItem/pagingParentProjectItemData?projectInstanceId='+$("#projectInstanceId").val() +'&gglxdm=' + $("#gglxdm").val() +'&id=' + $("#id").val()  + '&referenceNoticeId=' + referenceNoticeId);
			
		}
		/*if ($(this).val() != "") {
			$.ajax({
				type : "post",
				cache : false,
				url : ctx + "/notice/findProjectItemList",
				async : false,
				data : "projectInstanceId=" + $(this).val(),
				dataType : "json",
				success : function(data) {
					$("#bdjh").empty();
					for (var i = 0, l = data.length; i < l; i++) {
						$("#bdjh").append("<input id='" + data[i].id + "' type='checkbox' name='projectItemIdArray' value='" + data[i].id + "' deliveryTimeLimit=\"" + data[i]["deliveryTimeLimit"] + "\"/><label for=\"" + data[i].id + "\">" + data[i].bdmc00 + "</label>");
					}
					if (data.length == 1) {
						var singleCheckbox = $("#bdjh :checkbox");
						singleCheckbox.prop("checked", true).change();
					}
				}
			});
		}*/
	});
	
	//标段包树形结构
	//如何在标段包中只展示出没有发公告的标段
	$('#bdjh').combotree({  
		onClick:function(node){
			var leafId=$($(this).tree("getChildren",node.target)).filter(function(){
				return this.children==undefined||this.children==null||this.children.length==0;
			}).map(function(){
				return this.id;
			}).get();
			for(var i=0,l=leafId.length;i<l;i++){
				var id=leafId[i];
				var n=$(this).tree("find",id);
				//alert(n);
				$(this).tree("check",n.target);
			}
		},
		loadFilter:function(data,parent){
			return [{text:"全部",id:"",children:data}];
		},
		onBeforeLoad:function(){
		    var needLoad=$("#projectInstanceId").val()!="";
			if(needLoad){
				$.messager.progress({title:"系统提示",msg:"正在加载标段信息"}); 
			}
			return needLoad;
		},
		onLoadSuccess:function(){
			$.messager.progress("close"); 
		},
		onlyLeafCheck:true,  
	    url:ctx+'/projectItem/pagingParentProjectItemData?projectInstanceId='+$("#projectInstanceId").val() +'&gglxdm=' + $("#gglxdm").val() +'&id=' + $("#id").val() + '&referenceNoticeId=' + referenceNoticeId,
	    readonly:noticeId!="",
	    required: true,
	    onCheck:function(node,checked){
	    	autoTitle();
		},
	    onChange:function(newValue,oldValue){
	    	/*$("#bdjh").combotree("disable");*/
	    	var param=$(newValue).map(function() {
				return "projectItemId=" + this;
			}).get().join("&");
	    	$.ajax({
				type : "post",
				cache : false,//不缓冲此页面
				url : ctx + "/notice/getProjectItem",	//根据标段ID获取标段信息，并在选择该标段的时候将信息自动填入
				async : false,
				data : param,
				dataType : "json",
				success : function(data) {
					for ( var key in data) {
						$("[name='tenderNoticeData." + key + "']").val(data[key]);
					}
					$("#noticeForm").form('validate');
				}
			});
//	    	$.ajax({
//				url:ctx+"/notice/findTBProjectItemList",
//				async : false,
//				cache : false,//不缓冲此页面
//				type:"post",
//				data:param,
//				dataType:"json",
//				success:function(data){
////					for(var i=0;i<data.length;i++){
////						var $td=$("#qualificationRequirement>tbody.editor>tr:lt(" + ($("#qualificationRequirement>tbody.editor>tr").length - 1) + ")").find("td");
////						$td.eq(0).find("textarea").val(data[i].tbzgtj);
////					}  
//					
//					for(var i=0;i<data.length;i++){
//						$("#qualificationRequirement>tbody.editor>tr:lt(" + ($("#qualificationRequirement>tbody.editor>tr").length - 1) + ")").each(function(i) {
//							$(this).children("td").children("textarea[name=content]").val(data[i].tbzgtj);
//						});
//					}
//				},
//	    	error:function(){
//	    		alert("error");
//	    	}
//			});
	    }
	}); 
	
	/*$(document).on("change", ":checkbox[name='projectItemIdArray']", function() {
		autoTitle();
		$.ajax({
			type : "post",
			cache : false,
			url : ctx + "/notice/getProjectItem",
			async : false,
			data : $(":checkbox[name='projectItemIdArray']:checked").map(function() {
				return "projectItemId=" + $(this).val();
			}).get().join("&"),
			dataType : "json",
			success : function(data) {
				for ( var key in data) {
					$("[name='tenderNoticeData." + key + "']").val(data[key]);
				}
				$("#noticeForm").form('validate');
			}
		});
	});*/
	
	/*$("#ggxzdm").on('change',function(){
		$("#aaa,#bbb").toggle(this.value=="1");
		if(this.value=="1"){
			$("#noticeContent").removeAttr("contenteditable");
			$("#noticeContent").attr("title","正常公告不可编辑");
		}else{
			$("#noticeContent").attr("contenteditable","true");
			$("#noticeContent").removeAttr("title");
			
		}
		//$("#ccc").toggle(this.value!="1");
	});*/
	$("#save,#complete").click(function() {
		$("#ggnrwb").val($("#noticeContent").html());
		var aa=$("#ggnrwb").val();
		var ggnrwbverify=b64_md5(Utf8Encode(aa.replace(/\s+/g,"")));
		var paramArray = $("#noticeForm").serializeArray();
		$("#qualificationRequirement>tbody.editor>tr:lt(" + ($("#qualificationRequirement>tbody.editor>tr").length - 1) + ")").each(function(i) {
			paramArray.push({name:"qualificationRequirementList[" + i + "].content",value:$(this).children("td").children("textarea[name=content]").val()});
		});
		$("#attachmentRequirementList>tbody.editor>tr:lt(" + ($("#attachmentRequirementList>tbody.editor>tr").length - 1) + ")").each(function(i) {
			paramArray.push({name:"attachmentRequirementList[" + i + "].content",value:$(this).children("td").children("textarea[name=content]").val()});
		});
		var isComplete = $(this).attr("id") == "complete" ? true : false;
		paramArray.push({name:"isComplete",value:isComplete});
		paramArray.push({name:"ggnrwbverify",value:ggnrwbverify});
		paramArray.push({name:"ggnrwb",value:$("#noticeContent").html()});
		if (isComplete) {
			//提交时判断又没有章，
			/*if($("#"+sealName).length==0){
				$.messager.alert('系统提示',"请先盖章！");
				return false;	
			}*/
			
			//TODO 判断时间是否符合
			//TODO 后期要加上比如公告时间最少多少天、投标截止在公告结束之后几天等等内容判断！
			// 1.公告发布和结束时间判断
			if($("#ggfbsj").val()==""||$("#ggjssj").val()==""||$("#applyDateBegin").val()==""||$("#applyDateEnd").val()==""||$("#bidDeadline").val()==""||$("#bidOpenDate").val()==""){
				$.messager.alert("系统提示","请输入完整信息！");
				return;
			}		
			
			var ggfbsjStr = $("#ggfbsj").val();
			var ggfbsj = ggfbsjStr.replace(/\-/g, "/");
			var ggfbsjDate = new Date(ggfbsj);
			
			var ggjssjStr = $("#ggjssj").val();
			var ggjssj = ggjssjStr.replace(/\-/g, "/");
			var ggjssjDate = new Date(ggjssj);
			
			if(ggfbsjDate - ggjssjDate >= 0){
				$.messager.alert("系统提示","公告结束时间必须大于发布时间！");
				return;
			}
			
			// 2.招标文件获取开始和截止时间判断
			var applyDateBeginStr = $("#applyDateBegin").val();
			var applyDateBegin = applyDateBeginStr.replace(/\-/g, "/");
			var applyDateBeginDate = new Date(applyDateBegin);
			
			var applyDateEndStr = $("#applyDateEnd").val();
			var applyDateEnd = applyDateEndStr.replace(/\-/g, "/");
			var applyDateEndDate = new Date(applyDateEnd);
			
			if(applyDateBeginDate - applyDateEndDate >= 0){
				$.messager.alert("系统提示","招标（资格预审）文件获取截止时间必须大于开始时间！");
				return;
			}
			
			// 3.投标文件递交截止时间判断（必须大于招标文件获取截止时间）
			var applyDateEndStr = $("#applyDateEnd").val();
			var applyDateEnd = applyDateEndStr.replace(/\-/g, "/");
			var applyDateEndDate = new Date(applyDateEnd);
			
			var bidDeadlineStr = $("#bidDeadline").val();
			var bidDeadline = bidDeadlineStr.replace(/\-/g, "/");
			var bidDeadlineDate = new Date(bidDeadline);
			
			if(applyDateEndDate - bidDeadlineDate > 0){
				$.messager.alert("系统提示","投标（资格预审申请）文件递交截止时间不能小于招标（资格预审）文件获取截止时间！");
				return;
			}
			
			// 5. 招标文件获取开始时间 必须在公告发布时间 之后
			var applyDateBeginStr = $("#applyDateBegin").val();
			var applyDateBegin = applyDateBeginStr.replace(/\-/g, "/");
			var applyDateBeginDate = new Date(applyDateBegin);
			
			var ggfbsjStr = $("#ggfbsj").val();
			var ggfbsj = ggfbsjStr.replace(/\-/g, "/");
			var ggfbsjDate = new Date(ggfbsj);
			
			if(applyDateBeginDate - ggfbsjDate < 0){
				$.messager.alert("系统提示","招标（资格预审申请）文件获取时间不能小于公告发布时间！");
				return;
			}			
			
			// 4. 开标时间判断（必须大于投标文件递交截止时间）
			var bidDeadlineStr = $("#bidDeadline").val();
			var bidDeadline = bidDeadlineStr.replace(/\-/g, "/");
			var bidDeadlineDate = new Date(bidDeadline);
			
			var bidOpenDateStr = $("#bidOpenDate").val();
			var bidOpenDate = bidOpenDateStr.replace(/\-/g, "/");
			var bidOpenDateDate = new Date(bidOpenDate);
			
			if(bidDeadlineDate - bidOpenDateDate > 0){
				$.messager.alert("系统提示","开标时间不能小于投标（资格预审申请）文件递交截止时间！");
				return;
			}
			if($("#GGXZ").text().indexOf("延期公告") > 0){
				var bidOpenDateStr2 = $("#bidOpenDate2").val();
				var bidOpenDate2 = bidOpenDateStr2.replace(/\-/g, "/");
				var bidOpenDateDate2 = new Date(bidOpenDate2);
				if(bidOpenDateDate - bidOpenDateDate2 < 0){
					$.messager.alert("系统提示","开标时间不能提前");
					return;
				}
				var ggjssjStr2 = $("#ggjssj2").val();
				var ggjssj2 = ggjssjStr2.replace(/\-/g, "/");
				var ggjssjDate2 = new Date(ggjssj2);
				if(ggjssjDate - ggjssjDate2 < 0){
					$.messager.alert("系统提示","公告结束时间不能提前");
					return;
				}
				var applyDateEndStr2 = $("#applyDateEnd2").val();
				var applyDateEnd2 = applyDateEndStr2.replace(/\-/g, "/");
				var applyDateEndDate2 = new Date(applyDateEnd2);
				if(applyDateEndDate - applyDateEndDate2 < 0){
					$.messager.alert("系统提示","招标文件获取截止时间不能提前");
					return;
				}
				var bidDeadlineStr2 = $("#bidDeadline").val();
				var bidDeadline2 = bidDeadlineStr2.replace(/\-/g, "/");
				var bidDeadlineDate2 = new Date(bidDeadline2);
				if(bidDeadlineDate - bidDeadlineDate2 < 0){
					$.messager.alert("系统提示","投标文件递交截止时间不能提前");
					return;
				}
			}
			$.messager.confirm("系统提示", "提交后将不可修改，确认要提交审核吗？", function(r) {
				if (r) {
					$.ajax({
						url : ctx + "/notice/saveOrUpdateBidNotice",
						type : "post",
						beforeSend : function() {
							var validate = $("#noticeForm").form("validate");
							if (validate == true) {
								$.messager.progress({
									title : "系统提示",
									msg : "正在提交数据"
								});
								$("#save,#complete").prop("disabled", true);
							}
							return validate;
						},
						data : paramArray,
						dataType : "json",
						success : function(data) {
							if(data.success){
								$(":input[name='id']").val(data.data);
								$.jGrowl(data.msg);
								goBack();
							}else{
								$.messager.alert("系统提示",data.msg);
							}
						},
						complete : function() {
							$.messager.progress("close");
							$("#save,#complete").prop("disabled", false);
						}
					});
				}
			});
		} else {
			$.ajax({
				url : ctx + "/notice/saveOrUpdateBidNotice",
				type : "post",
				beforeSend : function() {
					var validate = true;
					if (validate == true) {
						$.messager.progress({
							title : "系统提示",
							msg : "正在提交数据"
						});
						$("#save,#complete").prop("disabled", true);
					}
					return validate;
				},
				data : paramArray,
				dataType:"json",
				success : function(data) {
					$("[name='id']").val(data.data);
					$.jGrowl(data.msg);
				},
				complete : function() {
					$.messager.progress("close");
					$("#save,#complete").prop("disabled", false);
				}
			});
		}
	});
	$("#preview").click(function() {
		var noticeId = $("[name='id']").val();
		if (noticeId == "") {
			$.messager.alert("系统提示", "请先保存内容！");
		} else {
			window.open(ctx + "/notice/editNotice?id=" + noticeId);
		}
	});
	/*******
	 * 时间范围限制
	 */
	var fake_time = true;
	function getMinDate(datename){
		$.messager.alert("系统提示","时间范围限制");
		if(fake_time){
			return undefined;
		}
		if(datename==="applyDateBegin"){
			return $("#applyDateEnd").val()==""?new Date(new Date().format("yyyy/MM/dd ")+"08:00:00").format("yyyy-MM-dd HH:mm:ss"):new Date(new Date().format("yyyy/MM/dd")+" 08:00:00").format("yyyy-MM-dd HH:mm:ss");
		}
		if(datename==="applyDateEnd"){
			return $("#applyDateBegin").val()==""?new Date(new Date(new Date().getTime()+4*24*60*60*1000).format("yyyy/MM/dd")+" 17:00:00").format("yyyy-MM-dd HH:mm:ss"):new Date(new Date($("#applyDateBegin").val().replace(/-/g,"/").split(" ")[0]+" 17:00:00").getTime()+4*24*60*60*1000).format("yyyy-MM-dd HH:mm:ss");
		}
		if(datename==="bidDeadline"){
			return $("#applyDateBegin").val()==""?undefined:'#F{$dp.$D(\'applyDateBegin\',{d:21});}';
		}
		if(datename==="bidOpenDate"){
			return $("#bidDeadline").val()==""?undefined:$("#bidDeadline").val()
		}
		if(datename==="ggfbsj"){
			return '%y-%M-%d';
		}
		if(datename==="ggjssj"){
			return $("#applyDateEnd").val()==""?undefined:$("#applyDateEnd").val();
		}
	}
	/*$("#applyDateBegin").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:getMinDate("applyDateBegin"),
			maxDate:$("#applyDateEnd").val()==""?undefined:new Date(new Date($("#applyDateEnd").val().replace(/-/g,"/").split(" ")[0]+" 23:59:59").getTime()-4*24*60*60*1000).format("yyyy-MM-dd HH:mm:ss")
		});
		return true;
	});
	$("#applyDateEnd").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:getMinDate("applyDateEnd")
		});
	});
	$("#bidDeadline").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:getMinDate('bidDeadline')
		});
	});
	$("#bidOpenDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:getMinDate('bidOpenDate')
		});
	});
	$("#ggfbsj").focus(function(){
		WdatePicker({
			isShowWeek:true,
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:getMinDate('ggfbsj')
		});
	});
	$("#ggjssj").focus(function(){
		WdatePicker({
			isShowWeek:true,
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:getMinDate('ggjssj')
		});
	});*/

	
	
	
	
	$(document).on("blur",":input",function(){
		//TODO 延期公告，不更新内容
		if($(this).attr("type")=="button"||$(this).attr("type")=="submit" || $("#GGXZ").text().indexOf("延期公告") > 0){
			return;
		}
		loadDefaultNoticeContent();
	});
	

	$('#controlPrice,#FBFXGCF,#CSXMF').bind('input propertychange', function() {

	    loadDefaultNoticeContent();
	});
	

	
	$("#controlPriceContent").blur(function(){
		loadDefaultNoticeContent();
	});
	
	$(".Wdate").focus(function() {
		//TODO 延期公告，不更新内容
		if($("#GGXZ").text().indexOf("延期公告") > 0){
			WdatePicker({
				dateFmt : 'yyyy-MM-dd HH:mm:ss'
			});
			return;
		}
		WdatePicker({
			dateFmt : 'yyyy-MM-dd HH:mm:ss',
			onpicked : loadDefaultNoticeContent
		});
	});
	
	//变更内容更新
	$("#noticeContent").blur(function(){
		$("#ggnrwb").val(this.innerHTML);
		//$("#"+sealName).remove();
		//document.all.DWebSignSeal.DelSeal("SigndataStr");
	});
	
	loadDefaultNoticeContent();
	/*function addSeal(sealName){
		if($("#"+sealName).length>0){
			$.messager.alert('系统提示',"已盖章,请核实！");
		}
		var imgData=CertInfo.getSignPicture("");
		var offset=$("#ggnr").offset();
		var annoForm=[];
		for(var i=0,l=nameArray.length;i<l;i++){
			var inputName=nameArray[0];
			$(":input[name='"+inputName+"']").each(function(){
				annoForm.push("\""+inputName+"\":\""+encodeURIComponent($(this).val())+"\"");//annoForm.append($("<input/>").attr("name",nameArray[i]).val($(this).val()));
			});
		}
		annoForm.push("\""+"jc-seal-input-list"+"\":\""+nameArray.join(",")+"\"");
		annoForm.push("\""+"jc-seal-data"+"\":\""+imgData+"\"");
		annoForm.push("\""+"jc-seal-position-x"+"\":\""+(offset.left+0)+"\"");
		annoForm.push("\""+"jc-seal-position-y"+"\":\""+(offset.top+0)+"\"");
		annoForm.push("\""+"jc-seal-name"+"\":\""+sealName+"\"");
		$("#ggnr").after($("<img/>").attr("src","data:image/png;base64,"+imgData).attr("id",sealName).addClass("jc-seal").css({position:"absolute",top:offset.top+0,left:offset.left+0,width:150,height:150}));
		//alert(annoForm.html());
		
		
		JITDSignOcx.SetCertChooseType(1);
		JITDSignOcx.SetCertEx("MY", "SC", "", "", "", "", "");
		if(JITDSignOcx.GetErrorCode()!=0){
			alert("错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return ;
		}
		//alert("{"+annoForm.join(",")+"}");
		var signData=JITDSignOcx.AttachSignStr("","{"+annoForm.join(",")+"}");
		$("#SigndataStrSealName").val(sealName);
		$("#SigndataStrSignData").val(signData);
	}*/
	/*$("#sign").click(function(){
		//gaiZhang($("#sealName").val());
		//addSeal(sealName);
		var signData=sealUtil.addSeal(sealName,nameArray,"ggnr",0,0);
		$("#SigndataStrSignData").val(signData);
	});	*/
	//$(":input:first").blur();
});

function loadDefaultNoticeContent(){
	var paramArray=$("#noticeForm").serializeArray();
	$("#qualificationRequirement>tbody.editor>tr:lt(" + ($("#qualificationRequirement>tbody.editor>tr").length - 1) + ")").each(function(i) {
		paramArray.push({name:"qualificationRequirementList[" + i + "].content",value:$(this).children("td").children("textarea[name=content]").val()});
	});
	$("#attachmentRequirementList>tbody.editor>tr:lt(" + ($("#attachmentRequirementList>tbody.editor>tr").length - 1) + ")").each(function(i) {
		paramArray.push({name:"attachmentRequirementList[" + i + "].content",value:$(this).children("td").children("textarea[name=content]").val()});
	});
	setTimeout(function(){
		$.ajax({
			url:ctx+"/notice/loadNoticeContent",
			type:"post",
			data:paramArray,
			dataType:"html",
			success:function(data){
				// TODO
				$("#noticeContent").html(data);
				$("#ggnrwb").val(data);
				//$("#"+sealName).remove();
			}
		});
	},300);
}
