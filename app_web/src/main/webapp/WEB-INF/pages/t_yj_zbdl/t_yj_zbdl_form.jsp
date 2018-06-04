<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招标人/招标代理机构电子招标业绩表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<form:form id="t_yj_zbdl_form_id" action="${pageContext.request.contextPath}/t_yj_zbdl/saveOrUpdate" method="post" commandName="t_yj_zbdl">
	<form:hidden path="id"/>
	<table class="mytablerow" style="width:600px;">
		<tr>
			<th width="90px">招标人/招标代理机构代码  </th><td><form:input path="ztdm00" cssClass="validate[maxSize[4]]"/></td>
			<th width="90px">招标项目编号 </th><td><form:input path="zbxmbh" cssClass="validate[maxSize[10]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标项目名称</th><td><form:input path="zbxmmc" cssClass="validate[maxSize[50]]"/></td>
			<th width="90px">招标人代码</th><td><form:input path="zbrdm0" cssClass="validate[maxSize[4]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标人名称</th><td><form:input path="zbrmc0" cssClass="validate[maxSize[50]]"/></td>
			<th width="90px">招标项目合同总金额</th><td><form:input path="zbxmje" cssClass="validate[custom[number]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标项目代理收费金额</th><td><form:input path="zbdlje" cssClass="validate[custom[number]]"/></td>
			<th width="90px">金额币种代码</th><td><form:input path="jebzdm" cssClass="validate[maxSize[1]]"/></td>
		</tr>
		<tr>
			<th width="90px">金额单位</th><td><form:input path="jedw00" cssClass="validate[maxSize[0]]"/></td>
			<th width="90px">招标项目合同签署时间</th><td><form:input path="htqssj" cssClass="validate[custom[date]] Wdate" onclick="WdatePicker();"/></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	$("#t_yj_zbdl_form_id").validationEngine({showOneMessage : true,promptPosition : "bottomLeft"});
});
</script>
