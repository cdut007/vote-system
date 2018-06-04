<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标项目列表</title>
<sys:link easyui="true" plupload="true"/>
<style type="text/css">
.xmzt {
 padding: 4px 6px 4px 0px;
 color: #F00;
 TEXT-ALIGN: center;
 font-weight: bold;
}
</style>
<script type="text/javascript">
	
	//TODO 各种无效！
	$(document).ready(function(){
		var msg = "${msg}";
		if(msg==null || msg==""){

		}else{
			$.messager.alert("系统提示",msg);
			//alert($("#uploadBidFile"));
			//console.info($("#uploadBidFile"));
			//禁用 快速投标按钮
			//$("#uploadBidFile").hide();
			//$("#uploadBidFile").find(".l-btn-text").hide();
			//$("#uploadBidFile").prop("disabled",true);
			//$("#uploadBidFile").attr("disabled","disabled");
		}
	});
	
	function detailZBGG(id) {
		window.showModalDialog("${pageContext.request.contextPath}/notice/detailForFlow1?id=" + id + "&t=" + new Date(), "招标公告详细信息", "dialogWidth:800px;dialogHeight:500px;location:no");
	}
	$(function(){
		$('#node_0').datagrid({
			title:"投标项目列表",
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			//fitColumns : true,
			idField : "id",
			striped : true,
			//treeField : "text",
			animate : false,
			url : "${pageContext.request.contextPath}/tenderProjectList",
			onOpen:function(){
				window.setTimeout(function(){
					new plupload.Uploader({
						runtimes : 'html5,silverlight,html4',
						browse_button : "uploadBidFile",
						//container : document.getElementById('container'),
						url : ctx + '/uploadBidFile',
						flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
						silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
						multi_selection : false,
						multipart_params : {fjgslx:"10",unique:true},
						//file_data_name:"Filedata",
						//drop_element : 'drop_area',
						filters : {
							mime_types : [{ title : "投标文件", extensions : "ebid" },{ title : "Zip files", extensions : "zip" }],
							prevent_duplicates : true,//不允许选取重复文件
							max_file_size : '5000mb'//最大只能上传400kb的文件
						},
						init : {
							PostInit : function() {
							},
							FilesAdded : function(up, files) {
								up.start();
							},
							UploadProgress : function(up, file) {
								$("div." + file.id).progressbar("setValue", file.percent);
							},
							FileUploaded : function(up, file, result){
								var data=$.parseJSON(result.response);
								$.messager.alert("系统提示",data.msg);
								up.removeFile(file);
								/* $("div."+files.id).progressbar("destory"); */
							},
							UploadComplete : function(uploader, files) {
								
							},
							Error : function(up, err) {
								$.messager.alert("系统提示",err);
							},
							FilesRemoved:function(up,files){
								
							}
						}
					}).init();
				},1000);
			},
			toolbar:[
				{id:"uploadBidFile",text:"快速投标",iconCls:'myicon-attach'}
			],
			columns : [ [ {
				field : "zbxmbh",
				title : "项目编号",
				width : 80
			},
			{
				field : "zbxmmc",
				title : "项目名称",
				width : 150
			},
			{
				field:"tenderProjectClassifyCode",
				title:"项目类别",
				width:80
			},
			{
				field:"lxsj00",
				title:"立项时间",
				width:80
			},
			{
				field : "organTName",
				title : "招标人",
				width : 200
			},
			{
				field : "organAName",
				title : "代理机构",
				width : 200
			},
			{
				field : "id",
				title : "操作",
				formatter:function(value,rowData,rowIndex){
					var optStr = "<a class='button red small' href='${pageContext.request.contextPath}/projectDetail?id="+rowData["id"]+"'>详细</a>";
					return optStr;
				}
			}]]
		});
	});
	
	
	/**
	 * 勘探报名
	 */
	function reconnaissance(tenderId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "勘探报名",
			href : "${pageContext.request.contextPath}/reconnaissance?id="+tenderId,
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "报名",
				color : "red",
				handler : function() {
					$("#" + id + " form").attr("action", "${pageContext.request.contextPath}/apply");
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							$.messager.alert('系统提示', data.msg);
							if (data.success) {
								$('#' + id).dialog('close');
							}
							/* if (data.success) {
								$('#' + id).dialog('close');
								$('#department-treegrid').treegrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							} */
						}
					});
				}
			}, {
				text : "取消报名",
				color : "red",
				handler : function() {
					$("#" + id + " form").attr("action", "${pageContext.request.contextPath}/cancelApply");
					$("#" + id + " form").ajaxSubmit({
						dataType : "json",
						success : function(data) {
							$.messager.alert('系统提示', data.msg);
							if (data.success) {
								$('#' + id).dialog('close');
							}
						}
					});
				}
			} ]
		});
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标项目管理
		</div>
		<div class="blank10"></div>
		<table id="node_0">
		</table>
		<div class="blank5"></div>
	</div>
</body>
</html>
