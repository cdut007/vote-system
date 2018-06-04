<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set value="${tenderItemService.createTenderItemQuery().tenderItemId(processBusinessKey).singleResult()}" var="tenderItem"></c:set>
<c:set value="${tenderItem.projectItem}" var="projectItem"></c:set>
<c:set value="${tenderItem.tender}" var="tender"></c:set>
<c:set value="${tender.projectInstance}" var="projectInstance"></c:set>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投标保证金支付</title>
<jsp:include page="/common/link.jsp" />
<style type="text/css">
.money {
	font-weight: bold;
	color: orange;
	font-size: 14px;
}
</style>
<script type="text/javascript">
	function enterUpload() {
		window.showModalDialog("${pageContext.request.contextPath}/attachment/enterUpload?t=" + new Date(), "", "dialogWidth:800px;dialogHeight:500px;");
	}
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<!--ready事件-->
	<div class="block">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			投标保证金支付银
		</div>
		<div class="tableTitle" style="cursor:pointer;" onclick="$('#projectInfo').toggle();">${projectInstance.zbxmmc}（单击隐藏）</div>
		<table class='mytableStyle' id="projectInfo">
			<tr>
				<th width="120px">所属项目</th>
				<td colspan='3'>${projectInstance.project.xmmc00}</td>
			</tr>
			<tr>
				<th>招标项目编号:</th>
				<td>${projectInstance.zbxmbh}</td>
				<th>招标项目名称:</th>
				<td>${projectInstance.zbxmmc}</td>
			</tr>
			<tr>
				<th width="120px">招标人</th>
				<td>${projectInstance.project.organ.ztmc00}</td>
				<th width="120px">代理机构</th>
				<td>${projectInstance.organ.ztmc00}</td>
			</tr>
			<tr>
				<th width="120px">招标方式</th>
				<td></td>
				<th width="120px">组织形式</th>
				<td></td>
			</tr>
			<tr>
				<th width="120px">招标内容与范围</th>
				<td colspan='3'>
					<pre>${projectInstance.nryfw0}</pre>
				</td>
			</tr>
			<tr style="height:40px;">
				<td colspan='4'>
					<span class="money">保证金： ${projectItem.recruitFileData.bidDepositAmount}${util:dictionary('JEDWDM',projectItem.recruitFileData.bidDepositUnit)}(${util:dictionary('CURRENCY',projectItem.recruitFileData.bidDepositCurrency)})</span>
					<div class="fr">
						<form id="payForm" action="${pageContext.request.contextPath}/workflow/completeForm" method="post">
							<input type='hidden' name='taskId' value='${taskId}' /> 
							<a type='button' class='button red' href="${pageContext.request.contextPath}/paybank" target="_blank">网银支付</a>
							<input type='submit' class='button red' value="已使用其它方式支付"/>
						</form>
					</div>
				</td>
			</tr>
		</table>
		<div class="blank10"></div>
		<div class='tableTitle2'>保证金支付凭证上传</div>
			<div class="usBox">
			<y:bidFileUploadify fjsszt="${tenderItem.id}" fjgslx="24" uploadType="2" />
		</div>
		<div class="blank10"></div>
		<div class='tableTitle2'>支付方式说明</div>
		<div class="usBox">
			<p>为最大限度的给代理机构和投标单位提供便利，系统支持以下多种不同的支付方式：</p>
			<br />
			<p style="text-indent: 2em;">
				1、直接在系统中选择网银支付（支付便捷，系统自动对账） <i style="font-size:14pt;color:red">推荐！</i>
			</p>
			<br />
			<p style="text-indent: 10em;">
				<span style="border:1px solid #ccc;color:red;padding:5px;cursor:pointer">网银支付</span>
			</p>
			<br />
			<p style="text-indent: 2em;">2、在系统外直接通过网银支付，柜台转账 （存在人工对账及审核的时间）</p>
			<br />
			<p style="text-indent: 4em;">
				如果您已支付，请点击：<span style="border:1px solid #ccc;color:red;padding:5px;cursor:pointer" onclick="">其它方式</span>，系统将会通知代理机构核对您的支付信息。核对成功后系统将会通知您。
			</p>
		</div>
	</div>

	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>
