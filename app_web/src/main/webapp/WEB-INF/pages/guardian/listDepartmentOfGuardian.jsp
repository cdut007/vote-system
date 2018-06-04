<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript" src="/resources/page/guardian/listGuardian.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业信息管理
			<code>&gt;</code>
			指定监标人
		</div>
	</div>
	<div class="block">
		<div class="usBox">
				<div>临时标段，请设计下UI吧，主要做监标人审核：<br/>
				
					<c:forEach items="${items}" var="item" varStatus="status">
						<input name="items" value="${item.id}" id="item_${item.id}" type="checkbox"/>
						<label id="item_${item.id}" for="item_${item.id}">${item.bdmc00}</label>&nbsp;&nbsp;
					</c:forEach>
				
				
				
				</div>
			<a id="addOrganizationUserList" class="button red">添加人员</a> 
			<a id="removeOrganizationUser" class="button red">移除人员</a>
			<div class="blank10"></div>
			<div class="clearfix" style="height:600px">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="width:320,region:'west'">
						<table id="department-treegrid">
						</table>
					</div>
					<div data-options="region:'center'">
						<table id="userList"></table>
					</div>
				</div>
				
				
				<div id="userlisttoolbar">
					<table>
						<tr>
							
							<td class="tr"><a id="saveGuardianItemBtn" class="button medium red">指定监标人标段</a></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
