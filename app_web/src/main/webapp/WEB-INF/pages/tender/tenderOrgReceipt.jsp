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
<title>报名信息</title>
<sys:link easyui="true" jgrowl="true" datepicker="true"/>


</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			<a href="javascript:history.go(-1);">投标回执</a>
		</div>
	</div>
	<div class="block">
	
	<form id="invitation_Form" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
		<input type="hidden" name="taskId" value="${taskId}"></input>
			<div class="easyui-panel" data-options="title:'报名概况',collapsible:true">
				<table style="width:98%;table-layout:fixed;margin:0 auto;">
					<tbody>
						<!-- <tr>
							<td align="center" colspan="1"><b>投标回执</b></td>
						</tr> -->
						<tr>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贵公司于<fmt:formatDate value="${date}" type="both" pattern="yyyy年MM月dd日  hh时mm分ss秒"/>日对招标项目${tenderItem.projectInstanceName}&nbsp;${tenderItem.projectItemName}&nbsp;的投标报名申请已经审核通过。</td>
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