<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
	$(function() {
		$("#projectList-datagrid").datagrid({
			title : "待归档项目",
			height : 400,
			//sortName:"bdbh00",
			//sortOrder:"desc",
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			idField : "id",
			striped : true,
			animate : false,
			url : ctx+"/projectInstance/stayArchiveList",
			rowStyler: function(index,row){
				if (row.archiveStatus=="1"){
					return 'background-color:#6293BB;color:#fff;';
				}
			},
			columns : [ [
				/* {field : "organProjectCode",title : "招标项目编号",width : 100}, */
				{field : "bdbh00",title : "标段编号",width:100},
				{field : "projectInstanceName",title : "项目名称",width:170},
				{field : "bdmc00",title : "标段名称",width:140},
				{field : "organTName",title : "招标人",width : 160},
				{field : "createTime",title : "添加时间",width : 120},
				{field : "archiveStatus",title : "是否归档",align:"center",sortable:true,sort:"asc",width :80,formatter:function(value){
					return value=="0"?"未归档":"已归档";
				}},
				/* {field : "projectInstance.zbfs00",title : "招标方式",width : 60},
				{field : "projectInstance.zbzzxs",title : "招标组织形式",width : 100}, */
				/* {field : "projectInstance.lxsj00",title : "立项时间",width : 100}, */
				{field : "opt",title : "操作",width:80,formatter : function(value,rowData,rowIndex) {
					return "<a class='button red small' href=\""+ctx+"/projectInstance/archiveForm?id=" + rowData["id"] + "\" target=\"_blank\">查看</a>";
				}} 
			] ],
			/*loadFilter: function(data){
				//console.log(data);
				data.total = data.totalElements;
				data.row = data.size;
				data.rows = data.content;
				return data;
			}*/
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				待归档项目
			</div>
			<div class="block">
				<table id="projectList-datagrid"></table>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
