<%@page pageEncoding="utf-8" import="com.mhb.common.Constants"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link easyui="true" plupload="true" spectrum="true" jgrowl="true" webedit="true"/>
<script type="text/javascript">
	$(function() {
		//window.location=ctx+"/attachment/download/${recruitFile.htmlAttachment.path}";
		$("body").webEditor({
			home:ctx+"/home",
			user : {
				id : "${CURRENT_USER_SESSION_INFO.id}",
				name : "${CURRENT_USER_SESSION_INFO.userName}"
			},
			zoomPercent:90,
			href : [ctx+"/attachment/download/${recruitFile.htmlAttachment.path}"],
			uploadURL:ctx+"/document/imageUpload",
			openable:false,
			editable : true,
			reviewable : false,
			layout:"H",
			//client:true,
			saveasable:false
		});
	});
</script>
</head>
<body>
</body>
</html>