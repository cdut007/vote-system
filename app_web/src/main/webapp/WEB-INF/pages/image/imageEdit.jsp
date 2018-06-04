<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<form:form method="post" action="${pageContext.request.contextPath}/image/createOrUpdateImage" modelAttribute="tbImage" >
	<form:hidden path="id" />
	<table style="width:100%">
		<tbody>
			<tr>
				<td>图片名字</td>
				<td>
					<form:input path="name" cssClass="inputxt" />
				</td>
				<td rowspan="8">
					<form:hidden path="picId"/>
					<div style="float:right">
						<div id="logo" style="width:550px;height:280px;border:1px solid #ddd">
							<c:if test="${not empty tbImage.picId}">
								<img src="${pageContext.request.contextPath}/attachment/download/${tbImage.attachment.path}" style="width:550px;height:280px;" />
							</c:if>
						</div>
						<a id="pickfile" class="easyui-linkbutton" style="width:552px;">选择产品图片</a>
					</div>
				</td>
			</tr>
			<tr>
				<td>图片地址</td>
				<td>
					<form:input path="url" cssClass="inputxt" />
				</td>
			</tr>
			<tr>
				<td>图片排序</td>
				<td>
					<form:input path="orderNo" cssClass="inputxt" />
				</td>
			</tr>
			<c:choose>
				<c:when test="${empty tbImage.id}">
					<tr>
						<td>添加图片时间</td>
						<td>
							<form:input path="addTime" cssClass="inputxt" />
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td>修改图片时间</td>
						<td>
							<form:input path="editTime" cssClass="inputxt" />
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<td>导航栏显示</td>
				<td>
					<form:radiobutton path="display" value="1" label="是" checked="checked"/>
					<form:radiobutton path="display" value="0" label="否" />
				</td>
			</tr>
		</tbody>
	</table>
</form:form>