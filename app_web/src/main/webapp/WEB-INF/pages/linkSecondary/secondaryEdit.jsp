<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form method="post" action="${pageContext.request.contextPath}/LinkSecondary/createOrUpdateSecondary" modelAttribute="tblinksecondary">
	<form:hidden path="secondary_id" />
	<table>
		<tbody>
			<tr>
				<td>二级链接名字</td>
				<td>
					<form:input path="secondary_name" cssClass="inputxt easyui-validatebox" data-options="required:true"/>
				</td>
			</tr>
			<tr>
				<td>一级链接名字</td>
				<td>
					<form:select path="id" cssClass="inputxt easyui-validatebox" data-options="required:true"> 
						<form:option value="">无</form:option>
						<form:options items="${linkList}" itemLabel="link_name" itemValue="id"/>
						<%-- <c:forEach items="${linkSecondaryService.retrieveLinkSecondaryTop()}" var="item">
							<form:option value="${item[1].id}" label="${item[1].link_name}"/>
						</c:forEach> --%>
					</form:select>
				</td>
			</tr>
			<tr>
				<td>链接地址</td>
				<td>
					<form:input path="url" cssClass="inputxt easyui-validatebox" data-options="validType:'length[0,200]'"/>
				</td>
			</tr>
			<tr>
				<td>排序</td>
				<td>
					<form:input path="sortNumber" cssClass="inputxt easyui-numberbox" />
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
