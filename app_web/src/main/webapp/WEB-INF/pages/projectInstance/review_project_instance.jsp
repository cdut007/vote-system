<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--项目信息确认 --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建招标项目信息</title>
<%-- <sys:link easyui="true" ztree="true"/> --%>
<sys:link easyui="true" jgrowl="true" plupload="true" ztree="true" uedit="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
<script type="text/javascript">


/*$(function(){
	$("#save_button").click(function(){
		
		$("#project_instance_form").ajaxSubmit({
			url:"${pageContext.request.contextPath}/projectInstance/saveProjectInstance",
			type:"post",
			dataType:"json",
			beforeSend:function(){
				return $("#project_instance_form").form("validate");
			},
			success:function(result){
				var msg=result.msg;
				$.messager.alert("系统提示",msg);
				if($("#createByAgency").val()=="true"){
					window.location="${pageContext.request.contextPath}/projectInstance/agencylayout";
				}else{
					window.location="${pageContext.request.contextPath}/projectInstance/tendereelayout";
				}
			},
			error:function(){
				$.messager.alert("系统提示","存取数据失败");
			}
		});	
	});
});*/

$(function() {
	
	$("#pass").click(function() {
		$("input[name=pass]").val("true");
		$("#project_instance_form").submit();
	});
	$("#unpass").click(function() {
		if ($.trim($("#shyj").val()) == '') {
			$.messager.alert("警告","请填写审核意见！");
			return;
		}
		if($("#shyj").val().length > 1000){
			$.messager.alert("警告","最多输入1000个汉字(包含符号和空格)！");
			return;
		}
		$("input[name=pass]").val("false");
		$("input[name=reason]").val($("#shyj").val());
		$("#project_instance_form").submit();
	});

});


</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			新建招标项目
		</div>
		<div class="blank10"></div>
		<div class="usBox">
			<div class="clearfix">
				<form method="post" id="project_instance_form" action="${pageContext.request.contextPath}/workflow/completeForm" >
					<input type="hidden" name="id" value="${processBusinessKey}" /> 
					<input type='hidden' name="taskId" value="${taskId}">
					<input type="hidden" name="token" value="${token}" /> 
					<input type="hidden" name="createByAgency" value="${instance.createByAgency}" id="createByAgency"/> 
					<div class="easyui-panel" data-options="title:'项目信息',collapsible:true">
					<jsp:include page="reviewProject.jsp" />
					</div><br/>
					<div class="easyui-panel" data-options="title:'招标项目信息',collapsible:true"">
					<jsp:include page="reviewProjectInstance.jsp" />
					</div>
					<div class="blank10"></div>
					<table>
						<tr>
						<td >&nbsp;</td>
						<td style="vertical-align:middle">审核意见：</th>
						<td ><textarea id="shyj" name="shyj" style="width:672px;height:120px;"></textarea></td>
						</tr>
					</table>
					<%--<input type="button" class='button red' value="保 存"  id="save_button" /> 
					<input type="reset" class='button red' value="重 置" />--%>
					<input type="hidden" name="pass" value="true" />
					<input type="hidden" name="reason" value="" />
					<input type="button" class="button red" value="通过" id="pass" /> 
					<input type="button" class="button red" value="不通过" id="unpass" />
					<input type="button" class='button red' value="返 回" onclick="history.back()"/> 
				</form>
			</div>
		</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
	<div id="zbOrgan">
		<table id="zbrTable"></table>
	</div>
</body>
</html>
