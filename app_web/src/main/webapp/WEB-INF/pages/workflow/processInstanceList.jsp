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
		$("#processInstance-datagrid").datagrid({
			title : '流程实例',
			url : ctx+'/workflow/pagingProcessInstance',
			idField : 'PROC_INST_ID_',
			pagination : true,
			rownumbers : true,
			striped : true,
			height:400,
			onOpen:function(){
				$(this).on("click",".close",function(){
					var processInstanceId=$(this).parent().parent().parent().find(":checkbox").val();
					var id=new Date().getTime();
					$("body").append("<div id='" + id + "' style='padding:10px;'></div>");
					$("#" + id).dialog({
						title : '关闭内容',
						modal:true,
						width:600,
						height:400,
						content:"<form method='post' action='"+ctx+"/workflow/deleteProcessInstance'><input type='hidden' value='"+processInstanceId+"' name='processInstanceId'/><textarea name='deleteReason' style='width:560px;height:280px;' class='easyui-validatebox' data-options='required:true'></textarea></form>",
						buttons:[
							{text:"提交",handler:function(){
								$("#"+id+" form").ajaxSubmit({
									boforeSend:function(){
										return $("#"+id+" form").form("validate");
									},
									dataType:"json",
									success:function(data){
										if(data.success){
											$("#processInstance-datagrid").datagrid("reload");
											$("#" + id).dialog('destroy');
										}
										$.jGrowl(data.msg);
									}
								});
							}},
							{text:"关闭",handler:function(){
								$("#" + id).dialog('destroy');
							}}
						]
					});
				});
				$(this).on("click",".detail",function(){
					var processInstanceId=$(this).parent().parent().parent().find(":checkbox").val();
					var id=new Date().getTime();
					$("body").append("<div id='" + id + "' style='padding:10px;'></div>");
					$("#" + id).dialog({
						title : '查看详情',
						modal:true,
						width:800,
						height:600,
						href:ctx+"/workflow/processInstanceDetail?processInstanceId="+processInstanceId
					});
				});
			},
			columns:[[
				{checkbox:true,field:'PROC_INST_ID_'},
				{title:'流程名称',field:'PROC_DEF_NAME_',width:120},
				{title:'招标项目',field:'PROJ_NAME_',width:120},
				{title:'发起机构',field:'ORGAN_NAME_',width:120},
				{title:'发起人',field:'START_USER_NAME_',width:70},
				{title:'发起时间',field:'START_TIME_',width:80},
				{title:'当前结点',field:'ACT_NAME_',width:80},
				{title:'状态',field:'END_TIME_',width:60,formatter:function(value){
					return value!=undefined&&value!=null?"已结束":"未结束";
				}},
				{title:"操作",field:"opt",width:100,formatter:function(value,rowData,rowIndex){
					var endTime=rowData["END_TIME_"];
					return endTime!=undefined&&endTime!=null?"":"<a class='red button small detail'>查看进度</a><a class='red button small close'>删除</a>";
				}}
			]],
			onLoadSuccess:function(){
				new plupload.Uploader({
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
								$("form").submit();
							}
							top.$.jGrowl(data.msg);
						},
						UploadComplete : function(uploader, files) {
							top.$.messager.progress("close");
						},
						Error : function(up, err) {
							top.$.jGrowl(err.message);
						}
					}
				}).init();
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
				流程实例
			</div>
			<div class="blank10"></div>
			<table id="processInstance-datagrid"></table>
			<a id=""></a>
			<div class="blank10"></div>
		</div>
		<!--center end  -->
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>