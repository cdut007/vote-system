<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>澄清文件确认</title>
<sys:link uedit="true" jgrowl="true" easyui="true" ca="true"/>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<script type="text/javascript">
	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${bidEndingQuestion.pdfAttachment.fjid00}");
	    //document.all.HWPostil1.ForceSignType=7;
	}
	
	$(function() {
		
		var bidEndingQuestionId = "${bidEndingQuestion.id}";
		$("#id").val(bidEndingQuestionId);
		
		$("#sub").click(function() {
			
			$("#receiptForm").ajaxSubmit({
				dataType:"json",
				beforeSend:function(){
					$.messager.progress({
						title:"系统提示",
						msg:"正在提交投标回执确认信息"
					});
				},
				success : function(data) {
					if(data.success){
						//$.messager.alert("系统提示","确认成功！","info",function(){
							window.location="${pageContext.request.contextPath}/question/pagingBidEndingQuestionConfirmList";
						//});
					}
				},
				complete:function(){
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
			澄清文件确认
		</div>
	</div>
	<form id="receiptForm" action="${pageContext.request.contextPath}/question/confirmBidEndingQuestion" method="post" >
		<div class="block">
		
			<div id="HZNR" style="display:none;padding:50px;border:1px solid #ddd">${questionAnswer }</div>
			<input type="hidden" id="id" name="id" />
			
			<div style="width:100%;background:#f1f1f1;border:1px solid #ddd;height:660px;">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
			</div>
			
		</div>
		<div class="blank10"></div>
		<div class="block"> 
			<a class="button red" id='sub'>确认 </a>
		</div>
		<div class="blank10"></div>
	</form>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>