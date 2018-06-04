<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:国民经济行业分类代码表表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<form:form id="t_hyfl_form_id" action="${pageContext.request.contextPath}/t_hyfl/saveOrUpdate" method="post" commandName="t_hyfl">
	<form:hidden path="id"/>
	<table class="mytablerow" style="width:600px;">
		<tr>
			<th width="90px">字母码</th><td><form:input path="zmm000" cssClass="validate[maxSize[65]]"/></td>
			<th width="90px">大类</th><td><form:input path="dlei00" cssClass="validate[maxSize[65]]"/></td>
		</tr>
		<tr>
			<th width="90px">中类</th><td><form:input path="zlei00" cssClass="validate[maxSize[65]]"/></td>
			<th width="90px">小类</th><td><form:input path="xlei00" cssClass="validate[maxSize[65]]"/></td>
		</tr>
		<tr>
			<th width="90px">名称</th><td><form:input path="text" cssClass="validate[maxSize[100]]"/></td>
			<th width="90px">描述说明</th><td><form:input path="description" cssClass="validate[maxSize[250]]"/></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	$("#t_hyfl_form_id").validationEngine({showOneMessage : true,promptPosition : "bottomLeft"});
});
</script>
