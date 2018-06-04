<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true"></sys:link>
<script type="text/javascript">
$(function(){
	function detailPayOrderRecord(payOrderRecordId,queryId){
		var	btns;
		if(queryId==null){
			btns=[
					{text:"关闭",color:"red",handler:function(){
						$("#"+id).dialog("destroy");
					}},
					{text:"付款",color:"red",handler:function(){
						var is=$("#ss").html();
						window.location=ctx+"/unionpay/paySingle/"+is;
					}},
					{text:"删除",color:"orange",handler:function(){
						//$("#"+id).dialog("destroy");
						if($("[name='id']:checked").is(':checked')) {
						    var deleteId=$("[name='id']:checked").map(function(){return "ids="+$(this).val();}).get().join("&");
							//alert(deleteId);
							if(confirm("确定要删除记录吗？")){
								$.ajax({
									url:ctx+"/pay/deletePayItemRecordAll",
									type:"post",
									data:deleteId,
									dataType:"json",
									success:function(result){
										alert(result.msg);
										$("#"+id).dialog().reload;
										$("#payOrderRecord-datagrid").datagrid('reload');
									}
								});
							}
						}else{
							alert("请选择一条数据！");
						}
					}},
				];
		}else{
			btns=[
				{text:"关闭",color:"red",handler:function(){
						$("#"+id).dialog("destroy");
				}}
			];
		}
	    //alert(payOrderRecordId);
		var id=new Date().getTime();
		$("<div id='"+id+"' style='padding:10px;'></div>").appendTo($("body")).dialog({
			title:"订单详情",
			href:ctx+"/pay/payOrderRecordDetail/"+payOrderRecordId,
			width:640,
			height:480,
			modal:true,
			buttons:btns
		});
	}
	$("#payOrderRecord-datagrid").datagrid({
		title : "支付订单记录",
		idField : "payOrderRecordId",
		//fitColumns : true,
		singleSelect:true,
		striped : true,
		rownumbers:true,
		pagination:true,
		height : 400,
		toolbar:[],
		url : ctx + "/pay/pagingPayOrderRecordData",
		onOpen:function(data){
			$(this).on("click","a.detail",function(){
				var index=$(this).parents("tr.datagrid-row:first").attr("datagrid-row-index");
				var rows=$("#payOrderRecord-datagrid").datagrid("getRows");
				//alert(rows[index].queryId);
				//alert(JSON.stringify(rows[index]));
				detailPayOrderRecord(rows[index].payOrderRecordId,rows[index].queryId);
			});
		},
		columns : [[
		    {title:"订单编号",field:"payOrderRecordId",width:150},
			{title:"支付账号",field:"bankAccountNo",width:150,align:"center"},
			/* {title:"支付金额",field:"queryId",width:100,align:"right"}, */
			{title:"支付金额",field:"totalPrice",width:100,align:"right"},
			{title:"支付时间",field:"payDate",width:100,align:"center"},
			{title:"支付方式",field:"payType",width:100,align:"center"},
			{title:"支付用户",field:"userName",align:"center",width:100},
			{title:"包含项",field:"payItemRecordCount",align:"right",width:80},
			{title:"备注",field:"remark",align:"center",width:120},
			{title:"操作",field:"opt",width:100,formatter:function(value, row, index) {
				return "<a class=\"button orange small detail\">详情</a>";
			}}
		]]
	});
	var $searchForm=$("<form class='searchForm' style='padding:5px;'></form>");
	$("#payOrderRecord-datagrid").datagrid("getPanel").find(".datagrid-toolbar").prepend($searchForm);
	$searchForm.append("开始时间:<input name='minDate' class='inputxt Wdate'/>");
	$searchForm.append("&nbsp;&nbsp;结束时间:<input name='maxDate' class='inputxt Wdate'/>");
	$searchForm.append("&nbsp;&nbsp;<a class='button searchBtn red medium' style='float:right'\">查询</a>");
	//查询事件
	var queryParams=$("#payOrderRecord-datagrid").datagrid("options").queryParams;
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
			$("#payOrderRecord-datagrid").datagrid('reload');
			return false;
		}
	}).on("click",".searchBtn",function(){
		$("#payOrderRecord-datagrid").datagrid('reload');
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
				<span><a href="${pageContext.request.contextPath}/notice/processNoticeList" title="点击查看"> 未读消息 （<span style="color: red;">${fn:length(tenderNoticeService.processNotice()) }</span>） 个
				</a></span>
			</div>
			<table id="payOrderRecord-datagrid"></table>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>