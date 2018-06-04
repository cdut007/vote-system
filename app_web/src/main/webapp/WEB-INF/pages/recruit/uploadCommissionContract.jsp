<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set value="${commissionContractService.retrieveCommissionContractByProjectInstanceId(processBusinessKey)}" var="commissionContract" scope="request"/>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true" plupload="true"/>
<script type="text/javascript">
$(function(){
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : "uploadBtn",
		url : ctx + '/commissionContract/uploadCommissionContract',
		flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
		multi_selection : false,
		multipart_params : {
			projectInstanceId:$("#projectInstanceId").val()
		},
		filters : {
			 mime_types  : [ 
				{title:"word files",extensions : "doc,docx,pdf"}
			],
			prevent_duplicates : true,
			max_file_size : '200mb'
		},
		init : {
			PostInit : function() {
				
			},
			FilesAdded : function(up, files) {
				up.start();
			},
			UploadProgress : function(up, file) {

			},
			FileUploaded : function(up, file, result) {
				var ajax=$.parseJSON(result.response);
				if(ajax.success){
					alert("上传成功！");
					var attachment=ajax.data;
					$("#attachmentId").val(attachment.fjid00);
					$("#doc").attr("src",ctx+"/attachment/download/"+attachment.path);
					up.removeFile(file);
				}
			},
			UploadComplete : function(uploader, files) {

			},
			Error : function(up, err) {
				alert(err.message+"只支持 .pdf .doc .docx 文件");
			}
		}
	}).init();
	$("#saveBtn").click(function(){
		$("#qdhtForm").ajaxSubmit({
			url:ctx+"/commissionContract/createOrUpdateCommissionContract",
			dataType:"json",
			success:function(data){
				alert(data.msg);
			}
		});
	});
	$("#passBtn").click(function(){
		$("#qdhtForm").ajaxSubmit({
			url:ctx+"/commissionContract/createOrUpdateCommissionContract",
			dataType:"json",
			success:function(data){
				if(data.success){
					$("#qdhtForm").submit();
				}
			}
		});
	});
	$("#doc").load(function(){
		var titles=$(this).contents().find("body").find("div").filter(function(){
			return $(this).children("a").length>0&&$(this).children(".awtext1,.awtext2,.awtext3,.awtext4,.awtext5").length>0;
		});
		$("#navigation").tree({
			data:titles.map(function(){return {text:$(this).text(),anchor:$(this).children("a:first").attr("name"),toString:function(){return this.text;}};}).get(),
			onClick:function(node){
				var	src=$("#doc").attr("src");
				$("#doc").attr("src",src.split("#")[0]+"#"+node.anchor);
			}
		});
	});
});
</script>
<style type="text/css">
h3 {
	text-align: left;
	border: 0;
}

#spanClose:hover {
	background-color: #eee;
	font-weight: bold;
	cursor: pointer;
}

form {
	margin: 0;
}

.user_write {
	font-weight: 500;
	text-decoration: underline;
	font-family: 楷体;
	font-size: 15px;
	font-style: italic;
}
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',height:200,border:false">
		<jsp:include page="/common/top.jsp"/>
		<div class="blank10"></div>
	</div>
	<div  data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true,border:false">
			<div data-options="region:'north',height:30,border:false">
				<div class="block">
					<div id="ur_here">
						当前位置: <a href="${util:property('frontEnd')}">首页</a>
						<code>&gt;</code>
						上传委托代理合同
					</div>
				</div>
			</div>
			<div data-options="region:'west',width:300,title:'导航'" style="backrgound:#ddd">
				<ul id="navigation">
				</ul>
			</div>
			<div data-options="region:'center',border:true,title:'招标委托代理合同'" style="overflow:hidden;">
				<c:choose>
					<c:when test="${not empty commissionContract and not empty commissionContract.attachment}">
						<iframe id="doc" src="${pageContext.request.contextPath}/attachment/download/${commissionContract.attachment.path}" style="border:1px solid #ddd;width:100%;height:100%;"></iframe>
					</c:when>
					<c:otherwise>
						<iframe id="doc" style="border:1px solid #ddd;width:100%;height:100%;"></iframe>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div data-options="region:'south',height:50" style="text-align:right;padding-top:10px;padding-bottom:10px;padding-right:30px;background-color:#efefef;border: #ccc 1px solid;">
		<form id="qdhtForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm">
			<input id="projectInstanceId" type="hidden" value="${processBusinessKey}" name="projectInstanceId"/>
			<input type='hidden' id="taskId" name='taskId' value="${taskId}" />
			<input type='hidden' id="attachmentId" name='attachmentId' value="${commissionContract.attachmentId}" />
			<input type="button" class='button red' id="uploadBtn" value="上传"/>
			<input type="button" class='button red' id="saveBtn" value="保存"/>
			<input type="button" class='button red' id="passBtn" value="提交"/>
		</form>
	</div>
	<%--<jsp:include page="/common/bottom.jsp"/>--%>
</body>
</html>