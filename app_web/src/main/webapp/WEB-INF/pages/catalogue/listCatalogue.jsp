<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true"/>
<script type="text/javascript">
$(function(){
	function addOrEditCatalogue(catalogueId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (catalogueId?"编辑":"添加")+"栏目",
			href : ctx + "/catalogue/catalogueEdit",
			queryParams:{id:catalogueId},
			onClose : function() {
				$("#" + id).dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					$("#" + id + " form").ajaxSubmit({
						beforeSend : function() {
							return $("#" + id + " form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$('#' + id).dialog('close');
								$('#catalogue-datagrid').treegrid('reload');
							} else {
								$.messager.alert('系统提示', data.msg);
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
	function deleteCatalogue(ids){
		$.messager.confirm("系统提示","确认删除吗?",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/catalogue/deleteCatalogue",
					type:"post",
					dataType:"json",
					data:$(ids).map(function(){return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$('#catalogue-datagrid').treegrid('reload');
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	function restoreCatalogue(ids){
		$.ajax({
			url:ctx+"/catalogue/restoreCatalogue",
			type:"post",
			dataType:"json",
			data:$(ids).map(function(){return "id="+this;}).get().join("&"),
			success:function(data){
				if(data.success){
					$('#catalogue-datagrid').treegrid('reload');
				}
				$.jGrowl(data.msg);
			}
		});
	}
	$("#catalogue-datagrid").treegrid({
		title:"门户网站栏目列表",
		url:ctx+"/catalogue/listCatalogueData",
		striped:true,
		rownumbers:true,
		height:400,
		idField:"id",
		treeField:"catalogueName",
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				addOrEditCatalogue($(this).parent().parent().parent().attr("node-id"));
			});
			$(this).on("click","a.delete",function(){
				deleteCatalogue([$(this).parent().parent().parent().attr("node-id")]);
			});
		},
		toolbar:[
			{text:"添加栏目",handler:function(){
				addOrEditCatalogue();
			}},
			{text:"编辑栏目",handler:function(){
				var rows=$("#catalogue-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一条数据编辑！");
					return;
				}
				addOrEditCatalogue(rows[0]["id"]);
			}},
			{text:"删除栏目",handler:function(){
				var rows=$("#catalogue-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的数据！");
					return;
				}
				deleteCatalogue($(rows).map(function(){return this["id"];}).get());
			}},
			{text:"还原栏目",handler:function(){
				var rows=$("#catalogue-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要还原的数据！");
					return;
				}
				restoreCatalogue($(rows).map(function(){return this["id"];}).get());
			}}
		],
		columns:[[
			/* {field:"id",checkbox:true}, */
			{title:"栏目名称",field:"catalogueName",width:100},
			{title:"栏目标识",field:"catalogueFlag",width:100},
			{title:"序号",field:"orderNo",width:50},
			{title:"栏目地址",field:"catalogueURL",width:200},
			{title:"栏目描述",field:"catalogueDescription",width:200,hidden:true},
			{title:"创建时间",field:"createDate",width:120},
			{title:"修改时间",field:"editDate",width:120},
			{title:"状态",field:"deleteMark",width:50},
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
			栏目管理
		</div>
	</div>
	<div class="block">
		<table id="catalogue-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
