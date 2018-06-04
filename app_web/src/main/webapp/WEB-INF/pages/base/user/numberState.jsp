<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Constants.PLATFORM_NAME%></title>
<jsp:include page="/common/link.jsp" />
</head>

<body>

	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			会员管理
			<code>&gt;</code>
			会员账号状态
		</div>
	</div>

	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form:form id="userForm" commandName="userForm" method="post">
					<form:hidden path="id" />
					<table width="100%"  class="mytableStyle">
						<tr>
							<th style="width:200px">登录账号</th>
							<td>${userForm.loginName}</td>
						</tr>
						<tr>
							<th>机构代码</th>
							<td>${userForm.organ.ztdm00}</td>
						</tr>
						<tr>
							<th>机构名称</th>
							<td>${userForm.organ.ztmc00}</td>
						</tr>
						<tr>
							<th>是否缴费</th>
							<td>${util:dictionary('IS_PAY',userForm.isPay)}</td>
						</tr>

						<tr>
							<th>营业执照号码</th>
							<td>${userForm.organ.yyzzhm}</td>
						</tr>
						<tr>
							<th>CA证书编号</th>
							<td>${userForm.organ.cazsbh}</td>
						</tr>
						<tr>
							<th>税务登记号码</th>
							<td>${userForm.organ.swdjh0}</td>
						</tr>
						<tr>
							<th>开户名称</th>
							<td>${userForm.organ.accountName}</td>
						</tr>
						<tr>
							<th>开户银行</th>
							<td>${userForm.organ.khyh00}</td>
						</tr>
						<tr>
							<th>基本账户账号</th>
							<td>${userForm.organ.jbzhzh}</td>
						</tr>
						
						<tr>
							<th>注册资本</th>
							<td>${userForm.organ.zczb00}${util:dictionary('JEDWDM',userForm.organ.zczbdw)} (${util:dictionary('CURRENCY',userForm.organ.zczbbz)})</td>
						</tr>
						<tr>
							<th>审核状态</th>
							<td>${util:dictionary('JGSHZT',userForm.isAudits)}</td>
						</tr>
						<tr>
							<th>回退原因</th>
							<td>${userForm.backReason}</td>
						</tr>
					</table>
					<div class="blank10"></div>
					<input type="button" class="button orange" value="编辑" onclick="window.location='${pageContext.request.contextPath}/organ/organEdit'" />
					<input type="button" class="button blue" value="返回" onclick="window.location='${pageContext.request.contextPath}/home'" />
				</form:form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#saveUser').on('click', function() {
			$.ajax({
				url : '${pageContext.request.contextPath}/organ/organEdit',
				type : 'post',
				dataType : 'json',
				data : $('#userForm').serialize(),
				success : function(json) {
					alert("操作成功");
				}
			});
		});

	});
</script>
</html>