<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		datagrid();
	});
	
	function datagrid() {
		$("#recruitfile-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			title : "踏勘报名查看",
			region : "center",
			url : "${pageContext.request.contextPath}/projectItem/takanListData",
			idField : "id",
			columns : [ [ {
				field : "projectInstance",
				title : "所属招标项目",
				align : "left"/*,width:1*/
			}, {
				field : "bdmc00",
				title : "所属招标标段",
				align : "left"/*,width:1*/
			}, {
				hidden : false,
				field : "projectInstance.project.organ",
				title : "招标单位",
				align : "center"/*,width:510*/
			}, {
				title : "操作",
				field : "id",
				formatter : function(value, rowData) {
					return "<a class='button red small' title='踏勘查看' href=\"javascript:baoming('" + value + "');\">踏勘查看</a>";
				}
			} ] ],
			toolbar:[]
		});
	}

	function baoming(projectItemId) {
		$("#recruitfile-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			// title : "踏勘报名查看",
			region : "center",
			url : "${pageContext.request.contextPath}/baomingListData?projectItemId=${projectItemId}",
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
				field : "tkfzrName",
				title : "负责人",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "tkfzrPhone",
				title : "联系电话",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "tkrs",
				title : "踏勘人数",
				align : "center"/*,width:510*/
			} ] ],
			toolbar:[{
				text : "返回",
				color : "red",
				handler : function() {
					datagrid();
				}
			}]
		});
	}
	
	function baomingList(projectItemId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 450,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "报名列表",
			href : ctx + "/baomingList",
			queryParams:{projectItemId:projectItemId},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : []
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
				踏勘报名查看
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
