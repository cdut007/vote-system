<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<ul id="organroleauthtree" class="easyui-tree" data-options="fit:true,url:'${pageContext.request.contextPath}/organRole/getMenuCheckedTreeByOrganRoleId?id=${id}',animate:true,checkbox:true,cascadeCheck:false,onCheck:customCascadeCheck,onContextMenu:checkAllChildren"></ul>