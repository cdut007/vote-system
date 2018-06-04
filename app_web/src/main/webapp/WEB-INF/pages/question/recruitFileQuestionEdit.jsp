<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:useBean id="recruitFileQuestion" scope="request" type="com.mhb.question.entity.IRecruitFileQuestion"></jsp:useBean>
<jsp:setProperty property="projectItemId" name="recruitFileQuestion" value="${recruitFile.projectItemId}" />
<jsp:setProperty property="recruitFileId" name="recruitFileQuestion" value="${recruitFile.id}" />
<form:form modelAttribute="recruitFileQuestion" action="${pageContext.request.contextPath}/question/saveOrUpdateRecruitFileQuestion">
	<form:hidden path="id" />
	<form:hidden path="recruitFileId" />
	<form:hidden path="projectItemId" />
	<table>
		<tr>
			<td>标段：</td>
			<td>${recruitFile.projectItem.projectInstance.zbxmmc}-${recruitFile.projectItem.bdmc00}</td>
		</tr>
		<tr>
			<td>招标文件：</td>
			<td>${recruitFile.name}&nbsp;&nbsp;(${recruitFile.rev})</td>
		</tr>
		<tr>
			<td>问题内容：</td>
			<td>
				<form:textarea path="questionContent" placeholder="请输入要求澄清的问题..." cssStyle="height:220px;width:400px;" />
			</td>
		</tr>
		<tr>
			<td>提问机构：</td>
			<td>${CURRENT_USER_SESSION_INFO.organ.ztmc00}</td>
		</tr>
		<tr>
			<td>提问人：</td>
			<td>${CURRENT_USER_SESSION_INFO.userName}</td>
		</tr>
	</table>
</form:form>