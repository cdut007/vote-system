<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%--
添加修改用户信息
 --%>
<form:form method="post" action="${pageContext.request.contextPath}/user/saveOrUpdateUser" commandName="userForm">
	<form:hidden path="id" />
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">姓名：</td>
			<td><form:input path="userName" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="userName" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>身份证号：</td>
			<td><form:input path="identityNo" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="identityNo" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>性别：</td>
			<td><form:radiobuttons path="gender" items="${util:dictionaryTree('GENDER',false)}" itemLabel="itemName" itemValue="itemCode" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="gender" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>邮箱地址：</td>
			<td><form:input path="email" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="email" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>QQ：</td>
			<td><form:input path="qq0000" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="qq0000" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>联系电话：</td>
			<td><form:input path="phone" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="phone" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>登录账号：</td>
			<td><form:input path="loginName" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="loginName" cssClass="Validform_wrong" />
				</div></td>
		</tr>
			<tr>
			<td class="need"></td>
			<td>机构名称：</td>
			<td><form:input path="organ.ztmc00" cssClass="inputxt" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="organ.ztmc00" cssClass="Validform_wrong" />
				</div></td>
		</tr>
	</table>
</form:form>