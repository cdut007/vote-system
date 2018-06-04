<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">
function add(){
	var $dialog=addFormDialog({
		title:"新增招标项目",
		url:"${pageContext.request.contextPath}/projectInstance/addOrMod",
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/projectInstance/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#projectInstance_list").submit();
				}
			});
		}
	});
}
function edit(){
	var inputs = $(":input[name='projectInstance_id']:checked");
	if (inputs.length != 1) {
		alertMsg("请选择一条记录!");
		return;
	}
	var $dialog=addFormDialog({
		title:"修改招标项目",
		url:"${pageContext.request.contextPath}/projectInstance/addOrMod?id="+inputs[0].value.split(":")[0],
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/projectInstance/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#projectInstance_list").submit();
				}
			});
		}
	});

}
function del(){
	var inputs = $(":input[name='projectInstance_id']:checked");
	if (inputs.length == 0) {
		alertMsg("请选择要删除的记录!");
		return;
	}
	ajax({
		url:"${pageContext.request.contextPath}/projectInstance/del",
		data:$("#projectInstance_list").serialize(),
		success:function(data){
			$("#projectInstance_list").submit();
		}
	});
}

function detail(id){
	var $dialog=addFormDialog({
		title:"招标项目详细",
		url:"${pageContext.request.contextPath}/projectInstance/detail?id="+id,
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/projectPlan/saveOrUpdate",
				form:$dialog.find("#projectPlan_form_detail"),
				success:function(data){
				}
			});
			ajax({
				url:"${pageContext.request.contextPath}/t_zbwtdl/saveOrUpdate",
				form:$dialog.find("#t_zbwtdl_form_detail"),
				success:function(data){
				}
			});
		}
	});
}
</script>
</head>
<body>
	<div class="right_top_div">当前位置: 招标项目管理 &gt; 招标项目列表</div>
	<form:form id="projectInstance_list" action="${pageContext.request.contextPath}/projectInstance/list" method="post" commandName="projectInstance">
		
		<div class="mytable-border">
			<div class="panel-header">
				<div class="panel-title">招标项目列表</div>
				<div class="panel-tool"></div>
			</div>
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th width="20px"><input type="checkbox" /></th>
						<th width="150px">招标项目编号</th>
						<th width="200px">招标项目名称</th>
						<th>招标人</th>
						<th>代理机构</th>
						<th>招标方式</th>
						<th>组织形式</th>
						<th>立项时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="projectInstance_item" varStatus="status">
					<tr>
						<th>${(page.page-1)*page.pageSize+status.count}</th>
						<td><input name="projectInstance_id" type="checkbox" value="${projectInstance_item.id }" /></td>
						<td>${projectInstance_item.zbxmbh}</td>
						<td>${projectInstance_item.zbxmmc}</td>
						<td>${projectInstance_item.zbr000}</td>
						<td>${projectInstance_item.dljgmc}</td>
						<td>${util:dictionary('ZBFS00',projectInstance_item.zbfs00)}</td>
						<td>${util:dictionary('ZBZZXS',projectInstance_item.zbzzxs)}</td>
						<td><fmt:formatDate value="${projectInstance_item.lxsj00}" type="both" dateStyle="default" timeStyle="default"/></td>
						<td><input type='button' value='招标项目详细' onclick="detail('${projectInstance_item.id }')"/></td>
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
