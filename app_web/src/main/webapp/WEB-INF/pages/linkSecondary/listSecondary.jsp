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
	function addOrEditlink(secondary_id){
		var dialog=$("<div/>").css("padding","10px").appendTo($("body")).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (secondary_id?"编辑":"添加")+"二级链接",
			href : ctx + "/LinkSecondary/secondaryEdit",
			queryParams:{secondary_id:secondary_id},
			onClose : function() {
				dialog.dialog("destroy");
			},
			buttons : [ {
				text : "确认",
				color : "red",
				handler : function() {
					dialog.find("form").ajaxSubmit({
						beforeSend : function() {
							return dialog.find("form").form("validate");
						},
						dataType : "json",
						success : function(data) {
							if (data.success) {
								dialog.dialog('close');
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
					dialog.dialog("close");
				}
			} ]
		});
	}

	function deletelink(ids){
		$.messager.confirm("系统提示","确实删除吗",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/LinkSecondary/deleteSecondary",
					type:"post",
					dataType:"json",
					data:$(ids).map(function(){return "secondary_id="+this;}).get().join("&"),
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
			url:ctx+"/LinkSecondary/restoreSecondary",
			type:"post",
			dataType:"json",
			data:$(ids).map(function(){return "secondary_id="+this;}).get().join("&"),
			success:function(data){
				if(data.success){
					$('#product-datagrid').datagrid('row-checked"');
				}
				$.jGrowl(data.msg);
			}
		});
	}
	$("#product-datagrid").datagrid({
		title:"二级链接列表",
		url:ctx+"/LinkSecondary/listSecondaryData",
		idField:"secondary_id",
		striped:true,
		pagination:true,
		rownumbers:true,
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				var row=$("#product-datagrid").datagrid("getRows")[rowIndex];
				addOrEditlink(row["secondary_id"]);
			});
			$(this).on("click","a.delete",function(){
				var rowindex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
				var row=$("#product-datagrid").datagrid("getRows")[rowindex];
				deletelink([row["secondary_id"]]);
			});
		},
		toolbar:[
			{text:"添加二级链接",handler:function(){
				addOrEditlink();
			}},
			{text:"编辑二级链接",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一条数据编辑！");
					return;
				}
				//alert(JSON.stringify(rows));
				addOrEditlink(rows[0]["secondary_id"]);
			}},
			{text:"删除二级链接",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的数据！");
					return;
				}
				//alert(JSON.stringify(rows));
				//alert(rows[0][0]["secondary_id"]);
				deletelink($(rows).map(function(){return this["secondary_id"];}).get());
			}},
			{text:"还原二级链接",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要还原的数据！");
					return;
				}
				restorelink($(rows).map(function(){return this["secondary_id"];}).get());
			}}
		],
		columns:[[
			{checkbox:true,field:"secondary_id"},
			{title:"二级链接名称",field:"secondary_name",width:300},
			{title:"一级链接名称",field:"linkName",width:200},
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
			二级链接管理
		</div>
	</div>
	<div class="block">
		<table id="product-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
