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
<script type="text/javascript">
	$(function() {
		$("#saveUser").click(function(){
			//获取输入的密码
			var oldPassword=$("#oldPassword").val();
			var newPassword=$("#newPassword").val();
			var passwordRepeat=$("#passwordRepeat").val();
			//比对新密码和确认密码
			if(newPassword!=passwordRepeat){
				$.messager.alert("系统提示","两次输入的密码不一致，请重新输入！");
			}else if(oldPassword==""||newPassword==""||passwordRepeat==""){
				$.messager.alert("系统提示","不能为空！");
			}else{
				$.ajax({
					url:ctx+"/user/revisePassword",
					type:"post",
					data:{"oldPassword":oldPassword,"newPassword":newPassword},
					dataType:"json",
					success:function(result){
						if(result.success){
							$.messager.alert("系统提示","修改密码成功！","info",function(){
								window.location=ctx+"/home";
							});
						}else{
							$.messager.alert("系统提示","输入的旧密码与原密码不一致，请重新输入！","error");
						}
					},
					error:function(){
						$.messager.alert("系统提示","连接服务器失败！请重试！");
					}
				});//ajax
			}
		});
	});
</script>
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
			修改密码
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<form method="post">
					<table width="100%" style="table-layout:fixed;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">姓名：</td>
							<td>${userForm.userName} </td>
							<td></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">登录名：</td>
							<td>${userForm.loginName} </td>
							<td></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">旧密码：</td>
							<td>
								<input type="text" id="oldPassword" name="oldPassword"/>
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">新密码：</td>
							<td>
								<input type="text" id="newPassword" name="newPassword"/>
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">确认密码：</td>
							<td>
								<input type="text" id="passwordRepeat" name=passwordRepeat/>
							</td>
							<td></td>
						</tr>
					</table>	
					<div class="blank10"></div>
					<input type="button" class="button orange" id="saveUser" value="保存" />
					<input type="button" class="button blue" value="返回" onclick="window.location='${pageContext.request.contextPath}/home'" />
					
				</form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>