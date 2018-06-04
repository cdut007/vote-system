<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@ page language="java"%> 
<%@ page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%>  

<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply"/>
<c:set value="${expertApply.projectInstance}" var="projectInstance"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" ca="true" jgrowl="true" plupload="true"/>
<script type="text/javascript">
function reloadBidOpenList(projectItemId){
	if(projectItemId==undefined||projectItemId==null){
		$(".bidOpen-datagrid").each(function(){
			$(this).datagrid("reload");
		});
	}else{
		$("#"+projectItemId).datagrid("reload");
	}
};
function reloadSignList(){
	$("#sign-datagrid").datagrid("reload");
};
$(function () {
	dwr.engine.setActiveReverseAjax(true); // 激活反转 重要
	window.setTimeout(function(){
		new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',
			browse_button : "remedy",
			//container : document.getElementById('container'),
			url : ctx+'/uploadBidFile2',
			flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
			silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
			multi_selection : false,
			multipart_params :{fjgslx:"10",unique:true,expertApplyId:"${processBusinessKey}"},
			//file_data_name:"Filedata",
			//drop_element : 'drop_area',
			filters : {
				mime_types : [{ title : "投标文件", extensions : "bid" }],
				prevent_duplicates : true,//不允许选取重复文件
				max_file_size : '5000mb'//最大只能上传400kb的文件
			},
			init : {
				PostInit : function() {
				},
				FilesAdded : function(up, files) {
					$.messager.confirm("系统提示","每个投标只能补救一次，确认选择的投标文件正确吗？",function(ok){
						if(ok){
							up.start();
						}
					});
					/* $("#"+datagridType).datagrid("appendRow",{
						fjid00:files[0].id,
						fjmc00:files[0].name,
						status:"<div class='" + files[0].id + "' style='width:100%;'></div>",
						uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
						length:files[0].size,
						fjgslx:""
					}); */
					/* $("<div id=\"dialog-"+files.id+"\">").css("padding",5).appendTo($("body")).window({
						title:"上传进度",
						width:250,
						height:80,
						content:"<div class='" + files[0].id + "' style='width:100%;'></div>"
					}); */
					/* $("div." + files[0].id).progressbar({
					}); */
				},
				UploadProgress : function(up, file) {
					//$("div." + file.id).progressbar("setValue", file.percent);
				},
				FileUploaded : function(up, file, result){
					var data=$.parseJSON(result.response);
					$.messager.alert("系统提示",data.msg);
					up.removeFile(file);
					$("#bidFile-datagird").datagrid("reload");
				},
				UploadComplete : function(uploader, files) {
					
				},
				Error : function(up, err) {
					$.jGrowl(err);
				},
				FilesRemoved:function(up,files){
					
				}
			}
		}).init();
	},1000);
	
	$("#sign-datagrid").datagrid({
		title:"参会人员签到列表",
		fit:true,
		url:ctx+"/sign/pagingParticipantsData",
		/* pagination:true, */
		rownumbers:true,
		striped:true,
		method:"post",
		//height:300,
		queryParams:{expertApplyId:"${processBusinessKey}",userType:"3"},
		toolbar:[
			{id:"sign",text:"签到" ,iconCls:"myicon-qiandao" ,size:"large"}/* ,
			{id:"decrypt",text:"全部解密",iconCls:"myicon-lock_open"} */
		],
		onLoadSuccess:function(){
			/* var datagrid=$(this);
			window.setTimeout(function(){
				datagrid.datagrid("reload");
			},3000); */
		},

		columns:[[
		    {field:'id',checkbox:true},
		    {title:"项目名称",field:'projectInstanceName',hidden:true},
		    {title:"授权人姓名",field:'userName',align:"center",width:'10%',formatter:function(value,row,index){
		    	if(row.userType=="专家"){
		    		return "***";
		    	}else{
		    		return value;
		    	}
		    }},
		    {title:"身份证号",field:'userNumber',align:"center",width:'20%',formatter : function(value,row,index){ 
		    	if(null != value){
		    		return value.substring(0,6)+"******"+value.substring(13,18) ;
		    	}else{
		    		return value;
		    	}
		    }},
		    {title:"单位名称",field:'unitName',align:"center",width:'20%'},
		    {title:"联系方式",field:'phoneNumber',align:"center",width:'15%',formatter:function(value,row,index){
		    	if(row.userType=="专家"){
		    		return " ";
		    	}else{
		    		return value;
		    	}
		    }},
		    {title:"签到时间",field:'signtime',align:"center"}
		]]
	});
	$("#sign").click(function () { 
		$("#form1").ajaxSubmit({  
		    type: 'post',  
		    url: ctx+'/workflow/completeForm',  
		    success: function(data){  
		        alert('签到成功');
		        $("#sign").linkbutton("disable");
		        $("#sign-datagrid").datagrid("reload");
		    },  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        $('#sign-datagrid').datagrid('reload');
		    }  
		});
	});
	//倒计时
	var openDate=${expertApply.bidOpenDate.time};
	var currentDate=${now.time};
	var lastTime=(openDate-currentDate); 
	if(lastTime>0){
		var i = setInterval(function() {
    		lastTime=lastTime-1000;
    		var min=Math.floor(lastTime/1000/60);
    		var second=Math.floor(lastTime/1000%60);
    		$("#lastTime").html(min+"分"+second+"秒");
            if (lastTime <=0){
            	clearInterval(i);
            }
   		}, 1000);
	}else{
		$("#lastTime").html("已经开标");
	}
    
});

$(function() {
	if ($(":input[name='message']").val() != '') {
		$.jGrowl($(":input[name='message']").val());
	}
	$('#sub').click(function() {
		var $rows=$($("#bidFile-datagird").datagrid("getRows")).filter(function(){
			return this["isDecrypt"]=="未解密";
		});
		if($rows.length==0){
			if (confirm('确定提交吗？')) {
				//$('#form1').attr('action', '${pageContext.request.contextPath}/flow/completeTask');
				//$('#form1').attr('method', 'post');
				$('#form1').submit();
			}
		}else{
			var id = new Date().getTime();
			$("body").append("<div style='padding:10px' id='" + id + "'></div>");
			$("#"+id).dialog({
				open : true,
				title : '未解密原因',
				closed:false,
				modal:true,
				width:600,
				height:400,
				content:"<form action=\""+ctx+"/workflow/completeForm\" method=\"post\"><textarea name=\"noDecryptReason\" style=\"width:560px;height:280px\" class=\"easyui-validatebox\" data-options=\"required:true\"></textarea></form>",
				buttons:[
					{text:"提交",handler:function(){
						if($("#"+id+" form").form("validate")){
							$.messager.confirm("系统提示", "确认提交吗？", function(r) {
								if (r) {
									$("#"+id+" form").ajaxSubmit({
										type:"post",
										//dataType:"json",
										data:{
											taskId:$(":input[name='taskId']").val()
										},
										success:function(data){
											window.location.href=ctx+"/home";
										}
									});
								}
							});
						}
					}},
					{text:"取消",handler:function(){
						$("#"+id).dialog('destroy');
					}}
				]
			});
		}
	});
	$("#bidFile-datagird").datagrid({
		title:"投标文件",
		rownumbers : true,
		striped : true,
		url:ctx+"/bidFile/listBidFile",
		queryParams : {
			expertApplyId : "${processBusinessKey}"
		},
		idField:"id",
		toolbar:[
			{text:"全部解密",iconCls:"myicon-lock_open",handler:function(){
				var rows = $("#bidFile-datagird").datagrid("getRows");//获取当前的数据行
				$(rows).filter(function(){
					return this["isDecrypt"]=="未解密";
				}).each(function(){
					decrypt1(this["tenderItemId"],this["projectItemId"],this["bdmc00"]);
				});
			}}
		],
		columns:[[
			{field:"bdbh00",title:"标段编号",width:200,hidden:true},
			{field:"bdmc00",title:"标段名称",width:200},
			{field:"fjmc00",title:"附件名称",width:200},
			{field:"length",title:"附件大小",width:120,formatter:function(value,rowData,rowIndex){
				return castSize(value);
			}},
			{field:"uploadTime",title:"上传时间",width:200},
			{field:"isDecrypt",title:"是否解密",width:100},
			{field:"tenderItemId",title:"操作",width:100,formatter:function(value,rowData,rowIndex){
				return rowData["isDecrypt"]=="未解密"?"<input type=\"button\" onclick=\"decrypt1('"+value+"','"+rowData["projectItemId"]+"','"+rowData["bdmc00"]+"');\" class=\"easyui-linkbutton button red small\" value=\"解密\"/>":"";
			}}
		]]
	});
	$(".bidOpen-datagrid").each(function(){
		var projectItemId=$(this).attr("id");
		var projectItemName=$(this).attr("name");
		$(this).datagrid({
			//title : "开标一览表",
			url : ctx + "/bidFile/list",
			//pagination : true,
			rownumbers : true,
			striped : true,
			fit : true,
			//height:350,
			border:false,
			method : "post",
			rowStyler:function(index,row){
				if("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]){
					return "background:#127ad1;color:#fff;font-weight:900";
				}
			},
			onLoadSuccess:function(){
				/* var datagrid=$(this);
				window.setTimeout(function(){
					datagrid.datagrid("reload");
				},3000); */
			},
			queryParams : {
				projectInstanceId : "${expertApply.projectInstanceId}",
				expertApplyId : "${processBusinessKey}",
				projectItemId:projectItemId
			},
			columns : [ [ 
				{field : 'organProjectItemCode',title : "标段编号",width : 100,hidden:true},
				{field : 'projectItemName',title : "标段名称",hidden :true,width:150}, 
				{field : 'organBName',title : "投标单位",align : "center",width : 200,formatter : hidedate}, 
				{field : 'tbrdm0',title : "投标机构组织代码",align : "center",formatter : hidedate,hidden : true}, 
				{field : 'tbbjje',title : "投标报价",align : "center",width : 100,formatter:function(value, row, index){
					
					if(row.tbbjdw == "2"){
						return value + "(万元)";
					}
					
					return value + "(元)";
					
				}}, 
				{field : 'bidPartPrice',title : "分部分项工程费合价(元)",align : "center",width : 100}, 
				{field : 'bidMeasurePrice',title : "措施项目费合价(元)",align : "center",width : 100}, 
				{field : 'gq0000',title : "工期（交货期、服务周期）",width : 120,formatter : hidedate}, 
				{field : 'bidDepositAmount',title : "投标保证金额(元)",width : 120,formatter : hidedate,hidden : true}, 
				{field : 'isContributeDeposit',title : "是否缴纳投标保证金",align : "center",width : 100,formatter : function(value, row, index) {
					if (true||row["isConfirm"] == "已确认") {
						if ("0" == value) {
							return "待确认";
						} else if ("3" == value) {
							return "未上传";
						} else if ("1" == value) {
							return "已缴费";
						} else if ("2" == value) {
							return "未缴费";
						} else if ("4" == value) {
							return "无需缴纳";
						} else {
							return "未确认";
						}
					} /* else {
						if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
							return "";
						}
						return "******";
					} */
				}}, 
				
				{field : 'isConfirm',title : "投标结果是否确认",align : "left",width : 100}, 
				{field : "id",title : "操作",align : "left",width:100,formatter : function(value, row, index) {
/* 					if(row.tbbjje == null){
						return "";
					} else {
						return "${CURRENT_USER_SESSION_INFO.organId}" == row["organId"] ? "<input type='button' class='button red small' onclick=\"detail('" + value + "','"+projectItemId+"','"+projectItemName+"')\" value='确认'/>" : "";
					} */
					if (row["isConfirm"] == "已确认"||row.tbbjje == null) {
						return "";
					} else {
						return "${CURRENT_USER_SESSION_INFO.organId}" == row["organId"] ? "<input type='button' class='button red small' onclick=\"detail('" + value + "','"+projectItemId+"','"+projectItemName+"')\" value='确认'/>" : "";
					}
				}} 
			] ]
		});
	});
	//确认页面是否显示数据，原则自己可以看到自己的开标预览表和别人已经确认的开标预览表
	function hidedate(value, row, index) {
		//if (row["isConfirm"] == "已确认") {
			return value;
		/* //} else {
			if ("${CURRENT_USER_SESSION_INFO.organId}" == row["organId"]) {
				return value;
			}
			return "******";
		//} */
	};
});
function getData(origData) {
	//origData="MIIBpAYJKoZIhvcNAQcDoIIBlTCCAZECAQAxggFFMIIBQQIBADCBqTCBnDELMAkGA1UEBhMCQ04xDzANBgNVBAgMBlNoYW5YaTEQMA4GA1UEBwwHVGFpWXVhbjEtMCsGA1UECgwkU2hhblhpIERpZ2l0YWwgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MQwwCgYDVQQLDANSU0ExLTArBgNVBAMMJFNoYW5YaSBEaWdpdGFsIENlcnRpZmljYXRlIEF1dGhvcml0eQIIGd9uxrzjm1swDQYJKoZIhvcNAQEBBQAEgYCzErVBFkdqWlywu1zQUesJ1RxuDAhxC21UUMgcOimvwWv5rCClZNCzIxPoY3fiRZWBUlNU5E2RTuaL/MD/bBsbQ/Tv6bSUWzlG4ZQv4RcIbm+vi/LUXEH7bDdDDeSQx6wxHHrOsx4Es8eJpZXenY0fdGiqjRdSLGEJzb1sg0rFljBDBgkqhkiG9w0BBwEwFAYIKoZIhvcNAwcECIiTtkX7ftXkgCAgjAJn46z5dr+ZWPCnyL/ETs3uoUiFtg5Vnlz1YBzG/w=="; 
	var temp_DSign_Release_Result = JITDSignOcx.DecryptEnvelop(origData);
	if (JITDSignOcx.GetErrorCode() != 0) {
		alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		return;
	}
	var orig = JITDSignOcx.getData();
	/* $("<input/>").appendTo($("body")).val(orig); */
	return orig;
};

function detail(id,projectItemId,projectItemName) {
	$.messager.confirm('确认', '请核对您的投标信息，是否正确？', function(ok) {
		if (ok) {
			$.ajax({
				url : "${pageContext.request.contextPath}/bidFile/confirm",
				type : "post",
				data : {
					"id" : id,
					expertApplyId:"${processBusinessKey}",
					projectItemId:projectItemId
				},
				dataType : "json",
				beforeSend : function() {
				},
				complete : function() {

				},
				success : function(data) {
					$.messager.alert("系统提示", data.msg);
					$('#'+projectItemId).datagrid('reload');
					$("#bidFile-datagird").datagrid("reload");
				}
			});
		}
	});
};
function decrypt1(id,projectItemId,projectItemName) {
	$.ajax({
		url:ctx+"/getDigitalEnvelope",
		type:"post",
		data:{"tenderItemId":id},
		success:function(data){
			if(data==""){
				$.messager.alert("系统提示","获取数字信封失败！");
				return;
			}
			var orig=getData(data);
			$.ajax({
				url : ctx+"/bidFile/decrypt",
				type : "post",
				data : {
					"orig" : orig,
					"id" : id,
					"expertApplyId":"${processBusinessKey}"
				},
				dataType : "json",
				beforeSend : function() {
					$.messager.progress({
						title : "请您耐心等待...",
						msg : "正在解密投标文件并验证电子签名中...",
						text : "请稍后..."
					});
				},
				complete : function() {
					$.messager.progress("close");
				},
				success : function(data) {
					$.messager.alert("系统提示", data.msg);
					$("#"+projectItemId).datagrid("reload");
					$("#projectItem-tabs").tabs("select",projectItemName);
					$("#bidFile-datagird").datagrid("reload");
				}
			});
		}
	});
}
</script>
<style type="text/css">
.centerss {
 height: 150px;
 width: 1000px;
 margin: auto;
 text-align: center;
 line-height:40px;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			开标现场
		</div>
		<div class="centerss">
			<h2>开标项目名称:${projectInstance.zbxmmc}</h2>
			<h2>开标时间:${expertApply.bidOpenDate}</h2>
			<h2>评标时间:${expertApply.evaluateTime}</h2>
		  	<h2>开标倒计时:<span id="lastTime" ></span></h2>
		  	<h2>文件解密提交倒计时:<span id="lastDecodeEndTime" ></span></h2>
		</div>
	</div>
	<div class="block">
		<div id="kbylb1"  class="easyui-panel" data-options="title:'开标一览表',height:350">
			<div id="projectItem-tabs" class="easyui-tabs" data-options="fit:true,border:false">
				<c:forEach items="${expertApply.projectItemList}" var="projectItem">
					<div data-options="title:'${projectItem}'">
						<table class="bidOpen-datagrid" id="${projectItem.id}" name="${projectItem}" ></table>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="blank10"></div>
		<div style="float:left;width:100%;margin-right:5px;text-align:center;height:300px;">
			<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form1">
				<input type="hidden" name="taskId" value="${taskId}"/>
				<input type="hidden" name="projectInstanceId" value="${expertApply.projectInstanceId}"/>
				<input type="hidden" name="projectInstanceName" value="${projectInstance}"/>
				<input type="hidden" name="expertApplyId" value="${processBusinessKey}"/>
				<input type="hidden" name="userType" value="3"/>
			</form>
			<!-- <a class="button red medium" id="sign">签到</a><a id="decrypt" class="button red medium">完全解密</a> <a id="sub" class="button red medium">提交</a> -->
			<table id="sign-datagrid"></table>
		</div>
	</div>
	<div class="blank10"></div>
	
	<script>
	var lastDecodeTime = 0;
	
	var j = undefined;
	j=setInterval(function() {
		lastDecodeTime=lastDecodeTime-1000;
		var min=Math.floor(lastDecodeTime/1000/60);
		var second=Math.floor(lastDecodeTime/1000%60);
		if (lastDecodeTime>0){		 
			 $("#lastDecodeEndTime").html(min+"分"+second+"秒");
		}
	}, 1000);
	
	setTimeout(function() {
		loadDecodeTime();
	}, 1000);
		
	function loadDecodeTime(){
		$.ajax({
			url:ctx+"/sign/loadEndDecodeTime",
			type:"post",
			data:{"expertApplyId":"${expertApply.id}"},
			success:function(data){
				eval(" var response=" + data);
				if(response.data >0){

					setTimeout(function() {
						loadDecodeTime();
					}, 10000);
				}else{
					setTimeout(function() {
						loadDecodeTime();
					}, 2000);
				}
				lastDecodeTime = response.data;
			}
		
		});
	}
	$(function(){
		if("${projectInstanceType}"!="A01"&&"${projectInstanceType}"!="A02"){
			$(".bidOpen-datagrid").datagrid('hideColumn','bidPartPrice');
			$(".bidOpen-datagrid").datagrid('hideColumn','bidMeasurePrice');
		}
	});
	</script>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
