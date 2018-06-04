<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<sys:link plupload="true" easyui="true" ca="true" uedit="true"/>
<link rel="stylesheet" type="text/css" href="/resources/css/step.css">
<script src="/resources/jquery-plugins/jquery.step.js"></script>
<script type="text/javascript">
	$(function() {
		sealUtil.loadAllSealWithBKey("${winBidNotice.id}","data=string2sign","sealPos");
		sealUtil.loadAllSealWithBKey("${candidatePublicity.id}","data=string2sign","sealPos1");
		sealUtil.loadAllSealWithBKey("${evaluationReportMap[expertApply].id}","data=string2sign","sealPos2");


        $("#exportXLS_project").click(function() {
            var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
            form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#projectInfo").clone()).append($("#tenderProjectInfo").clone()).html()));
            form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]立项信息.pdf"));
            // console.log($("<div/>").append($("#projectInfo").clone()).append($("#tenderProjectInfo").clone()).html());
            form.submit();
        });
		$(".exportXLS1_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS1_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]投标单位签到表.pdf"));
			form.submit();
		});
		$(".exportXLS1_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS1_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]投标单位签到表.pdf"));
			form.submit();
		});
		$(".exportXLS2_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS2_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]投标单位报名登记表.pdf"));
			form.submit();
		});
		$(".exportXLS2_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS2_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]投标单位报名登记表.pdf"));
			form.submit();
		});
		$(".exportXLS3_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS3_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]来宾签到表.pdf"));
			form.submit();
		});
		$(".exportXLS3_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS3_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]来宾签到表.pdf"));
			form.submit();
		});
		$(".exportXLS4_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method", "POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS4_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]评标委员组成登记表.pdf"));
			form.submit();
		});
		$(".exportXLS4_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method", "POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS4_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]评标委员组成登记表.pdf"));
			form.submit();
		});
		$(".exportXLS5").click(	function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#openScore").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]开标记录表.pdf"));
			form.submit();
		});
		$(".exportXLS6").click(	function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val( $("<div/>").append($("#exportXLS6").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]投标报价打分表.pdf"));
			form.submit();
		});
		$(".exportXLS7").click(	function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS7").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]招标评分表.pdf"));
			form.submit();
		});
		$(".exportXLS8").click(	function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#geadeCollectTable").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]招标评分汇总表.pdf"));
			form.submit();
		});
		$(".exportXLS9").click(	function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val($("<div/>").append($("#exportXLS9").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]投标人排序表.pdf"));
			form.submit();
		});
		$(".exportXLS_1_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS_1_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]专家抽取等级表.pdf"));
			form.submit();
		});
		$(".exportXLS_1_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS_1_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]专家抽取等级表.pdf"));
			form.submit();
		});
		$(".exportXLS_2_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS_2_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]专家回避单位表.pdf"));
			form.submit();
		});
		$(".exportXLS_2_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS_2_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]专家回避单位表.pdf"));
			form.submit();
		});
		$(".exportXLS_3_1").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS_3_1").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]初步评审表.pdf"));
			form.submit();
		});
		$(".exportXLS_3_2").click(function() {
			var form = $("<form/>").attr("action",ctx + "/attachment/expertPDF").attr("method","POST").css("display", "none").appendTo($("body"));
			form.append($("<input/>").attr("name", "html").val(	$("<div/>").append($("#exportXLS_3_2").clone()).html()));
			form.append($("<input/>").attr("name", "exportName").val("${instance}[${projectItem.bdmc00}]初步评审表.pdf"));
			form.submit();
		});
	});
	//我也不知道这段是干嘛的，没用先注释掉
	<%--function fileupload(id) {--%>
		<%--new plupload.Uploader(--%>
				<%--{ //上传立项文件--%>
					<%--runtimes : 'html5,flash,silverlight,html4',--%>
					<%--browse_button : id,--%>
					<%--//container : document.getElementById('container'),--%>
					<%--url : ctx + '/attachment/uploadAttachment',--%>
					<%--flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',--%>
					<%--silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',--%>
					<%--multi_selection : false,--%>
					<%--multipart_params : {--%>
						<%--"fjsszt" : id--%>
					<%--},--%>
					<%--filters : {--%>
						<%--prevent_duplicates : true,--%>
						<%--max_file_size : '50000mb'--%>
					<%--},--%>
					<%--init : {--%>
						<%--PostInit : function() {--%>
						<%--},--%>
						<%--FilesAdded : function(up, files) {--%>
							<%--up.start();--%>
						<%--},--%>
						<%--UploadProgress : function(up, file) {--%>

						<%--},--%>
						<%--FileUploaded : function(up, file, result) {--%>
							<%--var data = eval("(" + result.response + ")");--%>
							<%--$("<div/>").css({--%>
										<%--float : "left",--%>
										<%--border : "1px solid #ddd",--%>
										<%--marginRight : "2px",--%>
										<%--marginBottom : "2px"--%>
							<%--}).append("<h5><a href=\"#\" style=\"float:right\" id=\""+data.data.fjid00+"\">删除</a></h5>").append("<div><img src=\""+ ctx	+ "/attachment/zoom/" + data.data.path + "?width=320&height=240\"/><div>").appendTo($("#" + id).parent().next());--%>
						<%--},--%>
						<%--UploadComplete : function(uploader, files) {--%>
						<%--},--%>
						<%--Error : function(up, err) {--%>

						<%--}--%>
					<%--}--%>
				<%--}).init();--%>
	<%--}--%>

	<%--$(function() {--%>

		<%--fileupload("lxwjFileId"); // 立项文件--%>
		<%--fileupload("xmqqFileId"); //上传项目前期文件--%>
		<%--fileupload("sqbFileId"); //上传申请表--%>
		<%--$(".tenderNotice a").each(function(index, domEle) {--%>
			<%--fileupload($(this).attr("id")); // 公告截图--%>
		<%--});--%>
		<%--$(".zbNotice").each(function(index, domEle) {--%>
			<%--fileupload("zbNoticeJtId_" + index); // 中标通知截图--%>
		<%--});--%>
		<%--$(document).on("click", ".tenderNoticePicContainer a", function() {--%>
			<%--var $a = $(this);--%>
			<%--$.ajax({--%>
				<%--url : ctx + "/attachment/deleteAttachment?id=" + $a.attr("id"),--%>
				<%--type : "post",--%>
				<%--dataType : "json",--%>
				<%--success : function(data) {--%>
					<%--if (data.success) {--%>
						<%--$a.parent().parent().remove();--%>
					<%--}--%>
				<%--}--%>
			<%--});--%>
		<%--});--%>
	<%--});--%>
	<%--function lookClarifyFile(recruitFileId) {--%>
		<%--var id = new Date().getTime();--%>
		<%--$("body").append("<div style='padding:10px' id='"+ id + "'></div>");--%>
		<%--$("#" + id).dialog({--%>
			<%--width : 800,--%>
			<%--height : 450,--%>
			<%--closed : false,--%>
			<%--modal : true,--%>
			<%--loadingMessage : '正在加载...',--%>
			<%--title : "查看招标文件澄清答疑及回执",--%>
			<%--href : "${pageContext.request.contextPath}/question/lookClarifyFile?id="--%>
					<%--+ recruitFileId,--%>
			<%--onClose : function() {--%>
				<%--$("#" + id).dialog("destroy");--%>
				<%--location.reload();--%>
			<%--}--%>
		<%--});--%>
	<%--}--%>
	<%--function submitForm() {--%>
		<%--$.ajax({--%>
			<%--type : 'post',--%>
			<%--dataType : 'json',--%>
			<%--data : $("#archiveFormId").serialize(),--%>
			<%--url : "${pageContext.request.contextPath}/projectInstance/archiveFormSave",--%>
			<%--success : function(data) {--%>
				<%--if (data.success) {--%>
					<%--$.messager.alert('系统提示', data.msg);--%>
				<%--} else {--%>
					<%--$.messager.alert('系统提示', data.msg);--%>
				<%--}--%>
			<%--},--%>
			<%--error : function(e, s1, s2) {--%>
				<%--$.messager.alert('系统提示', '操作失败！');--%>
			<%--}--%>
		<%--});--%>
	<%--}--%>
    $(function() {
    <!-- 删除附件 -->
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
    //删除附件
    function removeAttachment(fileId){
        var row= $("#otherInfo").datagrid("getSelected");
        var rowIndex = $("#otherInfo").datagrid("getRowIndex",row);
        $.messager.confirm('系统提示','确定要删除该附件吗？',function(r){
            if(r){
                var timer=window.setInterval(function(){
                    if(isUploaded(fileId)||!isNewFile(fileId)){//完成存储
                        $.ajax({
                            url : ctx+"/attachment/deleteAttachment",
                            data:{"id":(isUploaded(fileId)?$(":input."+fileId).val():fileId)},
                            type:"post",
                            dataType:"json",
                            success : function(data) {
                                if(data.success){
                                    if(isUploaded(fileId)){
                                        uploader.removeFile(fileId);
                                        $(":input."+fileId).remove();
                                    }
                                    $("#otherInfo").datagrid("clearSelections");
                                    $("#otherInfo").datagrid("deleteRow",rowIndex);
                                }else{
                                    $.messager.alert('系统提示', '删除失败！');
								}
                            }
                        });
                    }else if(isFullPercent(fileId)){//完成上传
                        return;
                    }else if(isNewFile(fileId)){//正在上传
                        uploader.removeFile(fileId);
                        $("#otherInfo").datagrid("deleteRow",rowIndex);
                    }
                    window.clearInterval(timer);
                },500);
            }
        });
    }
    $(document).on("click",".del",function(){
        removeAttachment($(this).attr("id"));
    });
	<!-- 其他附件上传开始 -->
	var projectId = '${projectItem.id}';
	console.log(projectId);

    var uploader = new plupload.Uploader({
        runtimes: 'html5,flash,silverlight,html4',
        browse_button: 'upload',
        url: ctx + '/attachment/uploadAttachment',
        flash_swf_url: '/resources/plupload-2.1.2/js/Moxie.swf',
        silverlight_xap_url: '/resources/plupload-2.1.2/js/Moxie.xap',
        multi_selection: false,
        multipart_params: {
            "fjsszt": projectId
        },
        filters: {
            prevent_duplicates: true,
            max_file_size: '20mb'
        },
        init: {
            PostInit: function () {
            },
            FilesAdded: function (up, files) {
                for(var i=0;i<files.length;i++){
                    var file=files[i];
                    $("#otherInfo").datagrid("appendRow",{
                        id:file.id,
                        fjmc:file.name,
                        uploadUser:"",
                        uploadTime:new Date().format("yyyy-MM-dd HH:mm:ss"),
                        option:"正在上传..."
                    });
                }
                up.start();
            },
            UploadProgress: function (up, file) {

            },
            FileUploaded: function (up, file, result) {
                var data=$.parseJSON(result.response);
                console.log(data);
                data.data.id=file.id;
                $($("#otherInfo").datagrid("getRows")).each(function(index){
                    if(this.id==data.data.id){
                        $("#otherInfo").datagrid("updateRow",{
                            index:index,
                            row:{
                                fjmc:data.data.fjmc00,
                                uploadUser:'${CURRENT_USER_SESSION_INFO.userName}',
                                uploadTime:data.data.uploadTime,
                                option: data["data"]["path"]?"<a id=\""+data["data"]["fjid00"]+"\" data-id=\""+self+"\" class=\"del button small red\">删除</a>&nbsp;<a target=\"_blank\" class=\"button small red\" href=\""+ctx+"/attachment/download/"+data["data"]["path"]+"\">下载</a>":""
                            }
                        });
                    }
                });
                up.removeFile(file);
            },
            UploadComplete: function (uploader, files) {
            },
            Error: function (up, err) {

            }
        }
    });
    uploader.init();

});

	<!-- 其他附件上传结束 -->
</script>
<style type="text/css">
h1,h2,h3,h4,h5 {
	border: none;
	text-align: left;
	line-height: 2em;
	font-weight: 900;
	font-family: 宋体;
	height: 2em;
}

h2 {
	font-size: 18px;
}

h3 {
	text-indent: 2em;
	font-size: 14px;
}

h4 {
	text-indent: 4em;
	font-size: 12px;
}

h5 {
	text-indent: 6em;
	font-size: 12px;
}
.tabs{
	border-style:hidden;
	padding-left:0;
}
.tabs-header{
	background-color: #fafafa;
}
.tabs-title {
	font-size: 16px;
  	font-weight: 500;
}
.tabs li {
	margin-right: 1px;
}
.tabs li.tabs-selected a.tabs-inner {
	background-color: #fafafa;
	color: #bd0a0b;
	font-size: 16px;
  	font-weight: 500;
}
.tabs li a.tabs-inner{ 
 	border: 0;
 } 
.tabs-wrap {
	margin: -2px 0 0 -2px;
}
.easyui-tabs table.mytableStyle>tbody>tr>td{
	width:300px;
	border-bottom: rgb(231, 231, 231) 1px solid;
    border-right: rgb(231, 231, 231) 1px solid;
}
.easyui-tabs table.mytableStyle>tbody>tr>th {
	width:120px;
	height:30px;
	text-align:right;
	border-bottom: rgb(231, 231, 231) 1px solid;
    border-right: rgb(231, 231, 231) 1px solid;
}


.easyui-tabs .easyui-tabs .tabs-title{
	font-size: 14px;
  	font-weight: 500;
}
.easyui-tabs .easyui-tabs .tabs-header{
	background-color: #fff;
}
.easyui-tabs .easyui-tabs .tabs li a.tabs-inner{
	color: #404040;
	background-color: #fff;
}
.easyui-tabs .easyui-tabs .tabs li.tabs-selected a.tabs-inner {
	background-color: #fff;
	color: #bd0a0b;
	font-size: 14px;
  	font-weight: 500;
  	border: 0;
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
			项目归档
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clear"></div>
			<c:set value="0" var="setup" />
			<table class="mytableStyle">
				<thead>
					<tr>
						<th style="background-color: #ffad02;font-size: 16px;font-weight: 500;color: #ffffff;" width="285px">项目编号</th>
						<th style="background-color: #ffad02;font-size: 16px;font-weight: 500;color: #ffffff;" width="285px">项目名称</th>
						<th style="background-color: #ffad02;font-size: 16px;font-weight: 500;color: #ffffff;" width="285px">标段名称</th>
						<th style="background-color: #ffad02;font-size: 16px;font-weight: 500;color: #ffffff;" width="285px">项目资料</th>
					</tr>
				</thead>
				<tr>
					<td style="background-color: #fafafa;text-align: center;font-size: 14px;font-weight: 500;color: #bd0a0b;">${projectItem.bdbh00}</td>
					<td style="background-color: #fafafa;text-align: center;font-size: 14px;font-weight: 500;color: #bd0a0b;">${instance}</td>
					<td style="background-color: #fafafa;text-align: center;font-size: 14px;font-weight: 500;color: #bd0a0b;">${projectItem.bdmc00}</td>
					<td style="background-color: #fafafa;text-align: center;font-size: 14px;font-weight: 500;color: #bd0a0b;">
						<c:if test="${not empty projectZipId}">
							<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${projectZipId}" target="_blank">一键下载</a>
						</c:if>
					</td>
				</tr>
			</table>
			<div class="easyui-panel" style="margin-top: 20px">
				<div class="easyui-tabs" data-options="border:false,tabWidth:'96',tabHeight:'40'" style="margin: 0 auto;font-size: 16px;">
					<div title="立项信息" style="padding:10px; background-color: #fafafa;font-weight: 500;">
						<div class="easyui-tabs" data-options="border:false,tabHeight:'30'" style="margin: 0 auto;font-size: 14px;">
							<div title="项目信息" style="padding:10px;">
								<table id="projectInfo" class="mytableStyle">
									<thead>
									<tr>
										<th colspan="4"><span class="left">项目信息
											<a id="exportXLS_project" class="button small red">下载</a></span>
										</th>
									</tr>
									</thead>
									<tbody>
										<tr>
											<th >招标人：</th>
											<td>${instance.organTName}</td>
											<th >项目名称：</th>
											<td>${project.xmmc00}</td>
										</tr>
										<tr>
											<th >项目地址：</th>
											<td>${project.xmdz00}</td>
											<th >项目行政区划：</th>
											<td>${dictionaryService.retrieveCacheDictionary('REGION',instance.project.region)}</td>
										</tr>
										<tr>
											<th >项目法人：</th>
											<td>${project.xmfr00}</td>
											<th >项目行业类型：</th>
											<td>${util:dictionary('INDUSTRY',project.industry)}</td>
										</tr>
										<tr>
											<th >投资金额币种：</th>
											<td>${util:dictionary('CURRENCY',project.currencyCode)}</td>
											<th >投资金额：</th>
											<td>${project.investmentAmount}</td>
										</tr>
										<tr>
											<th >项目批文：</th>
											<td>${project.approvalName}
												<span class="right">
													<c:if test="${not empty project.approvalfileId}">
														<div>
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
															<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${project.approvalfileId }">下载</a>
														</div>
													</c:if>
												</span>
											</td>
											<th >招标方案核准号：</th>
											<td>${project.zbfaNumber}</td>
										</tr>
										<tr>
											<th >项目批文单位：</th>
											<td>${project.approvalAuthority}</td>
											<th > 批准文号：</th>
											<td>${project.pzwh00}</td>
										</tr>
										<tr>
											<th >资金来源：</th>
											<td>${instance.project.funding}</td>
											<th >是否依法招标：</th>
											<td>
												<c:forEach items="${util:dictionaryTree('ACCORDING_TO_LAW',false)}" var="item">
													<c:if test="${item.itemCode==project.accordingToLaw}">
															${item.itemName}
													</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th > 项目审批时间：</th>
											<td><fmt:formatDate value="${project.xmlxsj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" /></td>
											<th > 是否进场：</th>
											<td>
												<c:forEach items="${util:dictionaryTree('YES_NO',false)}" var="item">
													<c:if test="${item.itemCode==project.sfjc00}">
														${item.itemName}
													</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th >联系人：</th>
											<td>${project.contacts}</td>
											<th > 联系方式：</th>
											<td>${project.phones}</td>
										</tr>
										<tr>
											<th >出资比例：</th>
											<td colspan="3">${project.czbl}</td>
										</tr>
										<tr>
											<th >项目规模：</th>
											<td colspan="3">${project.xmgm00}</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div title="招标项目信息" style="padding:10px;">
								<table id="tenderProjectInfo" class="mytableStyle">
									<tbody>
										<tr>
											<th >项目名称：</th>
											<td>${instance}</td>
											<th >招标项目名称：</th>
											<td>${instance.zbxmmc}</td>
										</tr>
										<tr>
											<th >招标编号：</th>
											<td>${instance.zbxmbh}</td>
											<th >机构内部招标编号：</th>
											<td>${instance.organProjectCode}</td>
										</tr>
										<tr>
											<th >招标项目类型：</th>
											<td>
												<c:choose>
													<c:when test="${instance.projectInstanceType=='A01'}">工程建设项目招标投标-房屋建筑</c:when>
													<c:when test="${instance.projectInstanceType=='A02'}">工程建设项目招标投标-市政</c:when>
													<c:when test="${instance.projectInstanceType=='A03'}">工程建设项目招标投标-公路</c:when>
													<c:when test="${instance.projectInstanceType=='A04'}">工程建设项目招标投标-铁路</c:when>
													<c:when test="${instance.projectInstanceType=='A05'}">工程建设项目招标投标-民航</c:when>
													<c:when test="${instance.projectInstanceType=='A06'}">工程建设项目招标投标-水运</c:when>
													<c:when test="${instance.projectInstanceType=='A07'}">工程建设项目招标投标-水利</c:when>
													<c:when test="${instance.projectInstanceType=='A08'}">工程建设项目招标投标-能源</c:when>
													<c:when test="${instance.projectInstanceType=='A09'}">工程建设项目招标投标-邮电通信</c:when>
													<c:when test="${instance.projectInstanceType=='A99'}">工程建设项目招标投标-其他</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</td>
											<th >申报责任人：</th>
											<td>${instance.zbzrr0}</td>
										</tr>
										<tr>
											<th >招标内容与范围：</th>
											<td colspan="3">${instance.nryfw0}</td>
										</tr>
										<tr>
											<th >审核部门名称：</th>
											<td>${instance.shbmmc}</td>
											<th >审核部门代码：</th>
											<td>${instance.shbmdm}</td>
										</tr>
										<tr>
											<th >监督部门名称：</th>
											<td>${instance.jdbmmc}</td>
											<th >监督部门代码：</th>
											<td>${instance.jdbmdm}</td>
										</tr>
										<tr>
											<th > 监督部门负责人：</th>
											<td>${instance.jdbmfzr}</td>
											<th >监督部门电话：</th>
											<td>${instance.jdbmdh}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div title="合同" style="padding:10px; background-color: #fafafa;">
						<table id="contractInfo"  class="mytableStyle">
							<thead>
								<tr>
									<th>序号</th>
									<th width="40%">文档标题</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tr>
								<td style="text-align:center">1</td>
								<td style="text-align:center">${commissionContract.htmc00}</td>
								<td style="text-align:center"><fmt:formatDate value="${commissionContract.htcjsj}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td style="text-align: center;">
									<c:if test="${not empty commissionContract.attachment.fjid00}">
										<div>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
											<a class="button small red" href="${pageContext.request.contextPath}/commissionContract/addOrMod?projectInstanceId=${instance.id}" style="cursor: pointer;" target="_blank">查看</a>
											<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${commissionContract.attachment.fjid00 }">下载</a>
										</div>
									</c:if>
								</td>
							</tr>
						</table>
					</div>
					<div title="公告" style="padding:10px; background-color: #fafafa;">
						<table id="noticeInfo" class="mytableStyle">
							<thead>
								<tr>
									<th>序号</th>
									<th width="35%">文档标题</th>
									<th>文档性质</th>
									<th>创建人</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<c:forEach items="${tenderNoticeList}" var="tenderNotice" varStatus="status">
								<tr>
									<th style="text-align:center">${status.count}</th>
									<td style="text-align:center">${tenderNotice.noticeTitle}</td>
									<td style="text-align:center">(${util:dictionary('GGXZDM',tenderNotice.ggxzdm)})</td>
									<td style="text-align:center">${tenderNotice.fbzrr0}</td>
									<td style="text-align:center"><fmt:formatDate value="${tenderNotice.ggfbsj}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<!-- TODO_SC 这里有个问题:获取的word附件是乱码，查服务器中生成的word文件没有扩展名和文件类型，下次注意一下word附件生成的过程！ -->
									<td style="text-align:center">
										<a class="button small red" href="${pageContext.request.contextPath}/projectInstance/lookTenderNotice?tenderNoticeId=${tenderNotice.id}" style="cursor: pointer;" target="_blank">查看</a>
										<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${tenderNotice.pdfAttachmentId}" target="_blank">下载</a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div title="招标资料" style="padding:10px; background-color: #fafafa;">
						<table id="tenderInfo" class="mytableStyle">
							<thead>
								<tr>
									<th>序号</th>
									<th>文档标题</th>
									<th>文档性质</th>
									<th>创建人</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<c:forEach items="${recruitFiles}" var="item" varStatus="status">
								<tr>
									<th style="text-align:center">${status.count}</th>
									<td style="text-align:center;width: 30%">${item.projectInstanceName}</td>
									<td style="text-align:center">
										<c:choose>
											<c:when test="${item.isPrejudication}">预审文件</c:when>
											<c:otherwise>招标文件</c:otherwise>
										</c:choose>
									</td>
									<td style="text-align:center">${item.author}</td>
									<td style="text-align:center"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									<td style="text-align: center;">
										<a class="button small red" href="${pageContext.request.contextPath}/recruitFileData/viewRecruitFileData?id=${item.id}" style="cursor: pointer;" target="_blank">查看</a>
										<c:choose>
											<c:when test="${item.isPrejudication}">
												<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${item.wordAttachmentId}" target="_blank">下载</a>																	
											</c:when>
											<c:otherwise>
												<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${item.pdfAttachment.fjid00}" target="_blank">下载</a>										
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div title="投标资料" style="padding:10px; background-color: #fafafa;">
						<table id="bidInfo" class="mytableStyle">
							<thead>
								<tr>
									<th rowspan="2">序号</th>
									<th rowspan="2">报名单位</th>
									<th rowspan="2">报名时间</th>
									<th rowspan="2">报名资料</th>
									<th colspan="2">投标文件</th>
									<th rowspan="2">投标保证金凭证</th>
								</tr>
								<tr>
									<th><c:if test="${not empty bidFileList_Pre}">预审</c:if></th>
									<th><c:if test="${not empty bidFileList_Post}">后审</c:if></th>
								</tr>
							</thead>
							<c:forEach items="${tenderList}" var="item" varStatus="status">
								<tr>
									<th style="text-align:center">${status.count}</th>
									<td>${item.organName}</td>
									<td style="text-align:center"><fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td style="text-align: center;">
										<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${item.zipAttachmentId}">下载</a>							
									</td>
									
									<td style="text-align:center">
										<c:if test="${not empty bidFileList_Pre}">
											<c:forEach items="${bidFileList_Pre}" var="bidFile" varStatus="status">
												<c:if test="${item.organId==bidFile.organId}">
													<a class="button small red" href="${pageContext.request.contextPath}/projectInstance/lookTbFile?id=${bidFile.id}" target="_blank">预览</a> 
													<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.wordAttachmentId}">下载</a>
												</c:if>
											</c:forEach>
										</c:if>
									</td>
									<td style="text-align:center">
										<c:if test="${not empty bidFileList_Post}">
											<c:forEach items="${bidFileList_Post}" var="bidFile" varStatus="status">
												<c:if test="${item.organId==bidFile.organId}">
													<a class="button small red" href="${pageContext.request.contextPath}/projectInstance/lookTbFile?id=${bidFile.id}" target="_blank">预览</a> 
													<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.wordAttachmentId}">下载</a>
												</c:if>
											</c:forEach>
										</c:if>
									</td>
									
									<%-- <td style="text-align: center;">
										<c:if test="${not empty bidFileList}">
											<c:forEach items="${bidFileList}" var="bidFile" varStatus="status">
												<c:if test="${item.organId==bidFile.organId}">
													<a class="button small red" href="${pageContext.request.contextPath}/projectInstance/lookTbFile?id=${bidFile.id}" target="_blank">预览</a> 
													<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${bidFile.wordAttachmentId}">下载</a>
												</c:if>
											</c:forEach>
										</c:if>
									</td> --%>
									<td style="text-align: center;">
										<c:if test="${empty tenderItemService.findDepositEvidenceAttachment(projectItem.id)}">
											<c:set var="depositEvidenceList" scope="page" value="${tenderItemService.findDepositEvidenceAttachment(projectItem.id)}"/>
											<c:forEach items="${depositEvidenceList}" var="depositEvidence">
												<a class="button small red" href="${pageContext.request.contextPath}/aptitude/showpic?id=${depositEvidence.fjid00}" style="cursor: pointer;" target="_blank">查看</a>
												<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${depositEvidence.id}">下载</a>									
											</c:forEach>
										</c:if> 
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div title="专家资料" style="padding:10px; background-color: #fafafa;">
						<div class="easyui-tabs" data-options="border:false,tabHeight:'30'" style="margin: 0 auto;font-size: 14px;">
							<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
								<c:set value="${status.count}" var="count"></c:set>
								<div title="第${status.count}轮" style="padding:10px;">
									<table id="extractInfoRorm" class="mytableStyle" style="margin-top: 10px;">
                                        <thead>
                                            <tr>
                                                <th colspan="4"><span class="left">专家抽取申请信息表
													<c:if test="${not empty expertApply.pdfAttachmentId}">
														<a class="button small red" href="${pageContext.request.contextPath}/attachment/download/${expertApply.pdfAttachmentId}">下载</a></span>
													</c:if>
												</th>
                                            </tr>
                                        </thead>
										<tr>
											<th>项目编号：</th>
											<td colspan="3">${expertApply.projectInstance.zbxmbh}</td>
										</tr>
										<tr>
											<th>项目名称：</th>
											<td colspan="3">${expertApply.projectInstance.zbxmmc}</td>
										</tr>
										<tr>
											<th>招标单位：</th>
											<td colspan="3">${expertApply.projectInstance.organTName}</td>
										</tr>
										<tr>
											<th>代理机构：</th>
											<td colspan="3">${expertApply.projectInstance.organAName}</td>
										</tr>
										<tr>
											<th>招标方式：</th>
											<td>${util:dictionary('ZBFS00',expertApply.projectInstance.zbfs00)}</td>
											<th>招标组织形式：</th>
											<td>${util:dictionary('ZBZZXS',expertApply.projectInstance.zbzzxs)}</td>
										</tr>
										<tr>
											<th>标段：</th>
											<td colspan="3">
													<nobr>${projectItem.bdmc00}</nobr>&nbsp;&nbsp;
											</td>
										</tr>
										<tr>
											<th>开标时间：</th>
											<td><fmt:formatDate value="${expertApply.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<th>开标地点：</th>
											<td>${expertApply.bidOpenPlace}</td>
										</tr>
										<tr>
											<th>评标委员会组建：</th>
											<td colspan="3">评标委员会构成： ${expertApply.juryTUserNum+expertApply.juryExpertNum}人，其中招标人代表 ${expertApply.juryTUserNum}人，专家${expertApply.juryExpertNum}人。</td>
										</tr>
										<tr>
											<th width="100px;">评标时间：</th>
											<td><fmt:formatDate value="${expertApply.evaluateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<th style="width:100px;">评标地点：</th>
											<td>${expertApply.evaluatePlace}</td>
										</tr>
										<tr>
											<th style="width:100px;">评标用时：</th>
											<td>${util:dictionary('PBSJDM',expertApply.dayNumber)}</td>
											<td colspan="2"></td>
										</tr>
										<tr>
											<th>所属库：</th>
											<td>${util:dictionary('SSK000',expertApply.expertDatabase)}</td>
											<th>专家所在区域：</th>
											<td>${util:dictionaryPath('REGION',expertApply.expertRegion)}</td>
										</tr>
										<tr>
											<th>备注说明：</th>
											<td colspan='3'>${expertApply.beizhu}<span id="sealPos"></span></td>
										</tr>
									</table>
									<table id="exportXLS_sc1_${count}" class="mytableStyle" style="margin-top: 10px;">
										<thead>
											<tr>
												<th colspan="8"><span class="left">专家抽取登记表</span></th>
											</tr>
											<tr>
												<th>序号</th>
												<th>专业</th>
												<th>人数</th>
												<th>报道时间</th>
												<th>报道地点</th>
												<th>开标时间</th>
											</tr>
										</thead>
										<c:forEach items="${expertApply.expertDemandList}" var="expertDemand" varStatus="status">
											<tr>
												<td style="text-align:center">${status.count}</td>
												<td>${expertDemand.specialtyFirstTypeName}-${expertDemand.specialtySecondTypeName}-${expertDemand.specialtyThirdTypeName}</td>
												<td>${expertDemand.expertCount}</td>
												<td>${expertDemand.expertCheckInTime}</td>
												<td>${expertDemand.expertCheckInAddress}</td>
												<td>${expertApply.bidOpenDate}</td>
											</tr>
										</c:forEach>
									</table>
									<table id="exportXLS_sc2_${count}" class="mytableStyle" style="margin-top: 10px;">
										<thead>
											<tr>
												<th colspan="8"><span class="left">回避单位</span></th>
											</tr>
											<tr>
												<th>序号</th>
												<th>回避单位代码</th>
												<th>回避单位名称</th>
											</tr>
										</thead>
										<c:forEach items="${expertApply.avoidanceOrganList}" var="avoidanceOrgan" varStatus="status">
											<tr>
												<td style="text-align:center">${status.count}</td>
												<td>${avoidanceOrgan.organCode}</td>
												<td>${avoidanceOrgan.organName}</td>
											</tr>
										</c:forEach>
									</table>
                                    <table id="extractResultRorm" class="mytableStyle" style="margin-top: 10px;">
                                        <thead>
                                        <tr>
                                            <th colspan="8"><span class="left">抽取结果<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${expertApply.expertApplyInfoMessagePdfId}">下载</a></span></th>
                                        </tr>
                                        <tr>
                                            <th>序号</th>
                                            <th>专家姓名</th>
                                            <th>身份证号码</th>
                                            <th>性别</th>
                                            <th>单位</th>
                                            <th>地区</th>
                                            <th>专业</th>
                                            <th>专家级别</th>
                                        </tr>
                                        </thead>
                                        <c:forEach items="${expertResultList}" var="expert" varStatus="status">
                                            <c:if test="${expert.expertApplyId==expertApply.id}">
                                                <tr>
                                                    <td style="text-align:center">${status.count}</td>
                                                    <td>${expert.expertName}</td>
                                                    <td>${expert.expertIdCard}</td>
                                                    <td>${expert.expertGender}</td>
                                                    <td>${expert.expertUnit}</td>
                                                    <td>${expert.expertAddress}</td>
                                                    <td>${expert.expertMajor}</td>
                                                    <td>${expert.expertLevel}</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </table>
								</div>
							</c:forEach>
						</div>
					</div>
					<div title="开标资料" style="padding:10px; background-color: #fafafa;">
						<div class="easyui-tabs" data-options="border:false,tabHeight:'30'" style="margin: 0 auto;font-size: 14px;">
							<div title="投标单位签到表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
								<table id="exportXLS1_${status.count}" class="mytableStyle">
									<thead>
										<tr>
											<th colspan="5">
												<c:if test="${expertApply.currentBidStage==1}">
													<span class="left">投标单位签到表(资格预审)<a class="exportXLS1_${status.count} button small red">下载</a></span>
												</c:if>
												<c:if test="${expertApply.currentBidStage==2}">
													<span class="left">投标单位签到表<a class="exportXLS1_${status.count} button small red" >下载</a></span>
												</c:if>
											</th>
										</tr>
										<tr>
											<th>序号</th>
											<th>投标人</th>
											<th>签到时间</th>
											<th>单位名称</th>
											<th>联系方式</th>
										</tr>
									</thead>
										<c:if test="${not empty signListMap[expertApply]}">
											<c:forEach items="${signListMap[expertApply]}" var="biderSign" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td>${biderSign.userName}</td>
													<td style="text-align:center"><fmt:formatDate value="${biderSign.signtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
													<td>${biderSign.unitName}</td>
													<td>${biderSign.phoneNumber}</td>
												</tr>
											</c:forEach>
										</c:if>
								</table>
								</c:forEach>
							</div>
							<div title="来宾签到表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
									<table id="exportXLS3_${status.count}" class="mytableStyle">
										<thead>
											<tr>
												<th colspan="5">
													<c:if test="${expertApply.currentBidStage==1}">
														<span class="left">来宾签到表(资格预审)<a class="exportXLS3_${status.count} button small red" target="_blank">下载</a></span>
													</c:if>
													<c:if test="${expertApply.currentBidStage==2}">
														<span class="left">来宾签到表<a class="exportXLS3_${status.count} button small red" target="_blank">下载</a></span>
													</c:if>
												</th>
											</tr>
											<tr>
												<th>序号</th>
												<th>来宾姓名</th>
												<th>签到时间</th>
												<th>单位名称</th>
<!-- 												<th>职务</th> -->
												<th>联系方式</th>
											</tr>
										</thead>
										<c:if test="${not empty signListMap[expertApply]}">
											<c:forEach items="${guestSignListMap[expertApply]}" var="guestSign" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td>${guestSign.userName}</td>
													<td style="text-align:center"><fmt:formatDate value="${guestSign.signtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
													<td>${guestSign.unitName}</td>
<%-- 													<td>${guestSign.userType}</td> --%>
													<td>${guestSign.phoneNumber}</td>
												</tr>
											</c:forEach>
										</c:if>
									</table>
								</c:forEach>
							</div>
							<div title="评标委员会签到表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
									<table id="exportXLS4_${status.count}" class="mytableStyle">
										<thead>
											<tr>
												<th colspan="7">
													<c:if test="${expertApply.currentBidStage==1}">
														<span class="left">评标委员会签到表(资格预审)<a class="exportXLS4_${status.count} button small red" target="_blank">下载</a></span>
													</c:if>
													<c:if test="${expertApply.currentBidStage==2}">
														<span class="left">评标委员会签到表<a class="exportXLS4_${status.count} button small red" target="_blank">下载</a></span>
													</c:if>
												</th>
											</tr>
											<tr>
												<th>序号</th>
												<th>专家姓名</th>
												<th>身份证号</th>
												<th>签到时间</th>
												<th>单位名称</th>
												<th>联系方式</th>
												<th>承诺书</th>
											</tr>
										</thead>
										<c:if test="${not empty expertApply.expertGroup.expertList}">
											<c:forEach items="${expertSignListMap[expertApply]}" var="expertSign" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td>${expertSign.userName}</td>
													<td>${expertSign.userNumber}</td>
													<td style="text-align:center"><fmt:formatDate value="${expertSign.signtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
													<td>${expertSign.unitName}</td>
													<td>${expertSign.phoneNumber}</td>
													<td>
														<c:if test="${expertApply.currentBidStage==1}">
															<c:if test="${not empty pre_expertPromiseZipId}">
																已签
																<%-- <div>
																	<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${pre_expertPromiseZipId}">下载</a>
																</div> --%>
															</c:if>
														</c:if>
														<c:if test="${expertApply.currentBidStage==2}">
															<c:if test="${not empty expertPromiseZipPostId}">
																已签
																<%-- <div>
																	<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${expertPromiseZipPostId }">下载</a>
																</div> --%>
															</c:if>
														</c:if>
													</td>
												</tr>
											</c:forEach>
<%-- 											<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td>${expert}</td>
													<td>${expert.identityNo}</td>
													<td>${expert.identityNo}</td>
													<td>${expert.identityNo}</td>
													<td>${expert.identityNo}</td>
													<td>${expert.identityNo}</td>
													<td>
														<c:if test="${expertApply.currentBidStage==1}">
															<c:if test="${not empty pre_expertPromiseZipId}">
																<div>
																	<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${pre_expertPromiseZipId}">下载</a>
																</div>
															</c:if>
														</c:if>
														<c:if test="${expertApply.currentBidStage==2}">
															<c:if test="${not empty expertPromiseZipPostId}">
																<div>
																	<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${expertPromiseZipPostId }">下载</a>
																</div>
															</c:if>
														</c:if>
													</td>
												</tr>
											</c:forEach> --%>
										</c:if>
									</table>
								</c:forEach>
							</div>
						</div>
					</div>
					<div title="评标资料" style="padding:10px; background-color: #fafafa;">
						<div class="easyui-tabs" data-options="border:false,tabHeight:'30'" style="margin: 0 auto;font-size: 14px;">
							<div title="评标报告" style="padding:10px;">
								<table id="bidEvaluationInfo_1" class="mytableStyle">
									<thead>
										<tr>
											<th>序号</th>
											<th>项目负责人</th>
											<th>评标报告结束时间</th>
											<th>操作</th>
										</tr>
									</thead>
									<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
										<c:if test="${not empty evaluationReportMap[expertApply]}">
											<tr>
												<td style="text-align: center;">${status.count }</td>
												<td style="text-align: center;">${expertApply.projectInstance.contacts}</td>
												<td style="text-align: center;"><fmt:formatDate value="${evaluationReportMap[expertApply].evaluationEndTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both" dateStyle="default" timeStyle="default" /></td>
												<td style="text-align: center;">
													<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${evaluationReportMap[expertApply].pdfAttachment.fjid00}">下载</a>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</table>
							</div>
							<div title="开标记录表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply">
									<table id="bidEvaluationInfo_2" class="mytableStyle">
										<thead>
											<tr>
												<th colspan="8">
												<span class="left">开标记录表
												<c:if test="${not empty bidOpenRecordMap[expertApply]}">
													<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${bidOpenRecordMap[expertApply] }">下载</a>
												</c:if>
												</span>
												</th>
											</tr>
											<tr>
												<th>序号</th>
												<th>投标单位</th>
												<th>投标报价</th>
												<th>质量</th>
												<th>工期</th>
												<th>其它说明 （书面修改或撤回投标通知等）</th>
												<th>是否缴纳投标保证金</th>
												<th>投标人签字</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${evaluationReportService.bidOpenStatistics(expertApply.id,projectItem.id)}" var="statistics">
												<c:forEach items="${statistics.bidFileList}" var="bidFile" varStatus="status">
													<tr>
														<td style="text-align:center">${status.count}</td>
														<td>${bidFile.organ}</td>
														<td>${bidFile.tbbjje*("1"==bidFile.tbbjdw ? 1 : 10000)=="0"?"":bidFile.tbbjje*("1"==bidFile.tbbjdw ? 1 : 10000)}</td>
														<td>${bidFile.quality}</td>
														<td>${bidFile.gq0000}</td>
														<td></td>
														<td style="text-align:center">${"1" eq bidFile.isContributeDeposit ? "是" : "否"}</td>
														<td style="text-align:center">${"1" eq bidFile.isConfirm ? "是" : "否"}</td>
													</tr>
												</c:forEach>
											</c:forEach>
										</tbody>
									</table>
								</c:forEach>
							</div>
							<div title="初步评审表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply">
									<table id="bidEvaluationInfo_3" class="mytableStyle">
										<thead>
											<tr>
												<th colspan="4">
													<c:if test="${expertApply.currentBidStage==1}">
														<span class="left">初步评审表(资格预审)</span>
													</c:if>
													<c:if test="${expertApply.currentBidStage==2}">
														<span class="left">初步评审表</span>
													</c:if>
												</th>
											</tr>
											<tr>
												<th>序号</th>
												<th>评标专家</th>
												<th>职务</th>
												<th>评审资料</th>
											</tr>
										</thead>
										<c:if test="${not empty expertApply.expertGroup.expertList}">
											<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
												<tr>
													<td style="text-align: center;">${status.count }</td>
													<td style="text-align: center;">${expert.userName }</td>
													<td style="text-align: center;">${expert.zhiwu0 }</td>
													<td style="text-align: center;">
														<a class="button small red" href="${pageContext.request.contextPath}/evaluation/expertPersonalReviewByOrderDownload?evaluationOrder=Preliminary&expertApplyId=${expertApply.id}&projectItemId=${projectItem.id}&expertId=${expert.id}" target="_blank">下载</a>
													</td>
												</tr>
											</c:forEach>
										</c:if>
										<tr>
											<td style="text-align: center;">合议结果</td>
											<td colspan="3">
												<c:if test="${expertApply.currentBidStage==1}">
													<c:if test="${not empty reviewDiscussionMap.qualFirstPreliminaryReview}">
														<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${reviewDiscussionMap.qualFirstPreliminaryReview }">初步评审合议表下载</a>	
													</c:if>
												</c:if>
												<c:if test="${expertApply.currentBidStage==2}">
													<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/evaluation/preliminaryResultReview?expertApplyId=${expertApply.id}&projectItemId=${projectItem.id}">初步评审合议查看</a>
													<c:if test="${not empty reviewDiscussionMap.firstPreliminaryReview}">
														<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${reviewDiscussionMap.firstPreliminaryReview }">初步评审合议表下载</a>	
													</c:if>
												</c:if>
											</td>
										</tr>
									</table>
									<%-- <div id="exportXLS_sc3" style="display: none;">
										<c:if test="${not empty expertApply}">
											<c:if test="${expertApply.currentBidStage==1}">
												<c:set value="-1" var="reviewStage" />
											</c:if>
											<c:if test="${expertApply.currentBidStage==2}">
												<c:set value="0" var="reviewStage" />
											</c:if>
											<c:forEach items="${evaluationReportService.preliminaryStatistics(expertApply.id,projectItem.id,reviewStage,null)}" var="statistics">
												${statistics}
											</c:forEach>
										</c:if>
									</div> --%>
								</c:forEach>
							</div>
							<div title="报价打分表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
									<c:if test="${expertApply.currentBidStage==2}">
									<c:if test="${not empty evaluationReportService.priceScoreStatistics(expertApply.id,projectItem.id)}">
									<table class="mytableStyle">
										<thead>
											<tr>
												<th colspan="8"><span class="left">报价打分表<a class="exportXLS6 button small red" target="_blank">下载</a></span></th>
											</tr>
										</thead>
									</table>
									<div id="exportXLS6">
										<c:if test="${not empty expertApply}">
											<c:forEach items="${evaluationReportService.priceScoreStatistics(expertApply.id,projectItem.id)}" var="statistics">
											${statistics}
											</c:forEach>
										</c:if>
									</div>
									</c:if>
									</c:if>
								</c:forEach>
							</div>
							<div title="招标评分表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
									<c:if test="${expertApply.currentBidStage==2}">
										<c:if test="${not empty evaluationReportService.evaluationDetailScoreStatistics(expertApply.id,projectItem.id,null)}">
										<table  class="mytableStyle">
											<thead>
												<tr>
													<th colspan="8"><span class="left">招标评分表<a class="exportXLS7 button small red" target="_blank">下载</a></span></th>
												</tr>
											</thead>
										</table>
										<div id="exportXLS7">
											<c:if test="${not empty expertApply}">
												<c:forEach items="${evaluationReportService.evaluationDetailScoreStatistics(expertApply.id,projectItem.id,null)}" var="statistics">
													${statistics}
												</c:forEach>
											</c:if>
										</div>
										</c:if>
									</c:if>
								</c:forEach>
							</div>
							<div title="投标人排序表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply" varStatus="status">
									<c:if test="${expertApply.currentBidStage==2}">
									<table  class="mytableStyle">
										<thead>
											<tr>
												<th colspan="4"><span class="left">投标人排序表<a class="exportXLS9 button small red" target="_blank">下载</a></span></th>
											</tr>
										</thead>
									</table>
									<div id="exportXLS9">
										<c:if test="${not empty expertApply}">
											<c:forEach items="${evaluationReportService.tenderItemSortStatistics(expertApply.id,projectItem.id)}" var="statistics">
												${statistics}
											</c:forEach>
										</c:if>
									</div>
									</c:if>
								</c:forEach>
							</div>
							<div title="详细评审表" style="padding:10px;">
								<c:forEach items="${expertApplyList}" var="expertApply">
									<table id="bidEvaluationInfo_7" class="mytableStyle">
										<thead>
											<tr>
												<th colspan="8">
													<c:if test="${expertApply.currentBidStage==1}">
														<span class="left">详细评审表(资格预审)</span>
													</c:if>
													<c:if test="${expertApply.currentBidStage==2}">
														<span class="left">详细评审表</span>
													</c:if>
												</th>
											</tr>
											<tr>
												<th>序号</th>
												<th>评标专家</th>
												<th>职务</th>
												<th>评审资料</th>
											</tr>
										</thead>
										<c:if test="${not empty expertApply.expertGroup.expertList}">
											<c:forEach items="${expertApply.expertGroup.expertList}" var="expert" varStatus="status">
												<tr>
													<td style="text-align: center;">${status.count }</td>
													<td style="text-align: center;">${expert.userName }</td>
													<td style="text-align: center;">${expert.zhiwu0 }</td>
													<td style="text-align: center;">
														<a class="button small red" href="${pageContext.request.contextPath}/evaluation/expertPersonalReviewByOrderDownload?evaluationOrder=Detail&expertApplyId=${expertApply.id}&projectItemId=${projectItem.id}&expertId=${expert.id}" target="_blank">下载</a>
													</td>
												</tr>
											</c:forEach>
										</c:if>
										<tr>
											<td style="text-align: center;">合议结果</td>
											<td colspan="3">
												<c:if test="${expertApply.currentBidStage==1}">
													<c:if test="${not empty reviewDiscussionMap.qualFirstDetailReview}">
														<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${reviewDiscussionMap.qualFirstDetailReview }">详细评审合议表下载</a>
													</c:if>
												</c:if>
												<c:if test="${expertApply.currentBidStage==2}">
													<c:if test="${not empty reviewDiscussionMap.firstDetailReview}">
														<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${reviewDiscussionMap.firstDetailReview }">详细评审合议表下载</a>
													</c:if>
												</c:if>
											</td>
										</tr>
									</table>
								</c:forEach>
							</div>
						</div>
					</div>
					<div title="定标资料" style="padding:10px; background-color: #fafafa;">
						<table id="candidatePublicity" class="mytableStyle">
							<thead>
								<tr>
									<th>序号</th>
									<th>文档标题</th>
									<th>文档性质</th>
									<th>创建人</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<c:if test="${not empty candidatePublicity}">
								<tr>
									<td>1</td>
									<td>中标候选人公示</td>
									<td style="text-align:center">${util:dictionary('GSLXDM',candidatePublicity.gslx)}</td>
									<td style="text-align:center">${candidatePublicity.contacts}</td>
									<td style="text-align:center"><fmt:formatDate value="${candidatePublicity.gskssj}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" /></td>
									<td style="text-align: center;">
										<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${candidatePublicity.pdfAttachmentId}">下载</a>
									</td>
								</tr>
							</c:if>									
							<c:if test="${not empty winBidNotice}">
								<tr>
									<td>2</td>
									<td>中标结果公告</td>
									<td style="text-align:center">正常公告</td>
									<td style="text-align:center">${winBidNotice.contacts}</td>
									<td style="text-align:center"><fmt:formatDate value="${winBidNotice.publishDate}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" /></td>
									<td style="text-align: center;">
										<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${winBidNotice.pdfAttachmentId}">下载</a>
									</td>
								</tr>
							</c:if>										
							<c:if test="${not empty zipNotifyId}">
								<tr>
									<td>3</td>
									<td>中标通知书</td>
									<td style="text-align:center">通知书</td>
									<td></td>
									<td></td>
									<td style="text-align: center;">
										<a class="button small red" target="_blank" href="${pageContext.request.contextPath}/attachment/download/${zipNotifyId}">下载</a>
									</td>
								</tr>
							</c:if>									
						</table>
					</div>
					<div title="其他资料" style="padding:10px; background-color: #fafafa;">
						<table id="otherInfo" class="easyui-datagrid mytableStyle" data-options="rownumbers:true,fitColumns:true">
							<thead>
								<tr>
									<th data-options="field:'fjmc',align:'center',width:300">文档标题</th>
									<th data-options="field:'uploadUser',align:'center',width:200,">创建人</th>
									<th data-options="field:'uploadTime',align:'center',width:200">创建时间</th>
									<th data-options="field:'option',align:'center',width:200">操作</th>
								</tr>
							</thead>
							<c:if test="${not empty bidOpeningQuestionAnswerZipAttachmentId}">
							<tr>
								<td>评标过程澄清文件</td>
								<td></td>
								<td>${bidOpeningQuestionAnswerZipAttachmentId.uploadTime}</td>
								<td style="text-align: center;">
									<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${bidOpeningQuestionAnswerZipAttachmentId.id}">下载</a>
								</td>
							</tr>
							</c:if>
							<c:if test="${not empty bidEndingQuestionAnswerZipAttachmentId}">
							<tr>
								<td>评标结果澄清文件</td>
								<td></td>
								<td>${bidEndingQuestionAnswerZipAttachmentId.uploadTime}</td>
								<td style="text-align: center;">
									<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${bidEndingQuestionAnswerZipAttachmentId.id}">下载</a>									
								</td>
							</tr>
							</c:if>
							<%-- <tr>
								<td>招标文件质疑文件</td>
								<td></td>
								<td></td>
								<td style="text-align: center;">
									<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${bidEndingQuestionAnswerZipAttachmentId.id}">下载</a>									
								</td>
							</tr> --%>
							<c:forEach items="${otherAttachmentList}" var="otherAtt">
								<tr>
									<td>${otherAtt.fjmc00}</td>
									<td>${otherAtt.uploadUserId}</td>
									<td><fmt:formatDate value="${otherAtt.uploadTime}" pattern="yyyy-MM-dd HH:ss:mm" type="both" dateStyle="default" timeStyle="default" /></td>
									<td style="text-align: center;">
										<a id="${otherAtt.fjid00}" class="del button small red">删除</a>
										<a class="button small red" target="_blank"	href="${pageContext.request.contextPath}/attachment/download/${otherAtt.fjid00}">下载</a>
									</td>
								</tr>
							</c:forEach>
						</table>
						<table class="mytableStyle">
							<tr>
								<td style="padding-right: 50px">
									<a id="upload" class="button small orange right" target="_blank">上传</a>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<c:choose>
				<c:when test="${projectItem.archiveStatus=='1'}">
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath}/projectItem/archive" method="post">
						<input type="hidden" value="${projectItem.id}" name="projectItemId" />
						<button class="button red">归档</button>
					</form>
				</c:otherwise>
			</c:choose>
	 	</div>
	</div> 
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
	<input type="hidden" id="setup" name="setup" value="${setup}" />
</body>
</html>
