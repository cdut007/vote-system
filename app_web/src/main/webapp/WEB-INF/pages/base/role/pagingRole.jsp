<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/page/base/role/pagingRole.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			企业管理
			<code>&gt;</code>
			角色管理
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<a class="button red" onclick="addRole();">添加角色</a> 
			<a class="button red" onclick="editRole();">编辑角色</a>
			<a class="button red" onclick="removeRole();">删除角色</a>
			<a class="button red" onclick="grantRole();">角色授权</a>
			<a class="button red" onclick="addRoleUser();">添加人员</a> 
			<a class="button red" onclick="removeRoleUser();">移除人员</a>
			<div class="blank10"></div>
			<div class="clearfix" style="height:600px">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="width:320,region:'west'">
						<table id="role-datagrid"></table>
					</div>
					<div data-options="region:'center'">
						<table id="userList"></table>
					</div>
				</div>
				<div id="userlisttoolbar">
					<table>
						<tr>
							<td class="tl">姓名/拼音: <input name="userName" class="inputxt" />
							</td>
							<td class="tr"><a class="button small red" onclick="queryRoleUser();">查 询</a></td>
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
