<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<div style="position:relative;">
	<img src="${pageContext.request.contextPath}/workflow/processDefinitionImage?processDefinitionId=${processInstance.processDefinitionId}"/>
	<c:forEach items="${activityList}" var="activity">
		<div style="position:absolute; border:2px solid red;left:${activity.x}px;top:${activity.y}px;width:${activity.width }px;height:${activity.height}px;"></div>
	</c:forEach>
</div>
