<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="bid" tagdir="/WEB-INF/tags/bid"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${expertApplyService.createExpertApplyQuery().expertApplyId(processBusinessKey).singleResult()}" var="expertApply" scope="request" />
<c:set value="${expertApply.projectInstance}" var="projectInstance" />
<c:set value="${projectItemService.createProjectItemQuery().expertApplyId(processBusinessKey).list()}" var="projectItemList" />
<c:set value="${evaluationReportService.getEvaluationReportByExpertApplyId(processBusinessKey,projectItemId)}" var="evaluationReport" />
<%
	//String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	pageContext.setAttribute("basePath",basePath);
%>
<%-- <c:set value="${evaluationReportSignService.getListByExpertApplyId(processBusinessKey,projectItemId)}" var="evaluationReportSignList" /> --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>提交评标报告</title>
<sys:link ca="true" uedit="true" easyui="true"/>
<script type="text/javascript" src="/resources/aip/AipMain.js"></script>
	<!--该事件在AIP引擎初始化完毕之后触发-->
	<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
       HWPostil1_NotifyCtrlReady();
	</SCRIPT>
<style type="text/css">
.contentBox {
	position: fixed;
	bottom: 67px;
	height: 500px;
	left: 10%;
	width: 70%;
	min-width: 800px;
	z-index: 1000;
	opacity: 1;
	border-radius: 5px;
	background-color: #fafafa;
}

p {
	text-indent: 2em
}
</style>
<script type="text/javascript">
	$(function() {
		
		$("#sub").click(function(){
            var r = ShowMessageOkCancel("确认提交吗?");
			if(r==1){
                var paramsArray = {"taskId":"${taskId}", "expertApplyId":"${processBusinessKey}","pass":"true","projectItemId":"${projectItemId}"};
                var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/evaluation/completeFormEvaluationReportSign_T");
                if ("redirect:/home" == returnValue) {
                    ShowMessage("文件上传成功");
                    window.location.href="/home";
                } else {
                	if("workflow/taskNotFound"==returnValue){
                    	ShowMessage("任务不存在或已被处理");
                		window.location.href="/home";
                	}else{
                		ShowMessage("文件上传失败");
                		return false;
                	}
                }
			}
		});
		
		$("#scoreDetail").click(function() {
			if ($("#scoreDetail").val() == "显示评分汇总表") {
				$("#scoreDetail").val("隐藏评分汇总表");
			} else {
				$("#scoreDetail").val("显示评分汇总表");
			}
			$("#scoreDetail_divToggle").toggle();
		});
		$("#chatDetail").click(function() {
			if ($("#chatDetail").val() == "显示询标澄清表") {
				$("#chatDetail").val("隐藏询标澄清表");
			} else {
				$("#chatDetail").val("显示询标澄清表");
			}
			$("#chatDetail_divToggle").toggle();
		});
		sealUtil.loadAllSealWithBKey("${evaluationReport.id}","data=string2sign","sealPos");
	});
	
	function HWPostil1_NotifyCtrlReady() {
        document.all.HWPostil1.HideMenuItem(30);
        OpenFile("${pageScope.basePath}/attachment/download/${evaluationReport.pdfAttachment.fjid00}");
        //document.all.HWPostil1.ForceSignType=7;
    }
	
</script>
<style type="text/css">
.chatMsg {
	line-height: 20px;
	display: inline-block;
	word-wrap: break-word;
	word-break: break-all;
	text-align: left;
}

.chatMsgBox {
	width: 96%;
	font-family: Tahoma, Verdana, '微软雅黑';
	background-color: #fff;
	border: 1px solid #ccc;
	opacity: 1;
	border-radius: 5px;
	padding: 5px;
}

#displayContent {
	width: 100%;
	height: 450px;
	overflow-y: auto;
	overflow-x: hidden;
}
</style>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			提交评标报告
		</div>
	</div>
	<div class="block">
		<div class="usBox main" style="padding: 3px;height:660px;">
				<!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
				<script src="/resources/aip/LoadAip.js"></script>
				<!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
		</div>
		<%-- <div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
			<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">
				${evaluationReport.evaluationReportContent}
			</div>
			<span id="sealPos"></span>
		</div> --%>
	</div>
	<%-- <div class="contentBox usBox none" id="chatDetail_divToggle">
		<div class="tc">
			<h2 class="tableTitle">${projectInstance.zbxmmc}询标澄清表</h2>
		</div>
		<div class="blank10"></div>
		<div id="displayContent">
			<c:forEach items="${message}" var="m">
				<div class="chatMsgBox">
					发送人：${m.sender.id}&nbsp;&nbsp;${m.sender.userName}&nbsp;&nbsp;&nbsp; 发送时间：
					<fmt:formatDate value="${m.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					<br />
					<div class='chatMsg'>
						<pre>${m.content}</pre>
					</div>
					<br />
				</div>
				<br />
			</c:forEach>
		</div>
	</div>
	<div class="contentBox usBox none" id="scoreDetail_divToggle" style="overflow:auto;">
		<div style="text-align:center;">
			<font style="font-size:14pt;font-weight:bold">${projectInstance.zbxmmc} 专家评分汇总表</font>
		</div>
		<div class="blank10"></div>
		<bid:groupResult expertApplyId="${processBusinessKey}"></bid:groupResult>
		<div class="blank10"></div>
	</div> --%>
	<div class="blank10"></div>
	<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
		<form:form>
			<textarea style="display: none" id="evaluationReportContent" name="evaluationReportContent">${evaluationReport.evaluationReportContent}</textarea>
			<input type="hidden" name="taskId" value="${taskId}" />
			<input type="hidden" name="sealSignData" id="sealSignData"/>
			<input type="hidden" name="sealName" id="sealName"/>
			<input type="hidden" name="expertApplyId" id="expertApplyId" value="${expertApplyId}"/>
			<span style="float:left"> 
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/bidOpenStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">开标记录表</a> 
				<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryStatisticsPass?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">初步评审表</a> 
				<%--<a class="button red" href="${pageContext.request.contextPath}/evaluation/priceScoreStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">报价打分表</a>  --%>
				<c:choose>
					<c:when test="${projectInstance.prereviewType=='1'}" >
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/evaluationDetailScoreStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">招标评分表</a> 
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/tenderItemSortStatistics?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">投标人排序表</a>
					</c:when>
					<c:otherwise>
						<a class="button red" href="${pageContext.request.contextPath}/evaluation/preliminaryStatistics1?expertApplyId=${processBusinessKey}&projectItemId=${projectItemId}" target="_blank">详细评审表</a>
					</c:otherwise>
				</c:choose>
			</span>
			<span style="float:right"> 
				<!-- <input type='button' class="button red" id='chatDetail' value="显示询标澄清表" />
				<input type='button' class="button red" id='scoreDetail' value="显示评分汇总表" /> -->
				<!-- <input type='button' class="button red" value="保存" /> -->
				<input type='button' class="button red" id='sub' value="提交下一步" />
			</span>
		</form:form>
	</div>
	<div class="blank10"></div>
</body>
</html>
