<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:投标人业绩信息表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<form:form id="t_yj_tbr_form_id" action="${pageContext.request.contextPath}/t_yj_tbr/saveOrUpdate" method="post" commandName="t_yj_tbr">
	<form:hidden path="id"/>
	<table class="mytablerow" style="width:600px;">
		<tr>
			<th width="90px">投标人代码</th><td><form:input path="tbrdm0" cssClass="validate[maxSize[4]]"/></td>
			<th width="90px">中标项目的标段（包）编号</th><td><form:input path="zbbdbh" cssClass="validate[maxSize[11]]"/></td>
		</tr>
		<tr>
			<th width="90px">中标项目和标段（包）名称</th><td><form:input path="zbbdmc" cssClass="validate[maxSize[50]]"/></td>
			<th width="90px">招标人代码</th><td><form:input path="zbrdm0" cssClass="validate[maxSize[4]]"/></td>
		</tr>
		<tr>
			<th width="90px">招标人名称</th><td><form:input path="zbrmc0" cssClass="validate[maxSize[50]]"/></td>
			<th width="90px">中标金额</th><td><form:input path="zbje00" cssClass="validate[custom[number]]"/></td>
		</tr>
		<tr>
			<th width="90px">合同金额</th><td><form:input path="htje00" cssClass="validate[custom[number]]"/></td>
			<th width="90px">合同结算金额</th><td><form:input path="htjsje" cssClass="validate[custom[number]]"/></td>
		</tr>
		<tr>
			<th width="90px">合同期限</th><td><form:input path="htqx00" cssClass="validate[custom[number]]"/></td>
			<th width="90px">实际履行期限</th><td><form:input path="sjlxqx" cssClass="validate[custom[number]]"/></td>
		</tr>
		<tr>
			<th width="90px">金额币种代码</th><td><form:input path="jebzdm" cssClass="validate[maxSize[1]]"/></td>
			<th width="90px">金额单位</th><td><form:input path="jedw00" cssClass="validate[maxSize[0]]"/></td>
		</tr>
		<tr>
			<th width="90px">合同签署时间</th><td><form:input path="htqssj" cssClass="validate[custom[date]] Wdate" onclick="WdatePicker();"/></td>
			<th></th><td></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	$("#t_yj_tbr_form_id").validationEngine({showOneMessage : true,promptPosition : "bottomLeft"});
});
</script>
