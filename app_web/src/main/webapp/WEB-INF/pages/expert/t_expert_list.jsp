<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:专家表单
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
		title:"新增专家",
		url:"${pageContext.request.contextPath}/t_expert/addOrMod",
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_expert/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_expert_list").submit();
				}
			});
		}
	});
}
function edit(){
	var inputs = $(":input[name='t_expert_id']:checked");
	if (inputs.length != 1) {
		alertMsg("请选择一条记录!");
		return;
	}
	var $dialog=addFormDialog({
		title:"修改专家",
		url:"${pageContext.request.contextPath}/t_expert/addOrMod?id="+inputs[0].value.split(":")[0],
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_expert/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_expert_list").submit();
				}
			});
		}
	});

}
function del(){
	var inputs = $(":input[name='t_expert_id']:checked");
	if (inputs.length == 0) {
		alertMsg("请选择要删除的记录!");
		return;
	}
	ajax({
		url:"${pageContext.request.contextPath}/t_expert/del",
		data:$("#t_expert_list").serialize(),
		success:function(data){
			$("#t_expert_list").submit();
		}
	});
}
</script>
</head>
<body>
	<div class="right_top_div">当前位置: 专家管理 &gt; 专家列表</div>
	<form:form id="t_expert_list" action="${pageContext.request.contextPath}/t_expert/list" method="post" commandName="t_expert">
		<table class="seachparam">
			<tr>
				<td>姓名:<form:input path="userName"/></td>
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
						<th width="20px"><input type="checkbox" />
						<th>姓名</th>
						<th>性别</th>
						<th>身份证件类型</th>
						<th>身份证件号码</th>
						<th>出生年月</th>
						<th>行政区划</th>
						<th>最后毕业院校</th>
						<th>最高学历</th>
						<th>联系电话</th>
						<th>通讯地址</th>
						<th>邮政编码</th>
						<th>单位名称</th>
						<th>是否在职</th>
						<th>职务</th>
						<th>工作简历</th>
						<th>专业分类</th>
						<th>从业年限</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="t_expert_item" varStatus="status">
					<tr>
						<th>${(page.page-1)*page.pageSize+status.count}</th>
						<td><input name="t_expert_id" type="checkbox" value="${t_expert_item.id }" /></td>
						<td>${t_expert_item.userName}</td>
						<td>${t_expert_item.gender}</td>
						<td>${t_expert_item.identityType}</td>
						<td>${t_expert_item.identityNo}</td>
						<td>${t_expert_item.csny00}</td>
						<td>${t_expert_item.region}</td>
						<td>${t_expert_item.graduate}</td>
						<td>${t_expert_item.zgxl00}</td>
						<td>${t_expert_item.phone}</td>
						<td>${t_expert_item.address}</td>
						<td>${t_expert_item.zipCode}</td>
						<td>${t_expert_item.dwmc00}</td>
						<td>${t_expert_item.isJob}</td>
						<td>${t_expert_item.zhiwu0}</td>
						<td>${t_expert_item.gzjl00}</td>
						<td>${t_expert_item.zyfl00}</td>
						<td>${t_expert_item.cynx00}</td>
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
						<td></td>
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
