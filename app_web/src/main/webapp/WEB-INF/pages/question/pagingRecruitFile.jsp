<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#recruitfile-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			title : "模板列表",
			region : "center",
			url : "${pageContext.request.contextPath}/question/pagingRecruitFileData",
			idField : "id",
			columns : [ [ {
				field : "projectInstanceName",
				title : "招标项目",
				align : "left"/*,width:1*/
			}, {
				field : "projectItemName",
				title : "所属招标标段",
				align : "left"/*,width:1*/
			}, {
				hidden : false,
				field : "organTName",
				title : "招标单位",
				align : "center"/*,width:510*/
			}, {
				hidden : true,
				field : "authorName",
				title : "编制人",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "organAName",
				title : "代理机构",
				align : "center"/*,width:510*/
			}, {
				hidden : true,
				field : "createTime",
				title : "创建时间",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "editTime",
				title : "修改时间",
				align : "center"/*,width:510*/
			}, {
				title : "文件预览",
				field : "id",
				formatter : function(value, rowData) {
					return "<a class='button red small' href='" + ctx + "/recruitFile/editRecruitFile?id=" + value + "' target='_blank'>预览</a><a class='button red small' href='" + ctx + "/attachment/download/"+rowData["wordAttachmentId"]+"' target='_blank'>下载</a>";
				}
			} ] ],
			toolbar:[{
				text : "添加疑问",
				iconCls : "myicon-application_add",
				handler : function() {
					var row=$("#recruitfile-datagrid").datagrid("getSelected");
					if(row==null){
						$.messager.alert("系统提示", "请先选择标段");
						return;
					}
					var id = new Date().getTime();
					$("body").append("<div style='padding:10px' id='" + id + "'></div>");
					$("#" + id).dialog({
						width : 600,
						height : 450,
						closed : false,
						modal : true,
						loadingMessage : '正在加载...',
						title : "需要澄清的问题",
						href : ctx + "/question/recruitFileQuestionEdit",
						queryParams:{recruitFileId:row.id},
						onClose : function() {
							$("#" + id).dialog("destroy");
						},
						buttons : [ {
							text : "确认",
							color : "red",
							handler : function() {
								$("#" + id + " form").ajaxSubmit({
									dataType:"json",
									beforeSend:function(){
										return $("#" + id + " form").form("validate");
									},
									success:function(data){
										if(data.success){
											$("#projectitem-datagrid").datagrid("reload");
											$("#" + id).dialog("close");
										}
										
										if(data.msg){
											$.messager.alert("系统提示",data.msg,"info");
										}
								
									}
								});
							}
						}, {
							text : "取消",
							color : "red",
							handler : function() {
								$("#" + id).dialog("close");
							}
						} ]
					});
				}
			}]
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
	
		<div class="AreaR ">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				招标文件/资格预审文件
				<code>&gt;</code>
				招标文件
			</div>
			<div class="block">
				<div class="usBox">
					<div class="clearfix" style="height:600px">
						<table id="recruitfile-datagrid" class="easyui-datagird"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
