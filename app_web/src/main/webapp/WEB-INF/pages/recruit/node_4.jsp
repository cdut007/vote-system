<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>代理机构--指定项目经理</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.wpsm {color: #f00;}
</style>
<script type="text/javascript">
	$(function() {
		$("#rwwpSubmit").click(function() {
			if($(":input[name='ownerId']").val()==""){
				$.jGrowl("请选择项目经理！");
				return;
			}
			$.messager.confirm("系统提示", "确认要提交任务委派信息吗？", function(r) {
				if (r) {
					$("#rwwpForm").attr("action", "${pageContext.request.contextPath}/workflow/completeForm");
					$("#rwwpForm").attr("method", "post");
					$("#rwwpForm").submit();
				}
			});
		});
		$("#user-datagrid").datagrid({
			title:"人员列表",
			url:ctx+"/user/pagingUserData",
			pagination:true,
			rownumbers:true,
			striped:true,
			method:"post",
			height:400,
			queryParams:{},
			singleSelect:true,
			onSelect:function(rowIndex, rowData){
				$(":input[name='ownerId']").val(rowData["id"]);
			},
			columns:[[
			    {field:'id',checkbox:true},
			    {title:"姓名",field:'userName',align:"center",width:100},
			    {title:"性别",field:'gender',align:"center",width:60},
			    {title:"所属部门",field:'department.departmentName',width:80},
			    {title:"联系电话",field:'phone',width:100},
			    {title:"登录账号",field:'loginName',width:80},
			    {title:"添加时间",field:'createDate',width:120},
			    {title:"最后修改时间",field:'modifyDate',width:120},
			    {title:"帐号状态",field:'deleteMark',align:"center",width:100}
			]]
		});
		$("#departmentId").combotree({
			url:ctx + "/department/getDepartmentTree",
			onChange:function(newValue, oldValue){
				$("#user-datagrid").datagrid("options")["queryParams"]["departmentId"]=newValue;
				$("#user-datagrid").datagrid("reload");
			}
		});
		$("#userName").keyup(function(){
			$("#user-datagrid").datagrid("options")["queryParams"]["userName"]=this.value;
			$("#user-datagrid").datagrid("reload");
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			指定项目经理
		</div>
		<div class="usBox">
			姓名:<input name="userName" id="userName" class="inputxt"/>
			&nbsp;
			部门:<input name="departmentId" id="departmentId"/>
			<div class="blank10"></div>
			<table id="user-datagrid" ></table>
			<div class="blank10"></div>
			<form class="registerform" id="rwwpForm" method="post" action="${pageContext.request.contextPath}/workflow/completeForm">
				<input type="hidden" name="taskId" value="${taskId}" />
				<input type="hidden" name="ownerId"/>
				<div>
					<input type="button" class='button red' id="rwwpSubmit" value="提 交" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
