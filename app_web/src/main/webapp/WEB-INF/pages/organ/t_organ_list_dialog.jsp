<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招投标主体基本信息管理表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript">

function selectDljg(){
	if(event.srcElement.tagName=="TD"){
       objrow=event.srcElement.parentNode;
	   objrad=objrow.cells[0].childNodes[0];//若嵌套结构有变化此处需要调整
	  objrad.checked=true;
    }
}

function queryTBOrgan_dialog(){
	$('#t_organ_list_dialog').submit();
}
</script>

</head>
<body>
	<form:form id="t_organ_list_dialog" action="${pageContext.request.contextPath}/t_organ/list_dialog" method="post" commandName="t_organ">
		<table class="seachparam">
			<tr>
				<th align="right">代理机构名称</th>
				<td>
				<form:hidden path="ztlx00" />
				<form:input path="ztmc00" title="代理机构名称"/> </td>
				<td align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="queryTBOrgan_dialog();">查 询</a>
				</td>
				<td width="50px"></td>
			</tr>
		</table>
		<div class="mytable-border">
			<div class="panel-header">
				<div class="panel-title">招标代理机构列表</div>
				<div class="panel-tool"></div>
			</div>
			<table class="mytable">
				<thead>
					<tr>
						<th width="20px"></th>
						<th>主体代码（组织机构代码）</th>
						<th>主体名称</th>
						<th>负责人</th>
						<th>单位性质</th>
						<th>行业代码</th>
						<th>CA证书编号</th>
						<!-- <th>资信等级</th> -->
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.rows}" var="t_organ_item" varStatus="status">
					<tr onclick="selectDljg()">
						<td><input name="selValue" type="radio" value="${t_organ_item.id}@${t_organ_item.ztdm00}" /></td>
						<td>${t_organ_item.ztdm00}</td>
						<td>${t_organ_item.ztmc00}</td>
						<td>${t_organ_item.fzr000}</td>
						<td>${t_organ_item.dwxz00}</td>
						<td>${t_organ_item.industry}</td>
						<td>${t_organ_item.cazsbh}</td>
						<%-- <td>${t_organ_item.zxdj00}</td> --%>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(page.rows)+1}" end="${page.pageSize}" varStatus="status">
					<tr>
						<td><input type="radio" disabled="disabled"/></td>
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

	</form:form>
</body>
</html>
