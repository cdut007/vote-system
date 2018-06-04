<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" easyui="true"/>
<script type="text/javascript">
$(function(){
		//var sealName = $("#sealName").val();
		/* var sealSignData = $("#signatureData").val();
		if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
			document.all.DWebSignSeal.ShowSeal(sealName, 1);
		} else {
			document.all.DWebSignSeal.SetStoreData(sealSignData);
			document.all.DWebSignSeal.ShowWebSeals();
			document.all.DWebSignSeal.SetMenuItem(sealName, 12);
			document.all.DWebSignSeal.LockSealPosition(sealName);
		}
		document.all.DWebSignSeal.SetMenuItem(sealid, 12);
		document.all.DWebSignSeal.LockSealPosition(sealid); */
		/* $("#sealName").val(sealName);
		$("#signatureData").val(document.all.DWebSignSeal.GetStoreData());
		$("#" + id + " form").ajaxSubmit({
			success : function(data) {
				$.jGrowl(data.msg);
			}
		}); */
		sealUtil.loadAllSealWithBKey("${receipts.id}","data=string2sign","modifyContentSealPostion");
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
			澄清与答疑
			<code>&gt;</code>
			澄清文件详情
			<code>&gt;</code>
			查看回执
		</div>
		<div class="block">
			<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
				<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;" id="receiptContentContainer">${receipts.receiptContent}</div>
			</div>
		</div>
		<span id="modifyContentSealPostion"></span>
	</div>
	<div style="border-radius: 5px;border:#e4e4e4 1px solid;padding:5px;position:fixed;bottom:0px;height:30px;background-color:#eeeeff;z-index:9999;right:5px;left:5px;">
		<form:form modelAttribute="receipts">
			<form:hidden path="receiptContent"/>
		</form:form>
		<%-- <input type="hidden" name="signatureData" id="signatureData" value="${signatureData.signatureData}"/>
		<input type="hidden" name="sealName" id="sealName" value="${sealSignData.sealName}"/> --%>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />
  </body>
</html>
