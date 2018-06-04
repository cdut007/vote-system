<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="expertList" value="${userService.retrieveExpertSign(processBusinessKey)}" />
<c:set var="expertApply" value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" />
<c:set var="expertGroup" value="${expertApply.expertGroup}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>代理机构--指定评标委员会组长</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.wpsm {color: #f00;}
</style>
<script type="text/javascript">
	$(function() {
		$("#rwwpSubmit").click(function() {
			var id = $("input[name=zzzj00]:checked").val();
			if(id == undefined){
				$.messager.alert("系统提示", "请选择您要投票的专家！");

			}else{
				$.messager.confirm("系统提示", "确定提交推选结果吗？", function(ok) {
					if (ok) {
						$("#form").ajaxSubmit({
							dataType:"json",
							success:function(data){
								if(data.success){
									//TODO
									$("#rwwpForm").submit();
								}else{
									$.messager.alert(data.msg);
								}
								
							}
						});
					}
				});
				
			}
/* 			
 * 
 *             保存组长
			//if("${expertGroup.zzzj00}" == null || "${expertGroup.zzzj00}" == ""){
				$.ajax({
					url : "${pageContext.request.contextPath}/expertGroup/saveHeader",
					type : "post",
					data : {
						"id" : "${expertGroup.id}",
						"zzzj00" : id
					},
					dataType : "json",
					success : function() {
					}
				});
			//} */
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			指定评标委员会组长
		</div>
		<div class="usBox">
			<div class="blank10"></div>
			<form id='form' action="${pageContext.request.contextPath}/expertGroup/saveHeader" method="post">
				<%-- <input type="hidden" name="taskId" value="${taskId}"/>	 --%>
				<input type="hidden" name="id" value="${expertGroup.id }"/>	
				<input type="hidden" name="projectInstanceId" value="${expertGroup.projectInstanceId }"/>	
				<table id="user-datagrid" class="datagrid-btable" >
					<c:forEach items="${expertList}" var="experts">
						<tr>
							<td><input type="radio" name="zzzj00" value="${experts.id}" />${experts.userName}</td>
							<td>
								<c:if test="${experts.gender=='1'}">&nbsp;&nbsp;&nbsp;&nbsp;男</c:if>
								<c:if test="${experts.gender=='2'}">&nbsp;&nbsp;&nbsp;&nbsp;女</c:if>
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;${experts.phone}</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div class="blank10"></div>
			<form class="registerform" id="rwwpForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm">
				<input type="hidden" name="taskId" value="${taskId}" />
				<div>
					<input type="button" class='button red' id="rwwpSubmit" value="提 交" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
