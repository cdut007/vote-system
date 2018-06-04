<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:招投标主体基本信息管理表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<jsp:include page="/common/link.jsp" />
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			系统管理
			<code>&gt;</code>
			菜单维护
			<code>&gt;</code>
			添加菜单
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<table id="organList"></table>
			<script type="text/javascript">
				$("#organList").datagrid({
					title : "机构列表",
					singleSelect : true,
					rownumbers : true,
					fitColumns : true,
					pagination : true,
					idField : "id",
					striped : true,
					animate : false,
					url : "${pageContext.request.contextPath}/t_organ/organ_list",
					columns : [ [ {
						field : "ztmc00",
						title : "单位名称",
						width:120
					}, {
						field : "ztdm00",
						title : "组织机构代码"
					}, {
						field : "fzr000",
						title : "负责人"
					}, {
						field : "phone",
						title : "联系电话"
					}, {
						field : "email",
						title : "企业邮箱"
					}, {
						field : "region",
						title : "行政区划"
					}, {
						field : "industry",
						title : "行业类别"
					}, {
						field : "organRoles",
						title : "机构角色",
						formatter : function(value) {
							var roleNames = "";
							for (var i = 0; i < value.length; i++) {
								if (i > 0)
									roleNames += ",";
								roleNames += value[i]["roleName"];
							}
							return roleNames;
						}
					}, {
						field : "id",
						title : "操作",
						formatter : function(value) {
							return "<a class=\"button orange small\" href=\"${pageContext.request.contextPath}/system/organrole_form?id=" + value + "\">查看</a>";
						}
					} ] ]
				});
			</script>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>
