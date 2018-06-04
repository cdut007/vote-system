<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/page/base/user/UserList.js"></script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			会员管理
			<code>&gt;</code>
			会员维护
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<!-- <table>
				<tr>
					<td>
						姓名/拼音: <input name="userName" class="inputxt" />
					</td>
					<td>
						登录账号: <input name="loginName" class="inputxt" />
					</td>
					<td>
						<a class="button red" onclick="queryRoleUser();">查 询</a>
					</td>
				</tr>
			</table> -->
			<a class="button red" onclick="selectDetailed();">查看详细</a> 
			<!-- <a class="button red" onclick="editUser();">编辑人员</a> 
			<a class="button red" onclick="removeUser();">删除人员</a> 
			<a class="button red" onclick="auditUser();">审核</a>  -->
			<!-- <a class="button red" onclick="editPay();">确认支付</a>  -->
			<a class="button red" onclick="resetPassword();">重置管理员密码</a>
			<div class="blank10"></div>
			<table id="user-datagrid"></table>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
