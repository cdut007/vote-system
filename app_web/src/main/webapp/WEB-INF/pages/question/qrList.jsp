<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script type="text/javascript">
	$(function() {
		$("#itemList-datagrid").datagrid({
			/* title : "澄清确认情况", */
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			url : "${pageContext.request.contextPath}/question/qrListData?projectItemId=${projectItemId}",
			columns : [ [ {
				field : "projectInstance.project.organ.ztmc00",
				title : "招标人",
				width : 80
			}, {
				field : "organ.ztmc00",
				title : "投标单位",
				width : 60
			}, {
				field : "reconSignatureDataId",
				title : "是否确认",
				width : 60,
				formatter : function(value, rowData) {
					if (value == null || $.trim(value) == '') {
						return "未确认";
					} else {
						return "已确认";
					}
				}
			} ] ]
		});
	});
</script>
<table id="itemList-datagrid"></table>








<!-- <table class="easyui-datagrid">
	<thead>
		<tr>
			<th>所属招标项目</th>
			<th>所属标段</th>
			<th>投标单位</th>
			<th>是否确认</th>
		</tr>
    </thead>
    <tbody>
		<tr>
			<td>001</td><td>name1</td><td>2323</td>
		</tr>
		<tr>
			<td>002</td><td>name2</td><td>4612</td>
		</tr>
	</tbody>

</table> -->

<%-- <table class='queryTable'>
	<c:forEach items="${list}" var="tender" varStatus="status">
	<tr>
		<th style="text-align: right;">踏勘单位名称：</th><th>${tender.organName }</th>
	</tr>
	<tr>
		<th style="text-align: right;">负责人姓名：</th><th>${tender.tkfzrName }</th>
	</tr>
	<tr>
		<th style="text-align: right;">负责人电话：</th><th>${tender.tkfzrPhone }</th>
	</tr>
	<tr>
		<th style="text-align: right;">人数：</th><th>${tender.tkrs }</th>
	</tr>
	<tr>
		<td style="text-align: right;">踏勘标段名称：</td><td>
		<c:forEach items="${tender.tenderItemList}" var="item" varStatus="status">
			${item.projectItem.bdmc00}<c:if test="${!status.last }">,</c:if>
		</c:forEach>
		</td>
	</tr>
	</c:forEach>
</table> --%>
			