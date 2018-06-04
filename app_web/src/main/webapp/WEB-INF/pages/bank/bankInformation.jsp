<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.mhb.bank.dto.response.ResponseAp,com.mhb.common.tag.ELFunctionLibrary" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<sys:link easyui="true"/>
	</head>
	<body>
		<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here"> 
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			账户信息查询
		</div>
		<%
		ResponseAp responseAp=(ResponseAp)request.getAttribute("responseAp");
		Integer num = responseAp.getBody().getInteger("field_num");
			if (num != null) {
				String serialRecord = responseAp.getBody().get("serial_record") + " ";
				String[] data = serialRecord.split("\\|");
				out.println("<table class='mytableStyle'>");
				for (int i = 0; i < num; i++) {
					out.println("<tr><th>"+data[i].trim() + "</th><td>" + data[num + i].trim()+"</td></tr>");
				}
				out.println("</table>");
			}
	 %>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	</body>		
</html>