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
				$.messager.alert("系统提示","添加成功！","info",function(){
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
			履约信息查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				履约信息详细
			</h4>
			<div class="blank10"></div>
			<form:form id="contractForm" method="post" action='${pageContext.request.contextPath}/organ/saveOrUpdateContractPerformance' modelAttribute="contractPerformance" >
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id"/>
				<input type="hidden" id="organWId" name="organWId" value="${organId}"/>
				
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%">项目标段（包）：</td>
						<td colspan="4">
							${contractPerformance.projectItem.bdmc00 }
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td>合同名称：</td>
						<td colspan="4">
							${contractPerformance.contractName }
						</td>
					</tr>
				</table>
				
				<table width="100%" style="table-layout:fixed;">					
					<!-- 以下为手动输入内容 -->
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">合同金额：</td>
						<td>
							${contractPerformance.contractPrice }
						</td>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">合同结算金额：</td>
						<td>	
							${contractPerformance.settlePrice }<span>&nbsp;万元</span>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">合同期限：</td>
						<td>
							${contractPerformance.contractPeriod }<span>&nbsp;天</span>
						</td>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">质量要求：</td>
						<td>
							${contractPerformance.qualityRequire }
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">合同完成时间：</td>
						
  							<td>${contractPerformance.finishTime }</td>				
 					
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">实际履约期限：</td>
						<td>
							${contractPerformance.actuallyPeriod }<span>&nbsp;天</span>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">递交时间：</td>
					
  							<td>${contractPerformance.submitTime }</td>				
					
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">合同签署时间：</td>
  						<td>${contractPerformance.contractSignTime }</td>				

					</tr>
					<tr>
						
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">履约信息：</td>
						<td>
							${contractPerformance.performInfo }
						</td>
					</tr>
				</table>
				
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need"></td>
						<td  style="width:15%;">合同主要内容:</td>
						<td colspan='4'>
							${contractPerformance.contractContent }
						</td>
					</tr>
					<tr>
						<td class="need"></td>
						<td  style="width:15%;">履约变更内容:</td>
						<td colspan='4'>
							${contractPerformance.performChangeContent }
						</td>
					</tr>
				</table>
				
				<div class="blank10"></div>
				<div class="blank10"></div>
				<div class="blank10"></div>
			</form:form>
				<a class="button red" onclick="history.go(-1)">返回</a>
		</div>
	</div>
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>