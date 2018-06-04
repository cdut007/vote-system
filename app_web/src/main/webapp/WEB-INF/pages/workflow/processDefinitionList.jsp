<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true" plupload="true"></sys:link>
<script type="text/javascript">
	$(function() {
		$("#processDefinition-datagrid").datagrid({
			title : '流程定义管理',
			url : '${pageContext.request.contextPath}/workflow/pagingProcessDefinition',
			idField : 'id',
			pagination : true,
			rownumbers : true,
			striped : true,
			height:400,
			toolbar:[
				{id:"372506c4-2a75-4e0a-845b-7b8ff3fab5b4",text:"上传流程定义"},
				{text:"导出流程定义",handler:function(){
					var rows=$("#processDefinition-datagrid").datagrid("getChecked");
					if(rows.length!==1){
						$.jGrowl("请选择一行数据");
						return;
					}
					window.location=ctx + "/workflow/exportDefinition?processDefinitionId=" + rows[0]["id"];
				}},
				{text:"查看流程图",handler:function(){
					var rows=$("#processDefinition-datagrid").datagrid("getChecked");
					if(rows.length!==1){
						$.jGrowl("请选择一行数据");
						return;
					}
					var processDefinitionId=rows[0]["id"];
					var processDefinitionName=rows[0]["name"];
					$("<div>").appendTo($("body")).dialog({
						title:processDefinitionName,
						width:800,
						height:600,
						content:"<img src=\""+ctx + "/workflow/processDefinitionImage?processDefinitionId="+processDefinitionId+"\"/>"
					});
				}}
			],
			columns:[[
				{checkbox:true,field:'id'},
				{title:'流程名称',field:'name',width:150},
				{title:'流程标识',field:'key',width:100},
				{title:'版本',field:'version',width:80},
				{title:'描述',field:'description',width:250}
			]],
			onLoadSuccess:function(){
				var options=$(this).datagrid("options");
				if(!options.uploader){
					options.uploader=new plupload.Uploader({
						runtimes : 'html5,flash,silverlight,html4',
						browse_button : "372506c4-2a75-4e0a-845b-7b8ff3fab5b4",
						url : ctx + '/workflow/importDefinition',
						flash_swf_url : '/resources/plupload-2.1.2/js/Moxie.swf',
						silverlight_xap_url : '/resources/plupload-2.1.2/js/Moxie.xap',
						multi_selection : false,
						filters : {
							mime_types : [ //只允许上传图片和zip文件
							{
								title : "Bpmn files",
								extensions : "bpmn,xml"
							} ],
							max_file_size : '400kb', //最大只能上传400kb的文件
							prevent_duplicates : true
						//不允许选取重复文件
						},
						init : {
							PostInit : function() {
							},
							FilesAdded : function(up, files) {
								up.start();
								top.$.messager.progress({
									title : "正在上传部署流程..."
								});
							},
							UploadProgress : function(up, file) {
							},
							FileUploaded : function(up, file, result) {
								var data = $.parseJSON(result.response);
								if (data.success) {
									$("#processDefinition-datagrid").datagrid("reload");//.submit();
								}
								$.jGrowl(data.msg);
							},
							UploadComplete : function(uploader, files) {
								$.messager.progress("close");
							},
							Error : function(up, err) {
								$.jGrowl(err.message);
							}
						}
					});
					options.uploader.init();
				}
			}
		});
	});
	function add() {
		top.$.layer({
			type : 2,
			shadeClose : true,
			title : [ '流程定义',
			//自定义标题风格，如果不需要，直接title: '标题' 即可
			'border:none; background:#4E96EC; color:#fff;' ],
			closeBtn : [ 0, true ],
			shade : [ 0.8, '#000' ],
			border : [ 0 ],
			offset : [ '', '' ],
			area : [ '100%', '100%' ],
			iframe : {
				src : "${pageContext.request.contextPath}/workflow/designer/main"
			},
			close : function(index) {
				$("form").submit();
				//location.href = "${pageContext.request.contextPath}/workflow/processDefinitionList";
			}
		});
	}
	function edit() {
		var id = CheckboxValue();
		if (id == "" || id == null) {
			layer.alert("请选择行！");
		} else if (id.split(',').length > 1) {
			layer.alert("只能選擇一個！");
		} else {
			top.$.layer({
				type : 2,
				shadeClose : true,
				title : [ '流程定义',
				//自定义标题风格，如果不需要，直接title: '标题' 即可
				'border:none; background:#4E96EC; color:#fff;' ],
				closeBtn : [ 0, true ],
				shade : [ 0.8, '#000' ],
				border : [ 0 ],
				offset : [ '', '' ],
				area : [ '100%', '100%' ],
				iframe : {
					src : "${pageContext.request.contextPath}/workflow/designer/main?processDefinitionId=" + id
				},
				close : function(index) {
					$("form").submit();
					//location.href = "${pageContext.request.contextPath}/workflow/processDefinitionList";
				}
			});
		}
	};
	function detail() {
		if ($(":input:checked").length == 1) {
			top.$.layer({
				type : 2,
				shadeClose : true,
				title : [ '详细',
				//自定义标题风格，如果不需要，直接title: '标题' 即可
				'border:none; background:#4E96EC; color:#fff;' ],
				closeBtn : [ 0, true ],
				shade : [ 0.8, '#000' ],
				border : [ 0 ],
				offset : [ '', '' ],
				area : [ '100%', '100%' ],
				iframe : {
					src : "${pageContext.request.contextPath}/workflow/processDefinitionDetail?processDefinitionId=" + $(":input:checked").val()
				}
			});
		}
	}

	function start() {
		if ($(":input:checked").length == 1) {
			startFormById($(":input:checked").val());
		}
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<!--center start  -->
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				工作流
				<code>&gt;</code>
				流程定义
			</div>
			<div class="blank10"></div>
			<table id="processDefinition-datagrid"></table>
			<a id=""></a>
			<div class="blank10"></div>
		</div>
		<!--center end  -->
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>