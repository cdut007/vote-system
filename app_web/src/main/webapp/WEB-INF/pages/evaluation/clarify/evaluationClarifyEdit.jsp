<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建澄清文件</title>
<sys:link uedit="true" jgrowl="true" easyui="true" />
<script type="text/javascript">
	$(function() {
		var ue = UE.getEditor('modifyContent', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold',
					'italic', 'underline', '|', 'forecolor', 'backcolor',
					'selectall', 'cleardoc', '|', 'customstyle', 'paragraph',
					'fontfamily', 'fontsize', '|', 'justifyleft',
					'justifycenter', 'justifyright', 'justifyjustify', '|',
					'inserttable', 'deletetable', 'insertparagraphbeforetable',
					'insertrow', 'deleterow', 'insertcol', 'deletecol',
					'mergecells', 'mergeright', 'mergedown', 'splittocells',
					'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		});
		$("#sub").click(function() {
			$("#clarifyForm").ajaxSubmit({
				dataType : "json",
				data : {
					isComplete : true
				},
				beforeSend : function() {
					$.messager.progress({
						title : "系统提示",
						msg : "正常保存澄清文件"
					});
				},
				success : function(data) {
					if (data.success) {
						$.messager.alert("系统提示", data.msg, "info", function() {
							window.close();
						});
					}
				},
				complete : function() {
					$.messager.progress("close");
				}
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			发起澄清
		</div>
	</div>
	<form id="clarifyForm" action="${pageContext.request.contextPath}/evaluationClarify/createOrUpdateEvaluationClarify" method="post">
		<input type='hidden' name="expertApplyId" value="${expertApplyId}" /> <input type='hidden' name="tenderItemId" value="${tenderItem.id}" /> <input type='hidden' name="projectItemId" value="${tenderItem.projectItemId}" /> <input type='hidden' name="projectInstanceId" value="${tenderItem.projectInstanceId}" /> <input type='hidden' name="projectItemName" value="${tenderItem.projectItemName}" /> <input type='hidden' name="projectInstanceName" value="${tenderItem.projectInstanceName}" />
		<div class="block">
			<table class="mytableStyle">
				<tr>
					<th>项目名称</th>
					<td>${tenderItem.projectInstanceName}</td>
					<th>标段名称</th>
					<td>${tenderItem.projectItemName}</td>
				</tr>
				<tr>
					<th>投标单位</th>
					<td colspan="3">${tenderItem.organBName}</td>
				</tr>
			</table>
			<div class="blank10"></div>
			<div class="easyui-panel" data-options="title:'澄清需求'" style="overflow: hidden">
				<textarea id="modifyContent" name="question" class="easyui-validatebox" style="height:400px;" data-options="required:true"></textarea>
			</div>
		</div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div class="blank10"></div>
		<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;position:fixed;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
			<span style="float:right"> <a class="button red" id='sub'>发起澄清</a> <a class="button red" onclick="window.close();">关闭</a>
			</span>
		</div>
	</form>
</body>
</html>
