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
			投标单位中标业绩管理
			<code>&gt;</code>
			中标业绩查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				中标业绩详细
			</h4>
			<div class="blank10"></div>
			<form:form id="projectItemForm" method="post" action='${pageContext.request.contextPath}/organ/saveOrUpdateContractPerformance' modelAttribute="projectItem" >
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id"/>
				<input type="hidden" id="organWId" name="organWId" value="${organId}"/>
				
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%">项目名称：</th>
						<td colspan="4">
							${project.xmmc00 }
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<th>招标项目：</th>
						<td colspan="4">
							${projectInstance.zbxmmc }
						</td>
					</tr>
				</table>
				
				<table width="100%" style="table-layout:fixed;">					
					<!-- 以下为手动输入内容 -->
					<tr>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">标段名称：</th>
						<td>
							${projectItem.bdmc00 }
						</td>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">招标单位：</th>
						<td>	
							${projectInstance.organTName }
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">代理单位：</th>
						<td>
							${projectInstance.organAName }
						</td>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">标段合同估价：</th>
						<td>
							${projectItem.bdhtgj }<span> 元</span>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">标段分类：</th>
						
  							<td>${projectItem.projectItemType }</td>				
 					
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">报名申请人数：</th>
						<td>
							${projectItem.applyNum }
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">标书售价：</th>
					
  							<td>${projectItem.price }<span> 元</span></td>				
					
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">平台使用费：</th>
  						<td>${projectItem.platformPrice }<span> 元</span></td>			

					</tr>
					<tr>
						
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">交货期：</th>
						<td>
							${projectItem.deliveryTimeLimit }
						</td>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">中标时间：</th>
						<td>
							${projectItem.createTime }
						</td>
					</tr>
					<tr>
						
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">监督部门：</th>
						<td>
							${projectInstance.jdbmmc }
						</td>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">审核部门：</th>
						<td>
							${projectInstance.shbmmc }
						</td>
					</tr>
					<tr>
						
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">招标方式：</th>
						<td>
							公开招标
						</td>
						<td class="need" style="width:10px;"></td>
						<th style="width:15%;">组织形式：</th>
						<td>
							委托招标
						</td>
					</tr>
				</table>
				
				<%-- <table width="100%" style="table-layout:fixed;">
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
				</table> --%>
				
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