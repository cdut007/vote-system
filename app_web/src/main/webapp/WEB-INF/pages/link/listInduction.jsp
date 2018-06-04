<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true"/>
<script type="text/javascript">
$(function(){
	function addOrEditlink(linkId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (linkId?"编辑":"添加")+"链接",
			href : ctx + "/link/inductionEdit",
			queryParams:{id:linkId},
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
								$('#product-datagrid').datagrid('reload');
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

	function deletelink(ids){
		$.messager.confirm("系统提示","确实删除吗",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/link/deleteInduction",
					type:"post",
					dataType:"json",
					data:$(ids).map(function(){return "id="+this;}).get().join("&"),
					success:function(data){
						if(data.success){
							$('#product-datagrid').datagrid("unselectAll");
							$('#product-datagrid').datagrid('reload');
						}
						$.jGrowl(data.msg);
					}
				});
			}
		});
	}
	function restorelink(ids){
		$.ajax({
			url:ctx+"/link/restorelink",
			type:"post",
			dataType:"json",
			data:$(ids).map(function(){return "id="+this;}).get().join("&"),
			success:function(data){
				if(data.success){
					$('#product-datagrid').datagrid('reload');
				}
				$.jGrowl(data.msg);
			}
		});
	}
	$("#product-datagrid").datagrid({
		title:"一级链接列表",
		url:ctx+"/link/listInductionData",
		idField:"id",
		striped:true,
		pagination:true,
		rownumbers:true,
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				var row=$("#product-datagrid").datagrid("getRows")[rowIndex];
				addOrEditlink(row["id"]);
			});
			$(this).on("click","a.delete",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				var row=$("#product-datagrid").datagrid("getRows")[rowIndex];
				deletelink([row["id"]]); 
			});
		},
		toolbar:[
			{text:"添加链接",handler:function(){
				addOrEditlink();
			}},
			{text:"编辑链接",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一条数据编辑！");
					return;
				}
				addOrEditlink(rows[0]["id"]);
			}},
			{text:"删除链接",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的数据！");
					return;
				}
				deletelink($(rows).map(function(){return this["id"];}).get());
			}},
			{text:"还原链接",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要还原的数据！");
					return;
				}
				restorelink($(rows).map(function(){return this["id"];}).get());
			}}
		],
		columns:[[
			{checkbox:true,field:"id"},
			{title:"链接名称",field:"link_name",width:500},
			{title:"序号",field:"sortNumber",width:100},
			{title:"链接地址",field:"url",width:200},
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
			一级链接管理
		</div>
	</div>
	<div class="block">
		<table id="product-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
