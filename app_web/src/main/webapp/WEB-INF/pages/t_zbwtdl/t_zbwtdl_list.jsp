<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标委托代理表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">
function add(){
	var $dialog=addFormDialog({
		title:"新增招标委托代理",
		url:"${pageContext.request.contextPath}/t_zbwtdl/addOrMod",
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_zbwtdl/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_zbwtdl_list").submit();
				}
			});
		}
	});
}
function edit(){
	var inputs = $(":input[name='t_zbwtdl_id']:checked");
	if (inputs.length != 1) {
		alertMsg("请选择一条记录!");
		return;
	}
	var $dialog=addFormDialog({
		title:"修改招标委托代理",
		url:"${pageContext.request.contextPath}/t_zbwtdl/addOrMod?id="+inputs[0].value.split(":")[0],
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_zbwtdl/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_zbwtdl_list").submit();
				}
			});
		}
	});

}
function del(){
	var inputs = $(":input[name='t_zbwtdl_id']:checked");
	if (inputs.length == 0) {
		alertMsg("请选择要删除的记录!");
		return;
	}
	ajax({
		url:"${pageContext.request.contextPath}/t_zbwtdl/del",
		data:$("#t_zbwtdl_list").serialize(),
		success:function(data){
			$("#t_zbwtdl_list").submit();
		}
	});
}
</script>
</head>
<body>
	<div class="right_top_div">当前位置: 招标委托代理管理 &gt; 招标委托代理列表</div>
	<form:form id="t_zbwtdl_list" action="${pageContext.request.contextPath}/t_zbwtdl/list" method="post" commandName="t_zbwtdl">
		<table class="seachparam">
			<tr>
			</tr>
		</table>
		<div class="mytable-border">
			<div class="panel-header">
				<div class="panel-title">周报面板</div>
				<div class="panel-tool"></div>
			</div>
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th width="20px"><input type="checkbox" /></th>
						<th>招标项目编号</th>
						<th>招标代理机构代码</th>
						<th>招标代理机构名称</th>
						<th>招标代理资格分类代码</th>
						<th>招标代理资格分级代码</th>
						<th>招标代理内容与范围</th>
						<th>招标代理权限</th>
						<th>招标代理机构项目负责人信息</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="t_zbwtdl_item" varStatus="status">
					<tr>
						<th>${(page.page-1)*page.pageSize+status.count}</th>
						<td><input name="t_zbwtdl_id" type="checkbox" value="${t_zbwtdl_item.id }" /></td>
						<td>${t_zbwtdl_item.zbxmbh}</td>
						<td>${t_zbwtdl_item.dljgdm}</td>
						<td>${t_zbwtdl_item.dljgmc}</td>
						<td>${t_zbwtdl_item.dlzgfl}</td>
						<td>${t_zbwtdl_item.dlzgfj}</td>
						<td>${t_zbwtdl_item.dlnrfw}</td>
						<td>${t_zbwtdl_item.zbdlqx}</td>
						<td>${t_zbwtdl_item.dlfzr0}</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(page.rows)+1}" end="${page.pageSize}" varStatus="status">
					<tr>
						<th>${fn:length(page.rows)+(page.page-1)*page.pageSize+status.count}</th>
						<td><input type="checkbox" disabled="disabled"/></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div id="operation">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add();">新增</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="edit();">修改</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del();">删除</a>
		</div>
	</form:form>
</body>
</html>
