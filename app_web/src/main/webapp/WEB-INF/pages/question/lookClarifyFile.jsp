<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<form class="registerform ajax" action="${pageContext.request.contextPath}/question/setQrReconnaissance" method="post">
	<table class="mytablerow" style="width:100%;">
		<tr>
			<td class="need"></td>
			<td style='width:10%;'>澄清内容:</td>
			<td>
				<textarea name="modifyContent" id="modifyContent" style="width:99%;height:160px;" readonly="readonly">${recruitFile.modifyContent==null?'无':recruitFile.modifyContent }</textarea>
			</td>
			<td></td>
		</tr>
		<tr>
			<td class="need"></td>
			<td style='width:10%;'>回执:</td>
			<td id="modifyContentSealPostion"></td>
			<td></td>
		</tr>
	</table>
</form>
<script type="text/javascript">

$(function() {
	//<c:if test="${fn:length(listTenderItem) > 0 }">
		//<c:forEach items="${listTenderItem }" var="tenderItem"  varStatus="status">
			//<c:if test="${not empty tenderItem.reconSignatureDataId}">
				var sealName = '${tenderItem.signatureData.sealName }';
				var strSignData = '${tenderItem.signatureData.signatureData }';
				if ($.trim(document.all.DWebSignSeal.FindSeal(sealName, 2)) != '') {
					document.all.DWebSignSeal.ShowSeal(sealName, 1);
				} else {
					document.all.DWebSignSeal.SetStoreData(strSignData); 
					document.all.DWebSignSeal.MoveSealPosition(sealName, ${status.index * 160}, 0, "modifyContentSealPostion");
					document.all.DWebSignSeal.ShowWebSeals();
					document.all.DWebSignSeal.SetMenuItem(sealName,12);
					document.all.DWebSignSeal.LockSealPosition(sealName);
				}
			
			//</c:if>
		//</c:forEach>
	//</c:if>
});

	
</script>
