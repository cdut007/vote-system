<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" datepicker="true" jgrowl="true" uedit="true" ca="true"/>
<script type="text/javascript">
$(function(){
	$("#bind").click(function(){
		var randomStr = "${pageContext.request.session.id}";
		//调用JITDSignOcx的选择证书
		//JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority, O = ShanXi Digital Certificate Authority, L = TaiYuan, S = ShanXi, C = CN", "");
		JITDSignOcx.Initialize(InitParam);
		JITDSignOcx.SetCertChooseType(1);
		JITDSignOcx.SetCert("SC", "", "", "", "", "");
		//JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,OU=RSA,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return false;
		}
		//带原文的数字签名
		var signStr = JITDSignOcx.AttachSignStr("", randomStr);
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return false;
		}
		$.ajax({
			url:ctx+"/user/bindCertInfo",
			type:"post",
			data:{signvalue:signStr},
			dataType:"json",
			success:function(data){
				$.messager.alert("系统提示",data.msg);
			}
		});
	});
	$("#unbind").click(function(){
		$.messager.confirm("系统提示","确认解绑吗?",function(ok){
			if(ok){
				var randomStr = "${pageContext.request.session.id}";
				//调用JITDSignOcx的选择证书
				JITDSignOcx.Initialize(InitParam);
				JITDSignOcx.SetCertChooseType(1);
				JITDSignOcx.SetCert("SC", "", "", "", "", "");
				//JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,OU=RSA,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
				if (JITDSignOcx.GetErrorCode() != 0) {
					alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
					return false;
				}
				//带原文的数字签名
				var signStr = JITDSignOcx.AttachSignStr("", randomStr);
				if (JITDSignOcx.GetErrorCode() != 0) {
					alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
					return false;
				}
				$.ajax({
					url:ctx+"/user/unbindCertInfo",
					type:"post",
					data:{signvalue:signStr},
					dataType:"json",
					success:function(data){
						$.messager.alert("系统提示",data.msg);
					}
				});
			}
		});
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
			会员基本信息维护
		</div>
	</div>

	<div class="block">
		<div class="usBox">
			<div class="clearfix">
				<%--
添加修改用户信息
 --%>
				<form:form id="userForm" commandName="userForm" action="${pageContext.request.contextPath}/user/updateUser"  method="post" onsubmit="return $(this).form('validate');">
					<form:hidden path="id" />
					<table width="100%" style="table-layout:fixed;">
						<tr>
							<td class="need">*</td>
							<td style="width:100px;">姓名：</td>
							<td><form:input path="userName" cssClass="inputxt easyui-validatebox" data-options="required:true"/></td>
							<td><div class="Validform_checktip">
									<form:errors path="userName" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>身份证号：</td>
							<td><form:input path="identityNo" cssClass="inputxt easyui-validatebox"  data-options="required:true,validType:'idcardNo'" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="identityNo" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>性别：</td>
							<td><form:radiobuttons path="gender" items="${util:dictionaryTree('GENDER',false)}"
									itemLabel="itemName" itemValue="itemCode" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="gender" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need">*</td>
							<td>邮箱地址：</td>
							<td><form:input path="email" cssClass="inputxt  easyui-validatebox"  data-options="required:true,validType:'email'" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="email" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>QQ：</td>
							<td><form:input path="qq0000" cssClass="inputxt easyui-validatebox" data-options="validType:'QQ'" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="qq0000" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>联系电话：</td>
							<td><form:input path="phone" cssClass="inputxt" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="phone" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>登录账号：</td>
							<td>${userForm.loginName}</td>
							<td><div class="Validform_checktip">
									<form:errors path="loginName" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>籍贯：</td>
							<td><form:input path="userNative" cssClass="inputxt" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="userNative" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						
						<tr>
							<td class="need"></td>
							<td>生日：</td>
							<td><form:input path="birthday" cssClass="inputxt" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="birthday" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						
						<tr>
							<td class="need"></td>
							<td>民族：</td>
							
							
							
							<td><form:select path="nation" datatype="*" nullmsg="请选择民族！">
									<form:option value="1">请选择</form:option>
									<form:options  items="${util:dictionaryTree('NATION',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="nation" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						
						<tr>
							<td class="need"></td>
							<td>政治面貌：</td>
							<td><form:select path="political" datatype="*" nullmsg="请选择政治面貌！">
									<form:option value="1">请选择</form:option>
									<form:options  items="${util:dictionaryTree('POLITICAL',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="political" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						
						<tr>
							<td class="need"></td>
							<td>宗教信仰：</td>
							<td><form:select path="religion" datatype="*" nullmsg="请选择宗教信仰！">
									<form:option value="1">请选择</form:option>
									<form:options  items="${util:dictionaryTree('RELIGION',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="religion" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>学历：</td>
							<td><form:select path="degreeLevel" datatype="*" nullmsg="请选择学历！">
									<form:option value="1">请选择</form:option>
									<form:options  items="${util:dictionaryTree('EDUCATION',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="degreeLevel" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>最后毕业院校：</td>
							<td><form:input path="graduate" cssClass="inputxt" /></td>
							<td><div class="Validform_checktip">
									<form:errors path="graduate" cssClass="Validform_wrong" />
								</div></td>
						</tr>
						<tr>
							<td class="need"></td>
							<td>是否在职：</td>
							<td><form:select path="isJob" datatype="*" nullmsg="未选择！">
									<form:option value="1">请选择</form:option>
									<form:options  items="${util:dictionaryTree('YES_NO',false)}" itemLabel="itemName" itemValue="itemCode"/>
								</form:select></td>
							<td><div class="Validform_checktip">
									<form:errors path="isJob" cssClass="Validform_wrong" />
								</div></td>
						</tr>
					</table>
					<div class="blank10"></div>
					<input type="button" class="button orange" id="saveUser" value="保存" />
					<input type="button" id="bind" class="button orange" id="saveUser" value="绑定USBKey" />
					<input type="button" id="unbind" class="button orange" id="saveUser" value="解绑USBKey" />
					<input type="button" class="button blue" value="重置" onclick="window.location='${pageContext.request.contextPath}/user/userEdit1'" />
					<input type="button" class="button blue" value="返回" onclick="window.location='${pageContext.request.contextPath}/home'" />
				</form:form>
			</div>
		</div>
	</div>
	<div class="blank"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
<script  type="text/javascript">
$(document).ready(function() { 
	$('#saveUser').on('click', function() {
		$.ajax({
			url:'${pageContext.request.contextPath}/user/updateUser',
			type:'post',
			cache:false,
			dataType:'json',
			data:$('#userForm').serialize(),
			beforeSend : function() {
				return $('#userForm').form("validate");
			},
			success:function(data){
				alert("修改成功");  
			}
		});

	});
	
}); 
  
</script>
</html>