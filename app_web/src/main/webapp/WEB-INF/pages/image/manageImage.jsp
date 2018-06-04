<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true" plupload="true"/>
<script type="text/javascript">
$(function(){
	function initPLUpload(pickfile){
		var uploader = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight,html4',//上传文件初始化选那种方式的优先级顺序
			browse_button : pickfile,//触发浏览文件按钮标签的唯一id
			//container : document.getElementById('container'),给开始上传文件绑定事件
			url : ctx + "/attachment/uploadAttachment",//服务器端接收和处理上传文件的脚本地址
			flash_swf_url : "/resources/plupload-2.1.2/js/Moxie.swf",//flash文件地址
			silverlight_xap_url : "/resources/plupload-2.1.2/js/Moxie.xap",//silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
			multi_selection : false,//多选对话框
			multipart_params : {
				fjgslx : "30",
				unique : true
			},//跟mutilpart关联在一起的键值对
			//选择文件扩展名的过滤器，每一个过滤器规则中只有title和extensions
			filters : {
				mime_types : [ //只允许上传图片和zip文件
				{
					title : "Image files",
					extensions : "jpg,gif,png,bmp"
				}, ],
				prevent_duplicates : true,//是否允许选择重复的文件，true为不能
				max_file_size : '200mb'//最大上传文件大小
			},
			init : {//当plupload初始化以后执行
				PostInit : function() {//当init触发后执行
				},
				FilesAdded : function(up, files) {//当文件添加到上传队列后触发
					up.start();
				},
				UploadProgress : function(up, file) {//会在文件上传过程中不断触发，可以用此事件显示上传进度

				},
				FileUploaded : function(up, file, result) {//当队列中的某一个文件上传完成后触发
					var data = $.parseJSON(result.response);
					
					//显示已经上传的图片
					$("#logo").html($("<img/>").css({
						"width" : "550px",
						"height" : "280px"
					}).attr("src", "${pageContext.request.contextPath}/attachment/download/" + data.data.path));
					//设置附件ID
					$("#picId").val(data.data.fjid00);
					$("#addTime").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
					$("#editTime").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
					up.removeFile(file);
				},
				UploadComplete : function(uploader, files) {//当队列中的所有文件全部上传完成后触发

				},
				Error : function(up, err) {//当发生触发时触发

				}
			}
		}).init();
	};
	function addOrEditImage(imageId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 880,
			height : 425,
			closed : false,//属性可返回一个布尔值，该值声明了窗口是否已经关闭 html dom属性
			modal : true,//设置跳出来窗口后，是否对后边的页面进行操作
			loadingMessage : '正在加载...',//页面出不来，显示加载
			title : (imageId?"编辑":"添加")+"图片",//跳出来窗口的title名字
			href : ctx + "/image/imageEdit",//跳出来的页面
			queryParams:{id:imageId},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			onLoad:function(){
				initPLUpload("pickfile");
			},
			buttons : [ {//按钮定义为数组
				text : "确认",
				color : "white",
				handler : function() {
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + id).dialog('close');
								$('#product-datagrid').datagrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
							}
						}
					});
				}
			}, {
				text : "取消",
				color : "white",
				handler : function() {
					$("#" + id).dialog("close");
				}
			} ]
		});
	}

	function deleteImage(ids){
		$.messager.confirm("系统提示","确实删除吗",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/image/deleteImage",
					type:"post",
					dataType:"json",
					data:$(ids).map(function(){return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$('#product-datagrid').datagrid("unselectAll");
							$('#product-datagrid').datagrid('reload');
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	
	//TODO
	
	$("#product-datagrid").datagrid({
		title:"图片管理",
		url:ctx+"/image/manageImageData",
		idField:"id",
		striped:true,
		height:500,
		pagination:true,
		rownumbers:true,
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				var row=$("#product-datagrid").datagrid("getRows")[rowIndex];
				addOrEditImage(row["id"]);
			});
			$(this).on("click","a.delete",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				var row=$("#product-datagrid").datagrid("getRows")[rowIndex];
				deleteImage([row["id"]]); 
			});
		},
		toolbar:[
			{text:"添加图片",handler:function(){
				addOrEditImage();
			}},
			{text:"编辑图片",handler:function(){
				
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一张图片编辑！");
					return;
				}
				addOrEditImage(rows[0]["id"]);
			}},
			{text:"删除图片",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的图片！");
					return;
				}
				deleteImage($(rows).map(function(){return this["id"];}).get());
			}},
		
		],
		columns:[[
			{checkbox:true,field:"id"},
			{title:"图片名称",field:"name",width:300},
			{title:"序号",field:"orderNo",width:50},
			{title:"图片地址",field:"url",width:162},
			{title:"添加时间",field:"addTime",width:157},
			{title:"修改时间",field:"editTime",width:157},
			{title:"操作",field:"opt",formatter:function(value,rowData,rowIndex){
			return "<a class=\"button orange small edit\">编辑</a><a class=\"button red small delete\">删除</a>";
			}}
		]]
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			网站管理
			<code>&gt;</code>
			图片管理
		</div>
	</div>
	<div class="block">
		<table id="product-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
