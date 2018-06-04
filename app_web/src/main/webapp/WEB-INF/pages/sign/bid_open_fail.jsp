<%@page pageEncoding="utf-8" language="java"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>开标信息</title>
<sys:link easyui="true" jgrowl="true" datepicker="true"/>


</head>
<c:set value="${bidOpenCheckService.loadBidOpenRecord(processBusinessKey)}" var="record" scope="request"></c:set>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">开标管理</a>
			<code>&gt;</code>
			开标信息
		</div>
	</div>
	<div class="block">
	
	<form id="invitation_Form" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
		<input type="hidden" name="taskId" value="${taskId}"></input>
			<div class="easyui-panel" data-options="title:'项目概况',collapsible:true">
				<table style="width:98%;table-layout:fixed;margin:0 auto;">
					<tbody>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标编号</td>
							<td>${record.projectInstance.zbxmbh}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">招标项目名称</td>
							<td>${record.projectInstance.zbxmmc}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">标段</td>
							<td>${record.projectItem.bdmc00}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">开标时间</td>
							<td>${record.bidOpenDate}</td>
						</tr>
						<tr>
							<td class="need"></td>
							<td style="width:100px">失败原因</td>
							
								<td>${record.closeReason}</td>
						
						</tr>
		
					</tbody>
				</table>
			</div>
					<div class="blank10"></div>
					<input id='complete' type="button" class="button red" value="确定" />
			</form>
	</div>
	<script>
	
		$("#complete").click(function(){	
			
			$("#invitation_Form").submit();
			
		});
		
	</script>

	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>