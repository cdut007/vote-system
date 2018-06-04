<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="y" uri="http://www.ylz.com/jstl"%>
<form:form method="post" action="${r'${pageContext.request.contextPath}'}/${entityTemplate.entityInstanceName}/createOrUpdate${entityTemplate.simpleEntityName}" modelAttribute="${entityTemplate.entityInstanceName}">
	<form:hidden path="<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>" />
	<table width="100%" style="table-layout:fixed;">
		<#list entityTemplate.fieldWithMappingList as fieldWithMapping>
		<#if !fieldWithMapping.primary>
		<tr>
			<td class="need"><#if fieldWithMapping.notNull>*</#if></td>
			<td style="width:100px;"><#if fieldWithMapping.comment??>${fieldWithMapping.comment}<#else>${fieldWithMapping.fieldName}</#if></td>
			<td><form:input path="${fieldWithMapping.fieldName}" cssClass="inputxt easyui-validatebox" data-options="required:<#if fieldWithMapping.notNull>true<#else>false</#if>"/></td>
		</tr>
		</#if>
		</#list>
	</table>
</form:form>