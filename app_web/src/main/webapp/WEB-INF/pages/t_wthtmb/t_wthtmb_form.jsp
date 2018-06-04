<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%-- 
Describe:委托合同模板信息表表单
Copyright: Copyright(c)2014
Company: 美宏博科技有限公司
author: ZORO
--%>
<html>
<head>
<link rel="stylesheet" href="plug-in/validform/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="plug-in/validform/css/demo.css" type="text/css" />
<link href="plug-in/validform/plugin/jqtransform/jqtransform.css" type="text/css" rel="stylesheet" />
<style>
.mytable {
	margin-top: 10px;
}

.mytable td {
	font-size: 12px;
	vertical-align: middle
}

.btn {
	color: #484848;
	font: 12px/1.5 arial;
	padding-top: 8px;
	padding-bottom: 8px;
	align: center
}
</style>
<script charset="utf-8" src="js/kindeditor-4.1.1/kindeditor-min.js"></script>
<script charset="utf-8" src="js/kindeditor-4.1.1/zh_CN.js"></script>
<script>
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="mbnr00"]', {
			allowFileManager : true,
			afterBlur : function() {
				this.sync();//同步KindEditor的值到textarea文本域
			}
		});
	});
</script>

<script type="text/javascript">
	function saveInfo() {
		$.ajax({
			url : "${pageContext.request.contextPath}/t_wthtmb/saveOrUpdate",
			data : $("#t_wthtmb_form_id").serialize(),
			type : "post",
			dtaType : 'json',
			success : function(data) {
				alert(data.msg);
				$('#li').html();
			},
			error : function(data) {
				alert(data.msg);
			}
		});
		/*$('#t_wthtmb_form_id').submit();
		window.close(); */
	}
</script>
</head>
<body>
	<h3 style="text-align:left;font-weight:bold">模板:${t_wthtmb.mbmc00}</h3>
	<form id="t_wthtmb_form_id" class="registerform" action="${pageContext.request.contextPath}/t_wthtmb/saveOrUpdate" method="post">
		<input type='hidden' name="id" value="${t_wthtmb.id}" /> <input type='hidden' name="mbcjr0" value="${t_wthtmb.mbcjr0}" /> <input type='hidden' name="mbcjsj"
			value='<fmt:formatDate value="${t_wthtmb.mbcjsj}" type="both" dateStyle="default" timeStyle="default" />' />
		<table class="mytable" style="width:98%;">

			<tr>
				<td width="120px">模板名称</td>
				<td style="text-align: left"><input name="mbmc00" type="text" value="${t_wthtmb.mbmc00}" class="inputxt" datatype="s1-50" nullmsg="请输入模板名称！" /></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
				<td width="120px">模板类型</td>
				<td style="text-align: left"><select name="mblx00" style="width:175px;">
						<option value="">请选择</option>
						<c:forEach items="${util:dictionaryTree('MBLB00',false)}" var="item">
							<option value="${item.itemCode}" ${item.itemCode==t_wthtmb.mblx00?selected='selected'"":""}>${item.itemName}</option>
						</c:forEach>
				</select></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
			<tr>
				<td colspan='5'><textarea name="mbnr00" style="width:780px;height:450px;overflow-y:visible">
								${t_wthtmb.mbnr00}
							</textarea></td>
				<td><div class="infostyle">
						<span class="Validform_checktip"></span> <span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span>
					</div></td>
			</tr>
		</table>
	</form>
	<input type="button" class="btn" onclick="saveInfo()" value="保存" />
	<input type="button" class="btn" onclick="javascript:window.close()" value="关闭" />
	<script type="text/javascript" src="/resources/plug-in/validform/js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="/resources/plug-in/validform/js/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript" src="/resources/plug-in/validform/plugin/jqtransform/jquery.jqtransform-min.js"></script>
	<script type="text/javascript">
		$(function() {
			//$(".registerform").Validform();  //就这一行代码！;
			$(".registerform").Validform({
				tiptype : function(msg, o, cssctl) {
					if (!o.obj.is("form")) {
						var objtip = o.obj.parents("td").next().find(".Validform_checktip");
						cssctl(objtip, o.type);
						objtip.text(msg);

						var infoObj = o.obj.parents("td").next().find(".infostyle");
						if (o.type == 2) {
							infoObj.fadeOut(200);
						} else {
							if (infoObj.is(":visible")) {
								return;
							}
							var left = o.obj.offset().left, top = o.obj.offset().top;

							infoObj.css({
								left : left + 170,
								top : top - 45
							}).show().animate({
								top : top - 35
							}, 200);
						}

					}
				},
				usePlugin : {
					jqtransform : {}
				}
			});
		});
	</script>
</body>
</html>

