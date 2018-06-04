<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" " http://www.w3.org/TR/html4/strict.dtd">
<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<%-- <c:set value="${tenderNoticeService.getSignatureDataById(notice.id)}" var="signatureData"></c:set> --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<sys:link ca="true" uedit="true" easyui="true"/>
<script type="text/javascript">
$(function(){
	//验证电子印章
	sealUtil.loadAllSealWithBKey("${notice.id}","data=string2sign","sealPos");
	//alert($("#SigndataWtrSignData").val());
	/* var temp_DSign_Check_Result = JITDSignOcx.VerifyAttachedSign($("#SigndataWtrSignData").val());
    if(JITDSignOcx.GetErrorCode()!=0 && JITDSignOcx.GetErrorCode()!=-10101029){
    	if(JITDSignOcx.GetErrorCode()!=0 && JITDSignOcx.GetErrorCode()!=-10101037){
      		//V_STATUS.value = "错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode());
	      	$.messager.alert("系统提示","错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
	      	return ;	
    	}
    	else{
    		//Modified by lihe:2005.02.05
	        //V_STATUS.value = "错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode());
			$.messager.alert("系统提示","错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
	        return ;
    	}	
    }else{
	   	if(temp_DSign_Check_Result<0){
	   		$.messager.alert("系统提示"," 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
	   	}
      	var ORG_DATA = JITDSignOcx.getData();
      	var data=$.parseJSON(ORG_DATA);
      	var sealName=data['jc-seal-name'];
      	var positionX=data['jc-seal-position-x'];
      	var positionY=data['jc-seal-position-y'];
      	var nameArray=data['jc-seal-input-list'].split(",");
      	for(var i=0,l=nameArray.length;i<l;i++){
      		var inputName=nameArray[0];
			$(":input[name='"+inputName+"']").each(function(){
				if(encodeURIComponent($(this).val())!=data[inputName]){
					$.messager.alert("系统提示","数据电文验证失败!");
					return;
				}
			});
      	}
     	var imgData=data['jc-seal-data'];
		$("#ggnr").after($("<img/>").attr("src","data:image/png;base64,"+imgData).attr("id",sealName).addClass("jc-seal").css({position:"absolute",top:positionY,left:positionX,width:150,height:150}));
    } */
});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			招标/资格预审公告查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>招标/资格预审公告查看</h4>
			<form:form id="noticeForm" class="registerform" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="notice">
				<input type='hidden' name="id" value="${notice.id}">
				<input type='hidden' name="taskId" value="${taskId}">
				<input type='hidden' name="projectInstance.zbxmbh" value="${notice.projectInstance.zbxmbh}">
				<input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" value="${signatureData.sealName}"/>
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" value="${signatureData.signatureData}"/>
				<form:hidden path="ggnrwb" id="ggnrwb"/>
				<input type="hidden" name="changeContent" value="${notice.changeContent}" />
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
						<td>${util:dictionary('GGXZDM',notice.ggxzdm)}</td>
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
						<td >${notice.tenderNoticeData.bidFileObtainWay}</td>
						<th>保证金支付方式</th>
						<td>${notice.payType=="0"?"支付给代理机构":"支付给平台"}</td>
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
						<th style="vertical-align:middle">公告内容:</th>
						<td colspan='3'>
							<span id="ggnr"></span>
							<div id="noticeContent" style="border:1px solid #ddd;padding:50px;">${notice.ggnrwb}</div>
							<span id="sealPos"></span>
						</td>
					</tr>
				</table>
			</form:form>
		</div>
		<div class="blank10"></div>
		<a class="button orange" onclick="history.go(-1)">返回</a>
	</div>
</body>
</html>