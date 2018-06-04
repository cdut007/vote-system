<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<c:set value="${tenderNoticeService.getNotice(noticeId)}" var="notice" scope="request"></c:set>
<%-- <c:set value="${tenderNoticeService.getSignatureDataById(noticeId)}" var="signatureData"></c:set> --%>
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true" />
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<script type="text/javascript">
	$(function() {
		//验证电子印章
		//sealUtil.loadAllSealWithBKey("${noticeId}","data=string2sign","sealPos");
		
		$("#pass").click(function() {
			var ptfy = $("#PTSYF").val();
			var ggxz = $("#GGXZ").text();		
			if(ggxz != "撤销公告"){
				if(ptfy == null || ptfy == ""){
					ShowMessageOkCancel("请填写平台使用费！");
					return;
				}
				if(isNaN(ptfy) || ptfy <= 0){
					ShowMessageOkCancel("请输入正确的平台使用费！");
					return;
				}
			}
			$("input[name=pass]").val("true");
			$("#noticeForm").submit();
		});
		$("#unpass").click(function() {
			if ($.trim($("#shyj").val()) == '') {
				ShowMessageOkCancel("请填写审核意见！");
				return;
			}
			if($("#shyj").val().length > 1000){
				ShowMessageOkCancel("最多输入1000个汉字(包含符合和空格)！");
				return;
			}
			/* if(!sealUtil.sealExists(sealName)){
				$.messager.alert('系统提示',"请先盖章！");
				return;
			} */
			$("input[name=pass]").val("false");
			$("#noticeForm").submit();
		});
		
		$("#attachment").datagrid({
			title:"附件列表",
			rownumbers:true,
			striped:true,
			url:ctx+"/attachment/listAttachment",
			idField:"fjid00",
			queryParams:{"fjsszt":$("#attachmentSsztId").val()==""?"-1":$("#attachmentSsztId").val()},
			height:150,
			columns:[[
			  {title:"附件名称",field:"fjmc00",width:200},
			  {title:"上传时间",field:"uploadTime",width:100},
			  {title:"附件大小",field:"length",width:100,align:"right",formatter:function(value){
				  return castSize(value);
			  }},
			  {title:"附件类型",field:"fjgslx",width:100},
			  {title:"操作",field:"opt",width:100,align:'center',formatter:function(value,rowData,index){
				  return "<a target=\"_blank\" href=\""+ctx+"/attachment/download/"+rowData["path"]+"\">下载</a>";
			  }}
			]]
		});
	});
	
	$(document).ready(function(){
		var ggxz = $("#GGXZ").text();		
		if(ggxz == "撤销公告"){
			$("#PTFY").css("display","none");
		}
	});
	
	function HWPostil1_NotifyCtrlReady() {
	    document.all.HWPostil1.HideMenuItem(30);
	    OpenFile("${pageScope.basePath}/attachment/download/${notice.pdfAttachment.fjid00}");
	    //document.all.HWPostil1.ForceSignType=7;
	}
	
    document.onkeydown = function (event) {
        var e = event || window.event;
        if (e && e.keyCode == 13) {return false;}
    }; 
	
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标/资格预审公告审核
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标/资格预审公告审核</h4>
			<form:form id="noticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="notice" onsubmit="return $(this).form('validate');">
				<input type='hidden' name="id" value="${notice.id}">
				<input type='hidden' name="taskId" value="${taskId}">
				<form:hidden path="attachmentSsztId" id="attachmentSsztId"/>
				
				<input type='hidden' name="projectInstance.zbxmbh" value="${notice.projectInstance.zbxmbh}">
				<input type="hidden" id='signData' name="signData" />
				<%-- <input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" value="${signatureData.sealName}"/>
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" value="${signatureData.signatureData}"/> --%>
				<form:hidden path="ggnrwb" id="ggnrwb" />
				<table width="100%" class="mytableStyle" style="table-layout:fixed;">
					<tr>
						<th>招标项目名称：</th>
						<td colspan="3">${notice.projectInstance.zbxmmc}</td>
					</tr>
					<tr>
						<th>标段（包）编号集合:</th>
							<td colspan="3">
								<c:forEach items="${notice.projectItemList}" var="item">
								<nobr>${item.bdbh00}</nobr>&nbsp;&nbsp;
								</c:forEach>
							</td>
					</tr>
					<tr>
						<th>公告标题：</th>
						<td colspan="3">${notice.noticeTitle}</td>
					</tr>
					<tr>
						<th style="width:15%;">公告类型：</th>
						<td>${util:dictionary('GGLXDM',notice.gglxdm)}</td>
						
						<th style="width:15%;">公告性质：</th>
						<td id="GGXZ">${util:dictionary('GGXZDM',notice.ggxzdm)}</td>
					</tr>
					<tr>
						<th>${notice.projectItemType=='A'?'施工':(notice.projectItemType=='B'?'交货':(notice.projectItemType=='C'?'服务':''))}地点：</th>
						<td>${notice.tenderNoticeData.deliveryPlace}</td>
						<th>${notice.projectItemType=='A'?'工期':(notice.projectItemType=='B'?'交货期':(notice.projectItemType=='C'?'服务周期':''))}：</th>
						<td>
							<c:forEach items="${notice.projectItemList}" var="item" varStatus="num">
								<div>${item.bdmc00}:${item.deliveryTimeLimit }</div>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>招标文件获取开始时间：</th>
						<td><fmt:formatDate value="${notice.tenderNoticeData.applyDateBegin}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th>招标文件获取截止时间：</th>
						<td><fmt:formatDate value="${notice.tenderNoticeData.applyDateEnd}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th>招标文件获取方法：</th>
						<td colspan="3">${notice.tenderNoticeData.bidFileObtainWay}</td>
					</tr>
					<tr>
						<th>投标文件递交截止时间：</th>
						<td><fmt:formatDate value="${notice.tenderNoticeData.bidDeadline}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th>投标文件递交方法：</th>
						<td>${notice.tenderNoticeData.bidSendForm}</td>
					</tr>
					<tr>
						<th>开标时间：</th>
						<td><fmt:formatDate value="${notice.tenderNoticeData.bidOpenDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th>开标地点：</th>
						<td>${notice.tenderNoticeData.bidOpenPlace}</td>
					</tr>
					<tr>
						<th>公告发布时间：</th>
						<td><fmt:formatDate value="${notice.ggfbsj}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th>公告结束时间：</th>
						<td><fmt:formatDate value="${notice.ggjssj}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th>公告发布责任人：</th>
						<td>${notice.fbzrr0}</td>
						<th>交易平台验证责任人：</th>
						<td>${notice.yzzrr0}</td>
					</tr>
					<tr>
						<th style="vertical-align:middle">公告发布媒体:</th>
						<td colspan='3'>${notice.tenderNoticeData.ggfbmt}</td>
					</tr>
					
						<tr>
							<th style="vertical-align:middle"></th>
							<td colspan='3'>
								<table id="attachment"></table>
							</td>
					</tr>
					<tr>
						<th style="vertical-align:middle">公告内容:</th>
						<td colspan='3'><span id="ggnr"></span>
							<%-- <div id="noticeContent" style="border:1px solid #ddd;padding:50px;">${notice.ggnrwb}</div>
							<span id="sealPos"></span> --%>
							<div class="usBox main" style="padding: 3px;height:660px;" id="">
								<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
								<script src="/resources/aip/LoadAip.js"></script>
								<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
							</div>
						</td>
					</tr>
<!--  					<tr>
						<th style="vertical-align:middle">推送公共服务平台:</th>
						<td colspan='3'>
							<div><label for="connectPublicService-true">是</label><input type="radio" id="connectPublicService-true" name="connectPublicService" value="true"/></div>
							<div><label for="connectPublicService-false">否</label><input type="radio" id="connectPublicService-false" name="connectPublicService" value="false"  checked="checked"/></div>
						</td>
					</tr>-->
					<tr>
						<th style="vertical-align:middle">审核意见:</th>
						<td colspan='3'><textarea id="shyj" name="shyj" style="width:99%;height:120px;" class="inputxt easyui-validatebox" data-options="validType:'length[0,1000]'"></textarea></td>
					</tr>
					<tr id="PTFY" >
						<th>
							平台使用费
						</th>
						<td>
							<table>
								<thead>
									<tr>
										<th>标段</th>
										<th>金额</th>
									</tr>
								</thead>
								<c:forEach items="${notice.projectItemList}" var="item">
									<tr>
										<td width="50%">${item.bdmc00}</td>
										<td>
											<input type='hidden' name="itemIdplatformPrice" value="${item.id}" id="${item.id}">
											<input type='hidden' name="sectionId" value="${item.id}">
											<input id="PTSYF" style="width:80px" type='text' name="platformPrice" value="${item.platformPrice}" onblur="$('#${item.id}').val('${item.id}||||'+this.value);">元

												<%--<form:input path="platformPrice"/>--%>
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
				</table>
				<div class="blank10"></div>
				<input type="hidden" name="pass" value="true" />
				<!-- <input type="button" class="button red" value="电子印章" id="sign" /> -->
				<input type="button" class="button red" value="通过" id="pass" />
				<input type="button" class="button red" value="不通过" id="unpass" />
				
			</form:form>
		</div>
	</div>
</body>
</html>