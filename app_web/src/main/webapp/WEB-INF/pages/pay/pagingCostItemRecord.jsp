<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true"/>
<script type="text/javascript">
$(function(){
	$("#costItemRecord-datagrid").datagrid({
		title : "费用明细",
		idField : "payItemRecordId",
		fitColumns : true,
		singleSelect:true,
		striped : true,
		rownumbers:true,
		pagination:true,
		height : 400,
		url : ctx + "/pay/pagingCostItemRecordData",
		toolbar:[],
		onOpen:function(){
			/* $(this).on("click","a.detail",function(){
				var index=$(this).parents("tr.datagrid-row:first").attr("datagrid-row-index");
				var rows=$("#costItemRecord-datagrid").datagrid("getRows");
				detailCostItemRecord(rows[index].payItemRecordId);
			}); */
		},
		columns : [[
			{title:"费用名称",field:"itemName",width:300},
			{title:"交易类型",field:"costType",width:80,align:"center"},
			{title:"交易对象",field:"targetOrganName",width:150},
			{title:"交易方式",field:"payType",align:"center",width:100},
			{title:"费用金额",field:"totalPrice",width:100,align:"right"},
			{title:"交易时间",field:"payDate",width:100}/* ,
			{title:"操作",field:"opt",width:100,formatter:function(value, row, index) {
				return "<a class=\"button orange small detail\">详情</a>";
			}} */
		]]
	});
	//搜索栏
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>");
	$("#costItemRecord-datagrid").datagrid("getPanel").find(".datagrid-toolbar").prepend($searchForm);
	$searchForm.append("开始时间:<input name='minDate' class='inputxt Wdate'/>");
	$searchForm.append("&nbsp;&nbsp;结束时间:<input name='maxDate' class='inputxt Wdate'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#costItemRecord-datagrid").datagrid("options").queryParams;
	$searchForm.on("blur",":input:not(.Wdate)",function(){
		queryParams[this.name]=this.value;
	}).on("focus",".Wdate",function(){
		WdatePicker({
			dateFmt:"yyyy-MM-dd",
			minDate:this.name=="minDate"?undefined:($(".Wdate[name='minDate']").val()==""?undefined:$(".Wdate[name='minDate']").val()),
			maxDate:this.name=="maxDate"?undefined:($(".Wdate[name='maxDate']").val()==""?undefined:$(".Wdate[name='maxDate']").val()),
			onpicked:function(){
				queryParams[this.name]=this.value;
			}
		});
	}).on("keydown",":input",function(){
		if(event.keyCode==13){
			$(this).blur();
			$("#costItemRecord-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#costItemRecord-datagrid").datagrid('reload');
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<!--center start  -->
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				账户管理
				<code>&gt;</code>
				费用管理
			</div>
			<div class="blank10"></div>
			<div>
				<span><a href="${pageContext.request.contextPath}/notice/processNoticeList" title="点击查看"> 未读消息 （<span style="color: red;">${fn:length(noticeService.processNotice()) }</span>） 个
				</a></span>
			</div>
			<table id="costItemRecord-datagrid"></table>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>