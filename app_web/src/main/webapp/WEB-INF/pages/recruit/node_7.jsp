<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib
	prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<title>招标文件项目经理审核</title>
<c:set
	value="${recruitFileService.createRecruitFileQuery().recruitFileId(processBusinessKey).singleResult()}"
	var="recruitFile" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<sys:link easyui="true" />
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
	pageContext.setAttribute("basePath",basePath);
%>
<head>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
<!--该事件在AIP引擎初始化完毕之后触发-->
<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>

<SCRIPT LANGUAGE=javascript>
	
		function HWPostil1_NotifyCtrlReady() {
	   		 document.all.HWPostil1.HideMenuItem(30);
	   		 OpenFile("${pageScope.basePath}/attachment/download/${recruitFile.pdfAttachment.fjid00}");
		}
	
		function strToJson(str){ 
    		var json = eval('(' + str + ')'); 
    		return json; 
   		 } 

	</SCRIPT>
<script type="text/javascript">
        $(function() {
            $("#pass").click(function(){
                $(this).parent("form").submit();
            });
            $("#nopassReason").dialog({
    			open : false,
    			title : '不通过原因',
    			closed:true,
    			modal:true,
    			width:600,
    			height:400,
    			buttons:[
    				{text:"提交",handler:function(){
    					if($("#reason").val()===""){
    						ShowMessageOkCancel("请填写原因内容！");
    						return;
    					}
    					var r=ShowMessageOkCancel("确认提交？") ;
    						if (r) {
    							   $("input[name=pass]").val("false");
    							   $("input[name=nopassReason]").val($("#reason").val());
    							   $("#unpass").parent("form").submit();
    						}
    				}},
    				{text:"关闭",handler:function(){
    					$('#nopassReason').dialog('close');
    				}}
    			]
    		});
    		//不通过按钮确认
    		$("#unpass").click(function(event) {
    			$(document).scrollTop(0);
    			$("#nopassReason").dialog("open");
    			$("#reason").focus();
    		});
		});
	</script>

</head>
<body class="easyui-layout" style="BACKGROUND: #ccc">
	<div data-options="region:'center',border:false">
		<div class="usBox main" style="padding: 3px; height: 630px;" id="">
			<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
			<script src="/resources/aip/LoadAip.js"></script>
			<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
		</div>
	</div>
	<div id="nopassReason">
				<textarea id="reason" style="position:absolute;width:560px;height:340px;"></textarea>
				<iframe frameborder=0 scrolling=no style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0;left:0;"></iframe>
	</div>
	<div data-options="region:'south',height:40,split:false"
		style="padding: 4px; text-align: right; background-color: #efefef;">
		<form
			action="${pageContext.request.contextPath}/workflow/completeForm"
			method="post">
			<input type="hidden" name="taskId" value="${taskId}" /> <input
				type="hidden" name="pass" value="true" />
				<input type="hidden" name="nopassReason" value="不通过" />
				<input type="button" class="button red" value="通过" id="pass" /> 
				<input type="button" class="button red" value="不通过" id="unpass" />
		</form>
	</div>
</body>
</HTML>
