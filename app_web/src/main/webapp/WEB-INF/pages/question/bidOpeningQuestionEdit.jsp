<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%-- <jsp:useBean id="bidOpeningQuestion" scope="request" type="com.mhb.question.entity.IBidOpeningQuestion"></jsp:useBean>
<jsp:setProperty property="projectInstanceId" name="bidOpeningQuestion" value="${expertApply.projectInstanceId}" />
<jsp:setProperty property="expertApplyId" name="bidOpeningQuestion" value="${expertApply.id}" /> --%>


<form:form modelAttribute="bidOpeningQuestion" action="${pageContext.request.contextPath}/question/saveOrUpdateBidOpeningQuestion">
	<form:hidden path="expertApplyId" />
	<table>
		<tr>
			<td>招标项目：</td>
			<td>${expertApply.projectInstance.zbxmmc}</td>
		</tr>
		<tr>
			<td>标段(包)集合：</td>
			<td>
				<c:forEach items="${expertApply.projectItemList}" var="item">
					<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td>开标时间：</td>
			<td>${expertApply.bidOpenDate}</td>
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