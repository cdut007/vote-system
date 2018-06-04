<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>

<html>
<head>
<%@include file="/common/link.jsp"%>
	<script type="text/javascript" src="/resources/page/guardian/listMainGuardian.js"></script>
	<script type="text/javascript" src="/resources/page/guardian/listGuardian.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			监标人管理
			<code>&gt;</code>
			指定监标人
		</div>
	</div>
	<div class="block">


		<div id="popDiv">
			<div class="block usBox">
				<div class="clearfix" style="height:420px;">
					<div class="easyui-layout" data-options="fit:true">
						<div data-options="width:320,region:'west'">
							<table id="department-treegrid">
							</table>
						</div>
						<div data-options="region:'center'">
							<table id="userList"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="blank10"></div>

		<table id="itemGuardianList_datagrid"><tr><td></td></tr></table>



		<table width="100%"><tr style="width:100%;padding-top: 5px;"><td align="right">
			<form:form id="completeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm'>
				<input type="hidden" name="pass" value="" />
				<input type="hidden" name="taskId" value="${expertApply.taskId}" />
				<input type="hidden" id="expertApplyId" name="expertApplyId" value="${expertApply.id}" />
				<input type="button" class="button red" value="保存" id="saveGuardianInMain" />
				<input type="button" class="button red" value="提交" id="pass" />
				<input type="hidden" name="projectInstanceId" id="projectInstanceId" value="${expertApply.projectInstanceId}"/>
			</form:form>


		</td></tr></table>

	</div>

	<jsp:include page="/common/bottom.jsp"/>

</body>
</html>
