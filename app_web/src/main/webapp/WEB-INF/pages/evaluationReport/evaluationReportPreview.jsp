<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:include page="/common/link.jsp" />
<head>
                                                     <!-- 签章控制组件 -->
<sys:link easyui="true" jgrowl="true" plupload="true" ca="true"/>
<script type="text/javascript">
	$(function(){
		sealUtil.loadAllSealWithBKey("${evaluationReport.id}","data=string2sign","");
		//循环返回来的专家签章
		//<c:if test="${!empty signList }">
		//<c:forEach items="${signList}" var="evaluationReportSign" varStatus="status">
			//alert('${evaluationReportSign.sealSignData}');
			//document.all.DWebSignSeal.SetStoreData('${evaluationReportSign.sealSignData}');
			//var posX = 100*${status.index + 1};
			//document.all.DWebSignSeal.MoveSealPosition("${evaluationReportSign.sealName}",posX,0,"juryAddSeal");
			//document.all.DWebSignSeal.ShowWebSeals();
		//</c:forEach>
	   //</c:if>
	});
</script>
</head>
<body>
	<jsp:include page="/common/top.jsp"/>
	<div class="blank10"></div>
	<div class="block ">
		<div class="AreaL">
			<%@include file="/common/left.jsp"%>
		</div>
		<div class="AreaR">
			<div id="ur_here">
				当前位置: <a href="${util:property('frontEnd')}">首页</a>
				<code>&gt;</code>
				评标报告内容
			</div>
			
			<div class="block">
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd;overflow: hidden;">
					<div class="view" style="background:#fff;width:650px;border:1px solid #000;padding:70px;margin:10px auto;">${report.evaluationReportContent}</div>
				</div>
				<!-- 显示专家签章 -->
				<textarea style="display: none" id="evaluationReportContent" name="evaluationReportContent">${report.evaluationReportContent}</textarea>
			</div>
		</div>
	</div>
	<%-- <form:form modelAttribute="${report}">
		<form:textarea id="evaluationReportContent" path="evaluationReportContent" style="display: none"/>
	</form:form> --%>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp"/>
</body>
</html>