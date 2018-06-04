<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<div class="easyui-layout" data-options="fit:true" style="width:800px;height:560px;">
	<div data-options="region:'center',border:false" style="padding:2px;">
		<table id="addroleuser-datagrid" class="easyui-datagrid" data-options="toolbar:'#addusertoolbar',url:'${pageContext.request.contextPath}/user/pagingUserData',rownumbers:true,border:true,pagination:true,fit:true,idField: 'id',striped:true,pageSize:20,queryParams:{notRoleId:'${notRoleId}'}">
			<thead>
				<tr>
					<th data-options="field:'id',checkbox:true"></th>
					<th data-options="field:'userName',width:80">用户姓名</th>
					<th data-options="field:'gender',width:60">性别</th>
					<th data-options="field:'createDate',width:100">添加时间</th>
					<th data-options="field:'modifyDate',width:100">最后修改时间</th>
					<th data-options="field:'deleteMark',width:100">帐号状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<div id="addusertoolbar">
	<form id="searchform">
		<table>
			<tr>
				<td>
					姓名/拼音: <input name="userName" class="inputxt" />
				</td>
				<td>
					<a class="button red small" onclick="$('#addOrganizationUserList').datagrid('reload',{notOrganizationId:'${organizationId}',userName:$('[name=userName]').val(),subjectId:$('[name=subjectId]').val()});"> <span class="icon-botton icons-main_images_Search"> </span>查 询</a>
				</td>
			</tr>
		</table>
	</form>
</div>