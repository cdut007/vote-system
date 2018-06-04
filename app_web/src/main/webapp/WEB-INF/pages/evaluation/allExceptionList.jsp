<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<jsp:include page="/common/link.jsp" />
	<script type="text/javascript">
		function exdetail(id)
		{
			var dialog=undefined;
			dialog=$("<div/>").css("padding",10).appendTo($("body")).dialog({
				title : "异常报告详情",
				//closed : true,
				width : 600,
				height : 450,
				href:ctx+"/evaluation/exceptionDetail?id="+ id,
				buttons : [
					{
						text : "关闭",
						handler : function() {
							dialog.dialog("destroy");
						}
					} ]
			});
		};
		$(function() {
			$("#allException-datagrid").datagrid({
				title:"异常管理 ",
				url:ctx+"/evaluation/allExceptionListData",
				pagination:true,
				rownumbers:true,
				striped:true,
				height:400,
				idField:"id",
				method:"post",
				columns:[[
					{field : 'expertApplyId',title : "项目名称",align : "center",width :90},
					{field : 'expertApply.projectInstanceName',title : "招标项目",align : "center",width : 90},
					{field : 'projectItem._toString',title : "标段名称",align : "center",width : 120},
					{field : 'exceptionTitle',title : "报告名称",align : "center",width : 120},

					{field : 'status',title : "状态",align : "center",width : 200,formatter : function(value, row, index) {
						if (0 == value) {
							return "新建";
						} else if (2 == value) {
							return "代理机构审核未通过";
						} else if (1 == value) {
							return "待审核";
						}else if (3 == value) {
							return "招标人审核未通过";
						}else if (4 == value) {
							return "公共服务平台审核未通过";
						}else if (9 == value) {
							return "审核通过";
						}else if (-1 == value) {
							return "驳回";
						}
					}},
					{field : 'createTime',title : "创建时间",align : "center",width : 120},
					{field : 'responseTime',title : "操作时间",align : "center",width : 120},
					{field : 'id',title : "操作",align : "center",width : 120,formatter:function(value,rowData,rowIndex){
						var aa = "<a class='button red small' onclick='exdetail(\"" + value + "\")'>详情</a>";
						return aa;
					}}
				]]
			});
		});
	</script>
</head>
<body>
<jsp:include page="/common/top.jsp" />
<div class="blank10"></div>
<div class="block ">
	<div id="ur_here">
		当前位置: <a href="${util:property('frontEnd')}">首页</a>
		<code>&gt;</code>
		<code>&gt;</code>
		异常管理
	</div>
</div>
<div class="block">
	<div class="usBox">
		<table id="allException-datagrid"></table>
	</div>
</div>
</body>
</html>