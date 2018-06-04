<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.mhb.bank.dto.response.ResponseAp,com.mhb.common.tag.ELFunctionLibrary" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:if test="${not empty projectInstanceId}">
	<c:set value="select organ from TBTender tender,TBOrgan organ where organ.id=tender.organId and tender.projectInstanceId='${projectInstanceId}' and tender.effective=true" var="hql"/>
	<c:set value="select virtualAccount,projectItem from TBVirtualAccount virtualAccount,TBProjectPackage projectItem where virtualAccount.projectItemId=projectItem.id and virtualAccount.projectInstanceId='${projectInstanceId}' and virtualAccount.accountType='B'" var="hql2"/>
	<c:set value="${baseService.retrieveByHQL(hql)}" var="organList"/>
	<c:set value="${baseService.retrieveByHQL(hql2)}" var="virtualAccountList"/>
	
	<c:set value="select virtualAccount from TBVirtualAccount virtualAccount where virtualAccount.projectInstanceId='${projectInstanceId}' and virtualAccount.accountType='C'" var="hql3"/>
	<c:set value="${baseService.retrieveByHQL(hql3)}" var="virtualAccountCList"/>
</c:if>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<sys:link easyui="true" />
		<script src="/resources/print/jquery.PrintArea.js"></script>
		<script type="text/javascript">
		$(function(){
			$("#print").click(function(){
				$(".mytableStyle").printArea();
			});
			$("#projectInstanceId").change(function(){
				$("#tenderDocumentCostForm").submit();
			});
			$("#addRecord").click(function(){
				var dialog=$("<div/>").appendTo($("body")).dialog({
					title:"添加标书费",
					content:"<form action=\""+ctx+"/transactionDetail/addRecord\" method=\"post\">\
									<table>\
										<tr><th>付款单位<th><td><select name='fromOrganId' class='inputxt easyui-validatebox' data-options='required:true'><c:forEach items='${organList}' var='organ'><option value='${organ.id}'>${organ}</option></c:forEach></select></td></tr>\
										<tr><th>付款银行<th><td><input type='text' name='fromBankName' class='inputxt easyui-validatebox' data-options='required:true'/></td></tr>\
										<tr><th>付款帐号<th><td><input type='text' name='fromAccount' class='inputxt easyui-validatebox' data-options='required:true'/></td></tr>\
										<tr><th>收款帐号<th><td><select name='toAccount' class='inputxt easyui-validatebox' data-options='required:true'><c:forEach items='${virtualAccountList}' var='virtualAccount'><option value=\"${virtualAccount[0].accountNumber}\" fromOrganId='${virtualAccount[0].organBId}'>${virtualAccount[0].organBName}[${virtualAccount[1]}]</option></c:forEach></select></td></tr>\
										<tr><th>到账时间<th><td><input type='text' class='inputxt easyui-datetimebox' name='createTime' data-options='required:true'/></td></tr>\
										<tr><th>支付金额<th><td><input type='text' class='inputxt easyui-numberbox' name='amount' data-options='required:true'/></td></tr>\
										<tr><th>备注<th><td><input type='text' class='inputxt' name='remark'/></td></tr>\
									</table>\
							</form>",
					buttons:[
					    {text:"保存",handler:function(){
					    	dialog.find("form").ajaxSubmit({
					    		dataType:"json",
					    		success:function(data){
					    			$.messager.alert("系统提示",data.msg);
					    		},
					    		error:function(e,s1,s2){
					    			alert(JSON.stringify(e));
					    			alert(s1);
					    			alert(s2);
					    		}
					    	});
					    }},
						{text:"取消",handler:function(){
							dialog.dialog("destroy");
						}}
					]
				});
			});
			$(document).on("change",":input[name='fromOrganId']",function(){
				var value=$(this).val();
				$(this).parents("form:first").find(":input[name='toAccount']").children("option").each(function(){
					if($(this).attr("fromOrganId")==value){
						$(this).prop("disabled",false);
						//alert($(this).val());
					}else{
						$(this).prop("disabled",true);
					}
				});
			}).change();
			$("#addRecordC").click(function(){
				var dialog=$("<div/>").appendTo($("body")).dialog({
					title:"添加保证金",
					content:"<form action=\""+ctx+"/transactionDetail/addRecord\" method=\"post\">\
									<table>\
										<tr><th>付款单位<th><td><select name='fromOrganId' class='inputxt easyui-validatebox' data-options='required:true'><c:forEach items='${organList}' var='organ'><option value='${organ.id}'>${organ}</option></c:forEach></select></td></tr>\
										<tr><th>付款银行<th><td><input type='text' name='fromBankName' class='inputxt easyui-validatebox' data-options='required:true'/></td></tr>\
										<tr><th>付款帐号<th><td><input type='text' name='fromAccount' class='inputxt easyui-validatebox' data-options='required:true'/></td></tr>\
										<tr><th>收款帐号<th><td><select name='toAccount' class='inputxt easyui-validatebox' data-options='required:true'><c:forEach items='${virtualAccountCList}' var='virtualAccount'><option value=\"${virtualAccount.accountNumber}\" fromOrganId='${virtualAccount.organBId}'>${virtualAccount.organBName}</option></c:forEach></select></td></tr>\
										<tr><th>到账时间<th><td><input type='text' class='inputxt easyui-datetimebox' name='createTime' data-options='required:true'/></td></tr>\
										<tr><th>支付金额<th><td><input type='text' class='inputxt easyui-numberbox' name='amount' data-options='required:true'/></td></tr>\
										<tr><th>备注<th><td><input type='text' class='inputxt' name='remark'/></td></tr>\
									</table>\
							</form>",
					buttons:[
					    {text:"保存",handler:function(){
					    	dialog.find("form").ajaxSubmit({
					    		dataType:"json",
					    		success:function(data){
					    			$.messager.alert("系统提示",data.msg);
					    		},
					    		error:function(e,s1,s2){
					    			alert(JSON.stringify(e));
					    			alert(s1);
					    			alert(s2);
					    		}
					    	});
					    }},
						{text:"取消",handler:function(){
							dialog.dialog("destroy");
						}}
					]
				});
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
				标书费用管理
			</div>
			<div class="blank10"></div>
			<form id="tenderDocumentCostForm" action="${pageContext.request.contextPath}/transactionDetail/tenderDocumentCost" method="get">
				项目:
				<select id="projectInstanceId" name="projectInstanceId" style="width:600px;">
					<option value="">全部</option>
					<c:forEach items="${projectInstanceList}" var="projectInstance">
						<option value="${projectInstance.id}" ${projectInstanceId==projectInstance.id?"selected='selected'":""}>${projectInstance}</option>
					</c:forEach>
				</select>
				<div class="blank10"></div>
				<a class="button red" id="addRecord">人工增加标书费</a>
				<a class="button red" id="addRecordC">人工增加保证金</a>
				<input class="button red" type="button" value="打印" id="print"/>
				<div class="blank10"></div>
				<c:set var="totalCost" value="0"/>
				<table class="mytableStyle">
					<thead>
						<tr>
							<!-- <th>序号</th> -->
							<th>流水号</th>
							<th>项目名称</th>
							<th>标段名称</th>
							<th>支付单位</th>
							<!-- <th>支付帐号</th> -->
							<th>支付银行</th>
							<th>金额（元）</th>
							<%-- <td>${bankTransactionDetail["fromOrganName"]}</td> --%>
							<th>支付时间</th>
							<th>备注</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${bankTransactionDetailList}" var="bankTransactionDetail" varStatus="status">
							<c:set var="totalCost" value="${totalCost+bankTransactionDetail['amount']}"/>
							<tr>
								<%-- <th>${status.count}</th> --%>
								<td>${bankTransactionDetail["certNo"]}</td>
								<td>${bankTransactionDetail["projectInstance"]}</td>
								<td>${bankTransactionDetail["projectSectionName"]}</td>
								<td>${bankTransactionDetail["organName"]}</td>
								<%-- <td>${bankTransactionDetail["fromAccount"]}</td> --%>
								<%-- <td>${bankTransactionDetail["fromOrganName"]}</td> --%>
								<td>${bankTransactionDetail["fromBankName"]}</td>
								<td style="text-align:right">${bankTransactionDetail["amount"]}</td>
								<td>${bankTransactionDetail["transactionTime"]}</td>
								<td>${bankTransactionDetail["remarks"]}</td>
							</tr>
						</c:forEach>
					</tbody>
						<tr>
							<%-- <th>${status.count}</th> --%>
							<th>合计</th>
							<td></td>
							<td></td>
							<td></td>
							<%-- <td>${bankTransactionDetail["fromOrganName"]}</td> --%>
							<td></td>
							<td style="text-align:right">${totalCost}</td>
							<td></td>
							<td></td>
						</tr>
					<tfoot>
					</tfoot>
				</table>
			</form>
		</div>
		<div class="blank10"></div>
		<jsp:include page="/common/bottom.jsp"/>
	</body>		
</html>