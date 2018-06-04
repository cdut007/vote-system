<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		function initPLUpload(pickfileId){
			var uploader = new plupload.Uploader({
				runtimes : 'html5,flash,silverlight,html4',
				browse_button : pickfileId,
				url : ctx + '/document/openLocalDocument',
				flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
				silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
				multi_selection : false,
				multipart_params : {
					fjgslx : "30",
					unique : true
				},
				filters : {
					mime_types  : [ //只允许上传图片和zip文件
						{title:"word文件",extensions : "doc"}
					],
					prevent_duplicates : true,
					max_file_size : '200mb'
				},
				init : {
					PostInit : function() {
						//alert(1);
					},
					FilesAdded : function(up, files) {
						up.start();
						$.messager.progress({
							title : "请您耐心等待...",
							msg : "正在上传招标文件模版",
							text : "请稍后..."
						});
					},
					UploadProgress : function(up, file) {

					},
					FileUploaded : function(up, file, result) {
						var ajax=$.parseJSON(result.response);
						if(ajax.success){
							var templateId=ajax.data.id;
							$.messager.alert("系统提示","上传成功！","",function(){
								window.location.href=ctx+"/document/previewTemplate?templateId="+templateId;
							});
						}
					},
					UploadComplete : function(uploader, files) {
						$.messager.progress("close");
					},
					Error : function(up, err) {
						$.messager.alert("系统提示",err);
					}
				}
			}).init();
		}
		function deleteMenu(id){
			$.messager.confirm("系统提示","确认删除吗?",function(ok){
				if(ok){
					$.ajax({
						url:ctx+"/document/deleteTemplaet",
						type:"post",
						dataType:"json",
						data:$(id).map(function(){return "id="+this;}).get().join("&"),
						success:function(data){
							if(data.success){
								$('#template-datagrid').datagrid('reload');
								$('#template-datagrid').datagrid("unselectAll");
							}
							$.jGrowl(data.msg);
						},
						error : function(e, s1, s2) {
							$.messager.alert('系统提示', '删除失败！');
						}
					});
				}
			});
		}
		function uploadTemplate(){
			$("<div/>").css("padding",10).appendTo($("body")).dialog({
				title:"上传招标文件模版",
				width:600,
				height:400,
				modal:true
				
			});
		};
		$("#template-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			//fitColumns : true,
			striped : true,
			pagination : true,
			title : "模板列表",
			region : "center",
			url : ctx+"/document/pagingTemplateData",
			queryParams:{"includeLock":false},
			idField : "id",
			toolbar:[
				{id:"open-local-file",text:"打开本地文件(.doc)",iconCls:"myicon-folder"}
			],
			onOpen:function(){
				$(this).on("click","a.delete",function(){
					var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
					var row=$("#template-datagrid").datagrid("getRows")[rowIndex];
					//alert(JSON.stringify(row));
					deleteMenu([row["id"]]); 
				});
			},
			columns : [ [ {
				field : "name",
				title : "模板名称",
				align : "left",
				width:160
			}, {
				hidden : false,
				field : "organName",
				title : "所属机构",
				align : "center",
				width:160
			}, {
				hidden : false,
				field : "authorName",
				title : "创建人",
				align : "center",
				width:60
			}, {
				hidden : false,
				field : "referenceTimes",
				title : "引用次数",
				align : "center",
				width:80
			}, {
				hidden : true,
				field : "description",
				title : "模板描述",
				align : "left",
				width : 210
			}, {
				hidden : false,
				field : "createTime",
				title : "创建时间",
				align : "center",
				width:120
			}, {
				hidden : true,
				field : "isDelete",
				title : "删除状态",
				align : "center",
				width:50
			}, {
				hidden : false,
				field : "editTime",
				title : "修改时间",
				align : "center",
				width:120
			}, {
				title : "操作",
				field : "id",
				formatter : function(value, rowData) {
					return "<a class='button red small' href='" + ctx + "/document/previewTemplate?templateId=" + value + "' target='_blank'>预览</a>" +
						"<a class='button red small' href='" + ctx + "/document/editTemplate?templateId=" + value + "' target='_blank'>编辑</a><a class='button red small delete'>删除</a>";
				}
			} ] ]
		});
		initPLUpload("open-local-file");
		
		$("#back").click(function(){
			window.location.href="${pageContext.request.contextPath}/home";
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
			招标文件
			<code>&gt;</code>
			招标文件模板
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix" style="height:600px">
				<table id="template-datagrid" class="easyui-datagird"></table>
			</div>
			<input type='button' class="button red" id="back" value='返回' />
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
