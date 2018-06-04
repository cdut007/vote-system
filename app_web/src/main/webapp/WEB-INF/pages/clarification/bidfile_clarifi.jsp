<%@page import="com.mhb.common.Constants,java.io.File,com.mhb.tender.entity.*"%>
<%@page import="com.mhb.common.util.ServletUtil"%>
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" ca="true" jgrowl="true" plupload="true"/>
<script type='text/javascript' src='/resources/jquery-plugins/jquery.im.js'></script>
<script src="/resources/designer/json2.js" type="text/javascript"></script>
<c:set value="${bidFileService.loadBidFile(bidFileId)}" var="bidFile" />

	
<script type="text/javascript">



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
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
			<div class="blank10"></div>
			<input type="hidden" id="attachmentSsztId" value="${bidFile.id}"></input>
			<table class="mytableStyle">
				<tr>
		
					<td>招标项目名称：</td>
					<td>${bidFile.projectInstanceName}</td>
					<td>标段名称：</td>
					<td>${bidFile.projectItemName}</td>
				</tr>
				<tr>
					<td>投标单位：</td>
					<td>${bidFile.organBName}</td>
					<td>投标报价：</td>
					<td>
						${bidFile.tbbjje}${bidFile.tbbjdw=='1'?'元':'万元'}
					</td>
		
				</tr>
				<tr>
				
					<td colspan='4'>
						<a id="addAttachment" class="button red">添加报价澄清附件</a><i>可以上传.pdf .doc .docx</i>
					</td>
				</tr>
				<tr>
					<td colspan='4'>
						<table id="attachmentUpload"></table>
					</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="blank10"></div>
			<div class="block">
				<button class="button red" onclick="submitClarify();">提交澄清</button>
			</div>
			
	
			<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form2">
					<input type="hidden" name="taskId" value="${taskId}" /> 
					<input type="hidden" name="message" value="${message}" />
			</form>
	</div>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
	

<script>

function submitClarify(){
	$("#form2").submit();
}

$(function() {
	var percent="<div class=\"progressbar easyui-fluid\" style=\"width: 127px; height: 20px;\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div><div class=\"progressbar-value\" style=\"width: 100%; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div></div></div>";
	function isNewFile(id){
		var isNewFile=$("div."+id).length==1;
		return isNewFile;
	}
	function isFullPercent(id){
		var isFullPercent=isNewFile(id)&&$("div."+id).progressbar("getValue")==100;
		return isFullPercent;
	}
	function isUploaded(id){
		var isUploaded=isFullPercent(id)&&$(":input."+id).length==1;
		return isUploaded;
	}
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'addAttachment',
		//container : document.getElementById('container'),
		url : ctx + '/attachment/uploadAttachment',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : true,
		multipart_params : {
			fjsszt : $("#attachmentSsztId").val(),
			fjgslx:"500"
		},
		filters : {
			mime_types : [ //只允许上传图片和zip文件
				{ title : "Pdf files", extensions : "pdf" },
				{ title : "Word files", extensions : "doc,docx" }
			],
			prevent_duplicates : true,//不允许选取重复文件
			max_file_size : '5000mb'//最大只能上传400kb的文件
		},
		init : {
			PostInit : function() {
			},
			FilesAdded : function(up, files) {

				if($("#id").val()==""){
					$("#attachmentUpload").datagrid("options").queryParams["fjsszt"]=$("#attachmentSsztId").val();
				}
				for(var i=0;i<files.length;i++){
					var file=files[i];
					$("#attachmentUpload").datagrid("appendRow",{
						 id:file.id,
						 fjid00:file.id,
						 fjmc00:file.name,
						 status:"<div class='" + file.id + "' style='width:100%;'></div>",
						 uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
						 length:file.size,
						 fjgslx:"500"
					});
					$("div." + file.id).progressbar({});
				}
				up.start();
			},
			UploadProgress : function(up, file) {
				$("div." + file.id).progressbar("setValue", file.percent);
			},
			FileUploaded : function(up, file, result) {
				var data=$.parseJSON(result.response);
				data.data.id=file.id;
				data.data.status=percent;
				
				$($("#attachmentUpload").datagrid("getRows")).each(function(index){
					if(this.id==data.data.id){
						$("#attachmentUpload").datagrid("updateRow",{index:index,row:data.data});
					}
				});
				up.removeFile(file);
				//$("div."+file.id).find(".progressbar-text").html("完成");
				//$("div."+file.id).find(".progressbar-value,.progressbar-text").css({backgroundColor:'#0095cd'});
			},
			UploadComplete : function(uploader, files) {
			},
			Error : function(up, err) {
			},
			FilesRemoved:function(up,files){
				
			}
		}
	});
	uploader.init();
	
	/**
	 * 保存
	 */
	$("#attachmentUpload").datagrid({
		title:"附件列表",
		rownumbers:true,
		striped:true,
		collapsible:true,
		url:ctx+"/attachment/listAttachment",
		idField:"fjid00",
		queryParams:{"fjsszt":$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val()},
		height:200,
		columns:[[
		  {title:"附件名称",field:"fjmc00",width:300},
		  {title:"上传时间",field:"uploadTime",width:120},
		  {title:"附件大小",field:"length",width:80,align:"right",formatter:function(value){
			  return castSize(value);
		  }},
		  {title:"进度",field:"status",width:150,align:"center",formatter:function(value){
			  return value?value:percent;
		  }},
		  {title:"附件类型",field:"fjgslx",width:120},
		  {title:"操作",field:"opt",width:120,align:'center',formatter:function(value,rowData,rowIndex){
			  return (rowData["path"]?"<a id=\""+rowData["fjid00"]+"\" class=\"del\">删除</a>&nbsp;<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>":"");
		  }}
		]]
	});
	
	//删除附件
	function removeAttachment(id){
		var rowIndex=$("#attachmentUpload").datagrid("getRowIndex",id)
		var row=$("#attachmentUpload").datagrid("getRows")[rowIndex];
		$.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
			if(r){
				var timer=window.setInterval(function(){
					if(isUploaded(id)||!isNewFile(id)){//完成存储
						$.ajax({
							url : ctx+"/attachment/deleteAttachment",
							data:{"id":(isUploaded(id)?$(":input."+id).val():id)},
							type:"post",
							dataType:"json",
							success : function(data) {
								if(data.success){
									if(isUploaded(id)){
										uploader.removeFile(id);
										$(":input."+id).remove();
										
									}
									
									$("#attachmentUpload").datagrid("clearSelections");
									$("#attachmentUpload").datagrid("deleteRow",rowIndex);
								}
							}
						});
					}else if(isFullPercent(id)){//完成上传
						return;
					}else if(isNewFile(id)){//正在上传
						uploader.removeFile(id);
						$("#attachmentUpload").datagrid("deleteRow",rowIndex);
					}
					window.clearInterval(timer);
				},500);
			}
		});
	}

	
	$(document).on("click",".del",function(){
		removeAttachment($(this).attr("id"));
	});
	
});
</script>
</body>
</html>
