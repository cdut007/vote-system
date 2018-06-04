<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- 
Describe:中标通知表单
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
	var notifyContent="${notify.content}";
	var organId="${notify.organId}";
	
	function changeProject(){
		var projectInstanceId=document.getElementById("projectInstanceId");
		
		$.post("${ctx}/bidNotify/findProjectItemList",{projectInstanceId:projectInstanceId.value},function(data){
			var jsonArray=eval("("+data+")");
			var projectItemId=document.getElementById("bdjh");
			projectItemId.options.length = 0;
			
			if(jsonArray.length>0){
				var optionPrompt = document.createElement("option");
				optionPrompt.value = "";
				optionPrompt.innerHTML = "---==请选择==---";
				projectItemId.appendChild(optionPrompt);
				
				for(var i=0;i<jsonArray.length;i++){
					var optionObj = document.createElement("option");
					optionObj.value = jsonArray[i].id;
					optionObj.innerHTML = jsonArray[i].bdmc00;
					projectItemId.appendChild(optionObj);
				}
			}
		});
		
		loadContent();
	}
	
	function changeItem(){
		var projectItemId=document.getElementById("bdjh").value;
		$.post("${ctx}/bidNotify/findOrganByProjectItem",{projectItemId:projectItemId},function(data){
			var jsonArray=eval("("+data+")");
			if(jsonArray.length>0){
				organId=jsonArray[0].id;
				bidOrgan=document.getElementById("bidOrgan");
				bidOrgan.innerHTML=jsonArray[0].ztmc00;
			}else{
				organId="";
				bidOrgan=document.getElementById("bidOrgan");
				bidOrgan.innerHTML="";
			}
			loadContent();
		});
		loadContent();
	}
	
	function changeOrgan(){
		loadContent();
	}


	function doSave(){//alert("doSave");
		var projectInstanceId=document.getElementById("projectInstanceId").value;
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
		
		var title=notifyForm.title.value;
		if(title==""){
			$.messager.alert('提示','必须填写标题','info');
			notifyForm.title.focus();
			return;
		}

		var days=notifyForm.days.value;
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
		}			
		
		if(bidOrgan==""){
			$.messager.alert('提示','没有中标机构','info');
			return;
		}
			
		var requestParam={
				id:notifyId,
				projectInstanceId:projectInstanceId,
				projectItemId:projectItemId,
				notifyType:0,
				title:title,
				organId:bidOrgan,
				content:notifyContent,
				days:days,
				linkman:linkman
		};
		$.post("${ctx}/bidNotify/save",requestParam,function(data){
			$.messager.alert('提示','保存成功！','info');
			//notifyId=data;
			window.location = "${pageContext.request.contextPath}/bidNotify/review?id="+data;
		});
	}
	
	function doSign(){
		window.location = "${pageContext.request.contextPath}/bidNotify/review?id="+notifyId;
	}
	
	function loadContent(){//alert("loadContent");
		var projectInstanceId=document.getElementById("projectInstanceId").value;
		var projectItemId=document.getElementById("bdjh").value;
		var days=document.getElementById("days").value;
		var linkman=document.getElementById("linkman").value;
		var requestParam={
				notifyId:notifyId,
				organId:organId,
				projectInstanceId:projectInstanceId,
				projectItemId:projectItemId,
				days:days,
				linkman:linkman
		};
		$.ajax({
			url:ctx+"/bidNotify/loadNotifyContent",
			type:"get",
			data:requestParam,
			dataType:"html",
			success:function(data){
				$("#notifyContent").html(data);
				notifyContent=data;
			}
		});
		
	}
	

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
							<c:if test="${not empty notify.id || not empty notify.projectInstanceId}">
								${projectInstance.zbxmmc}
								<input type="hidden" id="projectInstanceId" name="projectInstanceId" value="${notify.projectInstanceId}"/>
							</c:if>						
							<c:if test="${empty notify.id }">
								<select id="projectInstanceId" name="projectInstanceId" style="width:60%" missingMessage="请选择招标项目！" data-options="required:true" onchange="changeProject()">
								<option value="">---==请选择==---</option>
								<c:forEach items="${projectInstanceList}" var="projectInstance">
									<c:choose>
										<c:when test="${projectInstance.id == notify.projectInstanceId}">
											<option value="${projectInstance.id}" selected="selected">${projectInstance.zbxmmc }</option>
										</c:when>
										<c:otherwise>
											<option value="${projectInstance.id}">${projectInstance.zbxmmc}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								</select>
							</c:if>
							
						</td>
					</tr>
					<tr>
						<td class="need">*</td>
						<td style="vertical-align:middle;">标段（包）:</td>
						 <td style="padding-left:3px;" colspan="4">
						 	<c:if test="${not empty notify.id || not empty notify.projectItemId}">
								${projectItem.bdmc00}
								<input type="hidden" id="bdjh" name="bdjh" value="${notify.projectItemId}"/>
							</c:if>	
							<c:if test="${empty notify.id }">
							 	<select id="bdjh" name="bdjh" onchange="changeItem()" >
							 	</select>
						 	</c:if>
						</td> 
					</tr> 
					<tr>
						<td class="need" style="width:10px;">*</td>
						<td>中标单位：</td>
						<td style="text-align: left" colspan="4">
							<span id="bidOrgan">${organ.ztmc00}</span>
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
						<td class="need" style="width:10px;">*</td>
						<td style="width:15%;">签约期限（天）：</td>
						<td>
						<form:input id="days" cssStyle="width:30%" path="days" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,16]'" missingMessage="请输入签约期限" onblur="loadContent()" value="${notify.days}" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
						<td class="need" style="width:10px;">*</td>
						<td >联系人： <form:input id="linkman" cssStyle="width:30%" path="linkman" cssClass="inputxt easyui-validatebox" data-options="required:true,validType:'length[0,16]'" missingMessage="请输入签约期限" onblur="loadContent()" value="${notify.linkman}"/></td>
					<tr>
						<td class="need"></td>
						<td>通知内容</td>
						<td colspan="4">
							<span id="ggnr"></span><div id="notifyContent" ${notify.status=='0'?"contenteditable='true'":"contenteditable='false'"} style="padding:50px;border:1px solid #ddd">${notify.content}</div><%--${notify.content} --%>
						</td>
					</tr> 
					
				</table>
				<a id="addAttachment" class="button red">添加附件</a><i>可以上传.pdf .doc .docx</i>
				<table id="attachmentUpload"></table>
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
				<input type="hidden" id="attachmentSsztId" value="${notify.id}"/>
			</form:form>
		</div>
	</div>
	<script src="/resources/page/notice/notifyFile.js" type="text/javascript"></script>
</body>
</html>
<script>
$(function(){
	
	if(notifyId=="") loadContent();
	
	//变更内容更新
	$("#notifyContent").blur(function(){
		$("#content").val(this.innerHTML);
	});
	
	$("projectInstanceId").change(function(){
		//alert("change");
		var projectInstanceId=$("projectInstanceId").combobox("getValue");
		alert(projectInstanceId);
		
		$('#bdjh').combobox({   
			url:"${ctx}/bidNotify/findProjectItemList?projectInstanceId="+projectInstanceId,
			valueField: 'id',
			textField: 'zbxmmc',	
			multiple:false,
			panelWidth:"450",
			panelHeight:"auto",
			value:'${notify.projectInstanceId}'
		});
	});
	
});


</script>
