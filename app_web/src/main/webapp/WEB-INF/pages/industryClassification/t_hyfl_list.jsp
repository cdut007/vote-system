<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:国民经济行业分类代码表表单
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
		title:"新增国民经济行业分类代码表",
		url:"${pageContext.request.contextPath}/t_hyfl/addOrMod",
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_hyfl/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_hyfl_list").submit();
				}
			});
		}
	});
}
function edit(){
	var inputs = $(":input[name='t_hyfl_id']:checked");
	if (inputs.length != 1) {
		alertMsg("请选择一条记录!");
		return;
	}
	var $dialog=addFormDialog({
		title:"修改国民经济行业分类代码表",
		url:"${pageContext.request.contextPath}/t_hyfl/addOrMod?id="+inputs[0].value.split(":")[0],
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_hyfl/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_hyfl_list").submit();
				}
			});
		}
	});

}
function del(){
	var inputs = $(":input[name='t_hyfl_id']:checked");
	if (inputs.length == 0) {
		alertMsg("请选择要删除的记录!");
		return;
	}
	ajax({
		url:"${pageContext.request.contextPath}/t_hyfl/del",
		data:$("#t_hyfl_list").serialize(),
		success:function(data){
			$("#t_hyfl_list").submit();
		}
	});
}
</script>
</head>
<body>
	<div class="right_top_div">当前位置: 国民经济行业分类代码表管理 &gt; 国民经济行业分类代码表列表</div>
	<form:form id="t_hyfl_list" action="${pageContext.request.contextPath}/t_hyfl/list" method="post" commandName="t_hyfl">
		<div class="mytable-border">
			<div class="panel-header">
				<div class="panel-title">行业分类</div>
				<div class="panel-tool"></div>
			</div>
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th width="20px"><input type="checkbox" /></th>
						<th>字母码</th>
						<th>大类</th>
						<th>中类</th>
						<th>小类</th>
						<th>名称</th>
						<th>描述说明</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="t_hyfl_item" varStatus="status">
					<tr>
						<th>${(page.page-1)*page.pageSize+status.count}</th>
						<td><input name="t_hyfl_id" type="checkbox" value="${t_hyfl_item.id }" /></td>
						<td>${t_hyfl_item.zmm000}</td>
						<td>${t_hyfl_item.dlei00}</td>
						<td>${t_hyfl_item.zlei00}</td>
						<td>${t_hyfl_item.xlei00}</td>
						<td>${t_hyfl_item.text}</td>
						<td>${t_hyfl_item.description}</td>
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
