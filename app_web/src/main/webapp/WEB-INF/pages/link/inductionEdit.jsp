<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form method="post" action="${pageContext.request.contextPath}/link/createOrUpdateInduction" modelAttribute="tblink">
	<form:hidden path="id" />
	<table>
		<tbody>
			<tr>
				<td>链接名字</td>
				<td>
					<form:input path="link_name" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>栏目地址</td>
				<td>
					<form:input path="url" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>排序</td>
				<td>
					<form:input path="sortNumber" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>导航栏显示</td>
				<td>
					<form:radiobutton path="visible" value="1" label="是" checked="checked"/>
					<form:radiobutton path="visible" value="0" label="否" />
				</td>
			</tr>
			
		</tbody>
	</table>
</form:form>
