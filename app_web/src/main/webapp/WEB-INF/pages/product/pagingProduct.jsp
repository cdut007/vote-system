<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" jgrowl="true"/>
<script type="text/javascript">
$(function(){
	function addOrEditProduct(productId){
		var id = new Date().getTime();
		$("body").append("<div style='padding:10px' id='" + id + "'></div>");
		$("#" + id).dialog({
			width : 600,
			height : 400,
			closed : false,
			modal : true,
			loadingMessage : '正在加载...',
			title : (productId?"编辑":"添加")+"产品",
			href : ctx + "/product/productEdit",
			queryParams:{id:productId},
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
	function deleteProduct(ids){
		$.messager.confirm("系统提示","确实删除吗",function(ok){
			if(ok){
				$.ajax({
					url:ctx+"/product/deleteProduct",
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
		});
	}
	function restoreProduct(ids){
		$.ajax({
			url:ctx+"/product/restoreProduct",
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
		title:"产品列表",
		url:ctx+"/product/pagingProductData",
		idField:"id",
		striped:true,
		pagination:true,
		rownumbers:true,
		onOpen:function(){
			$(this).on("click","a.edit",function(){
				window.location.href=ctx+"/product/productEdit?id="+$(this).parent().parent().parent().children("td").find(":checkbox").val();
			});
			$(this).on("click","a.delete",function(){
				deleteProduct([$(this).parent().parent().parent().children("td").find(":checkbox").val()]);
			});
		},
		toolbar:[
			{text:"添加产品",handler:function(){
				window.location.href=ctx+"/product/productEdit";
				return;
				addOrEditProduct();
			}},
			{text:"编辑产品",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0||rows.length>1){
					$.jGrowl("请选择一条数据编辑！");
					return;
				}
				window.location.href=ctx+"/product/productEdit?id="+rows[0]["id"];
				return;
				addOrEditProduct(rows[0]["id"]);
			}},
			{text:"删除产品",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要删除的数据！");
					return;
				}
				deleteProduct($(rows).map(function(){return this["id"];}).get());
			}},
			{text:"还原产品",handler:function(){
				var rows=$("#product-datagrid").datagrid("getChecked");
				if(rows.length==0){
					$.jGrowl("请选择要还原的数据！");
					return;
				}
				restoreProduct($(rows).map(function(){return this["id"];}).get());
			}}
		],
		columns:[[
			{field:"id",checkbox:true},
			{field:"picId",title:"产品图片",formatter:function(value){
				return "<img src=\""+ctx+"/attachment/download/"+value+"\" style='width:160px;height:160px;'/>";
			}},
			{title:"产品信息",field:"productName",width:600,formatter:function(value,rowData,rowIndex){
				return "<table style='width:100%;table-layout: fixed;'><tr><td colspan='2'><a style='font-weight:900'>"+value+"</a></td></tr><tr><td>"+"<ul><li>库存："+(rowData["stock"]==null?"":rowData["stock"])+"</li><li>产地："+(rowData["yieldly"]==null?"":rowData["yieldly"])+"</li><li>型号："+(rowData["model"]==null?"":rowData["model"])+"</li></ul>"+"</td><td>"+"<ul><li>价格："+(rowData["price"]==null?"面议":rowData["price"])+"</li><li>品牌："+(rowData["brand"]==null?"":rowData["brand"])+"</li><li>制造商："+(rowData["manufacturer"]==null?"":rowData["manufacturer"])+"</li></ul>"+"</td></tr></table>";
			}},
			{title:"操作",field:"stock",formatter:function(value,rowData,rowIndex){
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
			企业管理
			<code>&gt;</code>
			产品管理
		</div>
	</div>
	<div class="block">
		<table id="product-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
