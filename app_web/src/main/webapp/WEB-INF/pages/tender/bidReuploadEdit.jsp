﻿<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set value="${tenderItemService.createTenderItemQuery().tenderItemId(processBusinessKey).singleResult()}" var="tenderItem"></c:set>
<c:set value="${tenderItem.projectItem}" var="projectItem"></c:set>
<c:set value="${tenderItem.tender}" var="tender"></c:set>
<c:set value="${tender.projectInstance}" var="projectInstance"></c:set>
<c:set value="${recruitFileService.findRecruitFile(projectItem.id)}" var="recruitFile"></c:set>
<c:set value="${attachmentService.createAttachmentQuery().referenceObjectId(processBusinessKey).attachmentUserType('24').list()}" var="sendBidDepositAttachment"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>下载标书/投标</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
pre {
 white-space: pre-wrap; /* CSS-3 */
 white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
 white-space: -pre-wrap; /* Opera 4-6 */
 white-space: -o-pre-wrap; /* Opera 7 */
 Word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
<!-- <script src="/resources/page/tender/bidReupload.js" type="text/javascript"></script> -->
<script type="text/javascript">
	$(function() {
		var percent="<div class=\"progressbar easyui-fluid\" style=\"width: 127px; height: 20px;\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div><div class=\"progressbar-value\" style=\"width: 100%; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\"><div class=\"progressbar-text\" style=\"width: 127px; height: 20px; line-height: 20px;background-color: rgb(0, 149, 205);\">完成</div></div></div>";
		$("#bidFile-datagrid").datagrid({
			title:"投标文件",
			rownumbers:true,
			striped:true,
			url:ctx+"/listBidFile",
			idField:"fjid00",
			queryParams:{"tenderItemId":$("#tenderItemId").val()},
			columns:[[
			  {title:"附件名称",field:"fjmc00",width:300},
			  {title:"上传时间",field:"uploadTime",width:150},
			  {title:"附件大小",field:"length",width:150,align:"right",formatter:function(value){
				  return castSize(value);
			  }},
			  {title:"进度",field:"status",width:150,align:"center",formatter:function(value){
			 	 return value?value:percent;
		 	  }},
			  {title:"附件类型",field:"fjgslx",width:150},
			  {title:"操作",field:"fjid00",width:150,align:'center',formatter:function(value,row,index){
					return "<a target=\"_blank\" class='button red small' href=\""+ctx+"/attachment/download/"+row["path"]+"\">下载</a><a class='button red small del' onclick=\"removeAttachment('"+row["fjid00"]+"');\" >删除</a>";
			  }}
			]]
		});
		
		$("#sendBidDepositAttachment-datagrid").datagrid({
			title:"保证金凭证",
			rownumbers:true,
			striped:true,
			url:ctx+"/listMargin",
			idField:"fjid00",
			queryParams:{"tenderItemId":$("#tenderItemId").val()},
			columns:[[
			  {title:"附件名称",field:"fjmc00",width:300},
			  {title:"上传时间",field:"uploadTime",width:150},
			  {title:"附件大小",field:"length",width:150,align:"right",formatter:function(value){
				  return castSize(value);
			  }},
			  {title:"进度",field:"status",width:150,align:"center",formatter:function(value){
			 	 return value?value:percent;
		 	  }},
			  {title:"附件类型",field:"fjgslx",width:150},
			  {title:"操作",field:"fjid00",width:150,align:'center',formatter:function(value,row,index){
				  return "<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+row["path"]+"\">下载</a>";
			  }}
			]]
		});
		function initPLUpload(datagridType,id,url,type,param,callback){
			return new plupload.Uploader({
				runtimes : 'html5,flash,silverlight,html4',
				browse_button : id,
				//container : document.getElementById('container'),
				url : url,
				flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
				silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
				multi_selection : false,
				multipart_params : param,
				//file_data_name:"Filedata",
				//drop_element : 'drop_area',
				filters : {
					mime_types : type,
					prevent_duplicates : true,//不允许选取重复文件
					max_file_size : '5000mb'//最大只能上传400kb的文件
				},
				init : {
					PostInit : function() {
					},
					FilesAdded : function(up, files) {
						up.start();
						$("#"+datagridType).datagrid("appendRow",{
							fjid00:files[0].id,
							fjmc00:files[0].name,
							status:"<div class='" + files[0].id + "' style='width:100%;'></div>",
							uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
							length:files[0].size,
							fjgslx:""
						});
						/* $("<div id=\"dialog-"+files.id+"\">").css("padding",5).appendTo($("body")).window({
							title:"上传进度",
							width:250,
							height:80,
							content:"<div class='" + files[0].id + "' style='width:100%;'></div>"
						}); */
						$("div." + files[0].id).progressbar({
						});
					},
					UploadProgress : function(up, file) {
						$("div." + file.id).progressbar("setValue", file.percent);
					},
					FileUploaded : function(up, file, result){
						callback(up, file, result);
						/* $("div."+files.id).progressbar("destory"); */
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
		}
		window.setTimeout(function(){
			//上传保证金功能初始化
			initPLUpload(
				'sendBidDepositAttachment-datagrid',
				$("#sendBidDeposit-1").get(),
				ctx + '/attachment/uploadAttachment',
				[{ title : "Image files", extensions : "jpg,gif,png,bmp" }],
				{fjsszt : $("#tenderItemId").val(),fjgslx:"24",unique:true},
				function(up, file, result){
					var data=$.parseJSON(result.response);
					$("#sendBidDepositAttachment-container").html($("<img/>").attr("src",ctx+"/attachment/download/"+data.data.path).css("width","100%"));
					$("#sendBidDepositAttachment-datagrid").datagrid("reload");
				}
			);
			//上传加密文件初始化功能
			initPLUpload(
				'bidFile-datagrid',
				$("#bidFileAttachment").get(),
				ctx + '/uploadBidFile',
				[{ title : "投标文件", extensions : "ebid" },{ title : "Zip files", extensions : "zip" }],
				{fjsszt : $("#tenderItemId").val(),tenderItemId : $("#tenderItemId").val(),fjgslx:"10",unique:true},
				function(up, file, result){
					console.log(result);
					if(result.status!='200'){
						$.messager.alert("上传失败","网络错误，请检测网络后重新上传！");
					}
					var data=$.parseJSON(result.response);
					$.jGrowl(data.msg);
					$("#bidFile-datagrid").datagrid("reload");
					up.removeFile(file);
				}
			); 
		},1000);
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标文件上传
		</div>
		<div class="blank10"></div>
			<div class='tableTitle' style="cursor:pointer;">项目：${projectInstance.zbxmmc}（单击显示）</div>
			<table class='mytableStyle none'>
				<tr>
					<th width="120px">所属项目</th>
					<td colspan='3'>${projectInstance.project.xmmc00}</td>
				</tr>
				<tr>
					<th>招标项目编号:</th>
					<td>${projectInstance.zbxmbh}</td>
					<th>招标项目名称:</th>
					<td>${projectInstance.zbxmmc}</td>
				</tr>
				<tr>
					<th width="120px">招标人</th>
					<td>${projectInstance.organTName}</td>
					<th width="120px">代理机构</th>
					<td>${projectInstance.organ.ztmc00}</td>
				</tr>
				<tr>
					<th width="120px">招标方式</th>
					<td>${dictionaryService.retrieveCacheDictionary("ZBFS00",projectInstance.zbfs00)}</td>
					<th width="120px">组织形式</th>
					<td>${dictionaryService.retrieveCacheDictionary("ZBZZXS",projectInstance.zbzzxs)}</td>
				</tr>
				<tr>
					<th width="120px">招标内容与范围</th>
					<td colspan='3'>
						<pre>${projectInstance.nryfw0}</pre>
					</td>
				</tr>
				<tr>
				<th width="120px">招标文件</th>
				<td colspan='3'>
					<c:choose>
						<c:when test="${empty recruitFile}">
							招标文件还在编制审核中
						</c:when>
						<c:otherwise>
							<p><a href="${pageContext.request.contextPath}/attachment/download/${recruitFile.wordAttachment.fjid00}" target="_blank">${recruitFile.wordAttachment.fjmc00}</a></p>
							<p><a href="${pageContext.request.contextPath}/attachment/download/${recruitFile.pdfAttachment.fjid00}" target="_blank">${recruitFile.pdfAttachment.fjmc00}</a></p>
							<p><a href="${pageContext.request.contextPath}/recruitFile/preview?recruitFileId=${recruitFile.id}" target="_blank">在线预览</a></p>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</table>
			<%-- <div class="blank10"></div>
			<a id="bidFileAttachment" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传投标文件</a>
			<div class="usBox">
			<table id="bidFile-datagrid"></table>
		    </div>
			<!-- 招标文件 -->
			<div class="tableTitle2">招标文件下载</div>
			<table class='mytableStyle'>
				<tr>
					<td width="100%;">
						<c:choose>
							<c:when test="${empty recruitFile}">
								招标文件还在编制审核中
							</c:when>
							<c:otherwise>
								<a class="button red" href="${pageContext.request.contextPath}/recruitFile/download/${projectInstance.zbxmmc}_${projectItem.bdmc00}招标文件.zip?id=${recruitFile.id}">${recruitFile.projectItem.projectInstance}_${recruitFile.projectItem}&nbsp;招标文件(下载)</a>
							</c:otherwise>
						</c:choose>
						<a class="button red" href="/resources/Bidfile_Edit.exe">下载编辑器</a>
					</td>
				</tr>
			</table> --%>
		<div class="blank10"></div>
		<a id="bidFileAttachment" class="easyui-linkbutton"  data-options="iconCls:'myicon-attach'">上传投标文件(.ebid)</a>
		<div class="usBox">
			<table id="bidFile-datagrid"></table>
		</div>
		<div class="blank10"></div>
		<a id="sendBidDeposit-1" class="easyui-linkbutton" data-options="iconCls:'myicon-attach'">上传保证金递交凭证(.jpg)</a>
 		
		
 		<div class="usBox">
			<table id="sendBidDepositAttachment-datagrid"></table>
		</div>
 		
		<div id="sendBidDepositAttachment-container" class="usBox" style="text-align: center;">
			<c:if test="${not empty sendBidDepositAttachment}">
				<c:forEach var="item" items="${sendBidDepositAttachment}">
					<img src="${pageContext.request.contextPath}/aptitude/showpic?id=${item.fjid00}" style="width:100%;"/>
				</c:forEach>
			</c:if>
		</div>
		<form method="post" id="tbForm" action="${pageContext.request.contextPath}/workflow/completeForm">
			<input id="tenderItemId" type="hidden" name="tenderItemId" value="${tenderItem.id}"/>
			<input type="hidden" value="${taskId}" name="taskId" /> 
			<input type="hidden" name="message" value="${message}" /> 
			<!-- <input type='button' id="subBtn" class='button red' value='提交' /> -->
		</form>
	</div>
</body>
<script>
//删除附件
function removeAttachment(id){
	var rowIndex=$("#bidFile-datagrid").datagrid("getRowIndex",id)
	var row=$("#bidFile-datagrid").datagrid("getRows")[rowIndex];
	$.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
		if(r){
					$.ajax({
						url : ctx+"/attachment/deleteAttachment",
						data:{"id":id},
						type:"post",
						dataType:"json",
						success : function(data) {
							$.messager.alert("提示",data.msg);
							if(data.success){
								$("bidFile-datagrid").datagrid("clearSelections");
								$("#bidFile-datagrid").datagrid("deleteRow",rowIndex);
							}
						}
					});
		}
	});
}
</script>
</html>