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
	
	/* $("#complete").click(function(){
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
	}); */
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
			投标单位奖惩信息管理
			<code>&gt;</code>
			奖惩信息查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				奖励/惩罚信息详细
			</h4>
			<div class="blank10"></div>
			<form:form id="contractForm" method="post" action='${pageContext.request.contextPath}/organ/saveOrUpdateContractPerformance' modelAttribute="rewardsAndPunishment" >
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id"/>
				<input type="hidden" id="organWId" name="organWId" value="${organId}"/>
				
				
				<table width="100%" style="table-layout:fixed;">					
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">类型：</td>
						<td>
							${rewardsAndPunishment.conferKind }
						</td>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">奖励/惩罚名称：</td>
						<td>	
							${rewardsAndPunishment.conferName }
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">颁发单位：</td>
						<td>
							${rewardsAndPunishment.conferOrganization }
						</td>
						<td class="need" style="width:10px;"></td>
						<td style="width:15%;">颁发时间：</td>
						<td>
							${rewardsAndPunishment.conferDate }
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