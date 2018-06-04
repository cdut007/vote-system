<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:专家表单
Copyright: Copyright(c)2013
Company: 美宏博科技有限公司
author: ZORO
--%>
<form:form id="t_expert_form_id" action="${pageContext.request.contextPath}/t_expert/saveOrUpdate" method="post" commandName="t_expert">
	<form:hidden path="id"/>
	<table class="mytablerow" style="width:600px;">
		<tr>
			<th width="90px">姓名<font color="red">*</font></th><td><form:input path="userName" cssClass="validate[required,maxSize[25]]"/></td>
			<th width="90px">性别<font color="red">*</font></th><td><form:input path="gender" cssClass="validate[required,maxSize[1]]"/></td>
		</tr>
		<tr>
			<th width="90px">身份证件类型<font color="red">*</font></th><td><form:input path="identityType" cssClass="validate[required,maxSize[25]]"/></td>
			<th width="90px">身份证件号码<font color="red">*</font></th><td><form:input path="identityNo" cssClass="validate[required,maxSize[25]]"/></td>
		</tr>
		<tr>
			<th width="90px">出生年月<font color="red">*</font></th><td><form:input path="csny00" cssClass="validate[required,custom[date]] Wdate" onclick="WdatePicker();"/></td>
			<th width="90px">行政区划</th><td><form:input path="region" cssClass="validate[maxSize[25]]"/></td>
		</tr>
		<tr>
			<th width="90px">最后毕业院校<font color="red">*</font></th><td><form:input path="graduate" cssClass="validate[required,maxSize[100]]"/></td>
			<th width="90px">最高学历<font color="red">*</font></th><td><form:input path="zgxl00" cssClass="validate[required,maxSize[25]]"/></td>
		</tr>
		<tr>
			<th width="90px">联系电话</th><td><form:input path="phone" cssClass="validate[maxSize[25]]"/></td>
			<th width="90px">通讯地址</th><td><form:input path="address" cssClass="validate[maxSize[250]]"/></td>
		</tr>
		<tr>
			<th width="90px">邮政编码</th><td><form:input path="zipCode" cssClass="validate[maxSize[25]]"/></td>
			<th width="90px">单位名称<font color="red">*</font></th><td><form:input path="dwmc00" cssClass="validate[required,maxSize[100]]"/></td>
		</tr>
		<tr>
			<th width="90px">是否在职<font color="red">*</font></th><td><form:input path="isJob" cssClass="validate[required,maxSize[25]]"/></td>
			<th width="90px">职务</th><td><form:input path="zhiwu0" cssClass="validate[maxSize[25]]"/></td>
		</tr>
		<tr>
			<th width="90px">工作简历</th><td><form:input path="gzjl00" cssClass="validate[]"/></td>
			<th width="90px">专业分类</th><td><form:input path="zyfl00" cssClass="validate[maxSize[25]]"/></td>
		</tr>
		<tr>
			<th width="90px">从业年限<font color="red">*</font></th><td><form:input path="cynx00" cssClass="validate[required,custom[number]]"/></td>
			<th></th><td></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$(function(){
	$("#t_expert_form_id").validationEngine({showOneMessage : true,promptPosition : "bottomLeft"});
});
</script>
