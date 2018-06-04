<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- <c:set value="${candidatePublicityService.getSignatureDataById(candidatePublicity.id)}" var="signatureData" scope="request" /> --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" uedit="true" easyui="true"/>
<jsp:include page="/common/link.jsp" />
<script>
	$(function() {
		/* var editor = UE.getEditor('gsnr', {
			toolbars : [ [ 'fullscreen', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'selectall', 'cleardoc', '|', 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols' ] ],
			elementPathEnabled : false,
			autoHeightEnabled : false
		}); */
		$("#projectInstanceId").change(function() {
			$.ajax({
				type : "post",
				cache : false,
				url : ctx + "/notice/findProjectItemList",
				async : false,
				data : "projectInstanceId=" + $(this).val(),
				dataType : "json",
				success : function(data) {
					var radioHtml = "";
					for (var i = 0; i < data.length; i++) {
						radioHtml += "<input id=\""+data[i].id+"\" type='radio' name='projectItemId' value='"+data[i].id+"'/><label for=\""+data[i].id+"\">" + data[i].bdmc00 + "</label>";
					}
					$("#bdjh").html(radioHtml);
				},
			});
		});
		$(document).on("change", "#bdjh :input", function() {
			var projectInstanceId = $("#projectInstanceId").val();
			var projectInstanceName = $("#projectInstanceId").children("option[value='" + projectInstanceId + "']").html();
			var projectItemName = $(":input[name='" + $(this).attr("name") + "']:checked").next().text();
			$(":input[name='publicityTitle']").val(projectInstanceName + "(" + projectItemName + ")中标候选人公示");
			loadDefaultCandidatePublicity();
		});
		$(".Wdate").focus(function() {
			WdatePicker({
				dateFmt : 'yyyy-MM-dd HH:mm:ss',
				onpicked : loadDefaultCandidatePublicity
			});
		});
		$(":input").filter(function() {
			return !$(this).hasClass("Wdate") && $(this).attr("type") == "text";
		}).blur(function() {
			loadDefaultCandidatePublicity();
		});
		function loadDefaultCandidatePublicity() {
			$.ajax({
				url : ctx + "/candidatePublicity/defaultCandidatePublicity",
				type : "post",
				data : $("#publicityForm").serialize(),
				dataType : "html",
				success : function(data) {
					editor.setContent(data);
				}
			});
		}
	});
	function formSubmit(submitType) {
		//保存草稿
		if (1 == submitType) {
			$("#publicityForm").attr("action", "${pageContext.request.contextPath}/candidatePublicity/saveOrUpdatePublicity");
			//提交审核
		} else if (2 == submitType) {
			$("#publicityForm").attr("action", "${pageContext.request.contextPath}/candidatePublicity/reviewPublicity");
		}
		$("#publicityForm").submit();
	}
	
	$(function(){
		sealUtil.loadAllSealWithBKey("${candidatePublicity.id}","data=string2sign","sealPos");
		//alert("${candidatePublicity.id}");
		/* var SigndataStrSignData = '${signatureData.signatureData}';
		var sealName='${signatureData.sealName}';
		//alert(sealName);
		if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
			document.all.DWebSignSeal.ShowSeal(sealName, 1);
		} else {
			document.all.DWebSignSeal.SetStoreData(SigndataStrSignData); 
			document.all.DWebSignSeal.ShowWebSeals();
			document.all.DWebSignSeal.SetMenuItem(sealName,12);
			document.all.DWebSignSeal.LockSealPosition(sealName);
		} */
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp" />
	<div class="blank10"></div>
	<div class="block ">
		<div id="ur_here">
			当前位置: <a href="${util:property('frontEnd')}">首页</a>
			<code>&gt;</code>
			中标候选人公示查看
		</div>
	</div>
	<div class="block">
		<div class="usBox">
			<h4 style='border-bottom: #666 1px solid;'>中标候选人公示查看</h4>
			<form:form id="publicityForm" method="post" action='${pageContext.request.contextPath}/workflow/completeForm' modelAttribute="candidatePublicity">
				<form:hidden path="id" />
				<form:hidden path="projectInstanceId" />
				<%-- <form:hidden path="projectItemId" /> --%>
				<form:hidden path="gskssj" />
				<form:hidden path="gsjssj" />
				<form:hidden path="contacts" />
				<form:hidden path="phone" />
				<form:hidden path="email" />
				<!-- <input type="hidden" id='signData' name="signData" />
				<input type="hidden" id='SigndataWtrSealName' name="SigndataWtrSealName" />
				<input type="hidden" id='SigndataWtrSignData' name="SigndataWtrSignData" /> -->
				<form:hidden path="gsnr" id="gsnr"/>
				<input type="hidden" name="taskId" value="${taskId}" />
				<div class="blank10"></div>
				<table class='mytableStyle'>
					<col style="width:100px" />
					<col />
					<col style="width:100px" />
					<col />
					<tr>
						<th width="120px">招标项目名称</th>
						<td colspan="3">${candidatePublicity.projectInstance}</td>
					</tr>
					<tr>
						<th width="120px">标段</th>
						<td >
							<c:forEach items="${candidatePublicity.projectItemList}" var="item">
								<nobr>${item.bdmc00}</nobr>&nbsp;&nbsp;
							</c:forEach>
						</td>
						<th>公示类型：</th>
						<td>${util:dictionary('GSLXDM',candidatePublicity.gslx)}</td>
					</tr>
				</table>
				<div class="blank10"></div>
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<span id="gsnrss"></span><div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${candidatePublicity.gsnr}</div>
					<span id="sealPos"></span>
				</div>
			</form:form>
		</div>
		<div class="blank10"></div>
		<a class="button orange" onclick="history.go(-1)">返回</a>
	</div>

</body>
</html>