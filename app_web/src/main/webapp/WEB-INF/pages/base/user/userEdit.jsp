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
			<td><form:input path="userName" cssClass="inputxt easyui-validatebox" data-options="required:true"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="userName" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>所在部门：</td>
			<td><form:input path="departmentId" cssClass="inputxt easyui-combotree" data-options="url:'${pageContext.request.contextPath}/department/getDepartmentTree'" /></td>
			<td><div class="Validform_checktip">
					<form:errors path="departmentId" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>角色：</td>
			<td><form:checkboxes items="${JSID00}" path="roleIds" itemLabel="roleName" itemValue="id" delimiter="&nbsp;&nbsp;"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="roleList" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td style="width:100px;">所属单位：</td>
			<td><form:input path="hisUnit" cssClass="inputxt easyui-validatebox" data-options="required:true"/></td>
			<td><div class="Validform_checktip">
				<form:errors path="userName" cssClass="Validform_wrong" />
			</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>身份证号：</td>
			<td><form:input path="identityNo" cssClass="inputxt easyui-validatebox" data-options="missingMessage:'请输入身份证号',required:true,validType:['idcardNo','noUseIdcardNo[&quot;${userForm.id}&quot;]']"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="identityNo" cssClass="Validform_wrong" />
				</div>
			</td>
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
			<td>电子邮箱：</td>
			<td><form:input path="email" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:['email',&quot;remote['${pageContext.request.contextPath}/user/validateEmail?id=${userForm.id}','email']&quot;]"/></td>
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
			<td><form:input path="phone" cssClass="inputxt" data-options="missingMessage:'请输入联系电话',required:true,validType:'mobileOrTelephone'"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="phone" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>登录账号：</td>
			<td><form:input path="loginName" cssClass="inputxt easyui-validatebox" data-options="required:true,invalidMessage:'登录账号已被其他用户使用'" validType="remote['${pageContext.request.contextPath}/user/validateLoginName','loginName']" disabled="${not empty userForm.id}"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="loginName" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>登录密码：</td>
			<td><form:input id="pwd1" type="password" path="password" cssClass="inputxt  easyui-validatebox" data-options="missingMessage:'请输入登录密码',required:true,validType:''"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="password" cssClass="Validform_wrong" />
				</div></td>
		</tr>
		<tr>
			<td class="need">*</td>
			<td>确认密码：</td>
			<td><form:input id="pwd2" type="password" path="" cssClass="inputxt  easyui-validatebox" data-options="missingMessage:'请再次输入登录密码',required:true,validType:''"/></td>
			<td><div class="Validform_checktip">
					<form:errors path="" cssClass="Validform_wrong" />
				</div></td>
		</tr>
	</table>
</form:form>


<c:forEach items="${roleIds}" var="role">
	<script>$('input[value=${role.id}]').prop('checked', true);</script>
</c:forEach>