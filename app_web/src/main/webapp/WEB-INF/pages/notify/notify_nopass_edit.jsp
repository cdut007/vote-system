<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- 
Describe:修改中标通知表单
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

	var notifyId="${notify.id}";
	var notifyContent;
	//var organIds="${notify.organId}";
	var projectInstanceId="${notify.projectInstanceId}";
	var projectItemId="${notify.projectItemId}";
	

	
	function doSave(){//alert("doSave");
		/*var projectInstanceId=document.getElementById("projectInstanceId").value;
		if(projectInstanceId==""){
			$.messager.alert('提示','必须选择招标项目','info');
			return;
		}
		
		var projectItemId=document.getElementById("bdjh").value;
		if(projectItemId==""){
			$.messager.alert('提示','必须选择标段','info');
			return;
		}
		
		var bidOrgan=organId;
		
		if(bidOrgan==""){
			$.messager.alert('提示','没有中标机构','info');
			return;
		}*/		
		
		var title=notifyForm.title.value;
		if(title==""){
			$.messager.alert('提示','必须填写标题','info');
			notifyForm.title.focus();
			return;
		}
		
		/*var days=notifyForm.days.value;
		if(days==""){
			$.messager.alert('提示','必须输入签约期限','info');
			notifyForm.days.focus();
			return;
		}	
		
		var linkman=notifyForm.linkman.value;
		if(linkman==""){
			$.messager.alert('提示','必须输入联系人','info');
			notifyForm.linkman.focus();
			return;
		}*/			

		var requestParam={
				id:notifyId,
				//projectInstanceId:projectInstanceId,
				//projectItemId:projectItemId,
				//notifyType:0,
				title:title//,
				//organId:organId,
				//content:notifyContent/*,
				//days:days,
				//linkman:linkman*/
		};
		$.post("${ctx}/bidNotify/save",requestParam,function(data){
			$.messager.alert('提示','保存成功！','info');
			window.location = "${pageContext.request.contextPath}/bidNotify/review?id="+notifyId;
		});
	}
	
	function doSign(){
		window.location = "${pageContext.request.contextPath}/bidNotify/review?id="+notifyId;
	}
	
	function loadContent(){//alert("loadContent");
		//var projectInstanceId=document.getElementById("projectInstanceId").value;
		//var projectItemId=document.getElementById("bdjh").value;
		//var days=document.getElementById("days").value;
		//var linkman=document.getElementById("linkman").value;
		var requestParam={
				notifyId:notifyId,
				//organId:organId,
				projectInstanceId:projectInstanceId,
				projectItemId:projectItemId//,
				//days:days,
				//linkman:linkman
		};
		$.ajax({
			url:ctx+"/bidNotify/loadNoPassNotifyContent",
			type:"get",
			data:requestParam,
			dataType:"html",
			success:function(data){
				$("#notifyContent").html(data);
				notifyContent=data;
			}
		});
		
	}
	
	loadContent();
</script>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			中标通知管理
			<code>&gt;</code>
			添加中标通知
		</div>
	</div>
	
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>
				${empty notify.id?"新增":"修改"}中标通知
			</h4>
			<div class="blank10"></div>
			<form:form id="notifyForm" method="post" action='${pageContext.request.contextPath}/notify/save' modelAttribute="notify" onsubmit="return $(this).form('validate');">
				<input type="hidden" name="token" value="${token}" />
				<form:hidden path="id" value="${notify.id}"/>
				<form:hidden path="wordAttachmentId" id="wordAttachmentId"/>
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%">招标项目名称：</td>
						<td colspan="4">
							${notify.projectName}
							<input type="hidden" id="projectInstanceId" name="projectInstanceId" value="${notify.projectInstanceId}"/>
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="vertical-align:middle;">标段（包）:</td>
						 <td style="padding-left:3px;" colspan="4">
							${notify.projectItemName}
							<input type="hidden" id="bdjh" name="bdjh" value="${notify.projectItemId}"/>
						</td> 
					</tr> 
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>未中标单位：</td>
						<td style="text-align: left" colspan="4">
							<span id="bidOrgan">${notify.organName}</span>
						</td>
					</tr>
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>通知标题：</td>
						<td style="text-align: left" colspan="4">
							<form:input cssStyle="width:60%" path="title" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,100]'" missingMessage="请输入公告标题" /><!-- <a id="preview" class="button small orange" target="_blank">预览</a> -->
						</td>
					</tr>					
				</table>
				<table width="100%" style="table-layout:fixed;">
					<tr>
						<td class="need" style="width:10px;">&nbsp;</td>
						<td style="width:15%;">&nbsp;</td>
						<td></td>
						<td class="need" style="width:10px;">&nbsp;</td>
						<td >&nbsp;</td>
					<tr>
						<td class="need"></td>
						<td>通知内容</td>
						<td colspan="4">
							<span id="ggnr"></span><div id="notifyContent" ${notify.status=='0'?"contenteditable='true'":"contenteditable='false'"} style="padding:50px;border:1px solid #ddd">${notify.content}</div><%--${notify.content} --%>
						</td>
					</tr> 
					
				</table>
				<div class="blank10"></div>
				<input type="hidden" id='sealName' name="sealName" value="SigndataStr"/>
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataStrSealName' name="SigndataStrSealName" />
				<input type="hidden" id='SigndataStrSignData' name="SigndataStrSignData" />
				<!--  <input id="addAttachment" type=button class="button red" value="添加附件"/>-->
				<input type="button" class="button red" value="保存" id="save" onclick="doSave()"/><!-- 草稿 -->
				<%--<input type="button" class='button red' value="电子印章" id="sign" onclick="doSign()" /> --%>
				<%--<input type="button" class="button red" value="提交审核" id="complete" /> --%>
				<input type="button" class="button red" value="返回" onclick="history.go(-1)" />
			</form:form>
		</div>
	</div>
</body>
</html>

