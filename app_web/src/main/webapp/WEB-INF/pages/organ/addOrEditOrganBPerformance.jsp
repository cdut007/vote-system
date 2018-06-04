<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function(){
	var organId = "${organId}";
	var contractPerformanceId = "${contractPerformance.id}";
	$("#id").val(contractPerformanceId);
	
	$("#complete").click(function(){
		$("#contractForm").ajaxSubmit({
			beforeSend:function(){
				$.messager.progress({title:"系统提示",msg:"正在提交"}); 
			},
			complete:function(){
				$.messager.progress("close"); 
			},
			dataType:"json",
			success:function(data){
				$.messager.alert("系统提示","提交成功！","info",function(){
					window.location="${pageContext.request.contextPath}/organ/organBPerformanceView?organId="+organId;
				});
			}
		});
	});
});

</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标单位履约信息管理
			<code>&gt;</code>
			添加/修改履约记录
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				${empty contractPerformance.id?"添加":"修改"}履约信息
			</h4>
			<div class="blank10"></div>
			<form:form id="contractForm" method="post" action='${pageContext.request.contextPath}/organ/saveOrUpdateContractPerformance' modelAttribute="contractPerformance" >
				<input type="hidden" name="token" value="${token}" />
				<input type="hidden" id="organWId" name="organWId" value="${organId}"/>
				<input type="hidden" id="id" name="id"/>
				
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%">项目标段（包）：</td>
						<td colspan="4">
						
								<select id="projectItemId" name="projectItemId" style="width:60%" class="easyui-validatebox" missingMessage="请选择项目标段（包）！" data-options="required:true">
								<option value="">---==请选择==---</option>
								<c:forEach items="${projectItemList}" var="projectItem">
									<c:choose>
										<c:when test="${projectItem.id == contractPerformance.projectItemId}">
											<option value="${projectItem.id}" selected="selected">${projectItem.bdmc00 }</option>
										</c:when>
										<c:otherwise>
											<option value="${projectItem.id}">${projectItem.bdmc00 }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								</select>						
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>合同名称：</td>
						<td colspan="4">
							<form:input path="contractName" cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
				</table>
				
				<table width="100%" style="table-layout:fixed;">					
					<!-- 以下为手动输入内容 -->
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">合同金额：</td>
						<td>
							<form:input type="number" path="contractPrice" cssClass="inputxt easyui-validatebox" data-options="required:true" /><span>&nbsp;万元</span>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">合同结算金额：</td>
						<td>	
							<form:input  type="number" path="settlePrice"  cssClass="inputxt easyui-validatebox" data-options="required:true" /><span>&nbsp;万元</span>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">合同期限：</td>
						<td>
							<form:input  type="number"  path="contractPeriod" cssClass="inputxt easyui-validatebox" data-options="required:true" /><span>&nbsp;天</span>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">质量要求：</td>
						<td>
							<form:input path="qualityRequire" cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">合同完成时间：</td>
						
  							<td><input type="text" id="finishTime" value="<fmt:formatDate value="${contractPerformance.finishTime}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="finishTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />&nbsp;</td>				
 					
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">实际履约期限：</td>
						<td>
							<form:input  type="number"  path="actuallyPeriod" cssClass="inputxt easyui-validatebox" data-options="required:true" /><span>&nbsp;天</span>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">递交时间：</td>
					
  							<td><input type="text" id="submitTime" value="<fmt:formatDate value="${contractPerformance.submitTime}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="submitTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />&nbsp;</td>				
					
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">合同签署时间：</td>
  						<td><input type="text" id="contractSignTime" value="<fmt:formatDate value="${contractPerformance.contractSignTime}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="contractSignTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />&nbsp;</td>				

					</tr>
					<tr>
						
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">履约信息：</td>
						<td>
							<form:input path="performInfo" cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
				</table>
				
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need">*</td>
						<td  style="width:15%;">合同主要内容:</td>
						<td colspan='4'>
							<form:textarea  path="contractContent" cssStyle="width:99%;height:50px;" cssClass="inputxt easyui-validatebox" data-options="required:true" missingMessage="请填写合同主要内容！"/>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td  style="width:15%;">履约变更内容:</td>
						<td colspan='4'>
							<form:textarea  path="performChangeContent" cssStyle="width:99%;height:50px;" cssClass="inputxt easyui-validatebox" data-options="required:true" missingMessage="请填写履约变更内容！"/>
						</td>
					</tr>
				</table>
				
				<div class="blank10"></div>
				<div class="blank10"></div>
				<div class="blank10"></div>
			</form:form>
				<input type="button" class="button red" value="提交" id="complete" />
		</div>
	</div>
</body>
</html>