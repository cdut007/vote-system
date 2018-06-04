<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<html>
<%-- 
Describe：用户列表
Copyright: Copyright(c)2011
Company: 美宏博科技有限公司
author: chenlinting
修改：zhangdingwang
修改说明：添加搜索功能
--%>
<head>
<sys:link easyui="true" jgrowl="true"></sys:link>
<script type="text/javascript">
$(function(){
	function generateCode(tableName){
		var id=new Date().getTime();
		$("<div/>").attr("id",id).appendTo($("body")).dialog({
			title : (tableName?"编辑":"添加")+"表",
			href : ctx+"/tool/generateCode?_="+id,
			width : 600,
			height : 400,
			modal : true,
			queryParams:{"table_name":tableName},
			onLoad:function(){
				$("#"+id+" form a.button").click(function(){
					$("#"+id+" form").attr("action",ctx+"/tool/"+$(this).attr("id")).submit();
				});
			},
			buttons:[
				{text:"取消",handler:function(){
					$("#"+id).dialog("destroy");
				}}
			]
		});
	}
	function createOrUpdateTable(tableName){
		var id=new Date().getTime();
		$("<div/>").attr("id",id).appendTo($("body")).dialog({
			title : (tableName?"编辑":"添加")+"表",
			href : ctx+"/tool/tableEdit?_="+id,
			width : 800,
			height : 600,
			modal : true,
			queryParams:{"table_name":tableName},
			onLoad:function(){
				$("#"+id+" table.mytableStyle").autoTable();
			},
			buttons:[
				{text:"保存",handler:function(){
					var $form = $("#"+id+" form");
					if(!$form.form("validate")){
						return;
					}
					var params = "old_table_name=" + $form.find(":input[name='old_table_name']").val();
					params += "&table_name=" + $form.find(":input[name='table_name']").val();
					params += "&tablespace_name=" + $form.find(":input[name='tablespace_name']").val();
					params += "&comments=" + $form.find(":input[name='table_comments']").val();
					var index=$("#"+id+" form table.mytableStyle>tbody.editor tr").length;
					var $oldColumnNameInputs = $form.find(":input[name='old_column_name']:lt("+index+")");
					var $columnNameInputs = $form.find(":input[name='column_name']:lt("+index+")");
					var $dataTypeInputs = $form.find(":input[name='data_type']:lt("+index+")");
					var $columnComments = $form.find(":input[name='column_comments']:lt("+index+")");
					var $nullableInputs = $form.find(":input[name='nullable']:lt("+index+")");
					var $primaryInputs = $form.find(":input[name='primary']:lt("+index+")");
					for ( var i = 0; i < index - 1; i++) {
						params += "&cols[" + i + "].primary=" + ($($primaryInputs[i]).prop("checked") ? "Y" : "N");
						params += "&cols[" + i + "].old_column_name=" + $oldColumnNameInputs[i].value;
						params += "&cols[" + i + "].column_name=" + $columnNameInputs[i].value;
						params += "&cols[" + i + "].data_type=" + $dataTypeInputs[i].value;
						params += "&cols[" + i + "].comments=" + $columnComments[i].value;
						params += "&cols[" + i + "].nullable=" + ($($nullableInputs[i]).prop("checked") ? "N" : "Y");
					}
					$.ajax({
						url : $form.attr("action"),
						type:"post",
						data : params,
						success : function(data) {
							if (data.success) {
								$("table-datagrid").datagrid("reload")
								$("#"+id).dialog("destroy");
							}
						}
					});
				}},
				{text:"取消",handler:function(){
					$("#"+id).dialog("destroy");
				}}
			]
		});
	}
	function deleteTable(table_name){
		$.messager.confirm("系统提示","确认删除吗！", function(ok) {
			if (ok) {
				$.ajax({
					url : ctx+"/tool/deleteTable",
					type:"post",
					data : $(table_name).map(function(){return "table_id="+this;}).get().join("&"),
					dataType:"json",
					success : function(data) {
						if (data.success) {
							$("#table-datagrid").datagrid("reload");
						}
					}
				});
			}
		});
	}
	$("#table-datagrid").datagrid({
		title:"数据库表对象",
		url:ctx+"/tool/pagingTableData",
		striped:true,
		pagination:true,
		rownumbers:true,
		idField:"table_name",
		toolbar:[
			{iconCls:"icon-add",text:"添加表",handler:function(){
				createOrUpdateTable();
			}},
			{iconCls:"icon-edit",text:"编辑表",handler:function(){
				var row=$("#table-datagrid").datagrid("getChecked");
				if(row.length!=1){
					$.jGrowl("请选择一条数据编辑!");
					return;
				}
				createOrUpdateTable(row[0]["table_name"]);
			}},
			{iconCls:"icon-remove",text:"删除表",handler:function(){
				var row=$("#table-datagrid").datagrid("getChecked");
				if(row.length==0){
					$.jGrowl("请选择要删除的数据!");
					return;
				}
				deleteTable($(row).map(function(){return this["table_name"];}).get());
			}}
		],
		onOpen:function(){
			$(this).on("click","a.generate",function(){
				generateCode($(this).parent().parent().parent().children("td").find(":checkbox").val());
			});
			$(this).on("click","a.edit",function(){
				createOrUpdateTable($(this).parent().parent().parent().children("td").find(":checkbox").val());
			});
			$(this).on("click","a.delete",function(){
				deleteTable([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
		},
		columns:[[
			{checkbox:true,field:"table_name"},
			{title:"表名",field:"name",width:200,formatter:function(value,rowData,rowIndex){
				return "<a>"+rowData["table_name"]+"</a>";
			}},
			{title:"表空间",field:"tablespace_name",width:200},
			{title:"备注",field:"comments",width:250},
			{title:"操作",field:"opt",width:200,formatter:function(value,rowData,rowIndex){
				var tableName=rowData["table_name"];
				return "<a class=\"button orange small generate\">生成代码</a>&nbsp;"+
				"<a class=\"button orange small edit\">编辑</a>&nbsp;"+
				"<a class=\"button red small delete\">删除</a>&nbsp;";
			}}
		]]
	});
	$("#table-datagrid").datagrid("getPanel").find(".datagrid-toolbar").prepend("表名：<input type='text' class='inputxt' name='table_name' onkeydown=\"if(event.keyCode==13){$('#table-datagrid').datagrid('reload',{table_name:this.value});}\"/>");
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			数据表管理
		</div>
		<form:form action="${pageContext.request.contextPath}/tool/tableMaintain" id="userform" method="post" commandName="user">
			<table id="table-datagrid"></table>
		</form:form>
	</div>
</body>
</html>