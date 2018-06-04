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
		$("#rewardsAndPunishmentForm").ajaxSubmit({
			beforeSend:function(){
				$.messager.progress({title:"系统提示",msg:"正在提交"}); 
			},
			complete:function(){
				$.messager.progress("close"); 
			},
			dataType:"json",
			success:function(data){
				$.messager.alert("系统提示","提交成功！","info",function(){
					window.location="${pageContext.request.contextPath}/organ/organBRewardsAndPunishmentView?organId="+organId;
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
			投标单位奖惩信息管理
			<code>&gt;</code>
			添加/修改奖惩信息
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				${empty rewardsAndPunishment.id?"添加":"修改"}奖惩记录
			</h4>
			<div class="blank10"></div>
			<form:form id="rewardsAndPunishmentForm" method="post" action='${pageContext.request.contextPath}/organ/saveOrUpdateRewardsAndPunishment' modelAttribute="rewardsAndPunishment" >
				<input type="hidden" name="token" value="${token}" />
				<input type="hidden" id="organId" name="organId" value="${organId}"/>
				<input type="hidden" id="id" name="id" value="${rewardsAndPunishment.id}"/>
				
				<table width="100%" style="table-layout:fixed;">					
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">类型：</td>
						<td>
							<select id="conferKind" name="conferKind" class="inputxt easyui-validatebox">
								<option>奖励</option>
								<option>惩罚</option>
							</select>
						</td>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">奖励/惩罚名称：</td>
						<td>	
							<form:input path="conferName"  cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">颁发单位：</td>
						<td>
							<form:input path="conferOrganization" cssClass="inputxt easyui-validatebox" data-options="required:true" />
						</td>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">颁发时间：</td>
						<td>
							<input type="text" id="conferDate" value="<fmt:formatDate value="${rewardsAndPunishment.conferDate}" pattern="yyyy-MM-dd" type="both" dateStyle="default" timeStyle="default" />" name="conferDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputxt Wdate easyui-validatebox" data-options="required:true" />
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
	
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>