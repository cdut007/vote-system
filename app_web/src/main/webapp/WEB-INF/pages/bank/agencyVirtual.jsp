<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<sys:link easyui="true" jgrowl="true"/>
<script type="text/javascript">
$(function(){
	$("#bank-datagrid").datagrid({
		title:"代理机构虚拟号详情",
		url:ctx+"/bank/agencyVirtualQuery?t="+new Date(),
		idField:"accountNumber",
		striped:true,
		sortName:"projectInstanceNo",
		sortOrder:"desc",
		pagination:true,
		rownumbers:true,
		toolbar:"#toolbar",
		onOpen:function(){
			$(this).on("click","a.update",function(){
				var rowIndex=parseInt($(this).parents("tr:first").attr("datagrid-row-index"));
				var row=$("#bank-datagrid").datagrid("getRows")[rowIndex];
				if(row["isLogout"]){
					$.messager.alert("系统提示","账户已经释放！");
					return;
				}
				$.ajax({
					url:ctx+"/bank/updateTransactionDetail",
					type:"post",
					data:{accountNo:row["accountNumber"]},
					dataType:"json",
					success:function(data){
						$.messager.alert("系统提示",data.msg);
					}
				});
			});
		},
		columns:[[
			{title:"项目编号",field:"projectInstanceNo",width:100,sortable:true,order:"desc"},
			{title:"项目名称",field:"projectInstanceName",width:120},
			/* {title:"账号名称",field:"accountName",width:100,hidden:true}, */
			{title:"虚拟号",field:"accountNumber",width:160},
			{title:"代理机构名称",field:"organAName",width:100},
			{title:"账号类型",field:"accountType",width:80,align:"center",formatter : function(value, row, index) {
				if("A" == value){
					return "企业账号";
				}else if("B" == value){
					return "标书账号";
				}else if("C" == value){
					return "标书费用";
				}
			}},
			{title:"主账号",field:"mainAccountNo",width:100,hidden:true},
			{title:"账号别名",field:"aliasAccountName",width:100},
			{title:"生成时间",field:"createTime",width:100},
			{title:"账户状态",field:"isLogout",align:"center",width:100,formatter:function(value,row,index){
				if(value!=null&&value==true){
					return "释放";
				}else{
					return "正常";
				}
			}},
			{title:"操作",field:"opt",formatter:function(value,rowData,rowIndex){
				return "<a class=\"button red small update\">更新交易明细</a>";
			}}
		]]
		
	});
	
	$("#sousuo").click(function(){
			var start = $('#startDate').datebox('getValue').replace(/[^\d]/g,"");
			var end = $('#endDate').datebox('getValue').replace(/[^\d]/g,"");
			var transactionType=$('#transactionType').val();
			$("#bank-datagrid").datagrid("reload",{"startDate":start,"endDate":end,"transactionType":transactionType});
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
				企业账户管理
				<code>&gt;</code>
				代理机构详情查询
		</div>
	</div>
	<div class="block ">
	<table id="bank-datagrid"></table>
	</div>
	<div class="blank10"></div>
	<%-- <jsp:include page="/common/bottom.jsp"/> --%>
    
  </body>
</html>
