<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form:form action="${pageContext.request.contextPath}/dictionary/createOrUpdateDictionary" method="post" modelAttribute="dictionary">
	<form:hidden path="id" />
	<form:hidden path="typeCode" />
	<form:hidden path="typeName" />
	<table>
		<tr>
			<th>字典类型名称:</th>
			<td>${dictionary.typeName}</td>
		</tr>
		<tr>
			<th>字典项名称:</th>
			<td><form:input path="itemName" cssClass="inputxt easyui-validatebox" data-options="required:true" cssStyle="width: 200px" /></td>
		</tr>
		<tr>
			<th>字典项编码:</th>
			<td><form:input path="itemCode" cssClass="inputxt easyui-validatebox" data-options="required:true" cssStyle="width: 200px" /></td>
		</tr>
		<tr>
			<th>父节点:</th>
			<td><form:input path="parentId" cssClass="inputxt easyui-combotree" cssStyle="width: 200px" data-options="url : '${pageContext.request.contextPath}/dictionary/dynamicDictionaryTree?typeCode=${dictionary.typeCode}&fetchId=${dictionary.parentId}&t=' + new Date().getTime(),required:true"/></td>
		</tr>
		<tr>
			<th>排序号:</th>
			<td><form:input path="orderNo" cssClass="inputxt easyui-numberbox" cssStyle="width: 200px"/></td>
		</tr>
		<tr>
			<th>字典描述:</th>
			<td><form:textarea path="description" cssStyle="width:200px;height:80px;" /></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
	/* $(function() {
		var $combotree = $("[name='parentId']").combotree({
			value : "${dictionary.parentId}",
		});
		$combotree.combotree("tree").tree({
			lines : true,
			url : '${pageContext.request.contextPath}/dictionary/dictionaryTree?typeCode=${dictionary.typeCode}&t=' + new Date().getTime(),
			onLoadSuccess : function(node, data) {
				if ("${dictionary.id}" != "") {
					var node = $(this).tree("find", "${dictionary.id}");
					$(this).tree("remove", node.target);
				}
				$combotree.combotree("setValue", '${dictionary.parentId}');
			}
		});
	}); */
</script>
