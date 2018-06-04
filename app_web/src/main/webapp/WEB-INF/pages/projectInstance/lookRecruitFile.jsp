<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<script type="text/javascript">
$(function() {
	$("body").webEditor({
		user : {
			id : "${CURRENT_USER_SESSION_INFO.id}",
			name : "${CURRENT_USER_SESSION_INFO.userName}"
		},
		zoomPercent:80,
		href : [ ctx+"/attachment/download/${recruitFile.htmlAttachment.path}" ],
		uploadURL:"${pageContext.request.contextPath}/document/imageUpload",
		openable:false,
		editable : false,
		reviewable : true
	});
});
</script>
</head>
<body id="webEditor">
</body>
</html>