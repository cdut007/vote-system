<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标人/招标代理机构电子招标业绩表单
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
		title:"新增招标人/招标代理机构电子招标业绩",
		url:"${pageContext.request.contextPath}/t_yj_zbdl/addOrMod",
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_yj_zbdl/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_yj_zbdl_list").submit();
				}
			});
		}
	});
}
function edit(){
	var inputs = $(":input[name='t_yj_zbdl_id']:checked");
	if (inputs.length != 1) {
		alertMsg("请选择一条记录!");
		return;
	}
	var $dialog=addFormDialog({
		title:"修改招标人/招标代理机构电子招标业绩",
		url:"${pageContext.request.contextPath}/t_yj_zbdl/addOrMod?id="+inputs[0].value.split(":")[0],
		handler:function(){
			ajax({
				url:"${pageContext.request.contextPath}/t_yj_zbdl/saveOrUpdate",
				form:$dialog.find("form:first"),
				success:function(data){
					$dialog.dialog("destroy");
					$("#t_yj_zbdl_list").submit();
				}
			});
		}
	});

}
function del(){
	var inputs = $(":input[name='t_yj_zbdl_id']:checked");
	if (inputs.length == 0) {
		alertMsg("请选择要删除的记录!");
		return;
	}
	ajax({
		url:"${pageContext.request.contextPath}/t_yj_zbdl/del",
		data:$("#t_yj_zbdl_list").serialize(),
		success:function(data){
			$("#t_yj_zbdl_list").submit();
		}
	});
}
</script>
</head>
<body>
	<div class="right_top_div">当前位置: 招标人/招标代理机构电子招标业绩管理 &gt; 招标人/招标代理机构电子招标业绩列表</div>
	<form:form id="t_yj_zbdl_list" action="${pageContext.request.contextPath}/t_yj_zbdl/list" method="post" commandName="t_yj_zbdl">
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
						<th width="20px"><input type="checkbox" />
						<th>招标人/招标代理机构代码  </th>
						<th>招标项目编号 </th>
						<th>招标项目名称</th>
						<th>招标人代码</th>
						<th>招标人名称</th>
						<th>招标项目合同总金额</th>
						<th>招标项目代理收费金额</th>
						<th>金额币种代码</th>
						<th>金额单位</th>
						<th>招标项目合同签署时间</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="t_yj_zbdl_item" varStatus="status">
					<tr>
						<th>${(page.page-1)*page.pageSize+status.count}</th>
						<td><input name="t_yj_zbdl_id" type="checkbox" value="${t_yj_zbdl_item.id }" /></td>
						<td>${t_yj_zbdl_item.ztdm00}</td>
						<td>${t_yj_zbdl_item.zbxmbh}</td>
						<td>${t_yj_zbdl_item.zbxmmc}</td>
						<td>${t_yj_zbdl_item.zbrdm0}</td>
						<td>${t_yj_zbdl_item.zbrmc0}</td>
						<td>${t_yj_zbdl_item.zbxmje}</td>
						<td>${t_yj_zbdl_item.zbdlje}</td>
						<td>${t_yj_zbdl_item.jebzdm}</td>
						<td>${t_yj_zbdl_item.jedw00}</td>
						<td>${t_yj_zbdl_item.htqssj}</td>
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
