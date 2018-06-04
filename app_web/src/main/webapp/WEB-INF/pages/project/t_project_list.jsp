<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>

<script type="text/javascript">

	/* window.onload=function(){
		var str = ${msg };
		if(str != null){
			alert(str);
		}
	} */
	$(document).ready(function(){
		var msg = "${msg}";
		if(msg==null || msg==""){

		}else{
			$.messager.alert("系统提示",msg);
		}
	});
	
	
	function deleteProject(id){
		$.ajax({
			url:ctx+"/project/delete",
			type:"post",
			data:{id : id},
			dataType:"json",
			success:function(result){
				if(result.success){
					$.messager.alert("系统提示","删除成功");
					$("#project_list").datagrid("reload");
				}else{
					$.messager.alert("系统提示",result.msg);
				}
			}
		});
	}

$(function() {
	
	$("#project_list").datagrid({
		singleSelect : true,
		height : 400,
		rownumbers : true,
		striped : true,
		fitColumns : true,
		pagination : true,
		title:"项目列表",
		url : "${pageContext.request.contextPath}/project/list_t",
		idField : "id",
	
		toolbar : [
				{
					text : "添加",
					iconCls : "myicon-application_add",
					handler : function() {
						window.location.href="/project/view_create_t_project"
					}
				}
				],
			columns : [ [ {
				field : "xmmc00",
				title : "项目名称",
				align : "left",
				width : 200
			}, {
				field : "xmbh00",
				title : "项目编号",
				align : "right",
				width : 90
			}, {
				field : "createTime",
				title : "创建时间",
				align : "right",
				width : 100
			}, {
				field : "sfjc00",
				title : "是否进场",
				align : "center",
				width : 80
			}, {
				field : "industry",
				title : "行业",
				align : "center",
				width : 100
			},
			{field:"id",title:"操作",align:"center",width:120,formatter : function(value,row,index) {
				var returnValue='<a class="button red small"  href="'+ctx+'/project/view?id='+row["id"] + '">查看</a>';
				returnValue+='<a class="button red small" href="'+ctx+'/project/view_create_t_project?id=' +row["id"] + '">编辑</a>';
				returnValue+='<a class="button red small" href="#" onclick=deleteProject("'+row["id"]+'");>删除</a>';
				return returnValue;

			   }
			}
				
			] ]

		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			项目管理
		</div>
		<div class="blank10"></div>
		<table id="project_list"></table>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
