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
<script type="text/javascript" src="/dwr/engine.js"></script>
<script type="text/javascript" src="/dwr/util.js"></script>
<script type='text/javascript' src='/resources/jquery-plugins/jquery.im.js'></script>
	
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
	$("#sign-datagrid").datagrid({
		title:"人员签到列表",
		fit:true,
		url:ctx+"/sign/pagingParticipantsData",
		rownumbers:true,
		striped:true,
		method:"post",
		//height:300,
		queryParams:{expertApplyId:"${processBusinessKey}",userType:"3"},
		toolbar:[
			{id:"guardianSign",text:"签 到" ,iconCls:"myicon-qiandao" ,size:"large"}/* ,
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
		    {title:"身份证号",field:'userNumber',width:'20%',align:"center",formatter : function(value,row,index){ 
		    	if(null != value){
		    		return value.substring(0,6)+"******"+value.substring(13,18) ;
		    	}else{
		    		return value;
		    	}
		    }},
		    {title:"单位名称",field:'unitName',align:"center",width:'20%'},
		    {title:"联系方式",field:'phoneNumber',width:'15%',align:"center",formatter:function(value,row,index){
		    	if(row.userType=="专家"){
		    		return " ";
		    	}else{
		    		return value;
		    	}
		    }},
		    {title:"签到时间",align:"center",field:'signtime'}
		]]
	});

    $("#sign2").click(function () {
        $("#form1").ajaxSubmit({
            type: 'post',
            url: ctx+'/workflow/completeForm',
            success: function(data){
                /* alert('签到成功'); */
                $.messager.alert('系统提示','签到成功！');
                $("#sign").linkbutton("disable");
                $("#sign-datagrid").datagrid("reload");
            },
            error: function(XmlHttpRequest, textStatus, errorThrown){
                $('#sign-datagrid').datagrid('reload');
            }
        });
    });

    $("#guardianSign").click(function (){


        var expertApplyId = $("#processBusinessKey").val();
        $.ajax({
            url: ctx + "/sign/guardianSign?_="+ Math.random(),
            type: "post",
            data: {expertApplyId:expertApplyId},
            dataType: "json",
            beforeSend: function () {
                $.messager.progress({
                    title: "系统提示",
                    msg: "正在保存专家抽取申请表"
                });
            },
            success: function (data) {
                $.messager.progress("close");
                if (data.success) {
                    $.messager.alert("系统提示", data.msg);
                    $("#form1").ajaxSubmit({
                        type: 'post',
                        url: ctx+'/workflow/completeForm',
                        success: function(data){
                            /* alert('签到成功'); */
                            $.messager.alert('系统提示','签到成功！');
                            $("#sign").linkbutton("disable");
                            $("#sign-datagrid").datagrid("reload");
                            window.location.href=ctx+"/home";
                        },
                        error: function(XmlHttpRequest, textStatus, errorThrown){
                            $('#sign-datagrid').datagrid('reload');
                        }
                    });
                } else {
                    $.messager.alert("系统提示", data.msg);
                }
            },
            complete: function () {

            }
        });

    });

	$("#sign2").click(function () {
		$("#form1").ajaxSubmit({  
		    type: 'post',  
		    url: ctx+'/workflow/completeForm',  
		    success: function(data){  
		        /* alert('签到成功'); */
		        $.messager.alert('系统提示','签到成功！');
		        $("#sign").linkbutton("disable");
		        $("#sign-datagrid").datagrid("reload");
		    },  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        $('#sign-datagrid').datagrid('reload');
		    }  
		});
	});
	//开标倒计时
	var openDate=${expertApply.bidOpenDate.time};
	var currentDate=${now.time};
	var lastTime=(openDate-currentDate); 
	if(lastTime>0){
		var i = undefined;
		i=setInterval(function() {
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
		onOpen:function(){
			window.setTimeout(function(){
				new plupload.Uploader({
					runtimes : 'html5,silverlight,html4',
					browse_button : "remedy",
					//container : document.getElementById('container'),
					url : ctx+'/uploadBidFile2',
					flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
					silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
					multi_selection : false,
					multipart_params :{
						fjgslx:"10",
						unique:true,
						expertApplyId:"${processBusinessKey}"
					},
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
			},3000);
			
		},
		toolbar:[
			{text:"全部解密",iconCls:"myicon-lock_open",handler:function(){
				var rows = $("#bidFile-datagird").datagrid("getRows");//获取当前的数据行
				$(rows).filter(function(){
					return this["isDecrypt"]=="未解密"||this["isDecrypt"]=="正在解密";
				}).each(function(){
					decrypt1(this["tenderItemId"],this["projectItemId"],this["bdmc00"], this["fjid00"], this["envelopeTypeOrder"]);					
				});
			}},{
				id:"remedy",
				iconCls:'myicon-attach',
				text:"解密失败补救"
			}
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
			{field:"envelopeTypeOrder",title:"投标文件顺序",width:100,formatter:function(value, row, index){
				
				if(row.envelopeTypeOrder=="second"){
					return "第二信封";
				}
				
				return "第一信封";

			}},
			{field:"tenderItemId",title:"操作",width:100,formatter:function(value,rowData,rowIndex){
				return rowData["isDecrypt"]=="未解密"||rowData["isDecrypt"]=="解密失败"?"<input type=\"button\" onclick=\"decrypt1('"+value+"','"+rowData["projectItemId"]+"','"+rowData["bdmc00"]+"','"+rowData["fjid00"]+"','"+rowData["envelopeTypeOrder"]+"');\" class=\"easyui-linkbutton button red small\" value=\"解密\"/>":"";
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
			sortName: "envelopeTypeOrder",
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
			toolbar:[
				{
					text : "刷新",
					iconCls : 'myicon-arrow_refresh',
					handler : function() {
						$("#"+projectItemId).datagrid("reload");
					}
				}
			],
			queryParams : {
				projectInstanceId : "${expertApply.projectInstanceId}",
				expertApplyId : "${processBusinessKey}",
				projectItemId:projectItemId
			},
			columns : [ [ 
				{field : 'organProjectItemCode',title : "标段编号",width : 100,hidden:true},
				{field : 'projectItemName',title : "标段名称",hidden :true,width:150}, 
				{field : 'organBName',title : "投标单位",align : "center",width : 150,formatter : hidedate}, 
				{field : 'tbrdm0',title : "投标机构组织代码",align : "center",formatter : hidedate,hidden : true}, 
				{field : 'tbbjje',title : "投标报价",align : "center",width : 80,formatter : function(value, row, index){
					
					if(value && value!=null){
						if(row.tbbjdw == "2"){
							return value + "(万元)";
						}
						
						return value + "(元)";
					}else{
						return "";
					}
					
				}}, 
				{field : 'bidPartPrice',title : "分部分项工程费合价(元)",align : "center",width : 150}, 
				{field : 'bidMeasurePrice',title : "措施项目费合价(元)",align : "center",width : 120}, 
				{field : 'gq0000',title : "工期/交货期/服务周期(天)",align : "center",width : 150,formatter:function(value, row, index){
					
					if(row.envelopeTypeOrder=="second"){
						return "";
					}
					
					return value;

				}}, 
				{field : 'bidDepositAmount',title : "投标保证金额(元)",width : 120,formatter : hidedate,hidden : true}, 
				{field : 'isContributeDeposit',title : "是否缴纳投标保证金",align : "center",width : 120,formatter : function(value, row, index) {
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
				/*{field : 'tbsj00',title : "文件递交时间",align : "center",width : 120,formatter : hidedate},*/ 
				{field : 'isConfirm',title : "投标结果是否确认",align : "left",width : 120}, 
				{field : 'envelopeTypeOrder',title : "信封顺序",align : "center",width : 100,formatter:function(value, row, index){
					
					if(row.envelopeTypeOrder=="second"){
						return "第二信封";
					}
					
					return "第一信封";

				}},
				{field : "id",title : "操作",align : "left",width:100,formatter : function(value, row, index) {
/* 					if(row.tbbjje == null){
						return "";
					} else {
						return "${CURRENT_USER_SESSION_INFO.organId}" == row["organId"] ? "<input type='button' class='button red small' onclick=\"detail('" + value + "','"+projectItemId+"','"+projectItemName+"')\" value='确认'/>" : "";
					} */
					if (row["isConfirm"] == "已确认"|| (row.tbbjje == null && row.gq0000==null) || (row.tbbjje == null && row.envelopeTypeOrder=="second")) {
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
	var InitParam="<?xml version=\"1.0\" encoding=\"utf-8\"?><authinfo><liblist><lib type=\"CSP\" version=\"1.0\" dllname=\"\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"Sml0M2tHTVAxMVYyMTEuZGxs\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"SERfR01DQUlTLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U2h1dHRsZUNzcDExXzMwMDBHTS5kbGw=\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U0tGQVBJLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U3hjYUNzcDExXzMwMDBHTS5kbGw=\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib></liblist></authinfo>";
	var ret = JITDSignOcx.Initialize(InitParam);
	if (ret != 0){
		 alert("初始化失败，错误码："+JITComVCTKEx.GetErrorCode()+" 错误信息："+JITComVCTKEx.GetErrorMessage(JITComVCTKEx.GetErrorCode()));
		JITDSignOcx.Finalize();
		//return;
	}
	
	JITDSignOcx.SetCertChooseType(1);
	if(JITDSignOcx.GetErrorCode()!=0){	
		alert("错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		JITDSignOcx.Finalize();
	 }
	//JITDSignOcx.SetCert();
	//JITDSignOcx.SetCert("SC", CERT_DN.value, "", "", CERTISSUSER_DN.value, "");
/*  	 if(JITDSignOcx.GetErrorCode()!=0){
	 	alert("设置证书过滤失败，错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
 		JITDSignOcx.Finalize();
 	 } */
 
 	//var origData = "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";
 	//JITDSignOcx.DecryptEnvelop(origData);
 	
	JITDSignOcx.VerifySignedEnvelop(origData);
 	 if (JITDSignOcx.GetErrorCode() != 0) {
		alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
		//return;
	}

	var orig = JITDSignOcx.getData();
	JITDSignOcx.Finalize();
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
function decrypt1(tenderItemId,projectItemId,projectItemName, fjid00, enTypeOrder) {
	
	$.ajax({
		url:ctx+"/getDigitalEnvelope",
		type:"post",
		dataType : "json",
		data:{
			"tenderItemId":tenderItemId,
			"fjid00": fjid00,
			"projectItemId" : projectItemId,
			"expertApplyId":$(":input[name='expertApplyId']").val()
		},
		success:function(data){
			if(data.success){
				
				 var orig=getData(data.data); 
				
				if(orig==undefined||orig==""){
					$.messager.alert("系统提示","获取解密秘钥失败！");
					return;
				}
				$.ajax({
					url : ctx+"/bidFile/decrypt",
					type : "post",
					data : {
						"orig" : orig,
						"fjid00" : fjid00,
						"tenderItemId" : tenderItemId,
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
			}else{					
				$.messager.alert("系统提示", data.msg);
				
			}
		}
	});
}
</script>
<script type="text/javascript">
	$(function(){
		var windowHeight=$(window).height();
		var imageHeight=200;
		var center=(windowHeight-imageHeight)/2;
		$("body").append("" +
		"<div class='helpbar' style='position:fixed;top:"+center+"px;left:20px;width:200px;height:200px;'>" +
			"<div style='position:relative;width:100%;'>"+
				"<img src='/resources/img/bidder/bidOpeningProcess.png' style='width:100%;'/>"+
				"<div style='position:absolute;top:330px;color:#000;margin-left:45px;font-weight: bold;'>"+"${expertApply.evaluateTime}"+"</div>"+
			"</div>"+
		"</div>");
	});
</script>
<style type="text/css">
.centerss {
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
		<div class="blank10"></div>
		<div style="float:left;width:100%;margin-right:5px;text-align:center;">
			<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form1">
				<input type="hidden" name="taskId" value="${taskId}"/>
				<input type="hidden" name="projectInstanceId" value="${expertApply.projectInstanceId}"/>
				<input type="hidden" name="projectInstanceName" value="${projectInstance}"/>
				<input type="hidden" name="expertApplyId" value="${processBusinessKey}"/>
				<input type="hidden" name="userType" value="3"/>
				<input type="hidden" name="processBusinessKey" id="processBusinessKey" value="${processBusinessKey}"/>
			</form>
			<table id="sign-datagrid"></table>
		</div>
		<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form2">
			<input type="hidden" name="taskId" value="${taskId}" />
			<input type="hidden" name="message" value="${message}" />
		</form>
		<div class="blank10"></div>
		<div class="usBox">
			<p>说明：</p>
			<br />
			<p style="text-indent: 2em;">1、请核对您的投标信息，是否正确。</p>
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
$(function(){
	setInterval(function(){
		$("#bidFile-datagird").datagrid("reload");
	},15000);
});

	</script>
	<jsp:include page="/common/bottom.jsp"/>

</body>
</html>
