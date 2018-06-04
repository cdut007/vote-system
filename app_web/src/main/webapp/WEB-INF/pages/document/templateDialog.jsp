<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<table id="template-datagrid" class="easyui-datagird" style="height:100%;"></table>
<script type="text/javascript">
	$("#template-datagrid").datagrid({
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		striped : true,
		pagination : true,
		/* title : "模板列表", */
		region : "center",
		url : ctx+"/document/pagingTemplateData",
		idField : "id",
		columns : [ [ {
			field : "name",
			title : "模板名称",
			align : "left"/*,width:1*/
		}, {
			hidden : false,
			field : "author.userName",
			title : "创建人",
			align : "center"/*,width:510*/
		}, {
			hidden : false,
			field : "description",
			title : "模板描述",
			align : "left",
			width : 510
		}, {
			hidden : false,
			field : "createTime",
			title : "创建时间",
			align : "center"/*,width:510*/
		} ] ]
	});
</script>