<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	function clarifyQuestion(id) {
		$.messager.confirm('系统提示', '确认忽略吗?', function(ok) {
			if (ok) {
				$.ajax({
					type : 'post',
					dataType : 'json',
					data : {
						id : id
					},
					url : ctx + "/question/clarifyQuestion",
					success : function(data) {
						if (data.success) {
							$('#recruitfilequestion-datagrid').datagrid('reload');
							$('#recruitfilequestion-datagrid').datagrid('unselectAll');
						}
					},
					error : function(e, s1, s2) {
						$.messager.alert('系统提示', '澄清失败！');
					}
				});
			}
		});
	}

	function chengQing(recruitFileId) {
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'><textarea style='width : 600; height : 400'></textarea></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : "澄清内容",
			onClose : function() {
				$("#" + id).dialog("destroy");
			}
		});
	}

	$(function() {
		sectionList();
	});

	function sectionList() {
		$("#recruitfilequestion-datagrid").datagrid({
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			title : "需要澄清的问题列表",
			region : "center",
			url : ctx+"/question/pagingRecruitFileQuestionDataByT",
			idField : "id",
			columns : [ [ 
			    {field : "projectInstanceName",title : "招标项目",align : "left",width : 150}, 
			    {field : "bdmc00",title : "标段",align : "left",width : 100}, 
			    {field : "tenderNoticeData.bidOpenDate",title : "开标时间",align : "center",width : 100}, 
			    {title : "操作",field : "id",formatter : function(value, rowData) {
					return "<a class='button red small' onclick=\"questionList('" + value + "')\">问题列表</a>";
				}} 
			] ]
		});
	}
	function questionList(projectItemId) {
		$("#recruitfilequestion-datagrid").datagrid("unselectAll");
		$("#recruitfilequestion-datagrid").datagrid({
			singleSelect : true,
			rownumbers : true,
			//fitColumns : true,
			striped : true,
			pagination : true,
			title : "需要澄清的问题列表 ",
			region : "center",
			onLoadSuccess : function() {
				$("#recruitfilequestion-datagrid").datagrid("clearSelections");
			},
			url : ctx + "/question/pagingRecruitFileQuestionSectionDataByT",
			cache:false,
			queryParams:{projectItemId:projectItemId},
			idField : "id",
			columns : [ [
			  	{field:"id",checkbox:true,hidden:true},
				{field : "projectInstanceName",title : "所属招标项目",align : "left"/*,width:1*/}, 
				{field : "projectItemName",title : "所属招标标段",align : "left"/*,width:1*/}, 
				{hidden : true,field : "recruitFileId",title : "招标文件ID",align : "center"/*,width:510*/}, 
				{hidden : true,field : "recruitFile",title : "招标文件",align : "left"/*,width:510*/}, 
				{hidden : false,field : "organBName",title : "投标单位",align : "center"/*,width:510*/}, 
				{hidden : false,field : "questionContent",title : "问题内容",align : "left",width : 510}, 
				{hidden : true,field : "questionDate",title : "创建时间",align : "center"/*,width:510*/}, 
				{hidden : false,field : "replied",title : "状态",align : "center"/*,width:510*/} ,
				{title : "操作",field : "opt",hidden:true,formatter : function(value, rowData,rowIndex) {
					if (rowData.replied=="待澄清") {
						return "<a class='button red small' onclick=\"ignoreQuestion('"+rowData["id"]+"')\">澄清</a>";
					} else {
						return "";
					}
				}}
			] ],
			toolbar : [ {
				text : "新建澄清",
				iconCls : "myicon-basket_go",
				handler : function() {
					var rowData = $($('#recruitfilequestion-datagrid').datagrid('getData')["rows"]).filter(function() {
						return this["replied"] == "待澄清";
					});
					if (rowData.length == 0) {
						$.messager.alert('系统提示', '没有待澄清的问题！');
						return;
					}
					window.open(ctx+"/question/form?projectItemId="+projectItemId+"&" + $(rowData).map(function() {
						return "questionId=" + this["id"];
					}).get().join("&"));
					return;
					var id = new Date().getTime();
					$("body").append("<div style='padding:10px' id='"+ id + "'></div>");
					$("#" + id).dialog({
						width : 600,
						height : 400,
						closed : false,
						modal : true,
						loadingMessage : '正在加载...',
						title : "招标文件澄清",
						href : ctx + "/question/form?" + $(rowData).map(function() {
							return "questionId=" + this["id"];
						}).get().join("&"),
						buttons : [ 
							{text : "确认",color : "red",handler : function() {
									$("#" + id + " form").ajaxSubmit({
										type : "post",
										dataType : "json",
										beforeSend : function() {
											return $("#" + id + " from").form("validate");
										},
										success : function(data) {
											if (data.success) {
												$("#" + id).dialog("destroy");
											}
											$.jGrowl(data.msg);
										}
									});
									questionList(projectItemId);
								}
							} ,
							{text : "取消",color : "red",handler : function() {
								$("#"+ id).dialog("destroy");
							}}
						]
					});
				}
			}, {
				text : "返回",
				iconCls : "myicon-arrow_redo",
				handler : function() {
					sectionList();
				}
			} ]
		});
	}
</script>
<script type="text/javascript">
$(function(){
	$("#queren").click(function(){
		$.messager.confirm('系统提示','确认提交吗？',function(ok){
				if(ok){
					$("#recruitfileForm").submit();
				}else{
					$.messager.alert('系统提示', '确认失败！');
				}
			}
		)
	});
})
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				招标文件/资格预审文件
				<code>&gt;</code>
				招标文件
			</div>
			<div class="block">
				<table id="recruitfilequestion-datagrid" class="easyui-datagird"></table>
				<div class="blank10"></div>
				<form id="recruitfileForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
					<input type="hidden" name="taskId" value="${taskId}" />
					<input type="button" class="button red" value="确认" id="queren"/> 
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
