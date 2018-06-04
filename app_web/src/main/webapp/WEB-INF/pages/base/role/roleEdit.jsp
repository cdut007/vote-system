<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<form:form method="post" action="${pageContext.request.contextPath}/role/saveOrUpdateRole" modelAttribute="role" onsubmit="return addMenus();">
	<form:hidden path="id" />
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">角色名称：</td>
			<td><form:input path="roleName" cssClass="inputxt" datatype="s1-100" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="roleName" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>角色描述：</td>
			<td><form:textarea path="roleDescription" datatype="s1-200" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="roleDescription" cssClass="Validform_wrong" />
				</div></td>
		</tr>
	</table>
</form:form>
