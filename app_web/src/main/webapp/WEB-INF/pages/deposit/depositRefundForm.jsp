<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- 
Describe:保证金退款
Copyright:2017
Company: 成都爱特联科技
author:  lihq
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<jsp:include page="/common/link.jsp" />
</head>
<script type="text/javascript">
$(function() {
	//alert("init");
	$('#projectInstanceId').combobox({   
		//url:"${ctx}/deposit/getProjectInstances",
		valueField: 'id',
		textField: 'zbxmmc',	
		multiple:false,
		panelWidth:"450",
		panelHeight:"auto",//"150",
		//data:eval('[{id:"1",zbxmmc:"11"},{id:"2",zbxmmc:"22"}]'),
		data:eval('${projects}'),
		value:'',
		onLoadSuccess:function(){
			//alert("success");
		},
		onChange:function(newValue,oldValue){
			//alert("changed!");
			//alert("${ctx}/deposit/findProjectItemList?projectInstanceId="+newValue);
			$('#projectItemId').combobox({   
				url:"${ctx}/deposit/findProjectItemList?projectInstanceId="+newValue
			});
		}
	});
	
	$('#projectItemId').combobox({   
		url:"",
		valueField: 'id',
		textField: 'bdmc00',	
		multiple:false,
		panelWidth:"450",
		panelHeight:"auto",
		value:'',
		onChange:function(newValue,oldValue){
			//alert(newValue);
			$('#bidOrgan').combobox({  
				url:"${ctx}/deposit/findTenderOrganList?projectItemId="+newValue
			});
		}
	});
	
	$('#bidOrgan').combobox({   
		valueField: 'organId',
		textField: 'organBName',	
		multiple:false,
		panelWidth:"450",
		panelHeight:"auto",//"150",
		value:'',
		onChange:function(newValue,oldValue){
			//alert(newValue);
		}
	});
	
	$("#save").click(function(){
		doSave();
	});
	
	/*$('#save').bind('click', function(){  
		
	});*/
	
	function doSave(){
		var projectInstanceId=$('#projectInstanceId').combobox("getValue");
		if(projectInstanceId==""){
			$.messager.alert('提示','必须选择招标项目','info');
			return;
		}
		
		var projectItemId=$('#projectItemId').combobox("getValue");
		if(projectItemId==""){
			$.messager.alert('提示','必须选择标段','info');
			return;
		}
		
		var bidOrgan=$('#bidOrgan').combobox("getValue");
		if(bidOrgan==""){
			$.messager.alert('提示','必须选择投标机构','info');
			return;
		}		
		
		var refundMoney=$('#refundMoney').val();
		if(refundMoney==""){
			$.messager.alert('提示','必须输入退款金额','info');
			return;
		}	
		
		//refundForm.submit();
		var id=$('#attachmentSsztId').val();
		
		var requestParam={
			id:id,	
			projectInstanceId:projectInstanceId,
			projectItemId:projectItemId,
			organId:bidOrgan,
			returnMoney:refundMoney
		};
		
		$.post("${ctx}/deposit/saveRefund",requestParam,function(data){
			$.messager.alert('提示','保存成功！','info');
			//notifyId=data;
			$('#attachmentSsztId').val(data);
			window.location = "${pageContext.request.contextPath}/deposit/depositReturnLayout";
		});
	}
	
});

</script>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			保证金退款管理
			<code>&gt;</code>
			添加保证金退款
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				添加保证金退款
			</h4>
			<div class="blank10"></div>
			<form:form id="refundForm" name="refundForm" method="post" action='${pageContext.request.contextPath}/deposit/saveRefund' modelAttribute="refund" onsubmit="return $(this).form('validate');" enctype="multipart/form-data">
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id" value="${refund.id}"/>
				<input type="hidden" id="attachmentSsztId" value="${refund.id}">
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%">招标项目名称：</td>
						<td colspan="4">
							<select id="projectInstanceId" ></select>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td >标段（包）:</td>
						<td colspan="4">
						 	<select id="projectItemId" ></select>
						</td> 
					</tr> 
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>投标单位：</td>
						<td style="text-align: left" colspan="4">
							<select id="bidOrgan" ></select>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>退款金额：</td>
						<td style="text-align: left" colspan="4">
							<input type="text" id="refundMoney" >元
						</td>
					</tr>		
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>上传退款凭证：</td>
						<td style="text-align: left" colspan="4">
							<!-- <input name="attachment" type="file" id="attach" size="50" > -->
							<a id="addAttachment" class="button red">添加附件</a><i>可以上传.jpg .bmp .png</i>
						</td>
					</tr>									
				</table>
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td >
							
							<table id="attachmentUpload"></table>						
						</td>
					<tr>
				</table>
				<div class="blank10"></div>
				<input type="button" class="button red" value="保存" id="save" onclick="doSave()"/>
				<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
			</form:form>
		</div>
	</div>
	<script src="/resources/page/deposit/depositRefund.js" type="text/javascript"></script> 
</body>
</html>

