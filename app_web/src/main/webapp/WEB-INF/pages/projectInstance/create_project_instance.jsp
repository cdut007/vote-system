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
<script type="text/javascript">


$(function(){
	$("#save_button").click(function(){
		
		$("#project_instance_form").ajaxSubmit({
			url:"${pageContext.request.contextPath}/projectInstance/saveProjectInstance",
			type:"post",
			dataType:"json",
			beforeSend:function(){
				var valid = $("#project_instance_form").form("validate");
				if(valid==true){
					$.messager.progress({title:"系统提示",msg:"正在提交"});
					$("#save_button").attr("disabled","disabled");
				}else{
					return false;
				}
			},
			complete:function(){
				$.messager.progress("close"); 
			},
			success:function(result){
				var msg=result.msg;
				if(result.success){
					$.messager.alert("系统提示",msg);
					if($("#createByAgency").val()=="true"){
						window.location="${pageContext.request.contextPath}/projectInstance/agencylayout";
					}else{
						window.location="${pageContext.request.contextPath}/projectInstance/tendereelayout";
					}
				}else{
					$.messager.alert("系统提示",msg,"error");
					$("#save_button").removeAttr("disabled");
				}
			},
			error:function(){
				$.messager.alert("系统提示","存取数据失败");
			}
		});	
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
				<form method="post" id="project_instance_form" action="${pageContext.request.contextPath}/projectInstance/saveProjectInstance" onsubmit="return $(this).form('validate');">
			
					<input type="hidden" name="token" value="${token}" /> 
					<input type="hidden" name="createByAgency" value="${instance.createByAgency}" id="createByAgency"/> 
					
					<jsp:include page="createProjectInstance.jsp" />
					<div class="blank10"></div>
					<input type="button" class='button red' value="保 存"  id="save_button" /> <input type="reset" class='button red' value="重 置" />
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
