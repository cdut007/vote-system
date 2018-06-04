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
<title>标书费用管理</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.plan{
	position: absolute;
	background-color:#fff;
	z-index:1000;
	border:2px #D40000 solid;
	left:200px;
	top:200px;
	width:850px;
	height:470px;
	display:none;
}


.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 100;
	-moz-opacity: 0.2;
	opacity: .20;
	filter: alpha(opacity = 20);
}

</style>
<script>
</script>

</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			标书费用管理
		</div>
	</div>
	<div class="blank10"></div>
	<div class="block">
		<div class="fl" style="width:260px;border-right:1px solid #ccc">
			<table id="dlproject-datagrid"></table>
		</div>
		<div class="fr" style="width:738px;border-right:1px solid #ccc">
			<table id="filecost-datagrid"></table>
		</div>
	</div>
	<div id="detail"></div>
	<div id="paysure"></div>
</body>
<script type="text/javascript">
function detail(id){
	$("#detail").window({
		title:"标书费用明细",
		href:"${pageContext.request.contextPath}/fileCost/review?id="+id,
		width:1100,
		height:600,
		modal:true
	});
}

function paysure(id){
	$("#paysure").dialog({
		title:"标书费用支付确认",
		href:"${pageContext.request.contextPath}/fileCost/review?id="+id,
		width:1100,
		height:600,
		modal:true,
		onClose:function(){
			$('#filecost-datagrid').datagrid("reload");
		}
	});
}

$('#dlproject-datagrid').datagrid({
		title:"代理项目列表",
		height : 500,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		fitColumns : true,
		idField : "id",
		striped : true,
		pageSize:20,
		animate : false,
		url : "${pageContext.request.contextPath}/fileCost/projectList",
		onClickRow:function(rowIndex,rowData){
			$('#filecost-datagrid').datagrid("load",{"projectInstanceId":rowData.id});
		},
		columns : [ [ {
			hidden:true,
			field : "id",
			title : "招标项目主键"
		}, {
			field : "zbxmmc",
			title : "招标项目名称",
			width : 280
		}
		 ] ]
	});
	
	$('#filecost-datagrid').datagrid({
		title:"标书费用支付记录",
		height : 400,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		fitColumns : true,
		idField : "id",
		striped : true,
		pageSize:10,
		animate : false,
		url : "${pageContext.request.contextPath}/fileCost/list",
		columns : [ [ {
			field : "tbdwzj",
			title : "投标单位"
		}, {
			field : "zfje00",
			title : "支付金额"
		}, {
			field : "_zfqrbz_",
			title : "支付确认标志",
			width : 40
		}, {
			field : "zfsj00",
			title : "支付时间",
			width : 80
		}, {
			field : "id",
			title : "操作",
			align : "left",
			formatter:function(value,rowData){
				if(rowData.zfqrbz=="1"){ //未确认
					return "<input type='button' class='button red small' onclick='paysure(\""+value+"\")' value='支付确认'/>";
				}else{
					return "<input type='button' class='button red small' onclick='detail(\""+value+"\")' value='明细'/>";
				}
			}
		}
		 ] ]
	});
</script>
</html>
