<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib tagdir="/WEB-INF/tags/sys" prefix="sys"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<sys:link ca="true" easyui="true"/>
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
				澄清内容
			</div>
			<div class="block">
				<div style="width:100%;background:#f1f1f1;border:1px solid #ddd">
					<div style="background:#fff;width:650px;border:1px solid #000;line-height:30px;padding:70px;margin:10px auto;">${recruitFiles.modifyContent}</div>
				</div>
			</div>
	</div>
	<div class="blank10"></div>
	<jsp:include page="/common/bottom.jsp" />		
</body>