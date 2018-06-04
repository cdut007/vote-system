<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@ page language="java" import="java.util.*,com.mhb.bank.dto.response.ResponseAp,org.apache.commons.lang3.StringUtils" pageEncoding="UTF-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<sys:link easyui="true" jgrowl="true" uedit="true" datepicker="true" plupload="true" ztree="true"/>
<script type="text/javascript">
	$(function(){
		$("#sousuo").click(function(){
			var start = $('#startDate').datebox('getValue').replace(/[^\d]/g,"");
			var end = $('#endDate').datebox('getValue').replace(/[^\d]/g,"");
			$.ajax({
				url:"${pageContext.request.contextPath}/bank/retrieveTransactionDetai",
				dataType:"json",
				type:"post",
				data:{"startDate":start,"endDate":end},
				success:function(){
					alert("搜索成功");
				}
			});//
		});
	});

</script>
</head>
  <body>
  <jsp:include page="/common/top.jsp"/>
  <div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				企业账户管理
				<code>&gt;</code>
				交易明细查询
		</div>
	</div>
	<!-- <div id="tb" style="padding:5px;height:auto">
	<div>
		开始时间：<input class="easyui-datebox" style="width:80px">
		结束时间：<input class="easyui-datebox" style="width:80px">
		<a href="#" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
	</div>
	</div> -->
	<div class="block">
			<%
		    	ResponseAp responseAp=(ResponseAp)request.getAttribute("responseAp");
				Integer fieldNum = responseAp.getBody().getInteger("field_num");
				if (fieldNum != null) {
					String serialRecord = responseAp.getBody().get("serial_record") + " ";
					String[] data = serialRecord.split("\\|");
					Integer recordNum = responseAp.getBody().getInteger("record_num");
					out.println("<table class='easyui-datagrid' data-options=\"rownumbers:true\"  title=\"交易明细查询\" >");
					out.println("开始时间：<input id='startDate' class='easyui-datebox' style='width:120px'/>");
					out.println("结束时间：<input id='endDate' class='easyui-datebox' style='width:120px'/>");
					out.println("<a id='sousuo' class='easyui-linkbutton' iconCls='icon-search'>搜索</a>");
					out.println("<thead>");
					out.println("<tr>");
					for (int r = 0; r <1; r++) {
						for (int i = 0; i < fieldNum; i++) {
							String value = data[(r * fieldNum) + i].trim();
							out.println("<th data-options=\"field:'"+data[i]+"',title:'"+data[i]+"'\">"+(StringUtils.isBlank(value) ? "-" : value) + "	"+"</th>");
						}
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
	<jsp:include page="/common/bottom.jsp"/>
    
  </body>
</html>
