<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:项目表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<%@include file="/common/link.jsp"%>

<script type="text/javascript">

function queryOrganPage() {
	var ztmc00 = $('#ztmc00').val();
	var organType = $('#organType').val()=='-1' ? '':$('#organType').val();
	//alert(organType);
	$("#organType_list").datagrid("reload", {
		ztmc00 : ztmc00,
		organType : organType
	});
}

/* $(".change_type").click(function(value,rowData){
	alert(value);
	alert(rowData);
});
$("a[name='change_type']").click(function(value,rowData){
	alert(value);
	alert(rowData);
}); */
function change_type(organId,value){
	//alert(organId);
	//alert(value);
	if(value=='0'){
		value='1';
	}else{
		value='0';
	}
	$.ajax({
		url : "${pageContext.request.contextPath}/organ/changeOrganType",
		type : "post",
		beforeSend : function() {
			$.messager.progress({
				title : "系统提示",
				msg : "请稍后..."
			});
		},
		data : {organId:organId, organType:value},
		dataType : "json",
		success : function(data) {
			if(data.success){
				$.messager.alert("系统提示",data.msg);
				$("#organType_list").datagrid("reload");
			}
		},
		complete : function() {
			$.messager.progress("close");
		}
	});

}

$(function() {
	
	var type = [
		{typeId : '0', name : '禁用'},
		{typeId : '1', name : '正常'}
	];
		
	/* function queryOrganPage() {
		alert();
		var ztmc00 = $('#ztmc00').val();
		var organType = $('#organType').val()=='---==请选择==---' ? '':($('#organType').val()=='禁用' ? '0' : '1');
		alert(ztmc00);
		alert(organType);
		return;
		$("#organType_list").datagrid("reload", {
			ztmc00 : ztmc00,
			organType : organType
		});
	} */
	
	$("#organType_list").datagrid({
		singleSelect : true,
		rownumbers : true,
		striped : true,
		height : 400,
		fitColumns : true,
		pagination : true,
		title:"机构状态列表",
		url : "${pageContext.request.contextPath}/organ/checkOrganType",
		//queryParams : {ztmc00,organType},
		idField : "id",

		columns : [ [ {
				field : "ztdm00",
				title : "主体代码",
				width : 200
			}, {
				field : "ztmc00",
				title : "主体名称",
				width : 400
			}, {
				field : "organType",
				title : "机构状态",
				width : 100,
				align : 'center',
				formatter:function(value, row, index) {
					if(value == '1'){
						return "<a class='change_type button red small' value='1' onclick='change_type(\""+row.id+"\","+value+")'>正常</a>";
					}else{
						return "<a class='change_type button grey small' value='0' onclick='change_type(\""+row.id+"\","+value+")'>禁用</a>";
					}
				}
			} ] ]
	});
});

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			机构状态管理
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<table>
				    <tr>
						<td>机构名称:</td>
						<td> 
							<input id="ztmc00" name="ztmc00" class="inputxt" />
						</td>
						<td>机构状态:</td>
						<td>
							<select id="organType" name="organType">
								<option value="-1">---==请选择==---</option>
								<option value="1">正常</option>
								<option value="0">禁用</option>
							</select>
						</td>
						<td><a class="button red" onclick="queryOrganPage()">查 询</a></td>
					</tr>
				</table> 
				<div class="blank10"></div>
				<table id="organType_list"></table>
			</div>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
