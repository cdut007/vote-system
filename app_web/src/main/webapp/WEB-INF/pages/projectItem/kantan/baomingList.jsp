<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#baomingList-datagrid").datagrid({
			fit : true,
			singleSelect : true,
			rownumbers : true,
			fitColumns : true,
			striped : true,
			pagination : true,
			// title : "踏勘报名查看",
			region : "center",
			url : "${pageContext.request.contextPath}/baomingListData?projectItemId=${projectItemId}",
			// url : "${pageContext.request.contextPath}/takanApplyListData",
			idField : "id",
			columns : [ [ {
				field : "projectInstance",
				title : "所属招标项目",
				align : "left"/*,width:1*/
			}, {
				field : "projectItem",
				title : "所属招标标段",
				align : "left"/*,width:1*/
			}, {
				hidden : false,
				field : "projectInstance.project.organ",
				title : "招标单位",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "tkfzrName",
				title : "负责人",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "tkfzrPhone",
				title : "联系电话",
				align : "center"/*,width:510*/
			}, {
				hidden : false,
				field : "tkrs",
				title : "踏勘人数",
				align : "center"/*,width:510*/
			} ] ],
			toolbar:[]
		});
	});
	
</script>

<table id="baomingList-datagrid" class="easyui-datagird"  style="width:550px;height:350px"></table>
