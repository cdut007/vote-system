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
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标项目管理
			<code>&gt;</code>
			标段管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<input type="button" class="button red" value="添加标段" onclick="window.location='${pageContext.request.contextPath}/projectItem/addOrEditProjectItem?projectInstanceId=${projectInstanceId}'" /> 
				<div class="blank10"></div>
				<table id="projectItemList-datagrid"></table>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$("#projectItemList-datagrid").datagrid({
			title:"标段列表",
			height : 400,
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			idField : "id",
			striped : true,
			animate : false,
			queryParams : {
				projectInstanceId:'${projectInstanceId}'
			},
			url : "${pageContext.request.contextPath}/projectItem/indProjectItemList",
			columns : [ [ 
	            {field:"id",checkbox:true},
	  			{title:'标段名称',field:'bdmc00',width:100},
				{title:'标段内容',field:'bdnr00',width:280},
				{title:'标段类别',field:'bdfldm',align:"center",width:60},
				{title:'标段合同估价',field:'bdhtgj',align:'right',width:90},
				{title:'估价单位',field:'bdgjdw',align:'right',width:80},
				{title:'估价币种',field:'bdgjdm',align:'right',width:80},
				{title:'标书售价（元）',field:'price',align:'right',width:90},
				{field : "opt",title : "操作",formatter : function(value,row,index) {
					value=row.id;
					return "<a class='button red small' href=\"${pageContext.request.contextPath}/projectItem/addOrEditProjectItem?id="+value+"\">修改</a>"
						   +"<a class='button red small'  href=\"javascript:deleteProjectItem('"+value+"','"+row.projectInstanceId+"');\">删除</a>";
				}
			  } ] ]
		});
	});
	
	//删除标段
	function deleteProjectItem(projectItemId,projectInstanceId){
		if(confirm("您确定要删除此标段吗")){
			window.location = "${pageContext.request.contextPath}/projectItem/indDeleteProjectItem?id=" + projectItemId+"&projectInstanceId="+projectInstanceId;
		}
	}
</script>
</html>
