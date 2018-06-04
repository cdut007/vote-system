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
			title : "踏勘报名",
			region : "center",
			url : "${pageContext.request.contextPath}/takanApplyListData",
			idField : "id",
			columns : [ [ {
				field : "projectInstance",
				title : "所属招标项目",
				align : "left"/*,width:1*/
			}, {
				field : "projectItem",
				title : "所属招标标段",
				align : "left"/*,width:1*/
			}, {
				hidden : false,
				field : "projectInstance.project.organ",
				title : "招标单位",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "projectInstance.organ",
				title : "代理机构",
				align : "center"/*,width:510*/
			}, {
				title : "操作",
				field : "id",
				formatter : function(value, rowData) {
					return "<a class='button red small' title='踏勘' href=\"javascript:takanNotice('"+value+"');\">踏勘</a>";
				}
			} ] ],
			toolbar:[]
		});
	});
	
	
	function takanNotice(tenderItemId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 450,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "踏勘通知",
			href : ctx + "/takanForm",
			queryParams:{tenderItemId:tenderItemId},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "报名",
				color : "red",
				handler : function() {
					$("#" + id + " form").ajaxSubmit({
						dataType:"json",
						beforeSend:function(){
							return $("#" + id + " form").form("validate");
						},
						success:function(data){
							if(data.success){
								// $("#projectitem-datagrid").datagrid("reload");
								$("#" + id).dialog("close");
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
				踏勘报名
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
