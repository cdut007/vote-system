<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.mhb.bank.dto.response.ResponseAp,org.apache.commons.lang3.StringUtils" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<sys:link easyui="true"/>
		<!-- <script type="text/javascript">
		$(function(){
				 $('.panel-title').css('text-align','center');		
		});
		</script> -->
	</head>
	
	<body>
		<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			银企对账
		</div>
		<%
		ResponseAp responseAp=(ResponseAp)request.getAttribute("Reconciliation");
		Integer fieldNum = responseAp.getBody().getInteger("field_num");
		if (fieldNum != null) {
			String serialRecord = responseAp.getBody().get("serial_record") + " ";
			String[] data = serialRecord.split("\\|");
			Integer recordNum = responseAp.getBody().getInteger("record_num");
			out.println("<table class='easyui-datagrid' data-options=\"rownumbers:true\"  title=\"银企对账\" >");
			out.println("<thead>");
			out.println("<tr>");
			for (int i = 0; i < fieldNum; i++) {
				String value = data[i].trim();
				out.print("<th data-options=\"field:'"+data[i]+"',title:'"+data[i]+"'\">"+(StringUtils.isBlank(value) ? "-" : value) +"</th>");
			}
			out.println("</tr>");
			out.println("</thead>");
			out.println("<tbody>");
			for (int r = 1; r < recordNum + 1; r++) {
					out.println("<tr>");
					for (int i = 0; i < fieldNum; i++) {
						String value = data[(r * fieldNum) + i].trim();
						out.print("<td>"+(StringUtils.isBlank(value) ? "-" : value) +"</td>");
					}
					out.println("</tr>");
			}
			out.println("</tbody>");
			out.println("</table>");
		}
	 %>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	</body>		
</html>