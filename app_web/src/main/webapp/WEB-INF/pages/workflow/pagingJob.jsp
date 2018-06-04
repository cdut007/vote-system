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
		$("#job-datagrid").datagrid({
			title : '执行计划列表',
			url : ctx+'/workflow/pagingJobData',
			idField : 'id',
			pagination : true,
			rownumbers : true,
			striped : true,
			height:400,
			onOpen:function(){
				$(this).on("click",".execute",function(){
					var jobId=$(this).parent().parent().parent().find(":checkbox").val();
					$.messager.confirm("系统提示","确定执行码?",function(ok){
						if(ok){
							$.ajax({
								url:ctx+"/workflow/executeJob",
								data:{jobId:jobId},
								type:"post",
								dataType:"json",
								success:function(data){
									$.messager.alert("系统提示",data.msg);
									if(data.success){
										$("#job-datagrid").datagrid("reload");
									}
								}
							});
						}
					});
				});
			},
			columns:[[
				{checkbox:true,field:'id'},
				{title:'流程定义ID',field:'processDefinitionId',width:150},
				{title:'流程实例ID',field:'processInstanceId',width:100},
				/* {title:'发起机构',field:'ORGAN_NAME_',width:120}, */
				{title:'重试次数',field:'retries',width:60},
				{title:'执行时间',field:'duedate',width:120},
				{title:'异常描述',field:'exceptionMessage',width:200},
				/* {title:'状态',field:'END_TIME_',width:60,formatter:function(value){
					return value!=undefined&&value!=null?"已结束":"未结束";
				}}, */
				{title:"操作",field:"opt",width:100,formatter:function(value,rowData,rowIndex){
					return "<a class='red button small execute'>执行</a>";
				}}
			]]/* ,
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
			} */
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
			<table id="job-datagrid"></table>
			<div class="blank10"></div>
		</div>
		<!--center end  -->
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>