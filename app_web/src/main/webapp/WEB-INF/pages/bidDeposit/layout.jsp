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
			投标保证金管理
		</div>
	</div>
	<div class="blank10"></div>
	<div class="block">
			<table id="biddeposit-datagrid"></table>
	</div>
	<div id="detail"></div>
</body>
<script type="text/javascript">
	function detail(id){
		$("#detail").window({
			title:"投标保证金明细",
			href:"${pageContext.request.contextPath}/bidDeposit/detail?id="+id,
			width:1100,
			height:600,
			modal:true
		});
	}
	$('#biddeposit-datagrid').datagrid({
		title:"投标保证金支付记录",
		height : 400,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		fitColumns : true,
		idField : "id",
		striped : true,
		pageSize:10,
		animate : false,
		url : "${pageContext.request.contextPath}/bidDeposit/list",
		columns : [ [ {
			field : "tbrdm0",
			title : "投标人"
		}, {
			field : "bzje0",
			title : "保证金金额"
		}, {
			field : "zfxs00",
			title : "支付形式",
			width : 30
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
						return "<input type='button' class='button red small' onclick='detail(\""+value+"\")' value='明细'/>";
			}
		}
		 ] ]
	});
</script>
</html>
