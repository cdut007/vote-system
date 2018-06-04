<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<c:set value="${tenderExceptionService.getEvaluationException(processBusinessKey)}" var="exception" scope="request"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" plupload="true" spectrum="true" jgrowl="true" webedit="true"/>
<script type="text/javascript">
$(function() {
	$("#pass").click(function(){
		var $form=$(this).parent("form");
		if($(".my_word_document>.my_word_comment>.tooltip").length>0){
			$.messager.confirm("系统提示","当前文件已经添加批注，确认通过后将放弃所有批注?", function(ok){
				if(ok){
					$form.submit();
				}
			});	
		}else{
			$.messager.confirm("系统提示","确认选择通过吗?", function(ok){
				if(ok){
					$form.submit();
				}
			});	
		}
	});
	$("#unpass").click(function(){
		var $dialog=$("<div/>").css("padding",5).appendTo($("body")).dialog({
			title:"不同意原因",
			width:430,
			height:360,
			content:"<form action='"+ctx+"/workflow/completeForm'><input type='hidden' name='taskId' value='${taskId}'/><input type='hidden' name='pass' value='false'/><textarea id=\"tstId\" name=\"nopassReason\" style='width:400px;height:250px;' class='easyui-validatebox' data-options='required:true'></textarea></form>",
			buttons:[
				{text:"提交",handler:function(){
					
					if($("#tstId").val()==null || $("#tstId").val()==""){
						$.messager.alert("系统提示","请在批注中添加审核不通过原因!");
						return;
					}
					
					$.messager.confirm("系统提示","确认提交吗?", function(ok){
						if(ok){				
							$dialog.find("form").submit();
						}
					});	
				}},
				{text:"取消",handler:function(){
					$dialog.dialog("destroy");
				}}
			]
		});
		return;
		var $form=$(this).parent("form");
		if($(".my_word_document>.my_word_comment>.tooltip").length==0){
			$.messager.alert("系统提示","请在批注中添加审核不通过原因!");	
		}else{
			$.messager.confirm("系统提示","确认选择不通过吗?", function(ok){
				if(ok){
					$("#webEditor").webEditor("saveDocument");
					$form.children("input[name='pass']").val("false");
					$form.submit();
				}
			});	
		}
	});
});
</script>
</head>
<body class="easyui-layout">

<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标异常报告审核</h4>
			
				<table width="100%" class="mytableStyle" style="table-layout:fixed;">
						<tr>
			<td class="need"></td>
			<td style="width:120px;">项目名称:</td>
			<td>
					${exception.expertApply.projectInstance.project.xmmc00}
			</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td style="width:120px;">招标项目名称:</td>
			<td>${exception.expertApply.projectInstanceName}

			</td>
		</tr>
		<tr>
			<td class="need"></td>
			<td style="width:120px;">相关标段（包）名称:</td>
			<td>${exception.projectItem.bdmc00}
			</td>
		</tr>

		<tr>
			<td class="need"></td>
			<td style="width:120px;">报告名称:</td>
			<td>${exception.exceptionTitle}
			</td>
		</tr>

		<tr>
			<td class="need"></td>
			<td style="width:120px;">招标异常情况描述:</td>
			<td>${exception.exceptionContent}
			</td>
		</tr>
				</table>
				<div data-options="region:'south',height:40,split:false" style="padding:4px;text-align:right;background-color:#efefef;">
		<form action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
			<input type="hidden" name="taskId" value="${taskId}"/>
			<input type="hidden" name="pass" value="true"/>
			<input type="button" class="button red" value="通过" id="pass"/>
			<input type="button" class="button red" value="不通过" id="unpass"/>
		</form>
	</div>
		</div>
	</div>
	
</body>
</html>