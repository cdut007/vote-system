<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>保证金划分</title>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function(){
	$("#saveBtn").click(function(){
		$("#depositPartitionForm").ajaxSubmit({
			beforeSend:function(){
				
			},
			dataType:"json",
			success:function(data){
				$.messager.alert("系统提示",data.msg);
			}
		});
	});
	$("input[name='amt']").blur(function(){
		//alert(1);
		/* var a=$("#amt").val();
		var str="";
		$("#amt").each(function(index, element){
			str += $(this).val();
   		 });
			alert(str);*/
		var sum=0;
		$("input[name='amt']").each(function(index,item){
			if($.isNumeric($(this).val())){
				var  val= parseFloat($(this).val());
				sum+=val;
			}
		}); 
		//if(sum!=$.trim($("#totalDepositedAmount").html())){
			$("#usedDepositedAmount").css("color",sum!=parseFloat($.trim($("#totalDepositedAmount").html()))?"red":"black");
		//}
		$("#usedDepositedAmount").html(sum);
		//alert(sum);
	});
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="block">
		<div id="ur_here">当前位置: 保证金划分</div>
		<div class="blank10"></div>
		<div class='tableTitle'>项目名称:${projectInstance.zbxmmc}</div>
		<form id="depositPartitionForm" action="${pageContext.request.contextPath}/depositPartition" method="post">
			<table class="mytableStyle">
				<thead>
					<tr>
						<th width='40px'>序号</th>
						<th>标段名称</th>
						<th>保证金金额</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${tenderItemList}" var="tenderItem" varStatus="status">
						<tr>
							<th style='text-align: center'>${status.count}</th>
							<td>${tenderItem.projectItemName}</td>
							<td style="width:100px"><input type="hidden" value="${tenderItem.id}" name="tenderItemId"/><input type="text" class="inputxt easyui-validatebox" data-options="required:true" name="amt" value="${projectItemAmtMap[tenderItem.projectItemId]}"/></td>
						</tr>
					</c:forEach>
					<tr>
						<th style='text-align: left' colspan="2">已划分保证金总额：</th>
						<td><span id="usedDepositedAmount"></span></td>
					</tr>
					<tr>
						<th style='text-align: left' colspan="2">保证金总额：</th>
						<td id="totalDepositedAmount">${totalAmt}</td>
					</tr>
				</tbody>
			</table>
			<div class="blank10"></div>
			<input id="saveBtn" type="button" class="button red" value="保存" />
		</form>
	</div>
</body>
</html>
