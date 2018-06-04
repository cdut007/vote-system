<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<ul id="roleauthtree" class="easyui-tree"
	data-options="fit:true,url:'${pageContext.request.contextPath}/role/getMenuCheckdTreeByRoleId?id=${id}',checkbox:true,cascadeCheck:false,onCheck:customCascadeCheck,onContextMenu:checkAllChildren">
</ul>
