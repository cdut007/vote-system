$.extend($.fn.validatebox.defaults.rules, {
	score : {
		validator : function(value, param) {
			if(value==""){
				return true;
			}
			return /^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/.test(value);
		},
		message : "分数必须是一个大于0的数值"
	},
	fullScore : {
		validator : function(value, param) {
			value=parseFloat(value);
			var sum=0;
			$(":input[name='groupFullScore']").filter(function(){
				return this.value!="";
			}).each(function(){
				sum+=parseFloat(this.value);
			});
			return sum==100&&100==value;
		},
		message : "总分必须等于100"
	},
	groupScore : {
		validator : function(value, param) {
			var $sum = $(this).parent().parent("tr").children("td").children("table").children("tbody.statistics").children("tr").children("td").children("[name^='sum']");
			if ($sum.length == 0) {
				return true;
			}
			var compareValue = $sum.val();
			if(value==""&&compareValue==""){
				return true;
			}
			if((value==""&&compareValue!="")||(value!=""&&compareValue=="")){
				return false;
			}
			value = parseFloat(value);
			compareValue = parseFloat(compareValue);
			return value == compareValue;
		},
		message : '当前数值 和  小计 的值必须相同！'
	}
});
$(function() {
	isPrejudication=$("#isPrejudication").val(); 
	ZFZJ=$("#ZFZJ").val(); 
	
	/*$(":radio[name='recruitFileData.bidDepositType']").change(function(){
		  $("#jindaxie").toggle('1'==this.value);
	      $("#dingzhi .easyui-numberbox").textbox('1'==this.value?"enableValidation":"disableValidation");
	      $("#baifenzhi .easyui-numberbox").textbox('0'==this.value?"enableValidation":"disableValidation");
	      //$("#dingzhi .easyui-numberbox").textbox('1'==this.value?"enable":"disable");
	      //$("#baifenzhi .easyui-numberbox").textbox('0'==this.value?"enable":"disable");
	      $("#dingzhi .easyui-numberbox").textbox("validate");
		  $("#baifenzhi .easyui-numberbox").textbox("validate");
	});
	$("#reviewMode").change(function(){
		$("#scoreGroup").find("tbody.editor").toggle(this.value=="SCORE").find("textarea").keyup();
		$("#passDetailReview").toggle(this.value=="PASS").find("textarea").keyup();
	}).change();*/
	/***************************************************************************
	 * 货币金额大写计算
	 */
	/*function castMonery() {
		//&& $("#bidDepositCurrency").val() != ""
		//			var currency = $("#bidDepositCurrency").children("option[value='" + $("#bidDepositCurrency").val() + "']").html();

		if ($("#bidDepositUnit").length >0 && $("#bidDepositUnit").val() != "" && $("#bidDepositAmount").val() != "" ) {
			var monery = parseFloat($("#bidDepositAmount").numberbox("getValue"));
			var unit = $("#bidDepositUnit").val() == "1" ? 1 : 10000;
			if (999999999999 < monery * unit) {
				$("#bidDepositUnit").val("1");
				unit = $("#bidDepositUnit").val() == "1" ? 1 : 10000;
			}
			$("#bigJE").html(convertCurrency(monery * unit));
		}
	}*/
	function serializeData() {
		var paramArray = $("#zbwjForm").serializeArray();
		var rows = 0;
		/***********************************************************************
		 * 初步评审部分
		 */
		$("#zbwjForm").find("#qualificationReview").children("tbody.editor").children("tr").each(function(i) {
			var groupParamArray=[];
			$(this).children("td").children(":input").each(function() {
				groupParamArray.push({name:$(this).attr("name"),value:$(this).val()});
			});
			var index = $(this).children("td").children("table").children("tbody.editor").children("tr").length - 1;
			$(this).children("td").children("table").children("tbody.editor").children("tr:lt(" + index + ")").each(function(j) {
				//初步评审阶段
				var reviewStage = "0";
				if(isPrejudication){
					reviewStage="-1";
				}
				paramArray.push({name : "qualificationReviewList[" + rows + "].reviewStage",value : reviewStage});
				for(var m=0,n=groupParamArray.length;m<n;m++){
					paramArray.push({name:"qualificationReviewList["+rows+"]."+groupParamArray[m].name,value:groupParamArray[m].value});
				}
				$(this).children("td").children(":input").each(function() {
					paramArray.push({
						name : "qualificationReviewList[" + rows + "]." + $(this).attr("name"),
						value : $(this).val()
					});
				});
				rows++;
			});
		});
		
		if(prereviewType=="2"){//合格制：详评
			//合格制：详评
			var index = $("#zbwjForm").find("#passDetailReview").children("tbody.editor").children("tr").length - 1;
			rows = 0;
			$("#zbwjForm").find("#passDetailReview").children("tbody.editor").children("tr:lt("+index+")").each(function(i) {
				var groupParamArray=[];
				$(this).children("td").children(":input").each(function() {
					groupParamArray.push({name:$(this).attr("name"),value:$(this).val()});
				});
				index = $(this).children("td").children("table").children("tbody.editor").children("tr").length - 1;
				$(this).children("td").children("table").children("tbody.editor").children("tr:lt(" + index + ")").each(function(j) {
					//详细评审阶段
					paramArray.push({name : "passReviewList[" + rows + "].reviewStage",value : "1"});
					for(var m=0,n=groupParamArray.length;m<n;m++){
						paramArray.push({name:"passReviewList["+rows+"]."+groupParamArray[m].name,value:groupParamArray[m].value});
					}
					$(this).children("td").children(":input").each(function() {
						paramArray.push({
							name : "passReviewList[" + rows + "]." + $(this).attr("name"),
							value : $(this).val()
						});
					});
					rows++;
				});
			});	
		}else{//有限数量制：详评
			rows=0;
			$("#zbwjForm").find("#scoreGroup").children("tbody:first").children("tr").each(function(i) {
				paramArray.push({name : "scoreReviewList[" + rows + "].reviewStage",value : 1});
				$(this).children("td").children(":input").each(function() {
					paramArray.push({name:"scoreReviewList["+rows+"]."+ $(this).attr("name"),value:($(this).attr("name")=="flag"&&$(this).val()==""?rows:$(this).val())});
				});
				rows++;
			});
			
			var index = $("#zbwjForm").find("#scoreGroup").children("tbody.editor").children("tr").length - 1;
			$("#zbwjForm").find("#scoreGroup").children("tbody.editor").children("tr:lt(" + index + ")").each(function(i) {
				if(!$(this).is(":hidden")){
					var groupParamArray=[];
					$(this).children("td").children(":input").each(function() {
						groupParamArray.push({name:$(this).attr("name"),value:($(this).attr("name")=="flag"&&$(this).val()==""?rows:$(this).val())});
					});
					index = $(this).children("td").children("table").children("tbody.editor").children("tr").length - 1;
					$(this).children("td").children("table").children("tbody.editor").children("tr:lt(" + index + ")").each(function(j) {
						paramArray.push({name : "scoreReviewList[" + rows + "].reviewStage",value : 1});
						for(var m=0,n=groupParamArray.length;m<n;m++){
							paramArray.push({name:"scoreReviewList["+rows+"]."+groupParamArray[m].name,value:groupParamArray[m].value});
						}
						$(this).children("td").children(":input").each(function() {
							paramArray.push({name:"scoreReviewList["+rows+"]."+ $(this).attr("name"),value:$(this).val()});
						});
						rows++;
					});
				}
			});
		}
		
		/*
		if($("#reviewMode").val()=="PASS"){
			var index = $("#zbwjForm").find("#passDetailReview").children("tbody.editor").children("tr").length - 1;
			rows = 0;
			$("#zbwjForm").find("#passDetailReview").children("tbody.editor").children("tr:lt("+index+")").each(function(i) {
				var groupParamArray=[];
				$(this).children("td").children(":input").each(function() {
					groupParamArray.push({name:$(this).attr("name"),value:$(this).val()});
				});
				index = $(this).children("td").children("table").children("tbody.editor").children("tr").length - 1;
				$(this).children("td").children("table").children("tbody.editor").children("tr:lt(" + index + ")").each(function(j) {
					//详细评审阶段
					paramArray.push({name : "passReviewList[" + rows + "].reviewStage",value : "1"});
					for(var m=0,n=groupParamArray.length;m<n;m++){
						paramArray.push({name:"passReviewList["+rows+"]."+groupParamArray[m].name,value:groupParamArray[m].value});
					}
					$(this).children("td").children(":input").each(function() {
						paramArray.push({
							name : "passReviewList[" + rows + "]." + $(this).attr("name"),
							value : $(this).val()
						});
					});
					rows++;
				});
			});
		}*/
		/***********************************************************************
		 * 详细评审部分
		 */
		/*rows=0;
		$("#zbwjForm").find("#scoreGroup").children("tbody:first").children("tr").each(function(i) {
			paramArray.push({name : "scoreReviewList[" + rows + "].reviewStage",value : 1});
			$(this).children("td").children(":input").each(function() {
				paramArray.push({name:"scoreReviewList["+rows+"]."+ $(this).attr("name"),value:($(this).attr("name")=="flag"&&$(this).val()==""?rows:$(this).val())});
			});
			rows++;
		});
		if($("#reviewMode").val()=="SCORE"){
			var index = $("#zbwjForm").find("#scoreGroup").children("tbody.editor").children("tr").length - 1;
			$("#zbwjForm").find("#scoreGroup").children("tbody.editor").children("tr:lt(" + index + ")").each(function(i) {
				if(!$(this).is(":hidden")){
					var groupParamArray=[];
					$(this).children("td").children(":input").each(function() {
						groupParamArray.push({name:$(this).attr("name"),value:($(this).attr("name")=="flag"&&$(this).val()==""?rows:$(this).val())});
					});
					index = $(this).children("td").children("table").children("tbody.editor").children("tr").length - 1;
					$(this).children("td").children("table").children("tbody.editor").children("tr:lt(" + index + ")").each(function(j) {
						paramArray.push({name : "scoreReviewList[" + rows + "].reviewStage",value : 1});
						for(var m=0,n=groupParamArray.length;m<n;m++){
							paramArray.push({name:"scoreReviewList["+rows+"]."+groupParamArray[m].name,value:groupParamArray[m].value});
						}
						$(this).children("td").children(":input").each(function() {
							paramArray.push({name:"scoreReviewList["+rows+"]."+ $(this).attr("name"),value:$(this).val()});
						});
						rows++;
					});
				}
			});
		}*/
		return paramArray;
	}
	function validateRecruitFileData(){
		$("#fullScore").validatebox({
			validType : ["score","fullScore"]
		});
		var length=$(":input[name='groupFullScore']").parent().parent().parent().children().length;
		$(":input[name='groupFullScore']").each(function(index){
			$(this).validatebox({
				required:index+1<length,
				validType:["score","groupScore"]
			});
			var innerLength=$(this).parent().parent().children().children("table").children("tbody.editor").children().length;
			$(this).parent("td").parent("tr").children("td").children("table").children("tbody.editor").children("tr").children("td").children(":input[name='itemFullScore']").each(function(index){
				$(this).validatebox({
					required:index+1<innerLength,
					validType:["score"]
				});
			});
		});
		return $("#zbwjForm").form("validate");
	}
	function sendRecruitFileData(){
		var validate=validateRecruitFileData();
		if(!validate){
			return false;
		}
		
		/*if($("#bidDepositUnit").val()=='1'){
			if($("#bidDepositAmount").val()>800000){
				$.messager.alert("系统提示","投标保证金不能超过80万！");
				return false;
			}
		}else if($("#bidDepositUnit").val()=='2'){
			if($("#bidDepositAmount").val()>80){
				$.messager.alert("系统提示","投标保证金不能超过80万！");
				return false;
			}
		}
		
		if(isPrejudication=="false"){
			if($("#candidateNum").val()==""||$("#candidateNum").val()==null){
				$.messager.alert("系统提示","请选择定标方式！");
				return false;
			}
			if($("#candidateNum").val()>3){
				$.messager.alert("系统提示","推荐中标候选人数不能大于3家！");
				return false;
			}
		} */
		if(ZFZJ=="true"){
			var SUM = parseInt($("#UserNum").val())+parseInt($("#ExpertNum").val());
			if(SUM<5){
				$.messager.alert("系统提示","依法必须进行的招标项目，资格审查委员会成员人数为五人以上！");
				return false;
			}
			if(SUM>5 && SUM%2==0){
				$.messager.alert("系统提示","依法必须进行的招标项目，资格审查委员会成员人数为五人以上单数！");
				return false;
			}
		}
		$.messager.confirm("系统提示","确认提交吗？",function(r){
			if(r){
				saveRecruitFileData(true);
			}
		});
	}
	function saveRecruitFileData(isComplete) {
		var param = serializeData();
		var evaluationMethodId = $("#evaluationMethodId").val();
		if(evaluationMethodId != null && evaluationMethodId != ""){
			$("#recruitFileData_evaluationMethodId").val(evaluationMethodId);
		}else{
			$("#recruitFileData_evaluationMethodId").val("4028e300-624113f1-0162-4113f175-0000");
			$("#recruitFileData_benchmarkId").val("4028e300-624113f1-0162-4113f175-0000");
		}
		param.push({
			name : "isComplete",
			value : isComplete==undefined?false:isComplete
		});
		$.ajax({
			url : ctx + "/recruitFileData/saveOrUpdateRecruitFileData1",
			type : "post",
			dataType : "json",
			cache : false,
			beforeSend : function() {
				$("#save,#complete").prop("disabled", true);
				$.messager.progress({
					title : "系统提示",
					msg : "正在提交数据"
				});
			},
			data : param,
			success : function(data) {
				$.jGrowl(data.msg);
				if(data.success){
					history.go(-1);
				}			
			},
			complete : function() {
				/*if($("#bidDepositValue").val()!=null){
					$("#bidDepositAmount").val('');
					$("#bidDepositUnit").val('');
					$("#bidDepositCurrency").val('');
				}
				if($("#bidDepositAmount").val()!=null){
					$("#bidDepositValue").val('');
				}*/
				$("#save,#complete").prop("disabled", false);
				$.messager.progress("close");
			}
		});
	}
	$("<div/>").appendTo($("body")).each(function() {
		var $navigate = $(this);
		$("#zbwjForm .panel-title").each(function() {
			var $panel = $(this);
			var contains = $(this).html();
			$navigate.append($("<div/>").html(contains).click(function() {
				$(document).scrollTop($panel.offset().top);
			}));
		});
	}).css({
		border : "1px solid #ddd",
		width : 80,
		position : "fixed",
		left : 20,
		top : ($(window).height() - 200) / 2
	}).children("div").css({
		verticalAlign : "middle",
		cursor : "pointer",
		textAlign : "center",
		marginTop : 1,
		marginBottom : 1,
		marginLeft : 1,
		marginRight : 1,
		height : 30,
		border : "1px solid #ccc"
	});
	/*castMonery();
	$(document).on("keyup", "#bidDepositAmount", function() {
		castMonery();
	});
	$(document).on("change", "#bidDepositUnit", function() {
		castMonery();
	});
	$(document).on("change", "#bidDepositCurrency", function() {
		castMonery();
	});*/
	$(".mytableStyle").filter(function() {
		return true;
		//return $(this).attr("id") != "qualificationReview";
	}).autoTable();
	//统计总分
	$("#scoreGroup").bind("rowChange",function(){
		var sum=0;
		$(this).find("[name='groupFullScore']").each(function(){
			var value=$(this).val();
			if($.isNumeric(value)){
				sum+=parseFloat(value);
			}
		});
		$("#fullScore").val(sum);
	}).on("blur","[name='groupFullScore']",function(){
		$("#scoreGroup").trigger("rowChange");
	}).find("[name='groupFullScore']:first").blur();
	/*$("#preview").click(function() {
		window.open(ctx+"/document/editTemplate?templateId="+$("#templateId").val());
	});*/
	/***************************************************************************
	 * 加载评分办法描述
	 */
	/*$("#evaluationMethodId").change(function() {
		var evaluationMethodId = this.value;
		$.ajax({
			url : ctx + "/evaluationMethod/loadEvaluationMethodDescription",
			data : {
				evaluationMethodId : evaluationMethodId,
				recruitFileId : ($("#id").val() == "" ? undefined : $("#id").val())
			},
			dataType : "html",
			type : "post",
			success : function(data) {
				$($("[name='flag'][value='price']").parent().parent().children("td").get(3)).html(data);
				$.parser.parse($($("[name='flag'][value='price']").parent().parent().children("td").get(3)));
				//$("#scoreGroup,#qualificationReview2").toggleClass("none");
			}
		});
	}).change();*/
	
	/* $(':checkbox[type="checkbox"]').each(function(){
         $(this).click(function(){
        	 console.info($(this).prop('checked'));
             if($(this).prop('checked')){
                 $(':checkbox[type="checkbox"]').attr('checked', false);
                 $(this).prop('checked',true);
                 //alert(this.id);
             }
         });
     });*/
	
	$(":checkbox[name='projectItemId']").change(function() {
		$(':checkbox[type="checkbox"]').removeAttr('checked');
        $(this).prop('checked',true);
		var param = $(":checkbox[name='projectItemId']:checked").map(function() {
			return $(this).attr("name") + "=" + $(this).val();
		}).get().join("&");
		$.ajax({
			url : ctx + "/recruitFileData/loadTenderNoticeData",
			type : "post",
			data : param,
			dataType : "json",
			success : function(data) {
				if (data.success) {
					if(data.msg == "isYS"){
						//alert("isYS");
						//$("#bidQualification").attr("data-options","required:true");//增加一个必填属性
						
						$("#invitation_div").show();
						$('#bidQualification').validatebox({
						    required: true,
						});
						$('#inviteEndTime').validatebox({
							required: true,
						});
						for ( var key in data.data) {
							$(":input[name='" + "tenderNoticeData." + key + "']").val(data.data[key]);
						}
						$("#applyDateBegin").val('');
						$("#applyDateEnd").val('');
						$("#bidDeadline").val('');
						$("#bidOpenDate").val('');
					}else{
						//alert("notYS");
						$("#invitation_div").hide();
						$('#bidQualification').validatebox({
						    required: false,
						});
						$('#inviteEndTime').validatebox({
							required: false,
						});
						for ( var key in data.data) {
							$(":input[name='" + "tenderNoticeData." + key + "']").val(data.data[key]);
						}						
					}
				}
			}
		});
		loadAcquireTemplateList($("#projectInstanceId").val(),param);
	});
	/***************************************************************************
	 * 提交事件
	 */
	$("#complete").click(function() {
		sendRecruitFileData();
	});
	/***************************************************************************
	 * 保存事件
	 */
	$("#save").click(function() {
		saveRecruitFileData();
	});
	
	/*******
	 * 时间范围限制
	 */
	var fake_time = true;
	
	$("#clarifytime").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:'%y-%M-%d {%H}:%m:%s'
		});
	});
	$("#inviteEndTime").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:'%y-%M-%d {%H}:%m:%s'
		});
	});
	
	$("#applyDateBegin").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:'%y-%M-%d {%H}:%m:%s',
			maxDate:fake_time?undefined:$("#applyDateBegin").val()==""?undefined:'#F{$dp.$D(\'applyDateEnd\',{d:-4});}'
		});
	});
	$("#applyDateEnd").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:fake_time?undefined:$("#applyDateBegin").val()==""?undefined:'#F{$dp.$D(\'applyDateBegin\',{d:4});}'
		});
	});
	$("#bidDeadline").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:fake_time?undefined:$("#applyDateEnd").val()==""?undefined:'#F{$dp.$D(\'applyDateEnd\',{d:15});}'
		});
	});
	$("#bidOpenDate").focus(function(){
		WdatePicker({
			dateFmt:'yyyy-MM-dd HH:mm:ss',
			minDate:fake_time?undefined:$("#bidDeadline").val()==""?undefined:$("#bidDeadline").val()
		});
	});
	
	
	
	/*$(":radio[name='DBFS']").change(function(value) {
		var type = $("input[name='DBFS']:checked").val();
		if(type == '0'){
			$("#candidateNum").show();
			$("#candidateNum").validatebox({required: true,});
		}
		if(type == '1'){
			$("#candidateNum").hide();
			$("#candidateNum").val('1');
		}		
	});*/
	
	function loadAcquireTemplateList(projectInstanceId,projectItemId){
		$.ajax({
			url:ctx+"/notice/acquireTemplateList?t="+new Date().getTime()+"&"+projectItemId,
			type:"post",
			dataType:"json",
			data:{
				projectInstanceId : projectInstanceId
			},
			success:function(data){
				if(data=="NO"){
					$("#zbwj").html("<option  value='000' selected='selected'>===暂无===</option>");
				}else{
					var data2=eval(data);
					var data3;
					$(data2).each(function(i){
						data3+="<option value="+this.id+" selected='selected'>"+this.documentName+"</option>";
					});
					$("#zbwj").html(data3);
				}
			}
		});
	}
	console.log($("#projectItemId").val());
	if($("#projectItemId").val()!=null){
		loadAcquireTemplateList($("#projectInstanceId").val(),"projectItemId="+$("#projectItemId").val());
	}
	
});