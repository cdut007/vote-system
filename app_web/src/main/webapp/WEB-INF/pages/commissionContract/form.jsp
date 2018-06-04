<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript" src="/resources/ca/Loadwebsign.js"></script>
<script type="text/javascript">
	window.onload = setSeal;
	function setSeal(){
		document.all.DWebSignSeal.SetStoreData("${commissionContract.signData}");
		document.all.DWebSignSeal.ShowWebSeals();
		document.all.DWebSignSeal.SetSealSignData("yfsign",$("#htnr00").val());
	}
</script>

<style type="text/css">
h3 {
 text-align: left;
 border: 0;
}

#spanClose:hover {
 background-color: #eee;
 font-weight: bold;
 cursor: pointer;
}

form {
 margin: 0;
}

.user_write {
 font-weight: 500;
 text-decoration: underline;
 font-family: 楷体;
 font-size: 15px;
 font-style: italic;
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
			签订合同
		</div>
		<form:form commandName="commissionContract">
			<form:textarea path="htnr00" id="htnr00" cssStyle="display:none"/>
		</form:form>
		<div class="blank10"></div>
		<div class="usBox main" id="ht_content">${commissionContract.htnr00==null?"合同暂时为空！":commissionContract.htnr00}</div>
		<div id="ht_end"></div>
	</div>
	<div class="blank10"></div>
</body>
</html>