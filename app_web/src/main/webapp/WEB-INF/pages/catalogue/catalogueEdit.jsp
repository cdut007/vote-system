<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form method="post" action="${pageContext.request.contextPath}/catalogue/createOrUpdateCatalogue" modelAttribute="catalogue">
	<form:hidden path="id" />
	<table>
		<tbody>
			<tr>
				<td>栏目名称</td>
				<td>
					<form:input path="catalogueName" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>栏目标识</td>
				<td>
					<form:input path="catalogueFlag" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>栏目描述</td>
				<td>
					<form:textarea path="catalogueDescription" />
				</td>
			</tr>
			<tr>
				<td>栏目序号</td>
				<td>
					<sys:number name="orderNo" value="${catalogue.orderNo}" />
				</td>
			</tr>
			<tr>
				<td>栏目地址</td>
				<td>
					<form:input path="catalogueURL" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>父栏目</td>
				<td>
					<form:select path="parentId">
						<form:option value="">无</form:option>
						<form:options items="${catalogueService.retrieveCatalogue()}" itemLabel="catalogueName" itemValue="id"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<td>导航栏显示</td>
				<td>
					<form:radiobutton path="display" value="true" label="是" />
					<form:radiobutton path="display" value="false" label="否" />
				</td>
			</tr>
			<tr>
				<td>允许添加内容</td>
				<td>
					<form:radiobutton path="allowAddContent" value="true" label="是" />
					<form:radiobutton path="allowAddContent" value="false" label="否" />
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
