<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:include page="/common/link.jsp" />
<head>
<sys:link easyui="true" jgrowl="true" plupload="true"/>
<script type="text/javascript">
	$(function(){
		$(function() {
			
			$("#evaluationList").datagrid({
				
				title : "评标报告",
				height : 400,
				singleSelect : true,
				rownumbers : true,
				fitColumns:true,				
				pagination : true,
				idField : "id",
				striped : true,
				animate : false,
				url : ctx + "/evaluation/listData",
				toolbar:[
					{
					
					}
				
				],
				columns : [ [
				    {field : "zbxmmc",title:"项目名称",width:220},
				    {field : "bdmc00",title : "标段",width : 220},
				    {field : "organTName",title : "项目负责人",width : 180},
				    {field : "signDate",title : "评标报告结束时间",width : 180},
					{field : "opt",title : "操作",width:80,formatter : function(value,rowData,rowIndex) {
						return "<a class='button red small'>预览</a>";
					}}
				] ]
			
			});
			$(this).on("click","a.small",function(){
				var rowData=$("#evaluationList").datagrid("getSelected");
				var id=rowData.id;
				window.location="${pageContext.request.contextPath}/evaluation/evaluationReportPreview_first?id="+id;
			});
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
				评标报告
			</div>
			<div class="block">
				<table id="evaluationList"></table>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>