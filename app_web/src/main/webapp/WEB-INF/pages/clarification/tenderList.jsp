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
<script>
	function bindFormEvent() {
		$("#zbplanBox").find(".registerform").Validform({
			ajaxPost : true,
			callback : function(data) {
				if (data.success) {
					alert(data.msg);
				}
			},
			tiptype : function(msg, o, cssctl) {
				if (!o.obj.is("form")) {
					var objtip = o.obj.parents("td").next().find(".Validform_checktip");
					cssctl(objtip, o.type);
					objtip.text(msg);
					var infoObj = o.obj.parents("td").next().find(".infostyle");
					if (o.type == 2) {
						infoObj.fadeOut(200);
					} else {
						if (infoObj.is(":visible")) {
							return;
						}
						var left = o.obj.offset().left, top = o.obj.offset().top;
						infoObj.css({
							left : left + 170,
							top : top - 45
						}).show().animate({
							top : top - 35
						}, 200);
					}
				}
			}
		});
	}

	function zb_plan(id){
		$("#overlay").css({ display: "block", width:$(document).width(),height: $(document).height()});
		$('#zbplanBox').show().load("${pageContext.request.contextPath}/projectPlan/form?projectInstanceId="+id, {
				date : new Date()
			}, function() {
				bindFormEvent();
			});
	}
	function cq_detail(id,tenderId){
		window.location.href="${pageContext.request.contextPath}/clarification/list?projectInstanceId="+id+"&tenderId="+tenderId;
	}
	
	$(function(){
		$("#cqtable-datagrid").datagrid(
					{
						singleSelect : true,
						rownumbers : true,
						fitColumns : true,
						striped : true,
						pagination : true,
						title : "招标项目计划",
						url : "${pageContext.request.contextPath}/projectItemList",
						idField : "id",

						columns : [ [ 
							{
							field : "organName",
							title : "投标单位名称",
							align : "left"/*,width:36*/
						}, {
							field : "projectInstanceName",
							title : "投标项目名称",
							align : "left",
							width:200
						}, {
							field : "id",
							title : "操作",
							align : "left"/*,width:2000*/,
							formatter:function(value,rowData){
								return "<input type='button' class='button red small' onclick='cq_detail(\""+rowData.projectInstanceId+"\",\""+value+"\")' value='澄清'/>";
							}
						}
						] ]
					});
	});
</script>

</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标列表
		</div>
	</div>
	<div class="block">
				<table id="cqtable-datagrid"></table>
	</div>
</body>
</html>
