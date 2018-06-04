<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@include file="/common/link.jsp"%>
<script type="text/javascript" src="/resources/page/base/department/listDepartment.js"></script>
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
			部门结构
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<a id="addDepartment" class="button red">添加部门</a> 
			<a id="editDepartment" class="button red">编辑部门</a> 
			<a id="removeDepartment" class="button red">删除部门</a>
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
							<td class="tl">姓名/拼音: <input name="userName" class="inputxt" /> 包含子部门人员: <input name="cascade" type="checkbox" value="true" checked="checked" onchange="queryOrganizationUser();" />
							</td>
							<td class="tr"><a id="searchBtn" class="button medium red" onclick="queryOrganizationUser();">查 询</a></td>
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
