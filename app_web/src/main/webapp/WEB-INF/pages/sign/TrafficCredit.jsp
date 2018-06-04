<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@ page language="java"%> 
<%@ page contentType="text/html; charset=utf-8"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%>  
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" ca="true" jgrowl="true" plupload="true"/>
<script type='text/javascript' src='/resources/jquery-plugins/jquery.im.js'></script>
<script src="/resources/designer/json2.js" type="text/javascript"></script>

	
<script type="text/javascript">
$(function() {
	
	dg= $("#bidFile-datagird").datagrid({
		title:"信用等级表",
		rownumbers : true,
		striped : true,
		url:ctx+"/bidFile/creditRating",
		queryParams : {
			expertApplyId : "${processBusinessKey}",
			projectItemId : "${projectItemId}"
		},
		idField:"id",				
		toolbar:[
			
		],
		columns:[[
			{field : 'bdbh00',width:'10%',title : "标段编号"},
			{field : 'projectItemName',width:'25%',title : "标段名称"}, 
			{field : 'organBName',title : "投标单位",width:'25%',align : "center"}, 
			{field : 'qualityGrade',title : "信用等级",width : '40%', formatter : function(value, row, index){
				return 	"<select id='"+row['id']+"' >"+
				"<option value='AA'  >AA</option>"+
				"<option value='A'  >A</option>"+
				"<option value='B' selected='selected' >B</option>"+
				"<option value='C'  >C</option>"+
				"</select>";
			}},
		]]
	});
});

</script>

<style type="text/css">
.centerss {
 width: 1000px;
 margin: auto;
 text-align: center;
 line-height:40px;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	
	<div class="block">
		
		<form action="${pageContext.request.contextPath}/workflow/completeForm" id="form2">
			<input type="hidden" name="taskId" value="${taskId}" /> 
			<input type="hidden" name="message" value="${message}" />
		</form>
		<div class="blank10"></div>
		
		<table id="bidFile-datagird"></table>
		<div class="blank10"></div>
		
		<div style="text-align:right;padding-top:10px;padding-bottom:10px;padding-right:5px;z-index:998;">
			<form id="workflowForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
				<input type="hidden" name="taskId" value="${taskId}" /> 	
				<a class="button red" id="complete">确认提交</a>
			</form>
		</div>
	
	</div>
	<jsp:include page="/common/bottom.jsp"/>

<script>


$("#complete").click(function() {
	var revise_list = Array();
	var rows = $("#bidFile-datagird").datagrid("getRows");//获取当前的数据行
	$(rows).each(function(){
			this['qualityGrade']=$('#'+this["id"]).val();
				var data = {
						id: this["id"],
						qualityGrade: this["qualityGrade"],
						tenderItemId: this["tenderItemId"],
						organBName: this["organBName"],
						expertApplyId: "${processBusinessKey}",
						projectItemId: this["projectItemId"]
				}
				revise_list.push(data);
	});
	$.ajax({
			url : "${pageContext.request.contextPath}/bidFile/savecreditRating",
			type : "post",
			data : {
				"data" : JSON.stringify(revise_list)
			},
			dataType : "json",
			beforeSend : function() {
				$("#complete").prop("disabled", true);
			},
			complete : function() {

			},
			success : function(data) {
				$.messager.alert("系统提示", data.msg);
				if(data.success){
					$("#workflowForm").submit();
				}
				$("#bidFile-datagird").datagrid("reload");
					
		}
	});
});

</script>
</script>
</body>
</html>
