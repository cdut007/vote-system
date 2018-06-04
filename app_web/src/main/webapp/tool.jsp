<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
添加修改用户信息
 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<jsp:include page="/common/link.jsp" />
<!-- 吉大正元签名 -->
<script type="text/javascript" src="/resources/ca/LoadJITDsign.js"></script>
<!--ready事件-->
<script type="text/javascript">
	$(function() {
		$("#decodeBtn").click(function() {
			$("#decode").val(getData($("#encode").val()));
		});
		/* var id="fa3c638e-b069-4efa-8c84-24ae3f107c73";
		$.ajax({
			url:ctx+"/getDigitalEnvelope",
			type:"post",
			data:{"tenderItemId":id},
			success:function(data){
				if(data==""){
					$.messager.alert("系统提示","获取数字信封失败！");
				}
				var orig=getData(data);
				$.ajax({
					url : ctx+"/bidFile/decrypt",
					type : "post",
					data : {
						"orig" : orig,
						"id" : id
					},
					dataType : "json",
					beforeSend : function() {
						$.messager.progress({
							title : "请您耐心等待...",
							msg : "正在解密投标文件并验证电子签名中...",
							text : "请稍后..."
						});
					},
					complete : function() {
						$.messager.progress("close");
					},
					success : function(data) {
						$.messager.alert("系统提示", data.msg);
						$("#bidFile-datagird").datagrid("reload");
						$('#bidOpen-datagrid').datagrid('reload');
					}
				});
			}
		}); */
	});
	function getData(origData) {
		/* origData="MIIBpAYJKoZIhvcNAQcDoIIBlTCCAZECAQAxggFFMIIBQQIBADCBqTCBnDELMAkGA1UEBhMCQ04xDzANBgNVBAgMBlNoYW5YaTEQMA4GA1UEBwwHVGFpWXVhbjEtMCsGA1UECgwkU2hhblhpIERpZ2l0YWwgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MQwwCgYDVQQLDANSU0ExLTArBgNVBAMMJFNoYW5YaSBEaWdpdGFsIENlcnRpZmljYXRlIEF1dGhvcml0eQIIGd9uxrzjm1swDQYJKoZIhvcNAQEBBQAEgYCzErVBFkdqWlywu1zQUesJ1RxuDAhxC21UUMgcOimvwWv5rCClZNCzIxPoY3fiRZWBUlNU5E2RTuaL/MD/bBsbQ/Tv6bSUWzlG4ZQv4RcIbm+vi/LUXEH7bDdDDeSQx6wxHHrOsx4Es8eJpZXenY0fdGiqjRdSLGEJzb1sg0rFljBDBgkqhkiG9w0BBwEwFAYIKoZIhvcNAwcECIiTtkX7ftXkgCAgjAJn46z5dr+ZWPCnyL/ETs3uoUiFtg5Vnlz1YBzG/w=="; */
		var temp_DSign_Release_Result = JITDSignOcx.DecryptEnvelop(origData);
		if (JITDSignOcx.GetErrorCode() != 0) {
			alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
			return;
		}
		var orig = JITDSignOcx.getData();
		/* $("<input/>").appendTo($("body")).val(orig); */
		return orig;
	};
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<form>
			<input type="text" id="encode" /> <a id="decodeBtn" class="easyui-linkbutton">解密</a> <input type="text" id="decode" />
		</form>
	</div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>