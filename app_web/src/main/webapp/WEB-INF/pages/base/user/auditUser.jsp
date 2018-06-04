<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%--
审核用户机构信息页面
 --%>
<form:form method="post" action="${pageContext.request.contextPath}/user/auditUser" commandName="userForm">
	<form:hidden path="id" />
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td class="need"></td>
			<td>登录账号：</td>
			<td>${userForm.loginName}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>机构代码：</td>
			<td>${userForm.organ.ztdm00}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>机构名称：</td>
			<td>${userForm.organ.ztmc00}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>是否缴费：</td>
			<td>${util:dictionary('IS_PAY',userForm.isPay)}</td>
		</tr>
		
		<tr>
			<td class="need"></td>
			<td>营业执照号码：</td>
			<td>${userForm.organ.yyzzhm}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>CA证书编号：</td>
			<td>${userForm.organ.cazsbh}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>税务登记号码：</td>
			<td>${userForm.organ.swdjh0}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>开户名称：</td>
			<td>${userForm.organ.accountName}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>开户银行：</td>
			<td>${userForm.organ.khyh00}</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>基本账户账号：</td>
			<td>${userForm.organ.jbzhzh}</td>
		</tr>
		
		<tr>
			<td class="need"></td>
			<td>注册资本：</td>
			<td>${userForm.organ.zczb00} ${util:dictionary('JEDWDM',userForm.organ.zczbdw)} (${util:dictionary('CURRENCY',userForm.organ.zczbbz)})</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td>回退原因：</td>
			<td><form:textarea path="backReason" id="backReason"/></td>
		</tr>
	</table>
</form:form>