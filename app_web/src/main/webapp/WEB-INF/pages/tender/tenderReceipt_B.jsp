<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标文件回执</title>
<sys:link uedit="true" jgrowl="true" easyui="true" ca="true"/>
<jsp:include page="/common/link.jsp" />

<script type="text/javascript">
$(function() {
	
	var tenderReceiptId = "${tenderReceipt.id}";
	$("#id").val(tenderReceiptId);
	//获取（显示）印章
	sealUtil.loadAllSealWithBKey(tenderReceiptId,"data=string2sign","sealPos");
	
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
					$.messager.alert("系统提示","投标回执已确认！","info",function(){
						window.location.href=ctx+"/tenderReceipt";
					});
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
			投标文件回执确认
		</div>
	</div>
	<form id="receiptForm" action="${pageContext.request.contextPath}/confirmTenderReceipt" method="post" >
		<div class="block">
		
			<div id="HZNR" style="padding:50px;border:1px solid #ddd">${tenderReceipt.receiptContent }</div>
			<span id="sealPos"></span>
	    	<input type="hidden" id="receiptContent" name="receiptContent" ></input>
	    	<input type="hidden" id="id" name="id" ></input>
			
		</div>
		<div class="blank10"></div>
		<div class="block"> 
			<a class="button red" id='sub'>确认回执</a>
		</div>
		<div class="blank10"></div>
	</form>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
</body>
</html>